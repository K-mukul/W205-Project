import json

# Let's open a file that only contains a sample of the tweets
with open("clean-tweets_sample.log", 'w') as outfile:
    # We'll get tweets from the clean-tweets_all.log file
    line_generator = open("clean-tweets_all.log")
    
    # Go through each line and pull out only the tweets that occurred at the top of the minute
    for line in line_generator:
        line_object = json.loads(line)
        date = line_object['date']
        if date[17:19] == '00':
            data = {}
            data['text'] = line_object['text']
            data['date'] = date
            json.dump(data, outfile)
            outfile.write('\n')
