import json

for day in range(24, 30):
    with open("clean-tweets_2015-11-"+str(day)+".log", 'w') as outfile:

        #Opens the file from whatever directory python notebook was launched from. 
        #You'll need a different path if the dictionay files are in a separate folder.

        filename = "tweets-keywords-v1-2015-11-" + str(day) + ".log"

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
                date = line_object['created_at']

                #Immediately write all tweets with scores to JSON
                #Also remove new lines, since Hive does not play well with '\n' in text
                data = {}
                data['text'] = tweet.replace('\n', ' ')
                data['date'] = date
                #data['score'] = score
                json.dump(data, outfile)
                outfile.write('\n')
