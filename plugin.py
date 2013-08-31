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
#from operator import itemgetter
#import re
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
        self._loadpickle() # load saved data.
        # initial states for games.
        self.games = None
        self.nextcheck = None
        # dupedict.
        self.dupedict = {}
        # fetchhost system.
        self.fetchhost = None
        self.fetchhostcheck = None
        # fill in the blanks.
        if not self.games:
            self.games = self._fetchgames()
        # now schedule our events.
        def checkcfbcron():
            self.checkcfb(irc)
        try:
            schedule.addPeriodicEvent(checkcfbcron, 30, now=False, name='checkcfb')
        except AssertionError:
            try:
                schedule.removeEvent('checkcfb')
            except KeyError:
                pass
            schedule.addPeriodicEvent(checkcfbcron, 30, now=False, name='checkcfb')

    def die(self):
        try:
            schedule.removeEvent('checkcfb')
        except KeyError:
            pass
        self.__parent.die()

    ######################
    # INTERNAL FUNCTIONS #
    ######################

    def _httpget(self, url):
        """General HTTP resource fetcher."""

        # self.log.info(url)

        try:
            h = {"User-Agent":"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:17.0) Gecko/20100101 Firefox/17.0"}
            page = utils.web.getUrl(url, headers=h)
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

        # how this works is we have an incoming away and homeid. we find out their conference ids.
        # against the self.channels dict (k=channel, v=set of #). then, if any of the #'s match in the v
        # we insert this back into postchans so that the function posts the message into the proper channel(s).
        if len(self.channels) == 0: # first, we have to check if anything is in there.
            #self.log.error("ERROR: I do not have any channels to output in.")
            return
        # we do have channels. lets go and check where to put what.
        confids = self._tidstoconfids(awayid, homeid)  # grab the list of conf ids.
        if not confids:  # failsafe here.
            return
        postchans = [k for (k, v) in self.channels.items() if __builtins__['any'](z in v for z in confids)]
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

        # first, try to see if it's in the database.
        dblookup = self._tidtoname(tid)
        if dblookup:  # return the DB entry.
            return dblookup
        else:  # not in the db. perform http lookup.
            url = b64decode('aHR0cDovL20ueWFob28uY29tL3cvc3BvcnRzL25jYWFmL3RlYW0v') + 'ncaaf.t.%s' % str(tid)
            html = self._httpget(url)
            if not html:
                self.log.error("ERROR: _tidwrapper: Could not fetch {0} :: {1}".format(url, e))
                return None
            # try and grab teamname.
            soup = BeautifulSoup(html, convertEntities=BeautifulSoup.HTML_ENTITIES, fromEncoding='utf-8')
            teamname = soup.find('div', attrs={'class':'uic title first'})
            if teamname:  # we found a team name.
                teamname = teamname.getText().encode('utf-8')
                # see if we can find the conference.
                conf = soup.find('div', attrs={'class':'uic last'})
                if conf:  # we found their conf.
                    conf = conf.getText()
                else:  # no conf.
                    conf = "None"
                #self.log.info("_tidwrapper: Should add in {0} as {1} (Conference: {2})".format(tid, teamname, conf))
                self.log.info('_tidwrapper: INSERT INTO teams VALUES ("{0}", "{1}", "{2}");'.format(conf, tid, teamname))
                return teamname.encode('utf-8')
            else:  # didn't find the team. Gotta bail..
                self.log.error("ERROR: _tidwrapper: Could not find teamname for tid: {0}".format(tid))
                #self.log.info(str(soup))
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

    def _tidstoconfids(self, tid1, tid2):
        """Fetch the conference ID for a team."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            #query = "SELECT confs.division, teams.conf FROM teams LEFT JOIN confs ON teams.conf = confs.id WHERE teams.id=?"
            #query = "SELECT confs.division, teams.conf FROM teams LEFT JOIN confs ON teams.conf = confs.id WHERE teams.id IN (?,?)"
            query = "SELECT DISTINCT conf FROM teams WHERE id IN (?, ?)"
            cursor.execute(query, (tid1, tid2,))
            item = [i[0] for i in cursor.fetchall()]  # put the ids into a list.
            # check to make sure we have something.
            if len(item) == 0:
                return None
            else:
                return item

    def _confs(self):
        """Return a dict containing all conferences and their ids."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            query = "SELECT id, conference FROM confs"
            cursor.execute(query)
            c = dict((i[0], i[1]) for i in cursor.fetchall())
            return c

    def _validconf(self, confname):
        """Validate a conf and return its ID."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            query = "SELECT id FROM confs WHERE conference=?"
            cursor.execute(query, (confname,))
            row = cursor.fetchone()
        # now return the name.
        if row:
            return row[0]
        else:
            return None

    def _confidtoname(self, confid):
        """Validate a conf and return its ID."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            query = "SELECT conference FROM confs WHERE id=?"
            cursor.execute(query, (confid,))
            row = cursor.fetchone()
        # now return the name.
        if row:
            return row[0].encode('utf-8')
        else:
            return None

    ####################
    # FETCH OPERATIONS #
    ####################

    def _fetchhost(self):
        """Return the host for fetch operations."""

        utcnow = self._utcnow()
        # if we don't have the host, lastchecktime, or fetchhostcheck has passed, we regrab.
        if ((not self.fetchhostcheck) or (not self.fetchhost) or (self.fetchhostcheck < utcnow)):
            url = b64decode('aHR0cDovL2F1ZC5zcG9ydHMueWFob28uY29tL2Jpbi9ob3N0bmFtZQ==')
            html = self._httpget(url) # try and grab.
            if not html:
                self.log.error("ERROR: _fetchhost: could not fetch {0}")
                return None
            # now that we have html, make sure its valid.
            if html.startswith("aud"):
                fhurl = 'http://%s' % (html.strip())
                self.fetchhost = fhurl # set the url.
                self.fetchhostcheck = utcnow+3600 # 1hr from now.
                return fhurl
            else:
                self.log.error("ERROR: _fetchhost: returned string didn't match aud. We got {0}".format(html))
                return None
        else: # we have a host and it's under the cache time.
            return self.fetchhost

    def _fetchgames(self):
        """Return the games.txt data."""

        url = self._fetchhost() # grab the host to check.
        if not url: # didn't get it back.
            self.log.error("ERROR: _fetchgames broke on _fetchhost()")
            return None
        else: # we got fetchhost. create the url.
            url = "%s/ncaaf/games.txt" % (url)
        # now we try and fetch the actual url with data.
        html = self._httpget(url)
        if not html:
            self.log.error("ERROR: _fetchgames: could not fetch {0} :: {1}".format(url))
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
                # handle each field here. cryptic but we figured it out w/Intrepd's help.
                t = {}  # tmp dict for each line.
                t['awayteam'] = cclsplit[2]
                t['hometeam'] = cclsplit[3]
                t['status'] = cclsplit[4]
                t['quarter'] = cclsplit[6]
                t['time'] = cclsplit[7]
                t['awayscore'] = int(cclsplit[8])
                t['homescore'] = int(cclsplit[9])
                t['start'] = int(cclsplit[10])
                #t['yrdstoscore'] = cclsplit[13]
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

        url = self._fetchhost() # grab the host to check.
        if not url: # didn't get it back.
            self.log.error("ERROR: _scoreevent broke on _fetchhost()")
            return None
        else: # we got fetchhost. create the url.
            url = '%s/ncaaf/plays-%s.txt' % (url, str(gid))
        # now fetch the url.
        html = self._httpget(url)
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
        ev = {'id':lastline[2], 'event':lastline[10].encode('utf-8')}  # id is 2, event itself is 10.
        return ev

    def _boldleader(self, awayteam, awayscore, hometeam, homescore):
        """Conveinence function to bold the leader."""

        if (int(awayscore) > int(homescore)):  # visitor winning.
            return "{0} {1} {2} {3}".format(ircutils.bold(awayteam), ircutils.bold(awayscore), hometeam, homescore)
        elif (int(awayscore) < int(homescore)):  # home winning.
            return "{0} {1} {2} {3}".format(awayteam, awayscore, ircutils.bold(hometeam), ircutils.bold(homescore))
        else:  # tie.
            return "{0} {1} {2} {3}".format(awayteam, awayscore, hometeam, homescore)

    def _scoretype(self, pd):
        """Return score event type based on the difference in points."""

        if pd in (1, 2):  # 1 and 2 pt safety.
            return "SAF"
        elif pd == 3:  # fg.
            return "FG"
        elif pd in (6, 7, 8):  # td.
            return "TD"
        else:  # rutroh.
            return "UNK"

    ######################
    # CHANNEL MANAGEMENT #
    ######################

    def cfbstart(self, irc, msg, args):
        """
        start or restart the CFBLive timer and live reporting.
        """

        def checkcfbcron():
            self.checkcfb(irc)
        try:
            schedule.addPeriodicEvent(checkcfbcron, 20, now=False, name='checkcfb')
        except AssertionError:
            irc.reply("The CFBLive checker was already running.")
        else:
            irc.reply("CFBLive checker started.")

    cfbstart = wrap(cfbstart, [('checkCapability', 'admin')])

    def cfbstop(self, irc, msg, args):
        """
        start or restart the CFBLive timer and live reporting.
        """

        try:
            schedule.removeEvent('checkcfb')
        except KeyError:
            irc.reply("The CFBLive checker was not running.")
        else:
            irc.reply("CFBLive checker stopped.")

    cfbstop = wrap(cfbstop, [('checkCapability', 'admin')])

    def cfbchannel(self, irc, msg, args, op, optchannel, optarg):
        """<add|list|del|confs> <#channel> <CONFERENCE>

        Add or delete conference(s) from a specific channel's output.
        Use conference name or ALL for everything. Can only specify one at a time.
        Ex: add #channel1 ALL OR add #channel2 SEC OR del #channel1 ALL OR list
        """

        # first, lower operation.
        op = op.lower()
        # next, make sure op is valid.
        validop = ['add', 'list', 'del', 'confs']
        if op not in validop: # test for a valid operation.
            irc.reply("ERROR: '{0}' is an invalid operation. It must be be one of: {1}".format(op, " | ".join([i for i in validop])))
            return
        # if we're not doing list (add or del) make sure we have the arguments.
        if ((op != 'list') and (op != 'confs')):
            if not optchannel or not optarg: # add|del need these.
                irc.reply("ERROR: add and del operations require a channel and team. Ex: add #channel SEC OR del #channel SEC")
                return
            # we are doing an add/del op.
            optchannel = optchannel.lower()
            # make sure channel is something we're in
            if op == 'add': # check for channel on add only.
                if optchannel not in irc.state.channels:
                    irc.reply("ERROR: '{0}' is not a valid channel. You must add a channel that we are in.".format(optchannel))
                    return
            # test for valid team now.
            confid = self._validconf(optarg)
            if not confid: # invalid arg(conf)
                irc.reply("ERROR: '{0}' is an invalid conference. Must be one of: {1}".format(optarg, " | ".join(sorted(self._confs().values()))))
                return
        # main meat part.
        # now we handle each op individually.
        if op == 'add': # add output to channel.
            self.channels.setdefault(optchannel, set()).add(confid) # add it.
            self._savepickle() # save.
            irc.reply("I have added {0} into {1}".format(optarg, optchannel))
        elif op == 'confs': # list confs.
            irc.reply("Valid Confs for cfbchannel: {0}".format(" | ".join(sorted(self._confs().values()))))
        elif op == 'list': # list channels.
            if len(self.channels) == 0: # no channels.
                irc.reply("ERROR: I have no active channels defined. Please use the cfbchannel add operation to add a channel.")
            else: # we do have channels.
                for (k, v) in self.channels.items(): # iterate through and output
                    irc.reply("{0} :: {1}".format(k, " | ".join([self._confidtoname(q) for q in v])))
        elif op == 'del': # delete an item from channels.
            if optchannel in self.channels:
                if confid in self.channels[optchannel]: # id is already in.
                    self.channels[optchannel].remove(confid) # remove it.
                    if len(self.channels[optchannel]) == 0: # none left.
                        del self.channels[optchannel] # delete the channel key.
                    self._savepickle() # save it.
                    irc.reply("I have successfully removed {0} from {1}".format(optarg, optchannel))
                else:
                    irc.reply("ERROR: I do not have {0} in {1}".format(optarg, optchannel))
            else:
                irc.reply("ERROR: I do not have {0} in {1}".format(optarg, optchannel))

    cfbchannel = wrap(cfbchannel, [('checkCapability', 'admin'), ('somethingWithoutSpaces'), optional('channel'), optional('text')])

    ###################
    # PUBLIC COMMANDS #
    ###################

    def cfblivestatus(self, irc, msg, args):
        """
        .
        """

        if len(self.channels) != 0:
            irc.reply("CHANNELS: {0}".format(self.channels))
        irc.reply("NEXTCHECK: {0}".format(self.nextcheck))
        games = self._fetchgames()
        if games:
            for (k, v) in games.items():
                if v['status'] == "P":
                    at = self._tidwrapper(v['awayteam'])
                    ht = self._tidwrapper(v['hometeam'])
                    irc.reply("{0} :: {1} v. {2} :: {3}".format(k, at, ht, v))

    cfblivestatus = wrap(cfblivestatus)

    def checkcfb(self, irc):
    #def checkcfb(self, irc, msg, args):
        """
        Main loop.
        """

        self.log.info("checkcfb: starting...")
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
        # NOTES:
        # t['awayteam'], t['hometeam'], t['status'], t['quarter'], t['time'], t['awayscore'], t['homescore'], t['start']
        # we go through and have to match specific conditions based on changes.
        for (k, v) in games1.items():  # iterate over games.
            if k in games2:  # must mate keys between games1 and games2.
                # ACTIVE GAME EVENTS HERE
                if ((v['status'] == "P") and (games2[k]['status'] == "P")):
                    # make sure the event is dupedict so we can print events.
                    if k not in self.dupedict:
                        self.dupedict[k] = set([])  # add.
                    # SCORING PLAY.
                    if ((games2[k]['awayscore'] > v['awayscore']) or (games2[k]['homescore'] > v['homescore'])):
                        self.log.info("Should post scoring event from {0}".format(k))
                        # now lets try and fetch the scoring event.
                        se = self._scoreevent(v['hometeam'])
                        if se:  # we got scoringevent back.
                            # make sure this event has not been posted yet.
                            if se['id'] in self.dupedict[k]:  # it's been posted.
                                self.log.info("checkcfb: I'm trying to repost scoring event {0} from {1}".format(se['id'], k))
                            else:  # we have NOT posted it yet. lets format for output.
                                # first, grab the teams.
                                at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                                ht = self._tidwrapper(v['hometeam'])  # fetch home.
                                # get the score diff so we can figure out the score type and who scored.
                                apdiff = abs((int(v['awayscore'])-int(games2[k]['awayscore'])))  # awaypoint diff.
                                hpdiff = abs((int(v['homescore'])-int(games2[k]['homescore'])))  # homepoint diff.
                                if apdiff != 0:  # awayscore is not 0, ie: awayteam scored.
                                    sediff = apdiff  # int
                                    seteam = at  # get awayteam.
                                    setype = self._scoretype(apdiff)  # score type.
                                else:  # hometeam scored.
                                    sediff = hpdiff  # int
                                    seteam = ht  # get awayteam.
                                    setype = self._scoretype(hpdiff)  # score type.
                                # rest of the string.
                                gamestr = self._boldleader(at, games2[k]['awayscore'], ht, games2[k]['homescore'])  # bold the leader.
                                scoretime = "{0} {1}".format(utils.str.ordinal(games2[k]['quarter']), games2[k]['time'])  # score time.
                                mstr = "{0} :: {1} :: {2} :: {3} ({4})".format(gamestr, setype, seteam, se['event'], scoretime)  # lets construct the string.
                                self._post(irc, v['awayteam'], v['hometeam'], mstr)  # post to irc.
                                self.dupedict[k].add(se['id'])  # add to dupedict.
                        else:  # scoring event did not work.
                            self.log.info("checkcfb: ERROR :: I could not get back a scoring event from: {0}".format(k))
                    # END OF 1ST AND 3RD QUARTER.
                    if ((v['time'] != games2[k]['time']) and (games2[k]['quarter'] in ("1", "3")) and (games2[k]['time'] == "0:00")):
                        self.log.info("Should end of quarter in {0}".format(k))
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        gamestr = self._boldleader(at, games2[k]['awayscore'], ht, games2[k]['homescore'])
                        qtrstr = "End of {0} qtr".format(utils.str.ordinal(games2[k]['quarter']))
                        mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor(qtrstr, 'red'))
                        self._post(irc, v['awayteam'], v['hometeam'], mstr)
                    # HALFTIME IN
                    if ((v['time'] != games2[k]['time']) and (games2[k]['quarter'] == "2") and (games2[k]['time'] == "0:00")):
                        self.log.info("Should fire halftime in {0}".format(k))
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        gamestr = self._boldleader(at, games2[k]['awayscore'], ht, games2[k]['homescore'])
                        mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor("HALFTIME", 'yellow'))
                        self._post(irc, v['awayteam'], v['hometeam'], mstr)
                    # HALFTIME OUT
                    if ((v['quarter'] != games2[k]['quarter']) and (v['time'] != games2[k]['time']) and (games2[k]['quarter'] == "3") and (games2[k]['time'] == "15:00")):
                        self.log.info("Should fire 3rd quarter in {0}".format(k))
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        gamestr = self._boldleader(at, games2[k]['awayscore'], ht, games2[k]['homescore'])
                        mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor("Start 3rd Qtr", 'green'))
                        self._post(irc, v['awayteam'], v['hometeam'], mstr)
                    # OT NOTIFICATION
                    if ((v['quarter'] != games2[k]['quarter']) and (int(games2[k]['quarter']) > 4)):
                        self.log.info("Should fire OT notification in {0}".format(k))
                        otper = "Start OT{0}".format(int(ev['statusperiod'])-4)  # should start with 5, which is OT1.
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        gamestr = self._boldleader(at, games2[k]['awayscore'], ht, games2[k]['homescore'])
                        mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor(otper, 'green'))
                        self._post(irc, v['awayteam'], v['hometeam'], mstr)
                # EVENTS OUTSIDE OF AN ACTIVE GAME.
                else:
                    # KICKOFF.
                    if ((v['status'] == "S") and (games2[k]['status'] == "P")):
                        self.log.info("{0} is kicking off.".format(k))
                        # add game into dupedict.
                        if k not in self.dupedict:
                            self.dupedict[k] = set([])
                        else:
                            self.log.info("checkcfb: kickoff: I tried to readd {0} to dupedict".format(k))
                        # now construct kickoff event.
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        mstr = "{0}@{1} :: {2}".format(at, ht, ircutils.mircColor("KICKOFF", 'green'))
                        self._post(irc, v['awayteam'], v['hometeam'], mstr)
                    # GAME GOES FINAL.
                    if ((v['status'] == "P") and (games2[k]['status'] == "F")):
                        self.log.info("{0} is going final.".format(k))
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        gamestr = self._boldleader(at, games2[k]['awayscore'], ht, games2[k]['homescore'])
                        if (int(games2[k]['quarter']) > 4):
                            fot = "F/OT{0}".format(int(games2[k]['quarter'])-4)
                            mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor(fot, 'red'))
                        else:
                            mstr = "{0} :: {1}".format(gamestr, ircutils.mircColor("F", 'red'))
                        self._post(irc, v['awayteam'], v['hometeam'], mstr)
                        # lets now try to remove from dupedict.
                        if k in self.dupedict:
                            del self.dupedict[k]  # delete.
                        else:
                            self.log.info("checkcfb: {0} went final but was not in dupedict".format(k))
                    # GAME GOES INTO A DELAY.
                    if ((v['status'] == "P") and (games2[k]['status'] == "D")):
                        self.log.info("{0} is going into delay.".format(k))
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        mstr = "{0}@{1} :: {2}".format(at, ht, ircutils.mircColor("DELAY", 'yellow'))
                        self._post(irc, v['awayteam'], v['hometeam'], mstr)
                    # GAME COMES OUT OF A DELAY.
                    if ((v['status'] == "D") and (games2[k]['status'] == "P")):
                        self.log.info("{0} is resuming from delay.".format(k))
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        mstr = "{0}@{1} :: {2}".format(at, ht, ircutils.mircColor("RESUMED", 'green'))
                        self._post(irc, v['awayteam'], v['hometeam'], mstr)

        # done checking. copy new to self.games
        self.games = games2 # change status.
        # last, before we reset to check again, we need to verify some states of games in order to set sentinel or not.
        # STATUSES :: D = Delay, P = Playing, S = Future Game, F = Final ?
        # first, we grab all the statuses in newgames (games2)
        gamestatuses = set([i['status'] for i in games2.values()])
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

    #checkcfb = wrap(checkcfb)

Class = CFBLive

# vim:set shiftwidth=4 softtabstop=4 expandtab textwidth=79:
