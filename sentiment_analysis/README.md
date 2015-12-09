# Sentiment Analysis

## Setup

```
pip install nltk
pip install pyyaml
pip install pprintpp
```

In python, run:

```
import nltk
nltk.download()
```

Download all packages (I did not download the panlex-lite package to the course AMI due to disk size).

## Running script

Current script takes a file as a parameter and appends the sentiment score to the end of the JSON.

```$python run_sentiment.py small-tweet.txt```

Output JSON is tweet-sentiment_output.log.

Note that we output all of our tweets to clean-tweets_all.log -- this file takes too long to process for sentiment analysis. Thus, we've sampled the tweets using the following script:

```$python sample_tweets.py```

This outputs the file clean-tweets_sample.log. Even with the sampled data, the sentiment analysis took several hours to run. To demonstrate the sentiment analysis on a very small data set, use the file small-tweet.txt.

## Loading data into Hive

Once the sampled data is finished with sentiment analysis, load the data in tweet-sentiment_sample.log into Hive using:

```$ hive -f sentiment_hive.sql```
