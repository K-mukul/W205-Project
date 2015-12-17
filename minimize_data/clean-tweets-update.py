import json
import sys

dates = sys.argv[1:]

for day in dates:
    with open("clean-tweets_" + day + ".log", 'w') as outfile:
        count = 0

        #Opens the file from whatever directory python notebook was launched from. 
        #You'll need a different path if the dictionay files are in a separate folder.

        filename = "tweets-keywords-v1-" + day + ".log"

        line_generator = open(filename)

        for line in line_generator:
            #Here we cycle through each tweet
            line_object = json.loads(line)

            #This requires a "try" call because some tweets apparently don't have text
            try:
                tweet = line_object['text']
            except:
                continue

            #We are now filtering for only tweets that have "black friday" or "blackfriday"
            if "black friday" in tweet.lower() or "blackfriday" in tweet.lower():
                count += 1
                date = line_object['created_at']

                #Immediately write all tweets with scores to JSON
                #Also remove new lines, since Hive does not play well with '\n' in text
                data = {}
                data['text'] = tweet.replace('\n', ' ')
                data['date'] = date
                print data
                #data['score'] = score
                json.dump(data, outfile)
                outfile.write('\n')
    print "There were", count, "tweets with 'black friday' on", day
