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
