#!/usr/bin/python
import fileinput
import json

for line in fileinput.input():
    line_object = json.loads(line)
    try:
        tweet = line_object['text']
    except KeyError:
        continue
    if "black friday" in tweet.lower() or "blackfriday" in tweet.lower():
        date = line_object['created_at']
        #Also remove new lines, since Hive does not play well with '\n' in text
        data = {}
        data['text'] = tweet.replace('\n', ' ')
        data['date'] = date
        #data['score'] = score
        print json.dumps(data)
