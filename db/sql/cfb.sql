-- DB STRUCTURE
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

-- DATA
-- DIVISIONS
INSERT INTO divs VALUES ('1', 'FBS');
INSERT INTO divs VALUES ('2', 'FCS');
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
INSERT INTO teams VALUES ("10", "41", "N.M. State", "nni");
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

-----------------------
-- NON-FBS ARE BELOW --
-----------------------

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

-- Big Sky
INSERT INTO confs VALUES ("2", "13", "Big Sky");
INSERT INTO teams VALUES ("13", "108", "Cal Poly", "cca");
INSERT INTO teams VALUES ("13", "113", "Eastern Wash.", "eeg");
INSERT INTO teams VALUES ("13", "115", "Idaho St. ", "iib");
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

-- Big South
INSERT INTO confs VALUES ("2", "92", "Big South");
INSERT INTO teams VALUES ("92", "211", "Charleston Sou.", "ccz");
INSERT INTO teams VALUES ("92", "2316", "Coastal Carolina", "cbi");
INSERT INTO teams VALUES ("92", "351", "Gardner-Webb", "ggf");
INSERT INTO teams VALUES ("92", "215", "Liberty", "lle");
INSERT INTO teams VALUES ("92", "354", "Presbyterian", "ppg");
INSERT INTO teams VALUES ("92", "178", "VMI", "vve");

-- CAA
INSERT INTO confs VALUES ("2", "98", "CAA");
INSERT INTO teams VALUES ("73", "546", "Albany", "aag");
INSERT INTO teams VALUES ("73", "195", "Delaware", "ddc");
INSERT INTO teams VALUES ("73", "196", "JMU", "jjb");
INSERT INTO teams VALUES ("73", "203", "Maine", "mma");
INSERT INTO teams VALUES ("73", "205", "New Hampshire", "nng");
INSERT INTO teams VALUES ("73", "206", "Rhode Island", "rra");
INSERT INTO teams VALUES ("73", "198", "Richmond", "rrc");
INSERT INTO teams VALUES ("73", "629", "Stony Brook", "sbf");
INSERT INTO teams VALUES ("73", "221", "Towson", "ttq");
INSERT INTO teams VALUES ("73", "199", "Villanova", "vvh");
INSERT INTO teams VALUES ("73", "200", "William & Mary", "wwn");

-- Cascade Collegiate Conference
INSERT INTO confs VALUES ("2", "103", "Cascade Collegiate");
INSERT INTO teams VALUES ("103", "2236", "Southern Oregon Raiders", "");

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

-- Central States Football League
INSERT INTO confs VALUES ("2", "108", "Central States Football League");
INSERT INTO teams VALUES ("108", "1991", "Bacone College", "");
INSERT INTO teams VALUES ("108", "615", "Langston", "");
INSERT INTO teams VALUES ("108", "619", "N.W. Oklahoma St.", "");
INSERT INTO teams VALUES ("108", "2338", "Southern Nazarene", "");
INSERT INTO teams VALUES ("108", "2324", "Texas College", "");

-- FCS Independents
INSERT INTO confs VALUES ("2", "74", "FCS Independents");
INSERT INTO teams VALUES ("74", "276", "Abilene Christian", "");
INSERT INTO teams VALUES ("74", "2595", "Charlotte", "nad");
INSERT INTO teams VALUES ("74", "2601", "Houston Baptist", "");
INSERT INTO teams VALUES ("74", "216", "Monmouth", "mae");
INSERT INTO teams VALUES ("74", "2539", "Incarnate Word", "");
INSERT INTO teams VALUES ("74", "2461", "Lake Erie College", "");
INSERT INTO teams VALUES ("74", "2349", "N.C. Pembroke", "");
INSERT INTO teams VALUES ("74", "2003", "N. Greenville", "");
INSERT INTO teams VALUES ("74", "1662", "Panhandle St.", "");
INSERT INTO teams VALUES ("74", "290", "S.W. Baptist", "");
INSERT INTO teams VALUES ("74", "2328", "Urbana", "");
INSERT INTO teams VALUES ("74", "2004", "We. Washington", "");

-- Great Lakes Football Conference
INSERT INTO confs VALUES ("2", "100", "Great Lakes Football Conference");
INSERT INTO teams VALUES ("100", "590", "Central St.", "");
INSERT INTO teams VALUES ("100", "249", "Kentucky Wesleyan", "");
INSERT INTO teams VALUES ("100", "2305", "Lincoln (MO)", "");
INSERT INTO teams VALUES ("100", "302", "St. Joseph's (IN)", "");
INSERT INTO teams VALUES ("100", "284", "Missouri S&T", "");

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

-- Great Northwest Athletic Conference
INSERT INTO confs VALUES ("2", "107", "Great Northwest Athletic Conference");
INSERT INTO teams VALUES ("107", "597", "Central Washington", "");
INSERT INTO teams VALUES ("107", "2344", "Dixie St.", "");
INSERT INTO teams VALUES ("107", "315", "Humboldt St.", "");
INSERT INTO teams VALUES ("107", "1920", "Western Oregon", "");

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

-- Frontier
INSERT INTO confs VALUES ("2", "62", "Frontier");
INSERT INTO teams VALUES ("62", "1017", "Eastern Oregon", "");
INSERT INTO teams VALUES ("62", "591", "Montana-Western", "");

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

-- NAIA-II INDEPENDENTS
INSERT INTO confs VALUES ("2", "78", "Independents (NAIA-II)");
INSERT INTO teams VALUES ("78", "2364", "Cent. Methodist", "");
INSERT INTO teams VALUES ("78", "2342", "Concordia Coll.", "");
INSERT INTO teams VALUES ("78", "1950", "Evangel", "");
INSERT INTO teams VALUES ("78", "1023", "Sioux Falls", "");
INSERT INTO teams VALUES ("78", "2323", "Webber Intl.", "");
INSERT INTO teams VALUES ("78", "2367", "William Jewell", "");

-- Ivy
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

-- Missouri Valley
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

-- Northeast
INSERT INTO confs VALUES ("2", "73", "Northeast");
INSERT INTO teams VALUES ("73", "1948", "Bryant", "bvx");
INSERT INTO teams VALUES ("73", "209", "Central Conn. St.", "cce");
INSERT INTO teams VALUES ("73", "136", "Duquesne", "ddi");
INSERT INTO teams VALUES ("73", "217", "Robert Morris", "rri");
INSERT INTO teams VALUES ("73", "259", "Sacred Heart", "sbe");
INSERT INTO teams VALUES ("73", "219", "St. Francis (PA)", "sps");
INSERT INTO teams VALUES ("73", "223", "Wagner", "wwa");

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
INSERT INTO teams VALUES ("99", "253", "Stonehill", "");

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
INSERT INTO teams VALUES ("20", "153", "Morehead State", "mmw");
INSERT INTO teams VALUES ("20", "169", "San Diego", "sbc");
INSERT INTO teams VALUES ("20", "2598", "Stetson", "");
INSERT INTO teams VALUES ("20", "170", "Valparaiso", "vvi");

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

-- WE DONT KNOW THEIR CONF. ASSIGN TO SWAC.
INSERT INTO teams VALUES ("23", "2599", "Reinhardt", "");  -- NONE?
INSERT INTO teams VALUES ("23", "2596", "Warner", "");  -- NONE?
INSERT INTO teams VALUES ("23", "584", "Tufts", "");  -- NONE?
INSERT INTO teams VALUES ("23", "2602", "Florida Tech", ""); -- ?
INSERT INTO teams VALUES ("23", "2358", "Birmingham-Southern", ""); -- Southern Collegiate Athletic
INSERT INTO teams VALUES ("23", "2600", "Berry", ""); -- Southern Collegiate Athletic
