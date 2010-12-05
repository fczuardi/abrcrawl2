# borrowed from http://johntron.com/creations/csv-to-json/
import csv
import json

f = open( '2010.csv', 'r' )
reader = csv.DictReader( f, fieldnames = ( "id", "album_id", "album_date", "album_title", "caption", "author" ) )
out = json.dumps( [ row for row in reader ] )
print out