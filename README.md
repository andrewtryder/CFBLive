Supybot-CFBLive
===============

If you do not know what this plugin does, do not use it. Very simple. It's intended for a small group of people. Don't ask nor expect support.

Again, thanks to Intrepd for help.

g|201301070104|73|104|F|31|4|0:00|42|14|1357608600|3|9|79|0|1|1|0|0|0
#
 0|g|
 1|201301070104|gameid
 2|          73|Visiting
 3|         104|Home
 4|           F|status (S has 1)
 5|          31|? (see above: S has 1)
 6|           4|Quarter
 7|        0:00|Time
 8|          42|Visiting Score
 9|          14|Home Score
10| 1357608600 |starttime GMT
11|          3 |currentDown
12|          9 |distance
13|          79|distanceToScore
14|          0 |drivePlays
15|          1 |driveTotal
16|          1 |awayTimeOuts
17|          0 |homeTimeOuts
18|          0 |venueId
19|          0 |?

20:38:27 <Intrepd> II
20:38:27 <Intrepd> IIaway = NFLTeam.fromID(Integer.parseInt(fields[2]));
20:38:27 <Intrepd> IIhome = NFLTeam.fromID(Integer.parseInt(fields[3]));
20:38:27 <Intrepd> IIstate = fields[4];
20:38:27 <Intrepd> IIquarter = Integer.parseInt(fields[6]);
20:38:29 <Intrepd> IItime = fields[7];
20:38:31 <Intrepd> IIawayScore = Integer.parseInt(fields[8]);
20:38:33 <Intrepd> IIhomeScore = Integer.parseInt(fields[9]);
20:38:35 <Intrepd> IIstartTime = new Date(Long.parseLong(fields[10]) * 1000);
20:38:38 <Intrepd> /IIcurrentDown = Integer.parseInt(fields[11]);
20:38:39 <Intrepd> /IIdistance = Integer.parseInt(fields[12]);
20:38:41 <Intrepd> /IIdistanceToScore = Integer.parseInt(fields[13]);
20:38:43 <Intrepd> /IIdrivePlays = Integer.parseInt(fields[14]);
20:38:45 <Intrepd> /IIdriveTotal = Integer.parseInt(fields[15]);
20:38:47 <Intrepd> /IIawayTimeOuts = Integer.parseInt(fields[16]);
20:38:49 <Intrepd> /IIhomeTimeOuts = Integer.parseInt(fields[17]);
20:38:53 <Intrepd> /IIvenueID = Integer.parseInt(fields[18]);II

