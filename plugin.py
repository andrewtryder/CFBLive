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
from BeautifulSoup import BeautifulSoup
import sqlite3
import os.path
import datetime  # utc time.
from itertools import chain
# extra supybot libs
import supybot.conf as conf
import supybot.schedule as schedule
import supybot.ircmsgs as ircmsgs
# stock supybot libs
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
        # rankings.
        self.rankings = {}
        self.rankingstimer = None
        # fill in the blanks.
        if not self.games:
            self.games = self._fetchgames()
        # now schedule our events.
        def checkcfbcron():
            self.checkcfb(irc)
        try:  # add our cronjob.
            schedule.addPeriodicEvent(checkcfbcron, 30, now=True, name='checkcfb')
        except AssertionError:
            try:
                schedule.removeEvent('checkcfb')
            except KeyError:
                pass
            schedule.addPeriodicEvent(checkcfbcron, 30, now=True, name='checkcfb')

    def die(self):
        try:  # remove cronjob.
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
            self.log.error("_post: something went wrong with confids for awayid: {0} homeid: {1} m: {2} confids: {3}".format(awayid, homeid, message, confids))
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

    ##################################
    # TEAM DB AND DATABASE FUNCTIONS #
    ##################################

    def _tidwrapper(self, tid, d=False):
        """TeamID wrapper."""

        # first, try to see if it's in the database.
        dblookup = self._tidtoname(tid, d=d)
        if dblookup:  # return the DB entry.
            return dblookup
        else:  # not in the db. perform http lookup to grab its name.
            url = b64decode('aHR0cDovL20ueWFob28uY29tL3cvc3BvcnRzL25jYWFmL3RlYW0v') + 'ncaaf.t.%s' % str(tid)
            html = self._httpget(url)
            if not html:
                self.log.error("ERROR: _tidwrapper: Could not fetch {0}".format(url))
                return "Unknown"
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
                self.log.info('_tidwrapper: INSERT INTO teams VALUES ("{0}", "{1}", "{2}", "");'.format(conf, tid, teamname))
                return teamname.encode('utf-8')
            else:  # didn't find the team. Gotta bail..
                self.log.error("ERROR: _tidwrapper: Could not find teamname for tid: {0}".format(tid))
                return "Unknown"

    def _tidtoname(self, tid, d=False):
        """Return team name for teamid from database. Use d=True to return as dict."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT team, tid FROM teams WHERE id=?", (tid,))
            row = cursor.fetchone()
        # now return the name.
        if not row:  # didn't find.
            return None
        else:  # did find.
            if row[1] != '':  # some are empty. we did get something back.
                # check if team is in rankings dict.
                if row[1] in self.rankings:  # in there so append the #.
                    if d:  # return as dict.
                        return {'rank':self.rankings[row[1]], 'team':row[0].encode('utf-8')}
                    else:  # normal return
                        return "({0}){1}".format(self.rankings[row[1]], row[0].encode('utf-8'))
                else:  # not in the table so just return the teamname.
                    if d: # return as dict.
                        return {'team': row[0].encode('utf-8')}
                    else:  # normal return
                        return row[0].encode('utf-8')
            else:  # return just the team.
                if d:  # return as dict.
                    return {'team': row[0].encode('utf-8')}
                else:  # normal return
                    return row[0].encode('utf-8')

    def _tidstoconfids(self, tid1, tid2):
        """Fetch the conference ID for a team."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            query = "SELECT DISTINCT conf FROM teams WHERE id IN (?, ?)"
            cursor.execute(query, (tid1, tid2,))
            item = [i[0] for i in cursor.fetchall()]  # put the ids into a list.
            # check to make sure we have something.
            if len(item) == 0:
                return None
            else:
                return item

    def _confs(self):
        """Return a dict containing all conferences and their ids: k=id, v=confs."""

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

    def _tidtoconf(self, tid):
        """Fetch what conference name (string) a team is in."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            query = "SELECT conference FROM confs WHERE id IN (SELECT conf FROM teams WHERE id=?)"
            cursor.execute(query, (tid,))
            conference = cursor.fetchone()[0]
        # now return.
        return conference.encode('utf-8')

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

    def _fbsconfs(self):
        """Return a list of all FBS conference ids."""

        with sqlite3.connect(self._cfbdb) as conn:
            cursor = conn.cursor()
            query = "SELECT id FROM confs WHERE division=1"
            cursor.execute(query)
            confids = [i[0] for i in cursor.fetchall()]
        # now return.
        return confids

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

    def _fetchgames(self, filt=True):
        """Return the games.txt data into a processed dict. Set filter=False for all games."""

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
        newgames = self._txttodict(html, filt=filt)
        if not newgames: # no new games for some reason.
            return None
        else: # we have games. return.
            return newgames

    def _filtergame(self, at, ht):
        """With at and ht ids, we need to test if we should filter."""

        # check to see what activeconfs comes from.
        if len(self.channels) != 0: # we have "active" confs. consolidate the sets from each active channel.
            activeconfs = set(chain.from_iterable(([v for (k, v) in self.channels.items()])))
        else:  # no active confs so we just grab FBS conf ids.
            activeconfs = set(self._fbsconfs())
        # now lets take the at+ht ids and test.
        teamidslist = self._tidstoconfids(at, ht)  # grab the list of conf ids for this game.
        if teamidslist:  # failsafe but should never trigger.
            if not activeconfs.isdisjoint(teamidslist):  # this will be True if one of the ids from teamidslist = in activeconfs.
                return True
            else:  # at/ht (game) is NOT in activeconfs.
                return False
        else:  # missing teams.. sigh.
            self.log.info("_filtergame: teamidslist failed on one of AT: {0} HT: {1}".format(at, ht))
            return False

    def _txttodict(self, txt, filt):
        """Games game lines from fetchgames and turns them into a list of dicts. filt=True to limit games."""

        lines = txt.splitlines()  # split.
        games = {}  # container.

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
                # now we need to test if we should filter.
                if filt:  # True. filtertest will be True if we should include the game. False if we should skip/pass over.
                    filtertest = self._filtergame(t['awayteam'], t['hometeam'])
                    if filtertest:  # add into games dict.
                       games[cclsplit[1]] = t
                else:  # False. Don't filter. Add everything.
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
            self.log.error("ERROR: Could not fetch {0} :: {1}".format(url))
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
            self.log.info("_scoretype: something sent me {0}".format(pd))
            return "UNK"

    def _rankings(self):
        """Fetch the AP/BCS rankings for display."""

        # first, we need the time.
        utcnow = self._utcnow()
        # now determine if we should repopulate.
        if ((len(self.rankings) == 0) or (not self.rankingstimer) or (utcnow > self.rankingstimer)):
            # we'll put a try/except for the BCS, as well.
            url = b64decode('aHR0cDovL3Nwb3J0cy55YWhvby5jb20vbmNhYS9mb290YmFsbC9wb2xscz9wb2xsPTE=')
            # fetch url
            html = self._httpget(url)
            if not html:
                self.log.error("ERROR: Could not fetch {0}".format(url))
                self.rankingstimer = utcnow+60
                self.log.info("_rankings: AP html failed")
            try:  # parse the table and populate.
                soup = BeautifulSoup(html)
                table = soup.find('table', attrs={'id':'ysprankings-results-table'})
                rows = table.findAll('tr')[1:26]  # just to make sure.
                for i, row in enumerate(rows):
                    team = row.find('a')['href'].split('/')[5]  # find the team abbr.
                    self.rankings[team] = i+1  # populate dict.
                # now finalize.
                self.rankingstimer = utcnow+86400 # 24hr.
                self.log.info("_rankings: updated AP rankings.")
            except Exception, e:  # something went wrong.
                self.log.error("_rankings: AP ERROR: {0}".format(e))
                self.rankingstimer = utcnow+60  # rerun in one minute.

    def _gctosec(self, s):
        """Convert seconds of clock into an integer of seconds remaining."""

        if ':' in s:
            l = s.split(':')
            return int(int(l[0]) * 60 + int(l[1]))
        else:
            return int(round(float(s)))

    ######################
    # CHANNEL MANAGEMENT #
    ######################

    def cfbliveon(self, irc, msg, args):
        """
        Re-enable CFBLive updates in channel.
        Must be enabled by an op in the channel scores are already enabled for.
        """

        # channel
        channel = channel.lower()
        # check if op.
        if not irc.state.channels[channel].isOp(msg.nick):
            irc.reply("ERROR: You must be an op in this channel for this command to work.")
            return
        # check if channel is already on.
        if channel in self.channels:
            irc.reply("ERROR: {0} is already enabled for CFBLive updates.".format(channel))
        # we're here if it's not. let's re-add whatever we have saved.
        # most of this is from _loadchannels
        try:
            datafile = open(conf.supybot.directories.data.dirize(self.name()+".pickle"), 'rb')
            try:
                dataset = pickle.load(datafile)
            finally:
                datafile.close()
        except IOError:
            irc.reply("ERROR: I could not open the CFBLive pickle to restore. Something went horribly wrong.")
            return
        # now check if channels is in the dataset from the pickle.
        if channel in dataset['channels']:  # it is. we're good.
            self.channels[channel] = dataset['channels'][channel]  # restore it.
        else:
            irc.reply("ERROR: {0} is not in the saved channel list. Please use cfbchannel to add it.".format(channel))

    cfbliveon = wrap(cfbliveon, [('channel')])

    def cfbliveoff(self, irc, msg, args):
        """
        Disable CFBLive scoring updates in a channel.
        Must be issued by an op in a channel it is enabled for.
        """

        # channel
        channel = channel.lower()
        # check if op.
        if not irc.state.channels[channel].isOp(msg.nick):
            irc.reply("ERROR: You must be an op in this channel for this command to work.")
            return
        # check if channel is already on.
        if channel not in self.channels:
            irc.reply("ERROR: {0} is not in self.channels. I can't disable updates for a channel I don't update in.".format(channel))
            return
        else:  # channel is in the dict so lets do a temp disable by deleting it.
            del self.channels[channel]
            irc.reply("I have successfully disabled cfblive updates in {0}".format(channel))

    cfbliveoff = wrap(cfbliveoff, [('channel')])

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

    def cfbgames(self, irc, msg, args):
        """
        Display all current games in the self.games
        """

        games = self._fetchgames(filt=False)
        if not games:
            irc.reply("ERROR: Fetching games.")
            return
        for (k, v) in games.items():
            at = self._tidwrapper(v['awayteam'])
            ht = self._tidwrapper(v['hometeam'])
            irc.reply("{0} v. {1} :: {2}".format(at, ht, v))

    cfbgames = wrap(cfbgames)

    def checkcfb(self, irc):
    #def checkcfb(self, irc, msg, args):
        """
        Main loop.
        """

        # debug.
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

        # before we run the main event handler, make sure we have rankings.
        self._rankings()
        # main handler for event changes.
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
                        # first, get some basics with teamnames.
                        at = self._tidwrapper(v['awayteam'], d=True)  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'], d=True)  # fetch home.
                        # get the score diff so we can figure out the score type and who scored.
                        apdiff = abs((int(v['awayscore'])-int(games2[k]['awayscore'])))  # awaypoint diff.
                        hpdiff = abs((int(v['homescore'])-int(games2[k]['homescore'])))  # homepoint diff.
                        if apdiff != 0:  # awayscore is not 0, ie: awayteam scored.
                            sediff = apdiff  # int
                            seteam = at['team']  # get awayteam.
                        else:  # hometeam scored.
                            sediff = hpdiff  # int
                            seteam = ht['team']  # get awayteam.
                        # figure out the scoretype.
                        setype = self._scoretype(sediff)  # figure out score type.
                        # first, we need to reconstruct at/ht as a string. since we called tidwrapper with d=True, we have to reattach the ranking, if present.
                        if 'rank' in at:  # we have rank so (#)Team.
                            at = "({0}){1}".format(at['rank'], at['team'])
                        else:  # no rank.
                            at = "{0}".format(at['team'])
                        if 'rank' in ht:  # do the same for the hometeam.
                            ht = "({0}){1}".format(ht['rank'], ht['team'])
                        else:  # no rank.
                            ht = "{0}".format(ht['team'])
                        # now construct the rest of the string.
                        gamestr = self._boldleader(at, games2[k]['awayscore'], ht, games2[k]['homescore'])  # bold the leader.
                        scoretime = "{0} {1}".format(utils.str.ordinal(games2[k]['quarter']), games2[k]['time'])  # score time.
                        se = self._scoreevent(v['hometeam'])  # use the hometeam id for plays-### (scoreevent page).
                        if se:  # we got scoringevent back.
                            # make sure this event has not been posted yet.
                            if se['id'] not in self.dupedict[k]:  # we have NOT posted it yet. lets format for output.
                                mstr = "{0} :: {1} :: {2} :: {3} ({4})".format(gamestr, ircutils.bold(setype), seteam, se['event'], scoretime)  # lets construct the string.
                                self._post(irc, v['awayteam'], v['hometeam'], mstr)  # post to irc.
                                self.dupedict[k].add(se['id'])  # add to dupedict.
                        else:  # scoring event did not work. just post a generic string. this could be buggy.
                            mstr = "{0} :: {1} :: {2} ({3})".format(gamestr, ircutils.bold(setype), seteam, scoretime)
                            self._post(irc, v['awayteam'], v['hometeam'], mstr)  # post to irc.
                    # UPSET ALERT. CHECKS ONLY IN 4TH QUARTER AT 2 MINUTE MARK.
                    if ((games2[k]['quarter'] == "4") and (v['time'] != games2[k]['time']) and (self._gctosec(v['time']) >= 120) and self._gctosec(games2[k]['time'] < 120)):
                        self.log.info("Should fire upset alert in {0}".format(k))
                        # fetch teams with ranking in dict so we can determine if there is a potential upset on hand.
                        at = self._tidwrapper(v['awayteam'], d=True)  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'], d=True)  # fetch home.
                        # now we need to check if there is a ranking in either or both teams and
                        # act properly depending on the rank + score.
                        if (('rank' in at) or ('rank' in ht)):  # require ranking. 3 scenarios: at ranked, ht ranked, both ranked.
                            awayscore = games2[k]['awayscore']  # grab the score.
                            homescore = games2[k]['homescore']
                            scorediff =  abs(awayscore-homescore)  # abs on the diff.
                            upsetalert, potentialupsetalert, upsetstr = False, False, None  # defaults.
                            if (('rank' in at) and ('rank' not in ht)):  # away team ranked, home team is not.
                                if homescore > awayscore:  # ranked awayteam is losing.
                                    upsetalert = True
                                elif scorediff < 9:  # score is within a single possession.
                                    potentialupsetalert = True
                            elif (('rank' not in at) and ('rank' in ht)):  # home team ranked, away is not.
                                if awayscore > homescore:  # ranked hometeam is losing.
                                    upsetalert = True
                                elif scorediff < 9:  # score is within a single possession.
                                    potentialupsetalert = True
                            else:  # both teams are ranked, so we have to check that is higher.
                                if at['rank'] > ht['rank']:  # away team ranked higher.
                                    if homescore > awayscore:  # home team is winning.
                                        upsetalert = True
                                    elif scorediff < 9:  # score is within a single possession.
                                        potentialupsetalert = True
                                elif ht['rank'] > at['rank']:  # home team is ranked higher.
                                    if awayscore > homescore:  # away team is winning.
                                        upsetalert = True
                                    elif scorediff < 9:  # score is within a single possession.
                                        potentialupsetalert = True
                            # now that we're done, we check on upsetalert and potentialupsetalert to set upsetstr.
                            if upsetalert:  # we have an upset alert.
                                upsetstr = ircutils.bold("UPSET ALERT")
                            elif potentialupsetalert:  # we have a potential upset.
                                upsetstr = ircutils.bold("POTENTIAL UPSET ALERT")
                            # should we fire?
                            if upsetstr:  # this was set above if conditions were met. so lets get our std gamestr, w/score, add the string, and post.
                                gamestr = self._boldleader(self._tidwrapper(v['awayteam']), games2[k]['awayscore'], self._tidwrapper(v['hometeam']), games2[k]['homescore'])
                                mstr = "{0} :: {1}".format(gamestr, upsetstr)
                                self._post(irc, v['awayteam'], v['hometeam'], mstr)
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
                        otper = "Start OT{0}".format(int(games2[k]['quarter'])-4)  # should start with 5, which is OT1.
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
                        # now construct kickoff event.
                        at = self._tidwrapper(v['awayteam'])  # fetch visitor.
                        ht = self._tidwrapper(v['hometeam'])  # fetch home.
                        atconf = self._tidtoconf(v['awayteam'])  # fetch visitor conf.
                        htconf = self._tidtoconf(v['hometeam'])  # fetch hometeam conf.
                        mstr = "{0}({1}) @ {2}({3}) :: {4}".format(ircutils.bold(at), atconf, ircutils.bold(ht), htconf, ircutils.mircColor("KICKOFF", 'green'))
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
        # STATUSES :: D = Delay, P = Playing, S = Future Game, F = Final, O = PPD
        # first, we grab all the statuses in newgames (games2)
        gamestatuses = set([i['status'] for i in games2.values()])
        self.log.info("GAMESTATUSES: {0}".format(gamestatuses))
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
                    self.nextcheck = utcnow+600
                    self.log.info("checkcfb: firstgametime is over an hour late so we're going to backoff for 10 minutes")
        else:  # everything is "F" (Final). we want to backoff so we're not flooding.
            self.nextcheck = self._utcnow()+600  # 10 minutes from now.
            self.log.info("checkcfb: no active games and I have not got new games yet, so I am holding off for 10 minutes.")

    #checkcfb = wrap(checkcfb)

Class = CFBLive

# vim:set shiftwidth=4 softtabstop=4 expandtab textwidth=79:
