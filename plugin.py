# -*- coding: utf-8 -*-
###
# Copyright (c) 2013, spline
# All rights reserved.
#
#
###
# my libs
from base64 import b64decode
import cPickle as pickle
import datetime
from operator import itemgetter
import re
from BeautifulSoup import BeautifulSoup
import sqlite3
import os.path
# extra supybot libs
import supybot.conf as conf
import supybot.schedule as schedule
import supybot.ircmsgs as ircmsgs
# extra supybot libs
import supybot.conf as conf
import supybot.schedule as schedule
import supybot.ircmsgs as ircmsgs
import supybot.utils as utils
from supybot.commands import *
import supybot.plugins as plugins
import supybot.ircutils as ircutils
import supybot.callbacks as callbacks
try:
    from supybot.i18n import PluginInternationalization
    _ = PluginInternationalization('CFBLive')
except:
    # Placeholder that allows to run the plugin on a bot
    # without the i18n module
    _ = lambda x:x

class CFBLive(callbacks.Plugin):
    """Add the help for "@plugin help CFBLive" here
    This should describe *how* to use this plugin."""
    threaded = True

    def __init__(self, irc):
        self.__parent = super(CFBLive, self)
        self.__parent.__init__(irc)
        # our cfblive db.
        self._cfbdb = os.path.abspath(os.path.dirname(__file__)) + '/db/cfb.db'
        # initial states for channels.
        self.channels = {} # dict for channels with values as teams/ids
        #self._loadpickle() # load saved data.
        # initial states for games.
        self.games = None
        self.nextcheck = None
        # fill in the blanks.
        #if not self.games:
        #    self.games = self._fetchgames()
        # now schedule our events.
        #def checkhardballcron():
        #    self.checkhardball(irc)
        #try: # check scores.
        #    schedule.addPeriodicEvent(checkhardballcron, self.registryValue('checkInterval'), now=False, name='checkhardball')
        #except AssertionError:
        #    try:
        #        schedule.removeEvent('checkhardball')
        #    except KeyError:
        #        pass
        #    schedule.addPeriodicEvent(checkhardballcron, self.registryValue('checkInterval'), now=False, name='checkhardball')

    def die(self):
        #try:
        #    schedule.removeEvent('checkhardball')
        #except KeyError:
        #    pass
        self.__parent.die()

    ######################
    # INTERNAL FUNCTIONS #
    ######################

    def _httpget(self, url, h=None, d=None, l=True):
        """General HTTP resource fetcher. Pass headers via h, data via d, and to log via l."""

        if self.registryValue('logURLs') and l:
            self.log.info(url)

        try:
            if h and d:
                page = utils.web.getUrl(url, headers=h, data=d)
            else:
                page = utils.web.getUrl(url)
            return page
        except utils.web.Error as e:
            self.log.error("ERROR opening {0} message: {1}".format(url, e))
            return None

    def _utcnow(self):
        """Calculate Unix timestamp from GMT."""

        ttuple = datetime.datetime.utcnow().utctimetuple()
        _EPOCH_ORD = datetime.date(1970, 1, 1).toordinal()
        year, month, day, hour, minute, second = ttuple[:6]
        days = datetime.date(year, month, 1).toordinal() - _EPOCH_ORD + day - 1
        hours = days*24 + hour
        minutes = hours*60 + minute
        seconds = minutes*60 + second
        return seconds

    ###########################################
    # INTERNAL CHANNEL POSTING AND DELEGATION #
    ###########################################

    def _post(self, irc, awayid, homeid, message):
        """Posts message to a specific channel."""

        # how this works is we have an incoming away and homeid. we then look up these (along with 0)
        # against the self.channels dict (k=channel, v=set of #). then, if any of the #'s match in the v
        # we insert this back into postchans so that the function posts the message into the proper channel(s).
        if len(self.channels) == 0: # first, we have to check if anything is in there.
            #self.log.error("ERROR: I do not have any channels to output in.")
            return
        # we do have channels. lets go and check where to put what.
        teamids = [awayid, homeid, '0'] # append 0 so we output. needs to be strings.
        postchans = [k for (k, v) in self.channels.items() if __builtins__['any'](z in v for z in teamids)]
        # iterate over each.
        for postchan in postchans:
            try:
                irc.queueMsg(ircmsgs.privmsg(postchan, message))
            except Exception as e:
                self.log.error("ERROR: Could not send {0} to {1}. {2}".format(message, postchan, e))

    ##############################
    # INTERNAL CHANNEL FUNCTIONS #
    ##############################

    def _loadpickle(self):
        """Load channel data from pickle."""

        try:
            datafile = open(conf.supybot.directories.data.dirize(self.name()+".pickle"), 'rb')
            try:
                dataset = pickle.load(datafile)
            finally:
                datafile.close()
        except IOError:
            return False
        # restore.
        self.channels = dataset["channels"]
        return True

    def _savepickle(self):
        """Save channel data to pickle."""

        data = {"channels": self.channels}
        try:
            datafile = open(conf.supybot.directories.data.dirize(self.name()+".pickle"), 'wb')
            try:
                pickle.dump(data, datafile)
            finally:
                datafile.close()
        except IOError:
            return False
        return True

    #########################
    # TEAM DB AND FUNCTIONS #
    #########################

    def _tidwrapper(self, tid):
        """TeamID wrapper."""

        dblookup = self._tidtoname(tid)
        if dblookup:  # return the DB entry.
            return dblookup
        else:  # perform http lookup.
            url = b64decode('aHR0cDovL20ueWFob28uY29tL3cvc3BvcnRzL25jYWFmL3RlYW0v') + 'ncaaf.t.%s' % str(tid)
            html = self._httpget(url)
            if not html:
                self.log.error("ERROR: _tidwrapper: Could not fetch {0} :: {1}".format(url, e))
                return None
            # try and grab teamname.
            soup = BeautifulSoup(html, convertEntities=BeautifulSoup.HTML_ENTITIES, fromEncoding='utf-8')
            teamname = soup.find('div', attrs={'class':'o w f'})
            if teamname:
                teamname = teamname.getText().encode('utf-8')
                self.log.info("_tidwrapper: Should add in {0} as {1}".format(tid, teamname))
                return teamname
            else:
                self.log.error("ERROR: _tidwrapper: Could not find teamname.")
                self.log.info(str(soup))
                return None

    def _tidtoname(self, tid):
        """Return team name for teamid from database."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT team FROM teams WHERE id=?", (tid,))
            row = cursor.fetchone()
        # now return the name.
        if not row:
            return None
        else:
            return row[0].encode('utf-8')

    ####################
    # FETCH OPERATIONS #
    ####################

    def _fetchgames(self):
        """Return the games.txt data."""

        url = b64decode('aHR0cDovL2F1ZDEyLnNwb3J0cy5hYzQueWFob28uY29tL25jYWFmL2dhbWVzLnR4dA==')
        headers = {"User-Agent":"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:17.0) Gecko/20100101 Firefox/17.0"}
        html = self._httpget(url, h=headers)
        if not html:
            self.log.error("ERROR: Could not fetch {0} :: {1}".format(url, e))
            return None
        # now turn the "html" into a list of dicts.
        newgames = self._txttodict(html)
        if not newgames: # no new games for some reason.
            return None
        else: # return newgames.
            return newgames

    def _txttodict(self, txt):
        """Games game lines from fetchgames and turns them into a list of dicts."""

        lines = txt.splitlines()
        games = {}

        for line in lines:  # iterate over.
            if line.startswith('g|'): # only games.
                cclsplit = line.split('|') # split.
                # handle each field here.
                t = {}  # tmp dict for each line.
                t['awayteam'] = self._tidwrapper(int(cclsplit[2]))
                t['hometeam'] = self._tidwrapper(int(cclsplit[3]))
                t['status'] = cclsplit[4]  #
                t['quarter'] = int(cclsplit[6])
                t['time'] = cclsplit[7]
                t['awayscore'] = int(cclsplit[8])
                t['homescore'] = int(cclsplit[9])
                t['start'] = int(cclsplit[10])
                t['yrdstoscore'] = int(cclsplit[13])
                #t[''] = cclsplit[]
                games[cclsplit[1]] = t
        # process if we have games or not.
        if len(games) == 0: # no games.
            self.log.error("ERROR: No matching lines in _txttodict")
            self.log.error("ERROR: _txttodict: {0}".format(txt))
            return None
        else:
            return games

    def _scoreevent(self, gid):
        """Fetch last scoring event from game."""

        url = b64decode('aHR0cDovL2F1ZDEyLnNwb3J0cy5hYzQueWFob28uY29tL25jYWFm') + '/plays-%s.txt' % str(gid)
        headers = {"User-Agent":"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:17.0) Gecko/20100101 Firefox/17.0"}
        html = self._httpget(url, h=headers)
        if not html:
            self.log.error("ERROR: Could not fetch {0} :: {1}".format(url, e))
            return None
        # process.
        lines = html.splitlines()
        scorelines = []  # put matching lines into list.
        for line in lines:  # iterate over each.
            if line.startswith('s'):  # only scoring.
                linesplit = line.split('|')  # split line.
                scorelines.append(linesplit)  # append.
        # make sure we have scorelines.
        if len(scorelines) == 0:  # bail if 0.
            return None
        # now return process scorelines.
        lastline = scorelines[-1]  # grab the last item in scorelines list.
        ev = lastline[10]  # event is always at 10.
        return ev.encode('utf-8')

    ###########################
    # INTERNAL EVENT HANDLERS #
    ###########################

    def _boldleader(self, awayteam, awayscore, hometeam, homescore):
        """Conveinence function to bold the leader."""

        if (int(awayscore) > int(homescore)):  # visitor winning.
            return "{0} {1} {2} {3}".format(ircutils.bold(awayteam), ircutils.bold(awayscore), hometeam, homescore)
        elif (int(awayscore) < int(homescore)):  # home winning.
            return "{0} {1} {2} {3}".format(awayteam, awayscore, ircutils.bold(hometeam), ircutils.bold(homescore))
        else:  # tie.
            return "{0} {1} {2} {3}".format(awayteam, awayscore, hometeam, homescore)

    def _begingame(self, ev):
        """Handle start of game event."""

        mstr = "{0}@{1} :: {2}".format(ev['awayteam'], ev['hometeam'], ircutils.mircColor("KICKOFF", 'green'))
        return mstr

    def _endgame(self, ev):
        """Handle end of game event."""

        gamestr = self._boldleader(ev['awayteam'], ev['awayscore'], ev['hometeam'], ev['homescore'])
        mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor("FINAL", 'red'))
        return mstr

    def _halftime(self, ev):
        """Handle halftime event."""

        gamestr = self._boldleader(ev['awayteam'], ev['awayscore'], ev['hometeam'], ev['homescore'])
        mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor("HALFTIME", 'yellow'))
        return mstr

    def _endhalftime(self, ev):
        """Handle end of game event."""

        gamestr = self._boldleader(ev['awayteam'], ev['awayscore'], ev['hometeam'], ev['homescore'])
        mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor("Start 3rd Qtr", 'green'))
        return mstr

    def _beginovertime(self, ev):
        """Handle start of overtime."""

        otper = "Start OT{0}".format(int(ev['statusperiod'])-4)  # should start with 5, which is OT1.
        gamestr = self._boldleader(ev['awayteam'], ev['awayscore'], ev['hometeam'], ev['homescore'])
        mstr = "{0} :: Start OT{1}".format(gamestr, ircutils.mircColor(otper, 'green'))
        return mstr

    ###################
    # PUBLIC COMMANDS #
    ###################

    def cfblivestatus(self, irc, msg, args):
        """
        .
        """

        games = self._fetchgames()
        if games:
            for (k, v) in games.items():
                irc.reply("{0} :: {1}".format(k,v))

    cfblivestatus = wrap(cfblivestatus)

    def checkcfb(self, irc):
        """
        Main loop.
        """

        # before anything, check if nextcheck is set and is in the future.
        if self.nextcheck:  # set
            utcnow = self._utcnow()
            if self.nextcheck > utcnow:  # in the future so we backoff.
                return
            else:  # in the past so lets reset it. this means that we've reached the time where firstgametime should begin.
                self.log.info("checkcfb: nextcheck has passed. we are resetting and continuing normal operations.")
                self.nextcheck = None
        # we must have initial games. bail if not.
        if not self.games:
            self.games = self._fetchgames()
            return
        # check and see if we have initial games, again, but bail if no.
        if not self.games:
            self.log.error("checkcfb: I did not have any games in self.games")
            return
        else:  # setup the initial games.
            games1 = self.games
        # now we must grab the new status to compare to.
        games2 = self._fetchgames()
        if not games2:  # something went wrong so we bail.
            self.log.error("checkcfb: fetching games2 failed.")
            return

        # main handler for event changes.
        # we go through and have to match specific conditions based on json changes.
        for (k, v) in games1.items():  # iterate over games.
            if k in games2:  # must mate keys between games1 and games2.
                ##############
                # CHECKS
                #####
                # 2 minute warning (4th quarter).
                # halftime.
                # scoring events
                # overtime notification?
                # final game.
                # redzone notifications.
                pass

        # done checking. copy new to self.games
        self.games = games2 # change status.
        # last, before we reset to check again, we need to verify some states of games in order to set sentinel or not.
        # first, we grab all the statuses in newgames (games2)
        gamestatuses = set([i['status'] for i in games2])
        # next, check what the statuses of those games are and act accordingly.
        if (('D' in gamestatuses) or ('P' in gamestatuses)): # if any games are being played or in a delay, act normal.
            self.nextcheck = None # set to None to make sure we're checking on normal time.
        elif 'S' in gamestatuses:  # no games being played or in delay, but we have games in the future. (ie: day games done but night games later)
            firstgametime = sorted([f['start'] for (i, f) in games2.items() if f['status'] == "S"])[0]  # get all start times with S, first (earliest).
            utcnow = self._utcnow()  # grab UTC now.
            if firstgametime > utcnow:   # make sure it is in the future so lock is not stale.
                self.nextcheck = firstgametime  # set to the "first" game with 'S'.
                self.log.info("checkcfb: we have games in the future (S) so we're setting the next check {0} seconds from now".format(firstgametime-utcnow))
            else:  # firstgametime is NOT in the future. this is a problem.
                fgtdiff = abs(firstgametime-utcnow)  # get how long ago the first game should have been.
                if fgtdiff < 3601:  # if less than an hour ago, just basically pass.
                    self.nextcheck = None
                    self.log.info("checkcfb: firstgametime has passed but is under an hour so we resume normal operations.")
                else:  # over an hour so we set firstgametime an hour from now.
                    self.nextcheck = utcnow+3600
                    self.log.info("checkcfb: firstgametime is over an hour from now so we're going to backoff for an hour".format(firstgametime))
        else:  # everything is "F" (Final). we want to backoff so we're not flooding.
            self.nextcheck = utcnow+600  # 10 minutes from now.
            self.log.info("checkcfb: no active games and I have not got new games yet, so I am holding off for 10 minutes.")

Class = CFBLive

# vim:set shiftwidth=4 softtabstop=4 expandtab textwidth=79:
