#!/usr/bin/env python
import sqlite3
import urllib2
from BeautifulSoup import BeautifulSoup
import sys

_cfbdb = '/home/spline/supybot/plugins/CFBLive/db/cfb.db'

def existingids():
    with sqlite3.connect(_cfbdb) as conn:
        cursor = conn.cursor()
        query = "SELECT id FROM teams"
        cursor.execute(query)
        ids = [i[0] for i in cursor.fetchall()]
    return ids

def find_missing_items(int_list):
    '''
    Finds missing integer within an unsorted list and return a list of
    missing items

    >>> find_missing_items([1, 2, 5, 6, 7, 10])
    [3, 4, 8, 9]

    >>> find_missing_items([3, 1, 2])
    []
    '''

    # Put the list in a set, find smallest and largest items
    original_set  = set(int_list)
    smallest_item = min(original_set)
    largest_item  = max(original_set)

    # Create a super set of all items from smallest to largest
    full_set = set(xrange(smallest_item, largest_item + 1))

    # Missing items are the ones that are in the full_set, but not in
    # the original_set
    return sorted(list(full_set - original_set))

#
def _ft(tid):
    url = 'http://m.yahoo.com/w/sports/ncaaf/team/ncaaf.t.%s' % (str(tid))
    request = urllib2.Request(url, headers={"User-Agent":"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:17.0) Gecko/20100101 Firefox/17.0"})
    html = (urllib2.urlopen(request))
    html = html.read()
    soup = BeautifulSoup(html)
    tn = soup.find('div', attrs={'class':'uic title first'})
    if tn:
        team = tn.getText()
    else:
        team = None

    conf = soup.find('div', attrs={'class':'uic last'})
    if conf:
        cn = conf.getText()
        confnum = conf.find('a')['href'].split('?')[0]
        confnum=''.join(i for i in confnum if i.isdigit())
    else:
        conf = None

    if team and conf:
        return team, cn, confnum
    else:
        return None

existing = existingids()
missing = find_missing_items(existing)
for m in missing:
    if m < 1956:
        continue
    mm = _ft(m)
    if mm:
        print 'INSERT INTO teams VALUES ("{0}", "{1}", "{2}", ""); -- {3}'.format(mm[2], m, mm[0], mm[1])
    else:
        print "{0} came back empty/wrong".format(m)
