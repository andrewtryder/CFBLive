#!/usr/bin/env python
import sqlite3
import sys

cfbid1 = sys.argv[1]
cfbid2 = sys.argv[2]

with sqlite3.connect("db/cfb.db") as conn:
    cursor = conn.cursor()
    #query = "SELECT confs.division, teams.conf FROM teams LEFT JOIN confs ON teams.conf = confs.id WHERE teams.id=?"
    query = "SELECT DISTINCT conf FROM teams WHERE id IN (?, ?)"
    #query = "SELECT confs.division, teams.conf FROM teams LEFT JOIN confs ON teams.conf = confs.id WHERE teams.id IN (?,?)"
    cursor.execute(query, (cfbid1, cfbid2,))
    #cursor.execute(query, (cfbid1,))
    #item = cursor.fetchall()
    item = [i[0] for i in cursor.fetchall()]
    print item
