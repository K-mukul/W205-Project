#!/usr/bin/env python
import os
import yaml
import json
from birdy.twitter import StreamClient
from kafka.client import KafkaClient
from kafka.producer import SimpleProducer
import sys

keywordsfile = "/vagrant/keywords-v1.txt"
tokenfile = "/vagrant/twitter-api-keys.yml"
kafkanodes = 'localhost:9092'
topic = "blackfriday"

with open(keywordsfile) as f:
    keywords = f.read().splitlines()
keywords_string = ','.join(set(keywords))

client = KafkaClient(kafkanodes)
producer = SimpleProducer(client)

tokens = yaml.safe_load(open(tokenfile))
client = StreamClient(tokens['consumer_key'],tokens['consumer_secret'],tokens['access_token'],tokens['access_secret'])
resource = client.stream.statuses.filter.post(track=keywords_string)

for data in resource.stream():
  tweet = json.dumps(data) + '\n'
  producer.send_messages(topic, tweet)
