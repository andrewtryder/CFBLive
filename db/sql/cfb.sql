------------------
-- DB STRUCTURE --
------------------

-- DIVISIONS
CREATE TABLE IF NOT EXISTS divs (
    id INT PRIMARY KEY,
    division TEXT
    );
-- CONFERENCES
CREATE TABLE IF NOT EXISTS confs (
    division INTEGER,
    id INTEGER PRIMARY KEY,
    conference TEXT,
    FOREIGN KEY(division) REFERENCES divs(id) ON DELETE NO ACTION ON UPDATE NO ACTION
    );
-- TEAMS
CREATE TABLE IF NOT EXISTS teams (
    conf INTEGER, -- link to conference id.
    id INT PRIMARY KEY,
    team TEXT,
    tid TEXT,
    FOREIGN KEY(conf) REFERENCES confs(id) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

----------
-- DATA --
----------

-- DIVISIONS
INSERT INTO divs VALUES ('1', 'FBS');
INSERT INTO divs VALUES ('2', 'non-FBS');

-- CONFS AND TEAMS

-- American Athletic
INSERT INTO confs VALUES ("1", "2", "AAC");
INSERT INTO teams VALUES ("2", "98", "Cincinnati", "ccj");
INSERT INTO teams VALUES ("2", "202", "UConn", "ccq");
INSERT INTO teams VALUES ("2", "80", "Houston", "hhe");
INSERT INTO teams VALUES ("2", "100", "Louisville", "llh");
INSERT INTO teams VALUES ("2", "101", "Memphis", "mmg");
INSERT INTO teams VALUES ("2", "13", "Rutgers", "rrd");
INSERT INTO teams VALUES ("2", "1019", "South Florida", "sbn");
INSERT INTO teams VALUES ("2", "82", "SMU", "smu");
INSERT INTO teams VALUES ("2", "15", "Temple", "ttb");
INSERT INTO teams VALUES ("2", "210", "UCF Knights", "ccf");

-- ACC
INSERT INTO confs VALUES ("1", "1", "ACC");
INSERT INTO teams VALUES ("1", "10", "BC Eagles", "bbf");
INSERT INTO teams VALUES ("1", "1", "Clemsux", "ccl");
INSERT INTO teams VALUES ("1", "2", "Duke", "ddf");
INSERT INTO teams VALUES ("1", "3", "FSU", "ffc");
INSERT INTO teams VALUES ("1", "4", "Georgia Tech", "ggc");
INSERT INTO teams VALUES ("1", "5", "Maryland", "mmd");
INSERT INTO teams VALUES ("1", "11", "Miami", "mmi");
INSERT INTO teams VALUES ("1", "6", "UNC", "nnl");
INSERT INTO teams VALUES ("1", "7", "N.C. State", "nnn");
INSERT INTO teams VALUES ("1", "12", "Pitt", "ppd");
INSERT INTO teams VALUES ("1", "14", "Syracuse", "ssw");
INSERT INTO teams VALUES ("1", "8", "Virginia", "vvb");
INSERT INTO teams VALUES ("1", "16", "Virginia Tech", "vvd");
INSERT INTO teams VALUES ("1", "9", "Wake Forest", "wwa");

-- Big 12
INSERT INTO confs VALUES ("1", "71", "Big 12");
INSERT INTO teams VALUES ("71", "79", "Baylor", "bbb");
INSERT INTO teams VALUES ("71", "19", "Iowa St.", "iih");
INSERT INTO teams VALUES ("71", "20", "Kansas", "kka");
INSERT INTO teams VALUES ("71", "21", "KState", "kkb");
INSERT INTO teams VALUES ("71", "24", "Oklahoma", "ooc");
INSERT INTO teams VALUES ("71", "25", "OKState", "ood");
INSERT INTO teams VALUES ("71", "85", "TCU", "tta");
INSERT INTO teams VALUES ("71", "83", "Schlonghorns", "tth");
INSERT INTO teams VALUES ("71", "86", "Texas Tech", "tto");
INSERT INTO teams VALUES ("71", "17", "WVU", "wwh");

-- Big 10
INSERT INTO confs VALUES ("1", "4", "Big 10");
INSERT INTO teams VALUES ("4", "26", "Illinois", "iic");
INSERT INTO teams VALUES ("4", "27", "Indiana", "iie");
INSERT INTO teams VALUES ("4", "28", "Iowa", "iig");
INSERT INTO teams VALUES ("4", "30", "Michigan St.", "mml");
INSERT INTO teams VALUES ("4", "29", "Michigan", "mmk");
INSERT INTO teams VALUES ("4", "31", "Minnesota", "mmn");
INSERT INTO teams VALUES ("4", "23", "Nebraska", "nnd");
INSERT INTO teams VALUES ("4", "32", "Northwestern", "nnv");
INSERT INTO teams VALUES ("4", "33", "Ohio St.", "oob");
INSERT INTO teams VALUES ("4", "34", "PSU", "ppb");
INSERT INTO teams VALUES ("4", "35", "Purdue", "ppj");
INSERT INTO teams VALUES ("4", "36", "Wisconsin", "wwo");

-- Conference USA
INSERT INTO confs VALUES ("1", "72", "Conference USA");
INSERT INTO teams VALUES ("72", "99", "E. Carolina", "eea");
INSERT INTO teams VALUES ("72", "2294", "Florida Atl.", "ffr");
INSERT INTO teams VALUES ("72", "2307", "Florida Intl.", "fli");
INSERT INTO teams VALUES ("72", "38", "Louisiana Tech", "llg");
INSERT INTO teams VALUES ("72", "176", "Marshall", "mmc");
INSERT INTO teams VALUES ("72", "152", "Middle Tenn.", "mmm");
INSERT INTO teams VALUES ("72", "182", "North Texas", "nnp");
INSERT INTO teams VALUES ("72", "81", "Rice", "rrb");
INSERT INTO teams VALUES ("72", "105", "Southern Miss", "sso");
INSERT INTO teams VALUES ("72", "106", "Tulane", "tts");
INSERT INTO teams VALUES ("72", "107", "Tulsa", "ttt");
INSERT INTO teams VALUES ("72", "207", "UAB", "aaz");
INSERT INTO teams VALUES ("72", "95", "UTEP", "ttl");
INSERT INTO teams VALUES ("72", "2560", "UTSA", "tsa");

-- FBS Independents
INSERT INTO confs VALUES ("1", "11", "FBS Independents");
INSERT INTO teams VALUES ("11", "97", "Army", "aaq");
INSERT INTO teams VALUES ("11", "88", "BYU", "bbi");
INSERT INTO teams VALUES ("11", "114", "Idaho", "iia");
INSERT INTO teams VALUES ("11", "102", "Navy", "nna");
INSERT INTO teams VALUES ("11", "41", "N.M. State", "nni");
INSERT INTO teams VALUES ("11", "104", "Notre Dame", "nnx");
INSERT INTO teams VALUES ("11", "2371", "Old Dominion", "oah");

-- Mid-American
INSERT INTO confs VALUES ("1", "6", "Mid-American");
INSERT INTO teams VALUES ("6", "47", "Akron", "aac");
INSERT INTO teams VALUES ("6", "48", "Ball St.", "bba");
INSERT INTO teams VALUES ("6", "49", "Bowling Green", "bbh");
INSERT INTO teams VALUES ("6", "208", "Buffalo", "bbp");
INSERT INTO teams VALUES ("6", "50", "Cent. Michigan", "ccg");
INSERT INTO teams VALUES ("6", "51", "East. Michigan", "eef");
INSERT INTO teams VALUES ("6", "52", "Kent St.", "kkc");
INSERT INTO teams VALUES ("6", "204", "UMass", "mme");
INSERT INTO teams VALUES ("6", "53", "Miami (OH)", "mmj");
INSERT INTO teams VALUES ("6", "42", "Northern Ill.", "nns");
INSERT INTO teams VALUES ("6", "54", "Ohio", "ooa");
INSERT INTO teams VALUES ("6", "55", "Toledo", "ttp");
INSERT INTO teams VALUES ("6", "56", "W. Michigan", "wwl");

-- Mountain West
INSERT INTO confs VALUES ("1", "87", "MWC");
INSERT INTO teams VALUES ("87", "87", "Air Force", "aab");
INSERT INTO teams VALUES ("87", "112", "Boise St.", "bbe");
INSERT INTO teams VALUES ("87", "89", "Colorado St.", "cco");
INSERT INTO teams VALUES ("87", "90", "Fresno St.", "ffe");
INSERT INTO teams VALUES ("87", "91", "Hawaii", "hhc");
INSERT INTO teams VALUES ("87", "39", "Nevada", "nnf");
INSERT INTO teams VALUES ("87", "92", "New Mexico", "nnh");
INSERT INTO teams VALUES ("87", "93", "San Diego St.", "ssb");
INSERT INTO teams VALUES ("87", "44", "San Jose St.", "ssc");
INSERT INTO teams VALUES ("87", "40", "UNLV", "nne");
INSERT INTO teams VALUES ("87", "46", "Utah St.", "uud");
INSERT INTO teams VALUES ("87", "96", "Wyoming", "wwq");

-- Pac-12
INSERT INTO confs VALUES ("1", "7", "Pac-12");
INSERT INTO teams VALUES ("7", "58", "Arizona St.", "aam");
INSERT INTO teams VALUES ("7", "57", "Arizona", "aal");
INSERT INTO teams VALUES ("7", "59", "Cal", "ccd");
INSERT INTO teams VALUES ("7", "18", "Colorado", "ccn");
INSERT INTO teams VALUES ("7", "60", "Oregon", "ooe");
INSERT INTO teams VALUES ("7", "61", "Oregon St.", "oof");
INSERT INTO teams VALUES ("7", "63", "Stanford", "sss");
INSERT INTO teams VALUES ("7", "64", "UCLA", "uua");
INSERT INTO teams VALUES ("7", "62", "USC", "uub");
INSERT INTO teams VALUES ("7", "94", "Utah", "uuc");
INSERT INTO teams VALUES ("7", "65", "Washington", "wwb");
INSERT INTO teams VALUES ("7", "66", "Washington St.", "wwc");

-- SEC
INSERT INTO confs VALUES("1", "8", "SEC");
INSERT INTO teams VALUES ("8", "73", "Alabama", "aad");
INSERT INTO teams VALUES ("8", "74", "Arkansas", "aan");
INSERT INTO teams VALUES ("8", "75", "Auburn", "aar");
INSERT INTO teams VALUES ("8", "67", "Florida", "ffa");
INSERT INTO teams VALUES ("8", "68", "Georgia", "ggb");
INSERT INTO teams VALUES ("8", "69", "Kentucky", "kkd");
INSERT INTO teams VALUES ("8", "76", "LSU", "lli");
INSERT INTO teams VALUES ("8", "78", "Miss St.", "mmq");
INSERT INTO teams VALUES ("8", "22", "Missouri", "mms");
INSERT INTO teams VALUES ("8", "77", "Ole Miss", "mmo");
INSERT INTO teams VALUES ("8", "70", "South Carolina", "ssi");
INSERT INTO teams VALUES ("8", "71", "Tennessee", "ttd");
INSERT INTO teams VALUES ("8", "84", "Texas A&M", "ttj");
INSERT INTO teams VALUES ("8", "72", "Vanderbilt", "vva");

-- Sun Belt
INSERT INTO confs VALUES ("1", "90", "Sun Belt");
INSERT INTO teams VALUES ("90", "37", "Arkansas St.", "aap");
INSERT INTO teams VALUES ("90", "2558", "Georgia St.", "gag");
INSERT INTO teams VALUES ("90", "45", "LA Lafayette", "ssq");
INSERT INTO teams VALUES ("90", "103", "LA Monroe", "nnb");
INSERT INTO teams VALUES ("90", "2549", "South Alabama", "sal");
INSERT INTO teams VALUES ("90", "185", "Texas St.", "ssv");
INSERT INTO teams VALUES ("90", "222", "Troy", "ttv");
INSERT INTO teams VALUES ("90", "224", "W. Kentucky", "wwk");

---------------------------------------------------------------------------
-- NON-FBS ARE BELOW - WE GENERALIZE THESE BECAUSE OUR SOURCE IS HORRIBLE -
-- I ORGANIZE THESE BY LOW->HIGH ON CONFERENCE ID.                        -
-- I USED A SCRIPT TO POPULATE MANY SO THERE ARE DUPES.                   -
---------------------------------------------------------------------------

-- Big Sky
INSERT INTO confs VALUES ("2", "13", "Big Sky");
INSERT INTO teams VALUES ("13", "108", "Cal Poly", "cca");
INSERT INTO teams VALUES ("13", "113", "Eastern Wash.", "eeg");
INSERT INTO teams VALUES ("13", "115", "Idaho St.", "iib");
INSERT INTO teams VALUES ("13", "116", "Montana", "mmu");
INSERT INTO teams VALUES ("13", "117", "Montana St.", "mmv");
INSERT INTO teams VALUES ("14", "308", "North Dakota", "nno");
INSERT INTO teams VALUES ("13", "118", "Northern Arizona", "nnr");
INSERT INTO teams VALUES ("13", "310", "Northern Colorado", "nnz");
INSERT INTO teams VALUES ("13", "257", "Portland St.", "ppe");
INSERT INTO teams VALUES ("13", "110", "Sacramento St.", "ses");
INSERT INTO teams VALUES ("13", "111", "Southern Utah", "ssp");
INSERT INTO teams VALUES ("13", "263", "UC Davis", "ccb");
INSERT INTO teams VALUES ("13", "119", "Weber St.", "wwe");
INSERT INTO teams VALUES ("13", "109", "Cal St. Northridge", "");

-- Missouri Valley Conference
INSERT INTO confs VALUES ("2", "14", "MVC");
INSERT INTO teams VALUES ("14", "121", "Illinois St.", "iid");
INSERT INTO teams VALUES ("14", "122", "Indiana St.", "iif");
INSERT INTO teams VALUES ("14", "125", "Missouri St.", "ssu");
INSERT INTO teams VALUES ("14", "309", "N.D. St.", "nds");
INSERT INTO teams VALUES ("14", "123", "Northern Iowa", "nnt");
INSERT INTO teams VALUES ("14", "311", "South Dakota", "ssk");
INSERT INTO teams VALUES ("14", "312", "S. Dakota St.", "sds");
INSERT INTO teams VALUES ("14", "124", "Southern Ill.", "ssn");
INSERT INTO teams VALUES ("14", "126", "Western Ill.", "wwj");
INSERT INTO teams VALUES ("14", "225", "Youngstown St.", "yyb");

-- Ivy League
INSERT INTO confs VALUES ("2", "15", "Ivy");
INSERT INTO teams VALUES ("15", "127", "Brown", "bbj");
INSERT INTO teams VALUES ("15", "128", "Columbia", "ccp");
INSERT INTO teams VALUES ("15", "129", "Cornell", "ccr");
INSERT INTO teams VALUES ("15", "130", "Dartmouth", "dda");
INSERT INTO teams VALUES ("15", "131", "Harvard", "hhb");
INSERT INTO teams VALUES ("15", "132", "Pennsylvania", "ppc");
INSERT INTO teams VALUES ("15", "133", "Princeton", "pph");
INSERT INTO teams VALUES ("15", "134", "Yale", "yya");

-- MEAC
INSERT INTO confs VALUES ("2", "17", "MEAC");
INSERT INTO teams VALUES ("17", "143", "Bethune-Cookman", "bbc");
INSERT INTO teams VALUES ("17", "144", "Delaware St.", "ddd");
INSERT INTO teams VALUES ("17", "145", "Florida A&M", "ffb");
INSERT INTO teams VALUES ("17", "229", "Hampton", "hha");
INSERT INTO teams VALUES ("17", "146", "Howard", "hhf");
INSERT INTO teams VALUES ("17", "147", "Morgan St.", "mmx");
INSERT INTO teams VALUES ("17", "621", "NC Central", "nac");
INSERT INTO teams VALUES ("17", "233", "Norfolk St.", "nan");
INSERT INTO teams VALUES ("17", "148", "NC A&T", "nnm");
INSERT INTO teams VALUES ("17", "363", "Savannah St.", "ssx");
INSERT INTO teams VALUES ("17", "149", "SCarolina St.", "ssj");

-- Ohio Valley
INSERT INTO confs VALUES ("2", "18", "OVC");
INSERT INTO teams VALUES ("18", "150", "Austin Peay", "aas");
INSERT INTO teams VALUES ("18", "120", "E. Illinois", "eed");
INSERT INTO teams VALUES ("18", "151", "E. Kentucky", "eee");
INSERT INTO teams VALUES ("18", "247", "Jacksonville St.", "jjc");
INSERT INTO teams VALUES ("18", "154", "Murray St.", "mmz");
INSERT INTO teams VALUES ("18", "155", "SE Missouri St.", "ssf");
INSERT INTO teams VALUES ("18", "157", "Tennessee St.", "ttf");
INSERT INTO teams VALUES ("18", "158", "Tennessee Tech", "ttg");
INSERT INTO teams VALUES ("18", "156", "Tenn-Martin", "tte");

-- Patriot League
INSERT INTO confs VALUES ("2", "19", "Patriot League");
INSERT INTO teams VALUES ("19", "159", "Bucknell", "bbk");
INSERT INTO teams VALUES ("19", "160", "Colgate", "ccm");
INSERT INTO teams VALUES ("19", "161", "Fordham", "ffl");
INSERT INTO teams VALUES ("19", "137", "Georgetown", "ggk");
INSERT INTO teams VALUES ("19", "162", "Holy Cross", "hhd");
INSERT INTO teams VALUES ("19", "163", "Lafayette", "lla");
INSERT INTO teams VALUES ("19", "164", "Lehigh", "llc");

-- Pioneer League
INSERT INTO confs VALUES ("2", "20", "Pioneer League");
INSERT INTO teams VALUES ("20", "165", "Butler", "bbr");
INSERT INTO teams VALUES ("20", "2357", "Campbell", "cam");
INSERT INTO teams VALUES ("20", "212", "Davidson", "ddb");
INSERT INTO teams VALUES ("20", "166", "Dayton", "ddj");
INSERT INTO teams VALUES ("20", "167", "Drake", "dde");
INSERT INTO teams VALUES ("20", "2001", "Jacksonville", "jjg");
INSERT INTO teams VALUES ("20", "139", "Marist", "mad");
INSERT INTO teams VALUES ("20", "2597", "Mercer", "");
INSERT INTO teams VALUES ("20", "153", "Morehead St.", "mmw");
INSERT INTO teams VALUES ("20", "169", "San Diego", "sbc");
INSERT INTO teams VALUES ("20", "2598", "Stetson", "");
INSERT INTO teams VALUES ("20", "170", "Valparaiso", "vvi");

-- Southern
INSERT INTO confs VALUES ("2", "21", "Southern");
INSERT INTO teams VALUES ("21", "171", "Appalachian St.", "aak");
INSERT INTO teams VALUES ("21", "177", "Chattanooga", "cas");
INSERT INTO teams VALUES ("21", "172", "Citadel", "cck");
INSERT INTO teams VALUES ("21", "350", "Elon", "eeo");
INSERT INTO teams VALUES ("21", "174", "Furman", "ffg");
INSERT INTO teams VALUES ("21", "175", "Georgia Southern", "ggh");
INSERT INTO teams VALUES ("21", "218", "Samford", "sks");
INSERT INTO teams VALUES ("21", "179", "W. Carolina", "wwi");
INSERT INTO teams VALUES ("21", "267", "Wofford", "wwp");

-- Southland
INSERT INTO confs VALUES ("2", "22", "Southland");
INSERT INTO teams VALUES ("22", "268", "C. Arkansas", "uca");
INSERT INTO teams VALUES ("22", "2559", "Lamar", "lab");
INSERT INTO teams VALUES ("22", "180", "McNeese St.", "mmf");
INSERT INTO teams VALUES ("22", "181", "Nicholls St.", "nnk");
INSERT INTO teams VALUES ("22", "183", "Northwestern St.", "nnw");
INSERT INTO teams VALUES ("22", "184", "Sam Houston St.", "ssa");
INSERT INTO teams VALUES ("22", "2234", "SE Louisiana", "sse");
INSERT INTO teams VALUES ("22", "186", "Stephen F. Austin", "sst");

-- SWAC
INSERT INTO confs VALUES ("2", "23", "SWAC");
INSERT INTO teams VALUES ("23", "356", "Alabama A&M", "aae");
INSERT INTO teams VALUES ("23", "187", "Alabama St.", "aaf");
INSERT INTO teams VALUES ("23", "188", "Alcorn St.", "aah");
INSERT INTO teams VALUES ("23", "589", "AR Pine Bluff", "aao");
INSERT INTO teams VALUES ("23", "189", "Grambling St.", "ggd");
INSERT INTO teams VALUES ("23", "190", "Jackson St.", "jja");
INSERT INTO teams VALUES ("23", "191", "Miss. Valley St.", "mmr");
INSERT INTO teams VALUES ("23", "192", "Prairie View A&M", "ppf");
INSERT INTO teams VALUES ("23", "193", "Southern", "ssl");
INSERT INTO teams VALUES ("23", "194", "Texas Southern", "ttn");

-- CIAA
INSERT INTO confs VALUES ("2", "25", "CIAA");
INSERT INTO teams VALUES ("25", "226", "Bowie St.", "");
INSERT INTO teams VALUES ("25", "2007", "Chowan", "");
INSERT INTO teams VALUES ("25", "227", "Elizabeth City St.", "");
INSERT INTO teams VALUES ("25", "228", "Fayetteville St.", "");
INSERT INTO teams VALUES ("25", "230", "Johnson C. Smith", "");
INSERT INTO teams VALUES ("25", "2467", "Lincoln Univ. (PA)", "");
INSERT INTO teams VALUES ("25", "231", "Livingstone", "");
INSERT INTO teams VALUES ("25", "2333", "Shaw", "");
INSERT INTO teams VALUES ("25", "2330", "St. Augustine's", "");
INSERT INTO teams VALUES ("25", "2337", "St. Paul's", "");
INSERT INTO teams VALUES ("25", "234", "Virginia St.", "");
INSERT INTO teams VALUES ("25", "235", "Virginia Union", "");
INSERT INTO teams VALUES ("25", "236", "Winston-Salem St.", "");

-- Eastern Collegiate
INSERT INTO confs VALUES ("2", "26", "Eastern Collegiate");
INSERT INTO teams VALUES ("26", "409", "Norwich Cadets", "");
INSERT INTO teams VALUES ("26", "564", "Gallaudet Univ.", "");
INSERT INTO teams VALUES ("26", "2389", "Becker College", "");
INSERT INTO teams VALUES ("26", "2390", "Castleton St.", "");
INSERT INTO teams VALUES ("26", "2372", "SUNY-Maritime", "");
INSERT INTO teams VALUES ("26", "2346", "Husson Univ.", "");
INSERT INTO teams VALUES ("26", "2493", "Mount Ida Col.", "");
INSERT INTO teams VALUES ("26", "2494", "Anna Maria Col.", "");
INSERT INTO teams VALUES ("26", "2440", "Gallaudet Univ.", "");

-- Gulf South
INSERT INTO confs VALUES ("2", "27", "Gulf South");
INSERT INTO teams VALUES ("27", "608", "Arkansas Tech", "");
INSERT INTO teams VALUES ("27", "598", "Arkansas-Monticello", "");
INSERT INTO teams VALUES ("27", "269", "Delta St.", "");
INSERT INTO teams VALUES ("27", "618", "Harding", "");
INSERT INTO teams VALUES ("27", "270", "Henderson St.", "");
INSERT INTO teams VALUES ("27", "273", "North Alabama", "");
INSERT INTO teams VALUES ("27", "1658", "Ouachita Baptist", "");
INSERT INTO teams VALUES ("27", "609", "Southern Ark.", "");
INSERT INTO teams VALUES ("27", "274", "Valdosta St.", "");
INSERT INTO teams VALUES ("27", "610", "West Alabama", "");
INSERT INTO teams VALUES ("27", "275", "West Georgia", "");

-- Lone Star
INSERT INTO confs VALUES ("2", "28", "Lone Star");
INSERT INTO teams VALUES ("28", "277", "Angelo St.", "");
INSERT INTO teams VALUES ("28", "278", "Cent. Oklahoma", "");
INSERT INTO teams VALUES ("28", "2309", "E. Central", "");
INSERT INTO teams VALUES ("28", "280", "Eastern N.M.", "");
INSERT INTO teams VALUES ("28", "369", "Midwestern St.", "");
INSERT INTO teams VALUES ("28", "2299", "Northeastern St.", "");
INSERT INTO teams VALUES ("28", "1386", "Southeastern O.K.", "");
INSERT INTO teams VALUES ("28", "1814", "Southwestern O.K. St.", "");
INSERT INTO teams VALUES ("28", "262", "Tarleton St.", "");
INSERT INTO teams VALUES ("28", "279", "TA&M-Commerce", "");
INSERT INTO teams VALUES ("28", "617", "TA&M-Kingsville", "");
INSERT INTO teams VALUES ("28", "265", "W. Texas A&M", "");

-- MID-AMERICA INTERCOLLEGIATE ATHLETICS ASSOCIATION
INSERT INTO confs VALUES ("2", "29", "Mid-America Intercollegiate");
INSERT INTO teams VALUES ("29", "282", "Cent. Missouri St.", "");
INSERT INTO teams VALUES ("29", "283", "Emporia St.", "");
INSERT INTO teams VALUES ("29", "342", "Fort Hays St.", "");
INSERT INTO teams VALUES ("29", "285", "Missouri Southern St.", "");
INSERT INTO teams VALUES ("29", "286", "Missouri Western St.", "");
INSERT INTO teams VALUES ("29", "307", "Nebraska-Omaha", "");
INSERT INTO teams VALUES ("29", "288", "Northwest Missouri St.", "");
INSERT INTO teams VALUES ("29", "289", "Pittsburg St.", "");
INSERT INTO teams VALUES ("29", "287", "Truman St.", "");
INSERT INTO teams VALUES ("29", "291", "Washburn", "");

-- Midwest Intercollegiate
INSERT INTO confs VALUES ("2", "30", "Midwest Intercollegiate");
INSERT INTO teams VALUES ("30", "447", "Beloit Col.", "");
INSERT INTO teams VALUES ("30", "448", "Carroll Univ. (WI)", "");
INSERT INTO teams VALUES ("30", "449", "Lake Forest Col.", "");
INSERT INTO teams VALUES ("30", "450", "Lawrence Univ.", "");
INSERT INTO teams VALUES ("30", "451", "Ripon College", "");
INSERT INTO teams VALUES ("30", "452", "St. Norbert Col.", "");
INSERT INTO teams VALUES ("30", "455", "Grinnell Col.", "");
INSERT INTO teams VALUES ("30", "456", "Illinois Col.", "");
INSERT INTO teams VALUES ("30", "457", "Knox College", "");
INSERT INTO teams VALUES ("30", "458", "Monmouth (IL)", "");
INSERT INTO teams VALUES ("30", "2391", "Beloit College", "");
INSERT INTO teams VALUES ("30", "2403", "Carroll Univ. (WI)", "");
INSERT INTO teams VALUES ("30", "2443", "Grinnell Col.", "");
INSERT INTO teams VALUES ("30", "2459", "Knox College", "");
INSERT INTO teams VALUES ("30", "2462", "Lake Forest Col.", "");
INSERT INTO teams VALUES ("30", "2464", "Lawrence Univ.", "");
INSERT INTO teams VALUES ("30", "2452", "Illinois Col.", "");
INSERT INTO teams VALUES ("30", "2485", "Monmouth (IL)", "");
INSERT INTO teams VALUES ("30", "2523", "St. Norbert Col.", "");
INSERT INTO teams VALUES ("30", "2515", "Ripon College", "");

-- Northern Sun Intercollegiate
INSERT INTO confs VALUES ("2", "33", "Northern Sun Intercollegiate ");
INSERT INTO teams VALUES ("33", "264", "Wayne State (NE)", "");
INSERT INTO teams VALUES ("33", "304", "Augustana (SD)", "");
INSERT INTO teams VALUES ("33", "305", "Minnesota St. Univ.", "");
INSERT INTO teams VALUES ("33", "313", "St. Cloud St.", "");
INSERT INTO teams VALUES ("33", "318", "Bemidji St.", "");
INSERT INTO teams VALUES ("33", "319", "Minnesota-Duluth", "");
INSERT INTO teams VALUES ("33", "321", "Minnesota St.-Moorhead", "");
INSERT INTO teams VALUES ("33", "322", "Northern St.", "");
INSERT INTO teams VALUES ("33", "323", "S.W. Minnesota St.", "");
INSERT INTO teams VALUES ("33", "324", "Winona St.", "");
INSERT INTO teams VALUES ("33", "427", "Upper Iowa", "");
INSERT INTO teams VALUES ("33", "2376", "University of Mary", "");
INSERT INTO teams VALUES ("33", "2334", "Minnesota-Crookston", "");
INSERT INTO teams VALUES ("33", "2345", "Concordia-St. Paul", "");
INSERT INTO teams VALUES ("33", "2335", "Concordia", "");
INSERT INTO teams VALUES ("33", "2336", "Concordia-St.", "");

-- Pennsylvania State Athletic Conference
INSERT INTO confs VALUES ("2", "34", "Pennsylvania State Athletic Conference");
INSERT INTO teams VALUES ("34", "246", "Gannon", "");
INSERT INTO teams VALUES ("34", "251", "LIU-C.W.", "");
INSERT INTO teams VALUES ("34", "253", "Mercyhurst", "");
INSERT INTO teams VALUES ("34", "325", "California (PA)", "");
INSERT INTO teams VALUES ("34", "326", "Clarion Golden", "");
INSERT INTO teams VALUES ("34", "327", "Edinboro", "");
INSERT INTO teams VALUES ("34", "328", "Indiana (PA)", "");
INSERT INTO teams VALUES ("34", "329", "Lock Haven", "");
INSERT INTO teams VALUES ("34", "330", "Shippensburg", "");
INSERT INTO teams VALUES ("34", "331", "Slippery Rock", "");
INSERT INTO teams VALUES ("34", "332", "Bloomsburg", "");
INSERT INTO teams VALUES ("34", "333", "Cheyney", "");
INSERT INTO teams VALUES ("34", "334", "East Stroudsburg", "");
INSERT INTO teams VALUES ("34", "335", "Kutztown", "");
INSERT INTO teams VALUES ("34", "336", "Mansfield", "");
INSERT INTO teams VALUES ("34", "337", "Millersville", "");
INSERT INTO teams VALUES ("34", "338", "West Chester", "");

-- Rocky Mountain Athletic
INSERT INTO confs VALUES ("2", "35", "Rocky Mountain Athletic");
INSERT INTO teams VALUES ("35", "339", "Adams St.", "");
INSERT INTO teams VALUES ("35", "2375", "CSU-Pueblo", "");
INSERT INTO teams VALUES ("35", "340", "Chadron St.", "");
INSERT INTO teams VALUES ("35", "341", "Colorado School of Mines", "");
INSERT INTO teams VALUES ("35", "343", "Ft. Lewis", "");
INSERT INTO teams VALUES ("35", "344", "Mesa St.", "");
INSERT INTO teams VALUES ("35", "346", "Nebraska-Kearney", "");
INSERT INTO teams VALUES ("35", "345", "N.Mexico Highlands", "");
INSERT INTO teams VALUES ("35", "266", "Western N.Mexico", "");
INSERT INTO teams VALUES ("35", "347", "Western St.", "");

-- South Atlantic
INSERT INTO confs VALUES ("2", "36", "South Atlantic");
INSERT INTO teams VALUES ("36", "2374", "Brevard Col.", "");
INSERT INTO teams VALUES ("36", "348", "Carson-Newman", "");
INSERT INTO teams VALUES ("36", "349", "Catawba", "");
INSERT INTO teams VALUES ("36", "352", "Lenoir-Rhyne", "");
INSERT INTO teams VALUES ("36", "353", "Mars Hill", "");
INSERT INTO teams VALUES ("36", "255", "Newberry", "");
INSERT INTO teams VALUES ("36", "622", "Tusculum", "");
INSERT INTO teams VALUES ("36", "355", "Wingate", "");

-- Southern Intercollegiate Athletic
INSERT INTO confs VALUES ("2", "37", "Southern Intercollegiate Athletic");
INSERT INTO teams VALUES ("37", "357", "Albany St.", "");
INSERT INTO teams VALUES ("37", "2293", "Benedict", "");
INSERT INTO teams VALUES ("37", "358", "Clark Atlanta", "");
INSERT INTO teams VALUES ("37", "359", "Fort Valley St.", "");
INSERT INTO teams VALUES ("37", "248", "Kentucky St.", "");
INSERT INTO teams VALUES ("37", "250", "Lane", "");
INSERT INTO teams VALUES ("37", "360", "Miles", "");
INSERT INTO teams VALUES ("37", "361", "Morehouse", "");
INSERT INTO teams VALUES ("37", "2310", "Stillman", "");
INSERT INTO teams VALUES ("37", "364", "Tuskegee", "");

-- West Virginia Intercollegiate Athletic
INSERT INTO confs VALUES ("2", "39", "West Virginia Intercollegiate Athletic");
INSERT INTO teams VALUES ("39", "2325", "Charleston Univ.", "");
INSERT INTO teams VALUES ("39", "371", "Concord", "");
INSERT INTO teams VALUES ("39", "372", "Fairmont St.", "");
INSERT INTO teams VALUES ("39", "373", "Glenville St.", "");
INSERT INTO teams VALUES ("39", "2377", "Seton Hill", "");
INSERT INTO teams VALUES ("39", "374", "Shepherd", "");
INSERT INTO teams VALUES ("39", "375", "W. Liberty St.", "");
INSERT INTO teams VALUES ("39", "593", "W. Virginia St.", "");
INSERT INTO teams VALUES ("39", "377", "W. Virginia Wesleyan", "");

-- Centennial Football
INSERT INTO confs VALUES ("2", "41", "Centennial Football");
INSERT INTO teams VALUES ("41", "437", "Juniata Col.", "");
INSERT INTO teams VALUES ("41", "439", "Moravian Col.", "");
INSERT INTO teams VALUES ("41", "382", "Dickinson Col.", "");
INSERT INTO teams VALUES ("41", "383", "Franklin & Marshall", "");
INSERT INTO teams VALUES ("41", "384", "Gettysburg", "");
INSERT INTO teams VALUES ("41", "385", "Johns Hopkins", "");
INSERT INTO teams VALUES ("41", "386", "Muhlenberg Col.", "");
INSERT INTO teams VALUES ("41", "388", "Ursinus", "");
INSERT INTO teams VALUES ("41", "389", "McDaniel", "");
INSERT INTO teams VALUES ("41", "2426", "Dickinson Col.", "");
INSERT INTO teams VALUES ("41", "2439", "Franklin & Marshall", "");
INSERT INTO teams VALUES ("41", "2441", "Gettysburg", "");
INSERT INTO teams VALUES ("41", "2455", "Johns Hopkins", "");
INSERT INTO teams VALUES ("41", "2456", "Juniata Col.", "");
INSERT INTO teams VALUES ("41", "2486", "Moravian Col.", "");
INSERT INTO teams VALUES ("41", "2496", "Muhlenberg Col.", "");

-- College Conference of Illinois and Wisconsin
INSERT INTO confs VALUES ("2", "42", "College Conference of Illinois and Wisconsin");
INSERT INTO teams VALUES ("42", "390", "Augustana (IL)", "");
INSERT INTO teams VALUES ("42", "391", "Carthage", "");
INSERT INTO teams VALUES ("42", "392", "Elmhurst Col.", "");
INSERT INTO teams VALUES ("42", "393", "Illinois Wesleyan", "");
INSERT INTO teams VALUES ("42", "394", "Millikin Univ.", "");
INSERT INTO teams VALUES ("42", "395", "North Central", "");
INSERT INTO teams VALUES ("42", "396", "North Park", "");
INSERT INTO teams VALUES ("42", "397", "Wheaton (IL)", "");
INSERT INTO teams VALUES ("42", "2427", "Elmhurst Col.", "");
INSERT INTO teams VALUES ("42", "2453", "Illinois Wesleyan", "");
INSERT INTO teams VALUES ("42", "2483", "Millikin Univ.", "");
INSERT INTO teams VALUES ("42", "2501", "North Park", "");

-- Iowa Intercollegiate Athletic
INSERT INTO confs VALUES ("2", "45", "Iowa Intercollegiate Athletic");
INSERT INTO teams VALUES ("45", "421", "Buena Vista", "");
INSERT INTO teams VALUES ("45", "422", "Central Col.", "");
INSERT INTO teams VALUES ("45", "453", "Coe Col.", "");
INSERT INTO teams VALUES ("45", "423", "Dubuque", "");
INSERT INTO teams VALUES ("45", "424", "Loras Col.", "");
INSERT INTO teams VALUES ("45", "425", "Luther", "");
INSERT INTO teams VALUES ("45", "426", "Simpson Col.", "");
INSERT INTO teams VALUES ("45", "428", "Wartburg", "");
INSERT INTO teams VALUES ("45", "2416", "Cornell Col.", "");
INSERT INTO teams VALUES ("45", "2519", "Simpson Col.", "");
INSERT INTO teams VALUES ("45", "2492", "Wartburg", "");
INSERT INTO teams VALUES ("45", "2468", "Loras Col.", "");
INSERT INTO teams VALUES ("45", "2399", "Buena Vista", "");
INSERT INTO teams VALUES ("45", "2405", "Central Col.", "");
INSERT INTO teams VALUES ("45", "2409", "Coe Col.", "");

-- Michigan Intercollegiate Athletic Association
INSERT INTO confs VALUES ("2", "46", "Michigan Intercollegiate Athletic Association");
INSERT INTO teams VALUES ("46", "430", "Adrian Col.", "");
INSERT INTO teams VALUES ("46", "431", "Albion", "");
INSERT INTO teams VALUES ("46", "432", "Alma Col.", "");
INSERT INTO teams VALUES ("46", "433", "Hope", "");
INSERT INTO teams VALUES ("46", "435", "Olivet Col.", "");
INSERT INTO teams VALUES ("46", "2350", "Kalamazoo", "");
INSERT INTO teams VALUES ("46", "2005", "Trine", "");
INSERT INTO teams VALUES ("46", "2506", "Olivet Col.", "");
INSERT INTO teams VALUES ("46", "2379", "Adrian Col.", "");
INSERT INTO teams VALUES ("46", "2382", "Alma Col.", "");

-- College Conference of Illinois and Wisconsin
INSERT INTO confs VALUES ("2", "47", "Middle Atlantic States Collegiate Athletic");
INSERT INTO teams VALUES ("47", "438", "Lebanon Valley", "");
INSERT INTO teams VALUES ("47", "436", "Albright Col.", "");
INSERT INTO teams VALUES ("47", "441", "Widener Univ.", "");
INSERT INTO teams VALUES ("47", "443", "FDU-Florham", "");
INSERT INTO teams VALUES ("47", "444", "King's Col. (PA)", "");
INSERT INTO teams VALUES ("47", "445", "Lycoming Col.", "");
INSERT INTO teams VALUES ("47", "446", "Wilkes Univ.", "");
INSERT INTO teams VALUES ("47", "2347", "Delaware Valley", "");
INSERT INTO teams VALUES ("47", "2380", "Albright Col.", "");
INSERT INTO teams VALUES ("47", "2430", "Wilkes Univ.", "");
INSERT INTO teams VALUES ("47", "2433", "FDU-Florham", "");
INSERT INTO teams VALUES ("47", "2586", "Stevenson Univ.", "");
INSERT INTO teams VALUES ("47", "2458", "King's College (PA)", "");
INSERT INTO teams VALUES ("47", "2465", "Lebanon Valley", "");
INSERT INTO teams VALUES ("47", "2470", "Lycoming Col.", "");

-- Minnesota Intercollegiate Athletic
INSERT INTO confs VALUES ("2", "49", "Minnesota Intercollegiate Athletic");
INSERT INTO teams VALUES ("49", "459", "Augsburg Col.", "");
INSERT INTO teams VALUES ("49", "460", "Bethel Univ. (MN)", "");
INSERT INTO teams VALUES ("49", "461", "Carleton Col.", "");
INSERT INTO teams VALUES ("49", "462", "Concordia Col. (MN)", "");
INSERT INTO teams VALUES ("49", "463", "Gustavus Adolphus", "");
INSERT INTO teams VALUES ("49", "464", "Hamline Univ.", "");
INSERT INTO teams VALUES ("76", "465", "Macalester Col.", "");
INSERT INTO teams VALUES ("49", "466", "St. John's (MN)", "");
INSERT INTO teams VALUES ("49", "467", "St. Olaf Col.", "");
INSERT INTO teams VALUES ("49", "468", "St. Thomas (MN)", "");
INSERT INTO teams VALUES ("49", "2384", "Augsburg Col.", "");
INSERT INTO teams VALUES ("49", "2414", "Concordia Col. (MN)", "");
INSERT INTO teams VALUES ("49", "2401", "Carleton Col.", "");
INSERT INTO teams VALUES ("49", "2446", "Hamline Univ.", "");
INSERT INTO teams VALUES ("49", "2394", "Bethel Univ. (MN)", "");
INSERT INTO teams VALUES ("49", "2524", "St. Olaf Col.", "");
INSERT INTO teams VALUES ("49", "2526", "St. Thomas (MN)", "");

-- New England Football
INSERT INTO confs VALUES ("2", "51", "New England Football");
INSERT INTO teams VALUES ("51", "239", "Curry Col.", "");
INSERT INTO teams VALUES ("51", "240", "MIT", "");
INSERT INTO teams VALUES ("51", "241", "Nichols Col.", "");
INSERT INTO teams VALUES ("51", "242", "Salve Regina", "");
INSERT INTO teams VALUES ("51", "244", "Western New England", "");
INSERT INTO teams VALUES ("51", "410", "Plymouth St.", "");
INSERT INTO teams VALUES ("51", "406", "U.S. Coast Guard Academy", "");
INSERT INTO teams VALUES ("51", "476", "Bridgewater St.", "");
INSERT INTO teams VALUES ("51", "477", "Fitchburg St.", "");
INSERT INTO teams VALUES ("51", "478", "Framingham St.", "");
INSERT INTO teams VALUES ("51", "479", "Maine Maritime Academy", "");
INSERT INTO teams VALUES ("51", "480", "Massachusetts-Dartmouth", "");
INSERT INTO teams VALUES ("51", "481", "Massachusetts Maritime", "");
INSERT INTO teams VALUES ("51", "483", "Westfield St.", "");
INSERT INTO teams VALUES ("51", "484", "Worcester St.", "");
INSERT INTO teams VALUES ("51", "2428", "Endicott Col.", "");
INSERT INTO teams VALUES ("51", "2398", "Bridgewater St.", "");
INSERT INTO teams VALUES ("51", "2406", "Worcester St.", "");
INSERT INTO teams VALUES ("51", "2421", "Curry Col.", "");
INSERT INTO teams VALUES ("51", "2436", "Westfield St.", "");
INSERT INTO teams VALUES ("51", "2437", "Fitchburg St.", "");
INSERT INTO teams VALUES ("51", "2438", "Framingham St.", "");
INSERT INTO teams VALUES ("51", "2473", "Maine Maritime Academy", "");
INSERT INTO teams VALUES ("51", "2479", "MIT", "");
INSERT INTO teams VALUES ("51", "2480", "Massachusetts Maritime", "");
INSERT INTO teams VALUES ("51", "2481", "Massachusetts-Dartmouth", "");
INSERT INTO teams VALUES ("51", "2488", "Western New England", "");
INSERT INTO teams VALUES ("51", "2499", "Nichols Col.", "");
INSERT INTO teams VALUES ("51", "2531", "U.S. Coast Guard Academy", "");
INSERT INTO teams VALUES ("51", "2509", "Plymouth St.", "");
INSERT INTO teams VALUES ("51", "2518", "Salve Regina", "");

-- New Jersey Athletic
INSERT INTO confs VALUES ("2", "52", "New Jersey Athletic");
INSERT INTO teams VALUES ("52", "412", "Western Conn. St.", "");
INSERT INTO teams VALUES ("52", "486", "Kean Univ.", "");
INSERT INTO teams VALUES ("52", "487", "Montclair St.", "");
INSERT INTO teams VALUES ("52", "488", "Rowan", "");
INSERT INTO teams VALUES ("52", "489", "College of N.J.", "");
INSERT INTO teams VALUES ("52", "490", "William Paterson", "");
INSERT INTO teams VALUES ("52", "553", "Brockport St.", "");
INSERT INTO teams VALUES ("52", "554", "Buffalo St.", "");
INSERT INTO teams VALUES ("52", "560", "SUNY Cortland", "");
INSERT INTO teams VALUES ("52", "2487", "Morrisville St.", "");
INSERT INTO teams VALUES ("52", "2417", "SUNY Cortland", "");

-- North Coast Atletic
INSERT INTO confs VALUES ("2", "53", "North Coast Athletic");
INSERT INTO teams VALUES ("53", "491", "Allegheny", "");
INSERT INTO teams VALUES ("53", "493", "Denison Univ.", "");
INSERT INTO teams VALUES ("53", "494", "Earlham", "");
INSERT INTO teams VALUES ("53", "503", "Hiram Col.", "");
INSERT INTO teams VALUES ("53", "495", "Kenyon Col.", "");
INSERT INTO teams VALUES ("53", "496", "Oberlin Col.", "");
INSERT INTO teams VALUES ("53", "497", "Ohio Wesleyan", "");
INSERT INTO teams VALUES ("53", "420", "Wabash", "");
INSERT INTO teams VALUES ("53", "498", "Wittenberg", "");
INSERT INTO teams VALUES ("53", "499", "Wooster", "");
INSERT INTO teams VALUES ("53", "2514", "Wabash", "");
INSERT INTO teams VALUES ("53", "2457", "Kenyon Col.", "");
INSERT INTO teams VALUES ("53", "2449", "Hiram Col.", "");
INSERT INTO teams VALUES ("53", "2505", "Ohio Wesleyan", "");
INSERT INTO teams VALUES ("53", "2503", "Oberlin Col.", "");
INSERT INTO teams VALUES ("53", "2381", "Allegheny", "");
INSERT INTO teams VALUES ("53", "2424", "Denison Univ.", "");

-- Ohio Athletic
INSERT INTO confs VALUES ("2", "54", "Ohio Athletic");
INSERT INTO teams VALUES ("54", "381", "Wilmington (OH)", "");
INSERT INTO teams VALUES ("54", "500", "Baldwin-Wallace Col.", "");
INSERT INTO teams VALUES ("54", "501", "Capital Univ.", "");
INSERT INTO teams VALUES ("54", "502", "Heidelberg Univ.", "");
INSERT INTO teams VALUES ("54", "504", "John Carroll", "");
INSERT INTO teams VALUES ("54", "505", "Marietta Col.", "");
INSERT INTO teams VALUES ("54", "506", "Mount Union", "");
INSERT INTO teams VALUES ("54", "507", "Muskingum Col.", "");
INSERT INTO teams VALUES ("54", "508", "Ohio Northern", "");
INSERT INTO teams VALUES ("54", "509", "Otterbein Col.", "");
INSERT INTO teams VALUES ("54", "2387", "Baldwin-Wallace Col.", "");
INSERT INTO teams VALUES ("54", "2400", "Capital Univ.", "");
INSERT INTO teams VALUES ("54", "2422", "Wilmington (OH)", "");
INSERT INTO teams VALUES ("54", "2476", "Marietta Col.", "");
INSERT INTO teams VALUES ("54", "2448", "Heidelberg Univ.", "");
INSERT INTO teams VALUES ("54", "2497", "Muskingum Col.", "");
INSERT INTO teams VALUES ("54", "2507", "Otterbein Col.", "");

-- Old Dominion Athletic
INSERT INTO confs VALUES ("2", "55", "Old Dominion Athletic");
INSERT INTO teams VALUES ("55", "510", "Bridgewater (VA)", "");
INSERT INTO teams VALUES ("55", "511", "Emory and Henry", "");
INSERT INTO teams VALUES ("55", "512", "Guilford Col.", "");
INSERT INTO teams VALUES ("55", "513", "Hampden-Sydney", "");
INSERT INTO teams VALUES ("55", "514", "Randolph-Macon", "");
INSERT INTO teams VALUES ("55", "515", "Washington & Lee", "");
INSERT INTO teams VALUES ("55", "555", "Catholic Univ.", "");

-- Presidents' Athletic
INSERT INTO confs VALUES ("2", "56", "Presidents' Athletic");
INSERT INTO teams VALUES ("56", "380", "Thomas More", "");
INSERT INTO teams VALUES ("56", "516", "Bethany Col. (WV)", "");
INSERT INTO teams VALUES ("56", "517", "Grove City Col.", "");
INSERT INTO teams VALUES ("56", "518", "Thiel", "");
INSERT INTO teams VALUES ("56", "519", "Washington & Jefferson", "");
INSERT INTO teams VALUES ("56", "520", "Waynesburg", "");
INSERT INTO teams VALUES ("56", "1765", "St. Vincent", "");
INSERT INTO teams VALUES ("56", "2329", "Geneva Col.", "");
INSERT INTO teams VALUES ("56", "2431", "Westminster (PA)", "");
INSERT INTO teams VALUES ("56", "2527", "St. Vincent", "");
INSERT INTO teams VALUES ("56", "2490", "Waynesburg", "");
INSERT INTO teams VALUES ("56", "2535", "Thomas More", "");
INSERT INTO teams VALUES ("56", "2536", "Thiel", "");
INSERT INTO teams VALUES ("56", "2393", "Bethany Col. (WV)", "");
INSERT INTO teams VALUES ("56", "2444", "Grove City Col.", "");

-- Southern California Intercollegiate Athletic
INSERT INTO confs VALUES ("2", "57", "Southern California Intercollegiate Athletic");
INSERT INTO teams VALUES ("57", "521", "Cal Lutheran", "");
INSERT INTO teams VALUES ("57", "522", "Claremont-Mudd-Scripps", "");
INSERT INTO teams VALUES ("57", "523", "La Verne", "");
INSERT INTO teams VALUES ("57", "524", "Occidental Col.", "");
INSERT INTO teams VALUES ("57", "525", "Pomona-Pitzer", "");
INSERT INTO teams VALUES ("57", "526", "Redlands", "");
INSERT INTO teams VALUES ("57", "527", "Whittier Col.", "");
INSERT INTO teams VALUES ("57", "2504", "Occidental Col.", "");
INSERT INTO teams VALUES ("57", "2510", "Pomona-Pitzer", "");

-- Southern Collegiate Athletic
INSERT INTO confs VALUES ("2", "58", "Southern Collegiate Athletic");
INSERT INTO teams VALUES ("58", "415", "DePauw Univ.", "");
INSERT INTO teams VALUES ("58", "365", "Austin Col.", "");
INSERT INTO teams VALUES ("58", "528", "Centre Col.", "");
INSERT INTO teams VALUES ("58", "529", "Millsaps Col.", "");
INSERT INTO teams VALUES ("58", "530", "Rhodes Col.", "");
INSERT INTO teams VALUES ("58", "532", "Trinity (TX)", "");
INSERT INTO teams VALUES ("58", "558", "Colorado Col.", "");
INSERT INTO teams VALUES ("58", "623", "University of the South", "");
INSERT INTO teams VALUES ("58", "2385", "Austin Col.", "");
INSERT INTO teams VALUES ("58", "2411", "Colorado Col.", "");
INSERT INTO teams VALUES ("58", "2425", "DePauw Univ.", "");
INSERT INTO teams VALUES ("58", "2484", "Millsaps Col.", "");
INSERT INTO teams VALUES ("58", "2513", "Rhodes Col.", "");
INSERT INTO teams VALUES ("58", "2358", "Birmingham-Southern", "");
INSERT INTO teams VALUES ("58", "2600", "Berry", "");

-- University Athletic Association
INSERT INTO confs VALUES ("2", "59", "University Athletic Association");
INSERT INTO teams VALUES ("59", "492", "Case Western Reserve", "");
INSERT INTO teams VALUES ("59", "533", "Carnegie Mellon", "");
INSERT INTO teams VALUES ("59", "537", "Washington (MO)", "");
INSERT INTO teams VALUES ("59", "1036", "Chicago Maroons", "");
INSERT INTO teams VALUES ("59", "2402", "Carnegie Mellon", "");
INSERT INTO teams VALUES ("59", "2404", "Case Western Reserve", "");
INSERT INTO teams VALUES ("59", "2407", "Chicago", "");
INSERT INTO teams VALUES ("59", "2491", "Washington (MO)", "");

-- Frontier
INSERT INTO confs VALUES ("2", "62", "Frontier");
INSERT INTO teams VALUES ("62", "1017", "Eastern Oregon", "");
INSERT INTO teams VALUES ("62", "591", "Montana-Western", "");
INSERT INTO teams VALUES ("62", "600", "Montana Tech", "");
INSERT INTO teams VALUES ("62", "628", "Rocky Mountain", "");
INSERT INTO teams VALUES ("62", "2302", "Montana State-Northern", "");
INSERT INTO teams VALUES ("62", "2306", "Carroll (MT)", "");

-- Midwest Collegiate Athletic
INSERT INTO confs VALUES ("2", "64", "Midwest Collegiate Athletic");
INSERT INTO teams VALUES ("64", "2322", "Waldorf", "");

-- Golden State
INSERT INTO confs VALUES ("2", "67", "Golden State");
INSERT INTO teams VALUES ("67", "599", "Azusa Pacific", "");

-- Mid-South Conference
INSERT INTO confs VALUES ("2", "68", "Mid-South");
INSERT INTO teams VALUES ("68", "2331", "Belhaven", "");
INSERT INTO teams VALUES ("68", "601", "Bethel (TN)", "");
INSERT INTO teams VALUES ("68", "602", "Campbellsville", "");
INSERT INTO teams VALUES ("68", "2311", "Cumberland Coll.", "");
INSERT INTO teams VALUES ("68", "595", "Cumberland Univ.", "");
INSERT INTO teams VALUES ("68", "2365", "Faulkner", "");
INSERT INTO teams VALUES ("68", "592", "Georgetown (KY)", "");
INSERT INTO teams VALUES ("68", "1022", "Lambuth", "");
INSERT INTO teams VALUES ("68", "2341", "Pikeville", "");
INSERT INTO teams VALUES ("68", "2361", "Shorter", "");
INSERT INTO teams VALUES ("68", "1861", "Union", "");
INSERT INTO teams VALUES ("68", "2319", "Union College", "");
INSERT INTO teams VALUES ("68", "626", "Virginia-Wise", "");
INSERT INTO teams VALUES ("68", "376", "W.V. Tech", "");

-- Heart of America Athletic Conference
INSERT INTO confs VALUES ("2", "70", "Heart of America Athletic Conference");
INSERT INTO teams VALUES ("70", "2002", "Lindenwood", "");
INSERT INTO teams VALUES ("70", "2584", "MidAmerica Nazarene", "");
INSERT INTO teams VALUES ("70", "2588", "Avila Univ.", "");
INSERT INTO teams VALUES ("70", "1103", "Baker", "");
INSERT INTO teams VALUES ("70", "2354", "Graceland", "");

-- Northeast
INSERT INTO confs VALUES ("2", "73", "Northeast");
INSERT INTO teams VALUES ("73", "546", "Albany", "aag");
INSERT INTO teams VALUES ("73", "1948", "Bryant", "bvx");
INSERT INTO teams VALUES ("73", "209", "Central Conn. St.", "cce");
INSERT INTO teams VALUES ("73", "136", "Duquesne", "ddi");
INSERT INTO teams VALUES ("73", "216", "Monmouth", "mae");
INSERT INTO teams VALUES ("73", "217", "Robert Morris", "rri");
INSERT INTO teams VALUES ("73", "259", "Sacred Heart", "sbe");
INSERT INTO teams VALUES ("73", "219", "St. Francis (PA)", "sps");
INSERT INTO teams VALUES ("73", "223", "Wagner", "wwa");

-- FCS Independents
INSERT INTO confs VALUES ("2", "74", "FCS Independents");
INSERT INTO teams VALUES ("74", "276", "Abilene Christian", "");
INSERT INTO teams VALUES ("74", "2595", "Charlotte", "nad");
INSERT INTO teams VALUES ("74", "2601", "Houston Baptist", "");
INSERT INTO teams VALUES ("74", "2539", "Incarnate Word", "");
INSERT INTO teams VALUES ("74", "2461", "Lake Erie Col.", "");
INSERT INTO teams VALUES ("74", "2349", "N.C. Pembroke", "");
INSERT INTO teams VALUES ("74", "2003", "N. Greenville", "");
INSERT INTO teams VALUES ("74", "1662", "Panhandle St.", "");
INSERT INTO teams VALUES ("74", "290", "S.W. Baptist", "");
INSERT INTO teams VALUES ("74", "2328", "Urbana", "");
INSERT INTO teams VALUES ("74", "2004", "We. Washington", "");
INSERT INTO teams VALUES ("74", "220", "St. Mary's Gaels", "");
INSERT INTO teams VALUES ("74", "362", "Morris Brown Wolverines", "");

-- Independents (III)
INSERT INTO confs VALUES ("2", "76", "Independents (III)");
INSERT INTO teams VALUES ("76", "556", "Chapman", "");
INSERT INTO teams VALUES ("76", "2451", "Huntingdon Col.", "");
INSERT INTO teams VALUES ("76", "2460", "LaGrange Col.", "");
INSERT INTO teams VALUES ("76", "2471", "Macalester Col.", "");

-- NAIA-I INDEPENDENTS
INSERT INTO confs VALUES ("2", "77", "Independents (NAIA-I)");
INSERT INTO teams VALUES ("77", "2366", "Culver-Stockton", "");
INSERT INTO teams VALUES ("77", "2308", "Edward Waters", "");
INSERT INTO teams VALUES ("77", "1423", "Haskell", "");
INSERT INTO teams VALUES ("77", "2552", "Kentucky Christian", "");
INSERT INTO teams VALUES ("77", "2314", "Manitoba", "");
INSERT INTO teams VALUES ("77", "1691", "Peru State", "");
INSERT INTO teams VALUES ("77", "2356", "Southern Virginia", "");
INSERT INTO teams VALUES ("77", "2315", "St. Francis Xavier", "");
INSERT INTO teams VALUES ("77", "2590", "Ave Maria", "");
INSERT INTO teams VALUES ("77", "2592", "Siena Heights", "");
INSERT INTO teams VALUES ("77", "2551", "Haskell", "");
INSERT INTO teams VALUES ("77", "2546", "Peru St.", "");
INSERT INTO teams VALUES ("77", "2596", "Warner", "");
INSERT INTO teams VALUES ("77", "2599", "Reinhardt", "");

-- NAIA-II INDEPENDENTS
INSERT INTO confs VALUES ("2", "78", "Independents (NAIA-II)");
INSERT INTO teams VALUES ("78", "2364", "Cent. Methodist", "");
INSERT INTO teams VALUES ("78", "2342", "Concordia Coll.", "");
INSERT INTO teams VALUES ("78", "1950", "Evangel", "");
INSERT INTO teams VALUES ("78", "1023", "Sioux Falls", "");
INSERT INTO teams VALUES ("78", "2323", "Webber Intl.", "");
INSERT INTO teams VALUES ("78", "2367", "William Jewell", "");
INSERT INTO teams VALUES ("78", "1020", "Simon Fraser", "");
INSERT INTO teams VALUES ("78", "2547", "Trinity Bible Col.", "");
INSERT INTO teams VALUES ("78", "2556", "George Mason Patriots", "");
INSERT INTO teams VALUES ("78", "2557", "Monterrey Tech", "");
INSERT INTO teams VALUES ("78", "1623", "Northwestern (OK) N/A", "");
INSERT INTO teams VALUES ("78", "1656", "Ottawa", "");
INSERT INTO teams VALUES ("78", "2343", "Laval Rouge", "");
INSERT INTO teams VALUES ("78", "2564", "Ohio State Newark", "");
INSERT INTO teams VALUES ("78", "2565", "Wright St.", "");
INSERT INTO teams VALUES ("78", "2566", "Alfred St.", "");
INSERT INTO teams VALUES ("78", "2567", "Williamson Tech", "");
INSERT INTO teams VALUES ("78", "2587", "Shepherd Tech", "");
INSERT INTO teams VALUES ("78", "2591", "Virginia-Lynchburg", "");
INSERT INTO teams VALUES ("78", "2593", "Point Univ.", "");

-- Liberty Conference
INSERT INTO confs VALUES ("2", "79", "Liberty Conference");
INSERT INTO teams VALUES ("79", "413", "WPI", "");
INSERT INTO teams VALUES ("79", "408", "US Merchant Marine Academy", "");
INSERT INTO teams VALUES ("79", "440", "Susquehanna", "");
INSERT INTO teams VALUES ("79", "567", "Hobart Col.", "");
INSERT INTO teams VALUES ("79", "536", "Rochester", "");
INSERT INTO teams VALUES ("79", "582", "St. Lawrence", "");
INSERT INTO teams VALUES ("79", "585", "Union (NY)", "");
INSERT INTO teams VALUES ("79", "2512", "RPI", "");
INSERT INTO teams VALUES ("79", "2412", "WPI", "");
INSERT INTO teams VALUES ("79", "2450", "Hobart Col.", "");
INSERT INTO teams VALUES ("79", "2522", "St. Lawrence", "");
INSERT INTO teams VALUES ("79", "2529", "Union (NY)", "");
INSERT INTO teams VALUES ("79", "2530", "US Merchant Marine Academy", "");

-- Big South
INSERT INTO confs VALUES ("2", "92", "Big South");
INSERT INTO teams VALUES ("92", "211", "Charleston Sou.", "ccz");
INSERT INTO teams VALUES ("92", "2316", "Coastal Carolina", "cbi");
INSERT INTO teams VALUES ("92", "351", "Gardner-Webb", "ggf");
INSERT INTO teams VALUES ("92", "215", "Liberty", "lle");
INSERT INTO teams VALUES ("92", "354", "Presbyterian", "ppg");
INSERT INTO teams VALUES ("92", "178", "VMI", "vve");

-- American Southwest
INSERT INTO confs VALUES ("2", "93", "American Southwest");
INSERT INTO teams VALUES ("93", "736", "E. Texas Baptist", "");
INSERT INTO teams VALUES ("93", "366", "Hardin-Simmons", "");
INSERT INTO teams VALUES ("93", "367", "Howard Payne", "");
INSERT INTO teams VALUES ("93", "2469", "Louisiana Col.", "");
INSERT INTO teams VALUES ("93", "2352", "Mary Hardin-Baylor", "");
INSERT INTO teams VALUES ("93", "368", "McMurry Univ.", "");
INSERT INTO teams VALUES ("93", "2008", "Mississippi Col.", "");
INSERT INTO teams VALUES ("93", "370", "Sul Ross St.", "");
INSERT INTO teams VALUES ("93", "2537", "Texas Lutheran", "");
INSERT INTO teams VALUES ("93", "2482", "McMurry Univ.", "");
INSERT INTO teams VALUES ("93", "2447", "Hardin-Simmons", "");
INSERT INTO teams VALUES ("93", "2528", "Sul Ross St.", "");

-- Dakota Athletic
INSERT INTO confs VALUES ("2", "94", "Dakota Athletic");
INSERT INTO teams VALUES ("94", "2540", "Minot St.", "");
INSERT INTO teams VALUES ("94", "2550", "Dakota St.", "");
INSERT INTO teams VALUES ("94", "2553", "Jamestown", "");
INSERT INTO teams VALUES ("94", "2555", "Dickinson St.", "");
INSERT INTO teams VALUES ("94", "2312", "Valley City St.", "");
INSERT INTO teams VALUES ("94", "2339", "Black Hills St.", "");
INSERT INTO teams VALUES ("94", "2340", "Mayville St.", "");

-- Northwest
INSERT INTO confs VALUES ("2", "95", "Northwest");
INSERT INTO teams VALUES ("95", "1718", "Puget Sound", "");
INSERT INTO teams VALUES ("95", "2298", "Pacific Lutheran", "");
INSERT INTO teams VALUES ("95", "573", "Menlo Oaks", "");
INSERT INTO teams VALUES ("95", "1502", "Linfield", "");
INSERT INTO teams VALUES ("95", "1929", "Whitworth", "");
INSERT INTO teams VALUES ("95", "2466", "Lewis & Clark", "");
INSERT INTO teams VALUES ("95", "2429", "Willamette", "");
INSERT INTO teams VALUES ("95", "2508", "Pacific Lutheran", "");
INSERT INTO teams VALUES ("95", "2511", "Puget Sound", "");
INSERT INTO teams VALUES ("95", "2562", "Pacific Univ.", "");

-- Great Lakes Intercollegiate Athletic
INSERT INTO confs VALUES ("2", "97", "Great Lakes Intercollegiate Athletic");
INSERT INTO teams VALUES ("97", "292", "Ashland", "");
INSERT INTO teams VALUES ("97", "293", "Ferris St.", "");
INSERT INTO teams VALUES ("97", "1348", "Findlay", "");
INSERT INTO teams VALUES ("97", "294", "Grand Valley St.", "");
INSERT INTO teams VALUES ("97", "2313", "Hillsdale", "");
INSERT INTO teams VALUES ("97", "297", "Michigan Tech", "");
INSERT INTO teams VALUES ("97", "298", "Northern Michigan", "");
INSERT INTO teams VALUES ("97", "299", "Northwood", "");
INSERT INTO teams VALUES ("97", "300", "Saginaw Valley", "");
INSERT INTO teams VALUES ("97", "2295", "Tiffin", "");
INSERT INTO teams VALUES ("97", "296", "Univ. of Indianapolis", "");
INSERT INTO teams VALUES ("97", "303", "Wayne State (MI)", "");

-- CAA
INSERT INTO confs VALUES ("2", "98", "CAA");
INSERT INTO teams VALUES ("98", "195", "Delaware", "ddc");
INSERT INTO teams VALUES ("98", "214", "Hofstra", "ddc");
INSERT INTO teams VALUES ("98", "196", "JMU", "jjb");
INSERT INTO teams VALUES ("98", "203", "Maine", "mma");
INSERT INTO teams VALUES ("98", "205", "New Hampshire", "nng");
INSERT INTO teams VALUES ("98", "197", "Northeastern", "nng");
INSERT INTO teams VALUES ("98", "206", "Rhode Island", "rra");
INSERT INTO teams VALUES ("98", "198", "Richmond", "rrc");
INSERT INTO teams VALUES ("98", "629", "Stony Brook", "sbf");
INSERT INTO teams VALUES ("98", "221", "Towson", "ttq");
INSERT INTO teams VALUES ("98", "199", "Villanova", "vvh");
INSERT INTO teams VALUES ("98", "200", "William & Mary", "wwn");

-- Northeast 10
INSERT INTO confs VALUES ("2", "99", "Northeast 10");
INSERT INTO teams VALUES ("99", "245", "American Intl.", "");
INSERT INTO teams VALUES ("99", "237", "Assumption", "");
INSERT INTO teams VALUES ("99", "238", "Bentley", "");
INSERT INTO teams VALUES ("99", "252", "UMass Lowell", "");
INSERT INTO teams VALUES ("99", "2332", "Merrimack", "");
INSERT INTO teams VALUES ("99", "254", "New Haven", "");
INSERT INTO teams VALUES ("99", "256", "Pace", "");
INSERT INTO teams VALUES ("99", "260", "Southern Connecticut St.", "");
INSERT INTO teams VALUES ("99", "1755", "St. Anselm", "");
INSERT INTO teams VALUES ("99", "243", "Stonehill", ""); -- Is this 253 not 243?
INSERT INTO teams VALUES ("99", "2538", "New Haven", "");

-- Great Lakes Football Conference
INSERT INTO confs VALUES ("2", "100", "Great Lakes Football Conference");
INSERT INTO teams VALUES ("100", "590", "Central St.", "");
INSERT INTO teams VALUES ("100", "249", "Kentucky Wesleyan", "");
INSERT INTO teams VALUES ("100", "2305", "Lincoln (MO)", "");
INSERT INTO teams VALUES ("100", "302", "St. Joseph's (IN)", "");
INSERT INTO teams VALUES ("100", "284", "Missouri S&T", "");

-- Empire Eight
INSERT INTO confs VALUES ("2", "102", "Empire Eight");
INSERT INTO teams VALUES ("102", "563", "Frostburg St.", "");
INSERT INTO teams VALUES ("102", "586", "Wesley Col.", "");
INSERT INTO teams VALUES ("102", "580", "Salisbury", "");
INSERT INTO teams VALUES ("102", "2548", "The Apprentice School", "");
INSERT INTO teams VALUES ("102", "2454", "Ithaca Col.", "");
INSERT INTO teams VALUES ("102", "2520", "Springfield Col.", "");
INSERT INTO teams VALUES ("102", "261", "Springfield Col.", "");
INSERT INTO teams VALUES ("102", "547", "Alfred", "");
INSERT INTO teams VALUES ("102", "569", "Ithaca Col.", "");
INSERT INTO teams VALUES ("102", "566", "Hartwick Col.", "");
INSERT INTO teams VALUES ("102", "581", "St. John Fisher", "");
INSERT INTO teams VALUES ("102", "2521", "Utica", "");

-- Cascade Collegiate Conference
INSERT INTO confs VALUES ("2", "103", "Cascade Collegiate");
INSERT INTO teams VALUES ("103", "2236", "Southern Oregon Raiders", "");

-- Mid-States Football Association
INSERT INTO confs VALUES ("2", "104", "Mid-States Football Association");
INSERT INTO teams VALUES ("104", "2373", "Grand View", "");
INSERT INTO teams VALUES ("104", "604", "Iowa Wesleyan", "");
INSERT INTO teams VALUES ("104", "624", "McKendree", "");
INSERT INTO teams VALUES ("104", "1951", "Olivet Nazarene", "");
INSERT INTO teams VALUES ("104", "258", "Quincy", "");
INSERT INTO teams VALUES ("104", "594", "St. Ambrose", "");
INSERT INTO teams VALUES ("104", "2348", "St. Francis (IL)", "");
INSERT INTO teams VALUES ("104", "603", "St. Xavier (IL)", "");
INSERT INTO teams VALUES ("104", "2545", "Taylor", "");
INSERT INTO teams VALUES ("104", "2544", "Walsh", "");
INSERT INTO teams VALUES ("104", "429", "William Penn", "");
INSERT INTO teams VALUES ("104", "1952", "Trinity Intl. (IL)", "");
INSERT INTO teams VALUES ("104", "2292", "St. Francis (IN)", "");
INSERT INTO teams VALUES ("104", "2351", "Marian", "");
INSERT INTO teams VALUES ("104", "2368", "Malone", "");

-- Heartland Collegiate Athletic
INSERT INTO confs VALUES ("2", "105", "Heartland Collegiate Athletic");
INSERT INTO teams VALUES ("105", "414", "Anderson Univ.", "");
INSERT INTO teams VALUES ("105", "378", "Bluffton Univ.", "");
INSERT INTO teams VALUES ("105", "379", "Defiance Col.", "");
INSERT INTO teams VALUES ("105", "2362", "Franklin Col.", "");
INSERT INTO teams VALUES ("105", "417", "Hanover", "");
INSERT INTO teams VALUES ("105", "418", "Manchester Col.", "");
INSERT INTO teams VALUES ("105", "611", "Mt. St. Joseph", "");
INSERT INTO teams VALUES ("105", "419", "Rose-Hulman", "");
INSERT INTO teams VALUES ("105", "2474", "Manchester Col.", "");
INSERT INTO teams VALUES ("105", "2495", "Mount St. Joseph", "");
INSERT INTO teams VALUES ("105", "2517", "Rose-Hulman", "");
INSERT INTO teams VALUES ("105", "2360", "Baker", "");
INSERT INTO teams VALUES ("105", "2396", "Bluffton Univ.", "");
INSERT INTO teams VALUES ("105", "2423", "Defiance Col.", "");

-- Wisconsin Intercollegiate Athletic Conference
INSERT INTO confs VALUES ("2", "106", "Wisconsin Intercollegiate Athletic Conference");
INSERT INTO teams VALUES ("106", "538", "Wisconsin-Eau Claire", "");
INSERT INTO teams VALUES ("106", "539", "Wisconsin-La Crosse", "");
INSERT INTO teams VALUES ("106", "540", "Wisconsin-Oshkosh", "");
INSERT INTO teams VALUES ("106", "541", "Wisconsin-Platteville", "");
INSERT INTO teams VALUES ("106", "542", "Wisconsin-River Falls", "");
INSERT INTO teams VALUES ("106", "543", "Wisconsin-Stevens Point", "");
INSERT INTO teams VALUES ("106", "544", "Wisconsin-Stout", "");
INSERT INTO teams VALUES ("106", "545", "Wisconsin-Whitewater", "");
INSERT INTO teams VALUES ("106", "2418", "Wisconsin-River Falls", "");
INSERT INTO teams VALUES ("106", "2419", "Wisconsin-Oshkosh", "");

-- Great Northwest Athletic Conference
INSERT INTO confs VALUES ("2", "107", "Great Northwest Athletic Conference");
INSERT INTO teams VALUES ("107", "597", "Central Washington", "");
INSERT INTO teams VALUES ("107", "2344", "Dixie St.", "");
INSERT INTO teams VALUES ("107", "315", "Humboldt St.", "");
INSERT INTO teams VALUES ("107", "1920", "Western Oregon", "");
INSERT INTO teams VALUES ("107", "2378", "Western Washington", "");

-- Central States Football League
INSERT INTO confs VALUES ("2", "108", "Central States Football League");
INSERT INTO teams VALUES ("108", "1991", "Bacone Col.", "");
INSERT INTO teams VALUES ("108", "615", "Langston", "");
INSERT INTO teams VALUES ("108", "619", "N.W. Oklahoma St.", "");
INSERT INTO teams VALUES ("108", "2338", "Southern Nazarene", "");
INSERT INTO teams VALUES ("108", "2324", "Texas Col.", "");

-- Empire Eight (109) - also (102)
-- INSERT INTO confs VALUES ("2", "109", "Empire Eight");

-- New England Small College Athletic Conference
INSERT INTO confs VALUES ("2", "110", "New England Small College Athletic Conference");
INSERT INTO teams VALUES ("110", "548", "Amherst Col.", ""); --
INSERT INTO teams VALUES ("110", "550", "Bates Col.", "");
INSERT INTO teams VALUES ("110", "552", "Bowdoin", "");
INSERT INTO teams VALUES ("110", "557", "Colby Col.", "");
INSERT INTO teams VALUES ("110", "565", "Hamilton Col.", "");
INSERT INTO teams VALUES ("110", "587", "Wesleyan (CT)", "");
INSERT INTO teams VALUES ("110", "588", "Williams", "");
INSERT INTO teams VALUES ("110", "575", "Middlebury", "");
INSERT INTO teams VALUES ("110", "583", "Trinity (CT)", "");
INSERT INTO teams VALUES ("110", "2532", "Tufts", "");
INSERT INTO teams VALUES ("110", "2533", "Trinity (CT)", "");
INSERT INTO teams VALUES ("110", "2489", "Wesleyan (CT)", "");
INSERT INTO teams VALUES ("110", "2445", "Hamilton Col.", "");
INSERT INTO teams VALUES ("110", "2410", "Colby Col.", "");
INSERT INTO teams VALUES ("110", "2388", "Bates Col.", "");
INSERT INTO teams VALUES ("110", "2383", "Amherst Col.", "");
INSERT INTO teams VALUES ("110", "2397", "Bowdoin", "");

-- Northern Athletics Conference
INSERT INTO confs VALUES ("2", "111", "Northern Athletics Conference");
INSERT INTO teams VALUES ("111", "559", "Concordia Univ. Chicago", "");
INSERT INTO teams VALUES ("111", "568", "Benedictine Univ.", "");
INSERT INTO teams VALUES ("111", "549", "Aurora", "");
INSERT INTO teams VALUES ("111", "570", "Lakeland Col.", "");
INSERT INTO teams VALUES ("111", "2363", "Concordia (WI)", "");
INSERT INTO teams VALUES ("111", "2326", "Wisconsin Lutheran", "");
INSERT INTO teams VALUES ("111", "2516", "Rockford Col.", "");
INSERT INTO teams VALUES ("111", "2475", "Maranatha Baptist", "");
INSERT INTO teams VALUES ("111", "2392", "Benedictine Univ.", "");
INSERT INTO teams VALUES ("111", "2415", "Concordia Univ. Chicago", "");
INSERT INTO teams VALUES ("111", "2463", "Lakeland Col.", "");

-- St. Louis Intercollegiate Athletic Conference
INSERT INTO confs VALUES ("2", "112", "St. Louis Intercollegiate Athletic Conference");
INSERT INTO teams VALUES ("112", "551", "Blackburn Col.", "");
INSERT INTO teams VALUES ("112", "2395", "Blackburn Col.", "");

-- Upper Midwest Athletic Conference
INSERT INTO confs VALUES ("2", "113", "Upper Midwest Athletic Conference");
INSERT INTO teams VALUES ("113", "320", "Minnesota-Morris", "");
INSERT INTO teams VALUES ("113", "561", "Eureka Col.", "");
INSERT INTO teams VALUES ("113", "571", "MacMurray Col.", "");
INSERT INTO teams VALUES ("113", "596", "Greenville Col.", "");
INSERT INTO teams VALUES ("113", "613", "Martin Luther Col.", "");
INSERT INTO teams VALUES ("113", "1918", "Westminster (MO)", "");
INSERT INTO teams VALUES ("113", "2420", "Crown Col.", "");
INSERT INTO teams VALUES ("113", "2502", "Northwestern College (MN)", "");
INSERT INTO teams VALUES ("113", "2525", "St. Scholastica", "");
INSERT INTO teams VALUES ("113", "2435", "Westminster (MO)", "");
INSERT INTO teams VALUES ("113", "2432", "Eureka Col.", "");
INSERT INTO teams VALUES ("113", "2442", "Greenville Col.", "");
INSERT INTO teams VALUES ("113", "2472", "MacMurray Col.", "");
INSERT INTO teams VALUES ("113", "2477", "Martin Luther Col.", "");
INSERT INTO teams VALUES ("113", "2585", "Presentation Col.", "");

-- Great Plains Athletic Conference
INSERT INTO confs VALUES ("2", "114", "USA South Athletic Conference");
INSERT INTO teams VALUES ("114", "562", "Ferrum Col.", "");
INSERT INTO teams VALUES ("114", "572", "Maryville Col. (TN)", "");
INSERT INTO teams VALUES ("114", "2006", "Greensboro Col.", "");
INSERT INTO teams VALUES ("114", "2296", "Shenandoah", "");
INSERT INTO teams VALUES ("114", "2359", "Methodist", "");
INSERT INTO teams VALUES ("114", "2370", "Christopher Newport", "");
INSERT INTO teams VALUES ("114", "2386", "Averett Univ.", "");
INSERT INTO teams VALUES ("114", "2500", "North Carolina Wesleyan", "");
INSERT INTO teams VALUES ("114", "2408", "Christopher Newport", "");
INSERT INTO teams VALUES ("114", "2434", "Ferrum Col.", "");
INSERT INTO teams VALUES ("114", "2478", "Maryville Col. (TN)", "");

-- Great Plains Athletic Conference
INSERT INTO confs VALUES ("2", "115", "Great Plains Athletic Conference");
INSERT INTO teams VALUES ("115", "306", "Morningside", "");
INSERT INTO teams VALUES ("115", "469", "Concordia Col. (NE)", "");
INSERT INTO teams VALUES ("115", "470", "Dana", "");
INSERT INTO teams VALUES ("115", "472", "Hastings Col.", "");
INSERT INTO teams VALUES ("115", "473", "Midland Lutheran", "");
INSERT INTO teams VALUES ("115", "475", "Nebraska Wesleyan", "");
INSERT INTO teams VALUES ("115", "625", "Northwestern (IA)", "");
INSERT INTO teams VALUES ("115", "2498", "Nebraska Wesleyan", "");
INSERT INTO teams VALUES ("115", "2554", "Midland Lutheran", "");

-- Kansas Collegiate Athletic Conference
INSERT INTO confs VALUES ("2", "117", "Kansas Collegiate Athletic Conference");
INSERT INTO teams VALUES ("117", "1033", "Southwestern Col.", "");
INSERT INTO teams VALUES ("117", "2369", "Bethany (KS)", "");
INSERT INTO teams VALUES ("117", "2353", "Kansas Wesleyan", "");
INSERT INTO teams VALUES ("117", "2543", "Southwestern Col.", "");
INSERT INTO teams VALUES ("117", "2594", "Sterling Col.", "");

-- Great Lakes Intercollegiate Athletic
INSERT INTO confs VALUES ("2", "118", "Great Lakes Intercollegiate Athletic");
INSERT INTO teams VALUES ("118", "2541", "Ohio Dominican", "");

-- Red River Athletic Conference
INSERT INTO confs VALUES ("2", "119", "Red River Athletic Conference");
INSERT INTO teams VALUES ("119", "2542", "Southwestern Assemblies of God", "");

--------------
-- UNSORTED --
--------------


-- WE DONT KNOW THEIR CONF. ASSIGN TO UNKNOWN CONF.
INSERT INTO confs VALUES ("2", "31337", "UNK");
-- Metro Atlantic Athletic
INSERT INTO teams VALUES ("31337", "614", "Fairfield", "");
INSERT INTO teams VALUES ("31337", "1018", "La Salle", ""); -- Metro Atlantic Athletic
INSERT INTO teams VALUES ("31337", "135", "Canisius", ""); -- Metro Atlantic Athletic
INSERT INTO teams VALUES ("31337", "140", "Siena", ""); -- Metro Atlantic Athletic
INSERT INTO teams VALUES ("31337", "141", "St. John's", ""); -- Metro Atlantic Athletic
INSERT INTO teams VALUES ("31337", "142", "St. Peter's", ""); -- Metro Atlantic Athletic
INSERT INTO teams VALUES ("31337", "584", "Tufts", "");  -- NONE?
INSERT INTO teams VALUES ("31337", "2602", "Florida Tech", ""); -- ?
INSERT INTO teams VALUES ("31337", "138", "Iona Gaels", ""); -- Independents (FCS)
INSERT INTO teams VALUES ("31337", "173", "East Tennessee St.", ""); -- Southern
INSERT INTO teams VALUES ("31337", "2563", "S.D. School of M&T", ""); -- Dakota Athletic
INSERT INTO teams VALUES ("31337", "2568", "UBC", ""); -- Canada West
INSERT INTO teams VALUES ("31337", "2589", "Robert Morris (IL)", ""); -- Chicagoland Collegiate
INSERT INTO teams VALUES ("31337", "2327", "Allen", ""); -- EIAC
INSERT INTO teams VALUES ("31337", "2303", "Paul Quinn", ""); -- IAC
INSERT INTO teams VALUES ("31337", "2561", "Notre Dame Col.", ""); -- Independents (II)
