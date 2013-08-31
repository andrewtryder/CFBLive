-- DIVISIONS
CREATE TABLE IF NOT EXISTS divs (
    id INT PRIMARY KEY,
    division TEXT
    );

-- MANUALLY INSERT DIVISIONS
INSERT INTO divs VALUES ('1', 'FBS');
INSERT INTO divs VALUES ('2', 'FCS');

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
    FOREIGN KEY(conf) REFERENCES confs(id) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- NOW OUR ACTUAL TEAMS TABLE.
-- American Athletic
INSERT INTO confs VALUES ("1", "2", "American Athletic");
INSERT INTO teams VALUES ("2", "98", "Cincinnati Bearcats");
INSERT INTO teams VALUES ("2", "202", "Connecticut Huskies");
INSERT INTO teams VALUES ("2", "80", "Houston");
INSERT INTO teams VALUES ("2", "100", "Louisville");
INSERT INTO teams VALUES ("2", "101", "Memphis");
INSERT INTO teams VALUES ("2", "13", "Rutgers");
INSERT INTO teams VALUES ("2", "1019", "South Florida");
INSERT INTO teams VALUES ("2", "82", "SMU");
INSERT INTO teams VALUES ("2", "15", "Temple");
INSERT INTO teams VALUES ("2", "210", "UCF Knights");

-- ACC
INSERT INTO confs VALUES ("1", "1", "ACC");
INSERT INTO teams VALUES ("1", "10", "BC Eagles");
INSERT INTO teams VALUES ("1", "1", "Clemsux");
INSERT INTO teams VALUES ("1", "2", "Duke");
INSERT INTO teams VALUES ("1", "3", "FSU");
INSERT INTO teams VALUES ("1", "4", "Georgia Tech");
INSERT INTO teams VALUES ("1", "5", "Maryland");
INSERT INTO teams VALUES ("1", "11", "Miami");
INSERT INTO teams VALUES ("1", "6", "North Carolina");
INSERT INTO teams VALUES ("1", "7", "N.C. State");
INSERT INTO teams VALUES ("1", "12", "Pitt");
INSERT INTO teams VALUES ("1", "14", "Syracuse");
INSERT INTO teams VALUES ("1", "8", "Virginia Cavaliers");
INSERT INTO teams VALUES ("1", "16", "Virginia Tech");
INSERT INTO teams VALUES ("1", "9", "Wake Forest");

-- Big 12
INSERT INTO confs VALUES ("1", "71", "Big 12");
INSERT INTO teams VALUES ("71", "79", "Baylors");
INSERT INTO teams VALUES ("71", "19", "Iowa State");
INSERT INTO teams VALUES ("71", "20", "Kansas");
INSERT INTO teams VALUES ("71", "21", "KState");
INSERT INTO teams VALUES ("71", "24", "Oklahoma");
INSERT INTO teams VALUES ("71", "25", "OKState");
INSERT INTO teams VALUES ("71", "85", "TCU");
INSERT INTO teams VALUES ("71", "83", "Schlonghorns");
INSERT INTO teams VALUES ("71", "86", "Texas Tech");
INSERT INTO teams VALUES ("71", "17", "WVU");

-- Big 10
INSERT INTO confs VALUES ("1", "4", "Big Ten");
INSERT INTO teams VALUES ("4", "26", "Illinois");
INSERT INTO teams VALUES ("4", "27", "Indiana");
INSERT INTO teams VALUES ("4", "28", "Iowa");
INSERT INTO teams VALUES ("4", "30", "Michigan State");
INSERT INTO teams VALUES ("4", "29", "Michigan");
INSERT INTO teams VALUES ("4", "31", "Minnesota");
INSERT INTO teams VALUES ("4", "23", "Nebraska");
INSERT INTO teams VALUES ("4", "32", "Northwestern");
INSERT INTO teams VALUES ("4", "33", "Ohio State");
INSERT INTO teams VALUES ("4", "34", "PSU");
INSERT INTO teams VALUES ("4", "35", "Purdue");
INSERT INTO teams VALUES ("4", "36", "Wisconsin");

-- Conference USA
INSERT INTO confs VALUES ("1", "72", "Conference USA");
INSERT INTO teams VALUES ("72", "99", "East Carolina");
INSERT INTO teams VALUES ("72", "2294", "Florida Atlantic");
INSERT INTO teams VALUES ("72", "2307", "Florida International");
INSERT INTO teams VALUES ("72", "38", "Louisiana Tech");
INSERT INTO teams VALUES ("72", "176", "Marshall");
INSERT INTO teams VALUES ("72", "152", "Middle Tennessee");
INSERT INTO teams VALUES ("72", "182", "North Texas");
INSERT INTO teams VALUES ("72", "81", "Rice");
INSERT INTO teams VALUES ("72", "105", "Southern Miss");
INSERT INTO teams VALUES ("72", "106", "Tulane");
INSERT INTO teams VALUES ("72", "107", "Tulsa");
INSERT INTO teams VALUES ("72", "207", "UAB");
INSERT INTO teams VALUES ("72", "95", "UTEP");
INSERT INTO teams VALUES ("72", "2560", "UTSA");

-- FBS Independents
INSERT INTO confs VALUES ("1", "11", "FBS Independents");
INSERT INTO teams VALUES ("11", "97", "Army");
INSERT INTO teams VALUES ("11", "88", "BYU");
INSERT INTO teams VALUES ("11", "114", "Idaho");
INSERT INTO teams VALUES ("11", "102", "Navy");
INSERT INTO teams VALUES ("10", "41", "New Mexico State");
INSERT INTO teams VALUES ("11", "104", "Notre Dame");
INSERT INTO teams VALUES ("11", "2371", "Old Dominion");

-- Mid-American
INSERT INTO confs VALUES ("1", "6", "Mid-American");
INSERT INTO teams VALUES ("6", "47", "Akron");
INSERT INTO teams VALUES ("6", "48", "Ball St.");
INSERT INTO teams VALUES ("6", "49", "Bowling Green");
INSERT INTO teams VALUES ("6", "208", "Buffalo");
INSERT INTO teams VALUES ("6", "50", "Central Michigan");
INSERT INTO teams VALUES ("6", "51", "Eastern Michigan");
INSERT INTO teams VALUES ("6", "52", "Kent St.");
INSERT INTO teams VALUES ("6", "204", "UMass");
INSERT INTO teams VALUES ("6", "53", "Miami (OH)");
INSERT INTO teams VALUES ("6", "42", "Northern Illinois");
INSERT INTO teams VALUES ("6", "54", "Ohio");
INSERT INTO teams VALUES ("6", "55", "Toledo");
INSERT INTO teams VALUES ("6", "56", "Western Michigan");

-- Mountain West
INSERT INTO confs VALUES ("1", "87", "Mountain West");
INSERT INTO teams VALUES ("87", "87", "Air Force");
INSERT INTO teams VALUES ("87", "112", "Boise");
INSERT INTO teams VALUES ("87", "89", "Colorado");
INSERT INTO teams VALUES ("87", "90", "Fresno State");
INSERT INTO teams VALUES ("87", "91", "Hawaii");
INSERT INTO teams VALUES ("87", "39", "Nevada");
INSERT INTO teams VALUES ("87", "92", "New Mexico");
INSERT INTO teams VALUES ("87", "93", "San Diego State");
INSERT INTO teams VALUES ("87", "44", "San Jose State");
INSERT INTO teams VALUES ("87", "40", "UNLV");
INSERT INTO teams VALUES ("87", "46", "Utah State");
INSERT INTO teams VALUES ("87", "96", "Wyoming");

-- Pac-12
INSERT INTO confs VALUES ("1", "7", "Pac-12");
INSERT INTO teams VALUES ("7", "58", "Arizona State");
INSERT INTO teams VALUES ("7", "57", "Arizona");
INSERT INTO teams VALUES ("7", "59", "Cal");
INSERT INTO teams VALUES ("7", "18", "Colorado");
INSERT INTO teams VALUES ("7", "60", "Oregon");
INSERT INTO teams VALUES ("7", "61", "Oregon State");
INSERT INTO teams VALUES ("7", "63", "Stanford");
INSERT INTO teams VALUES ("7", "64", "UCLA");
INSERT INTO teams VALUES ("7", "62", "USC");
INSERT INTO teams VALUES ("7", "94", "Utah");
INSERT INTO teams VALUES ("7", "65", "Washington");
INSERT INTO teams VALUES ("7", "66", "Washington State");

-- SEC
INSERT INTO confs VALUES("1", "8", "SEC");
INSERT INTO teams VALUES ("8", "73", "Alabama");
INSERT INTO teams VALUES ("8", "74", "Arkansas");
INSERT INTO teams VALUES ("8", "75", "Auburn");
INSERT INTO teams VALUES ("8", "67", "Florida");
INSERT INTO teams VALUES ("8", "68", "Georgia");
INSERT INTO teams VALUES ("8", "69", "Kentucky");
INSERT INTO teams VALUES ("8", "76", "LSU");
INSERT INTO teams VALUES ("8", "78", "Miss St.");
INSERT INTO teams VALUES ("8", "22", "Missouri");
INSERT INTO teams VALUES ("8", "77", "Ole Miss");
INSERT INTO teams VALUES ("8", "70", "South Carolina");
INSERT INTO teams VALUES ("8", "71", "Tennessee");
INSERT INTO teams VALUES ("8", "84", "Texas A&M");
INSERT INTO teams VALUES ("8", "72", "Vanderbilt");

-- Sun Belt
INSERT INTO confs VALUES ("1", "90", "Sun Belt");
INSERT INTO teams VALUES ("90", "37", "Arkansas St.");
INSERT INTO teams VALUES ("90", "2558", "Georgia St.");
INSERT INTO teams VALUES ("90", "45", "Louisiana-Lafayette");
INSERT INTO teams VALUES ("90", "103", "Louisiana-Monroe");
INSERT INTO teams VALUES ("90", "2549", "South Alabama");
INSERT INTO teams VALUES ("90", "185", "Texas State");
INSERT INTO teams VALUES ("90", "222", "Troy");
INSERT INTO teams VALUES ("90", "224", "Western Kentucky");

-----------------------
-- NON FBS ARE BELOW --
-----------------------

-- Big Sky
INSERT INTO confs VALUES ("2", "13", "Big Sky");
INSERT INTO teams VALUES ("13", "108", "Cal Poly");
INSERT INTO teams VALUES ("13", "113", "Eastern Washington");
INSERT INTO teams VALUES ("13", "115", "Idaho St. ");
INSERT INTO teams VALUES ("13", "116", "Montana");
INSERT INTO teams VALUES ("13", "117", "Montana St.");
INSERT INTO teams VALUES ("14", "308", "North Dakota");

INSERT INTO teams VALUES ("13", "118", "Northern Arizona");
INSERT INTO teams VALUES ("13", "310", "Northern Colorado");
INSERT INTO teams VALUES ("13", "257", "Portland St.");
INSERT INTO teams VALUES ("13", "110", "Sacramento St.");
INSERT INTO teams VALUES ("13", "111", "Southern Utah");
INSERT INTO teams VALUES ("13", "263", "UC Aggies");
INSERT INTO teams VALUES ("13", "119", "Weber St.");

-- Big South
INSERT INTO confs VALUES ("2", "92", "Big South");
INSERT INTO teams VALUES ("92", "211", "Charleston Southern");
INSERT INTO teams VALUES ("92", "2316", "Coastal Carolina");
INSERT INTO teams VALUES ("92", "351", "Gardner-Webb");
INSERT INTO teams VALUES ("92", "215", "Liberty");
INSERT INTO teams VALUES ("92", "354", "Presbyterian");
INSERT INTO teams VALUES ("92", "178", "Virginia Military Institute");

-- CAA
INSERT INTO confs VALUES ("2", "98", "Colonial Athletic Association");
INSERT INTO teams VALUES ("73", "546", "Albany");
INSERT INTO teams VALUES ("73", "195", "Delaware");
INSERT INTO teams VALUES ("73", "196", "James Madison");
INSERT INTO teams VALUES ("73", "203", "Maine");
INSERT INTO teams VALUES ("73", "205", "New Hampshire");
INSERT INTO teams VALUES ("73", "206", "Rhode Island");
INSERT INTO teams VALUES ("73", "198", "Richmond");
INSERT INTO teams VALUES ("73", "629", "Stony Brook");
INSERT INTO teams VALUES ("73", "221", "Towson");
INSERT INTO teams VALUES ("73", "199", "Villanova");
INSERT INTO teams VALUES ("73", "200", "William & Mary");

-- Central States Football League
INSERT INTO confs VALUES ("2", "108", "Central States Football League");
INSERT INTO teams VALUES ("108", "1991", "Bacone College");
INSERT INTO teams VALUES ("108", "615", "Langston");
INSERT INTO teams VALUES ("108", "619", "Northwestern Oklahoma St.");
INSERT INTO teams VALUES ("108", "2338", "Southern Nazarene");
INSERT INTO teams VALUES ("108", "2324", "Texas College");

-- FCS Independents
INSERT INTO confs VALUES ("2", "74", "FCS Independents");
INSERT INTO teams VALUES ("74", "276", "Abilene Christian");
INSERT INTO teams VALUES ("74", "2595", "Charlotte");
INSERT INTO teams VALUES ("74", "2601", "Houston Baptist");
INSERT INTO teams VALUES ("74", "216", "Monmouth");
INSERT INTO teams VALUES ("74", "2539", "Incarnate Word");
INSERT INTO teams VALUES ("74", "2461", "Lake Erie College");
INSERT INTO teams VALUES ("74", "2349", "North Carolina Pembroke");
INSERT INTO teams VALUES ("74", "2003", "North Greenville");
INSERT INTO teams VALUES ("74", "1662", "Panhandle State");
INSERT INTO teams VALUES ("74", "290", "Southwest Baptist");
INSERT INTO teams VALUES ("74", "2328", "Urbana");
INSERT INTO teams VALUES ("74", "2004", "Western Washington");

-- Frontier
INSERT INTO confs VALUES ("2", "62", "Frontier");
INSERT INTO teams VALUES ("62", "1017", "Eastern Oregon");
INSERT INTO teams VALUES ("62", "591", "Montana-Western");

-- NAIA-I INDEPENDENTS
INSERT INTO confs VALUES ("2", "77", "Independents (NAIA-I)");
INSERT INTO teams VALUES ("77", "2366", "Culver-Stockton");
INSERT INTO teams VALUES ("77", "2308", "Edward Waters");
INSERT INTO teams VALUES ("77", "1423", "Haskell");
INSERT INTO teams VALUES ("77", "2552", "Kentucky Christian");
INSERT INTO teams VALUES ("77", "2314", "Manitoba");
INSERT INTO teams VALUES ("77", "1691", "Peru State");
INSERT INTO teams VALUES ("77", "2356", "Southern Virginia");
INSERT INTO teams VALUES ("77", "2315", "St. Francis Xavier");

-- NAIA-II INDEPENDENTS
INSERT INTO confs VALUES ("2", "78", "Independents (NAIA-II)");
INSERT INTO teams VALUES ("78", "2364", "Central Methodist");
INSERT INTO teams VALUES ("78", "2342", "Concordia College");
INSERT INTO teams VALUES ("78", "1950", "Evangel");
INSERT INTO teams VALUES ("78", "1023", "Sioux Falls");
INSERT INTO teams VALUES ("78", "2323", "Webber International");
INSERT INTO teams VALUES ("78", "2367", "William Jewell");

-- Ivy
INSERT INTO confs VALUES ("2", "15", "Ivy");
INSERT INTO teams VALUES ("15", "127", "Brown");
INSERT INTO teams VALUES ("15", "128", "Columbia");
INSERT INTO teams VALUES ("15", "129", "Cornell");
INSERT INTO teams VALUES ("15", "130", "Dartmouth");
INSERT INTO teams VALUES ("15", "131", "Harvard");
INSERT INTO teams VALUES ("15", "132", "Pennsylvania");
INSERT INTO teams VALUES ("15", "133", "Princeton");
INSERT INTO teams VALUES ("15", "134", "Yale");

-- MEAC
INSERT INTO confs VALUES ("2", "17", "MEAC");
INSERT INTO teams VALUES ("17", "143", "Bethune-Cookman");
INSERT INTO teams VALUES ("17", "144", "Delaware State");
INSERT INTO teams VALUES ("17", "145", "Florida A&M");
INSERT INTO teams VALUES ("17", "229", "Hampton");
INSERT INTO teams VALUES ("17", "146", "Howard");
INSERT INTO teams VALUES ("17", "147", "Morgan State");
INSERT INTO teams VALUES ("17", "621", "NC Central");
INSERT INTO teams VALUES ("17", "233", "Norfolk State");
INSERT INTO teams VALUES ("17", "148", "North Carolina A&T");
INSERT INTO teams VALUES ("17", "363", "Savannah State");
INSERT INTO teams VALUES ("17", "149", "SCarolina State");

-- Mid-South Conference
INSERT INTO confs VALUES ("2", "68", "Mid-South");
INSERT INTO teams VALUES ("68", "2331", "Belhaven");
INSERT INTO teams VALUES ("68", "601", "Bethel (TN)");
INSERT INTO teams VALUES ("68", "602", "Campbellsville");
INSERT INTO teams VALUES ("68", "2311", "Cumberland College");
INSERT INTO teams VALUES ("68", "595", "Cumberland University");
INSERT INTO teams VALUES ("68", "2365", "Faulkner");
INSERT INTO teams VALUES ("68", "592", "Georgetown (KY)");
INSERT INTO teams VALUES ("68", "1022", "Lambuth");
INSERT INTO teams VALUES ("68", "2341", "Pikeville");
INSERT INTO teams VALUES ("68", "2361", "Shorter");
INSERT INTO teams VALUES ("68", "1861", "Union");
INSERT INTO teams VALUES ("68", "2319", "Union College");
INSERT INTO teams VALUES ("68", "626", "Virginia-Wise");
INSERT INTO teams VALUES ("68", "376", "West Virginia Tech");

-- Mid-States Football Association
INSERT INTO confs VALUES ("2", "104", "Mid-States Football Association");
INSERT INTO teams VALUES ("104", "2373", "Grand View");
INSERT INTO teams VALUES ("104", "604", "Iowa Wesleyan");
INSERT INTO teams VALUES ("104", "624", "McKendree");
INSERT INTO teams VALUES ("104", "1951", "Olivet Nazarene");
INSERT INTO teams VALUES ("104", "258", "Quincy");
INSERT INTO teams VALUES ("104", "594", "St. Ambrose");
INSERT INTO teams VALUES ("104", "2348", "St. Francis (IL)");
INSERT INTO teams VALUES ("104", "603", "St. Xavier (IL)");
INSERT INTO teams VALUES ("104", "2545", "Taylor");
INSERT INTO teams VALUES ("104", "2544", "Walsh");
INSERT INTO teams VALUES ("104", "429", "William Penn");

-- Missouri Valley
INSERT INTO confs VALUES ("2", "14", "Missouri Valley");
INSERT INTO teams VALUES ("14", "121", "Illinois State");
INSERT INTO teams VALUES ("14", "122", "Indiana State");
INSERT INTO teams VALUES ("14", "125", "Missouri State");
INSERT INTO teams VALUES ("14", "309", "North Dakota State");
INSERT INTO teams VALUES ("14", "123", "Northern Iowa");
INSERT INTO teams VALUES ("14", "311", "South Dakota");
INSERT INTO teams VALUES ("14", "312", "South Dakota State");
INSERT INTO teams VALUES ("14", "124", "Southern Illinois");
INSERT INTO teams VALUES ("14", "126", "Western Illinois");
INSERT INTO teams VALUES ("14", "225", "Youngstown State");

-- Northeast
INSERT INTO confs VALUES ("2", "73", "Northeast");
INSERT INTO teams VALUES ("73", "1948", "Bryant");
INSERT INTO teams VALUES ("73", "209", "Central Connecticut State");
INSERT INTO teams VALUES ("73", "136", "Duquesne");
INSERT INTO teams VALUES ("73", "217", "Robert Morris");
INSERT INTO teams VALUES ("73", "259", "Sacred Heart");
INSERT INTO teams VALUES ("73", "219", "St. Francis (PA)");
INSERT INTO teams VALUES ("73", "223", "Wagner");

-- Ohio Valley
INSERT INTO confs VALUES ("2", "18", "Ohio Valley");
INSERT INTO teams VALUES ("18", "150", "Austin Peay");
INSERT INTO teams VALUES ("18", "120", "Eastern Illinois");
INSERT INTO teams VALUES ("18", "151", "Eastern Kentucky");
INSERT INTO teams VALUES ("18", "247", "Jacksonville State");
INSERT INTO teams VALUES ("18", "154", "Murray State");
INSERT INTO teams VALUES ("18", "155", "Southeast Missouri State");
INSERT INTO teams VALUES ("18", "157", "Tennessee State");
INSERT INTO teams VALUES ("18", "158", "Tennessee Tech");
INSERT INTO teams VALUES ("18", "156", "Tennessee-Martin");

-- Patriot League
INSERT INTO confs VALUES ("2", "19", "Patriot League");
INSERT INTO teams VALUES ("19", "159", "Bucknell");
INSERT INTO teams VALUES ("19", "160", "Colgate");
INSERT INTO teams VALUES ("19", "161", "Fordham");
INSERT INTO teams VALUES ("19", "137", "Georgetown");
INSERT INTO teams VALUES ("19", "162", "Holy Cross");
INSERT INTO teams VALUES ("19", "163", "Lafayette");
INSERT INTO teams VALUES ("19", "164", "Lehigh");

-- Pioneer League
INSERT INTO confs VALUES ("2", "20", "Pioneer League");
INSERT INTO teams VALUES ("20", "165", "Butler");
INSERT INTO teams VALUES ("20", "2357", "Campbell");
INSERT INTO teams VALUES ("20", "212", "Davidson");
INSERT INTO teams VALUES ("20", "166", "Dayton");
INSERT INTO teams VALUES ("20", "167", "Drake");
INSERT INTO teams VALUES ("20", "2001", "Jacksonville");
INSERT INTO teams VALUES ("20", "139", "Marist");
INSERT INTO teams VALUES ("20", "2597", "Mercer");
INSERT INTO teams VALUES ("20", "153", "Morehead State");
INSERT INTO teams VALUES ("20", "169", "San Diego");
INSERT INTO teams VALUES ("20", "2598", "Stetson");
INSERT INTO teams VALUES ("20", "170", "Valparaiso");

-- Southern
INSERT INTO confs VALUES ("2", "21", "Southern");
INSERT INTO teams VALUES ("21", "171", "Appalachian State");
INSERT INTO teams VALUES ("21", "177", "Chattanooga");
INSERT INTO teams VALUES ("21", "172", "Citadel");
INSERT INTO teams VALUES ("21", "350", "Elon");
INSERT INTO teams VALUES ("21", "174", "Furman");
INSERT INTO teams VALUES ("21", "175", "Georgia Southern");
INSERT INTO teams VALUES ("21", "218", "Samford");
INSERT INTO teams VALUES ("21", "179", "Western Carolina");
INSERT INTO teams VALUES ("21", "267", "Wofford");

-- Southland
INSERT INTO confs VALUES ("2", "22", "Southland");
INSERT INTO teams VALUES ("22", "268", "Central Arkansas");
INSERT INTO teams VALUES ("22", "2559", "Lamar");
INSERT INTO teams VALUES ("22", "180", "McNeese State");
INSERT INTO teams VALUES ("22", "181", "Nicholls State");
INSERT INTO teams VALUES ("22", "183", "Northwestern State");
INSERT INTO teams VALUES ("22", "184", "Sam Houston State");
INSERT INTO teams VALUES ("22", "2234", "Southeastern Louisiana");
INSERT INTO teams VALUES ("22", "186", "Stephen F. Austin");

-- SWAC
INSERT INTO confs VALUES ("2", "23", "SWAC");
INSERT INTO teams VALUES ("23", "356", "Alabama A&M");
INSERT INTO teams VALUES ("23", "187", "Alabama State");
INSERT INTO teams VALUES ("23", "188", "Alcorn State");
INSERT INTO teams VALUES ("23", "589", "Arkansas-Pine Bluff");
INSERT INTO teams VALUES ("23", "189", "Grambling State");
INSERT INTO teams VALUES ("23", "190", "Jackson State");
INSERT INTO teams VALUES ("23", "191", "Mississippi Valley State");
INSERT INTO teams VALUES ("23", "192", "Prairie View A&M");
INSERT INTO teams VALUES ("23", "193", "Southern University");
INSERT INTO teams VALUES ("23", "194", "Texas Southern");

-- WE DONT KNOW THEIR CONF. ASSIGN TO SWAC.
INSERT INTO teams VALUES ("23", "2599", "Reinhardt");
INSERT INTO teams VALUES ("23", "2596", "Warner");
INSERT INTO teams VALUES ("23", "584", "Tufts");

