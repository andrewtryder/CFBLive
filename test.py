###
# Copyright (c) 2013-2014, spline
# All rights reserved.
#
#
###

from supybot.test import *

class CFBLiveTestCase(ChannelPluginTestCase):
    plugins = ('CFBLive',)

    def testCFBLive(self):
        self.assertResponse('cfbchannel add #test SEC', 'I have added SEC into #test')
        self.assertResponse('cfbchannel del #test SEC', 'I have successfully removed SEC from #test')

    

# vim:set shiftwidth=4 tabstop=4 expandtab textwidth=79:
