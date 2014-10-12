###
# Copyright (c) 2013-2014, spline
# All rights reserved.
#
#
###

from supybot.test import *

class CFBLiveTestCase(PluginTestCase):
    plugins = ('CFBLive',)

    def testCFBLive(self):
        self.assertError('cfbchannel add #test SEC', 'I have added SEC into #test')
        self.assertError('cfbchannel del #test SEC', 'I have successfully removed SEC from #test')

    

# vim:set shiftwidth=4 tabstop=4 expandtab textwidth=79:
