# borrowed from http://stackoverflow.com/questions/1871524/convert-from-json-to-csv-using-python/1872081#1872081
import json
import csv

jsonfile = open("2010.json","r")
c = json.loads(unicode(jsonfile.read()))
f = csv.writer(open("data/csv/2010.csv","wb+"))
f.writerow(["id", "album_id", "album_date", "album_title", "caption", "author"])
for c in c:
  f.writerow([c["id"], c["album_id"], c["album_date"], c["album_title"].encode('utf-8'), c["caption"].encode('utf-8'), c["author"].encode('utf-8')])