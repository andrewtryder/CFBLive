#!/usr/bin/env python
from BeautifulSoup import BeautifulSoup
import urllib2

url = 'http://m.yahoo.com/w/sports/ncaaf/teams?tab=2&.lang=en&.intl=US'
req = urllib2.Request(url)
html = (urllib2.urlopen(req)).read()
soup = BeautifulSoup(html)
confs = soup.findAll('div', attrs={'class':'g e'})

links = []

for conf in confs:
    base = conf.find('a')
    confname = base.getText()
    link = base['href']
    link = link.split('?')[0]
    confid = link.replace('/w/sports/ncaaf/teams/ncaaf.i-aa.', '')
    print "INSERT INTO confs VALUES (\"2\", \"{0}\", \"{1}\");".format(confid, confname)
    links.append({'confid':confid, 'link':'http://m.yahoo.com'+link+'?.ts=1372612825&.intl=US&.lang=en'})

for ff in links:
    lnk = ff['link']
    req = urllib2.Request(lnk)
    html = (urllib2.urlopen(req)).read()
    soup = BeautifulSoup(html)
    teams = soup.findAll('div', attrs={'class':'e d '})
    for team in teams:
        base = team.find('a')
        teamname = base.getText().encode('utf-8').replace('&amp;', '&')
        link = base['href']
        link = link.split('?')[0]
        teamid = link.replace('/w/sports/ncaaf/team/ncaaf.t.', '')
        print "INSERT INTO teams VALUES (\"{0}\", \"{1}\", \"{2}\");".format(ff['confid'], teamid, teamname)
