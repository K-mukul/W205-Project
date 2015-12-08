#!/bin/bash

# Download clean tweets
aws s3 cp s3://mids-205-finalproject/clean-tweets_2015-11-24.log .;
aws s3 cp s3://mids-205-finalproject/clean-tweets_2015-11-25.log .;
aws s3 cp s3://mids-205-finalproject/clean-tweets_2015-11-26.log .;
aws s3 cp s3://mids-205-finalproject/clean-tweets_2015-11-27.log .;
aws s3 cp s3://mids-205-finalproject/clean-tweets_2015-11-28.log .;
aws s3 cp s3://mids-205-finalproject/clean-tweets_2015-11-29.log .;
aws s3 cp s3://mids-205-finalproject/clean-tweets_2015-11-30.log .;

# Concatenate data to form one file with all Black Friday tweets
cat clean-tweets_2015* > clean-tweets_all.log;

# Create folder in HDFS for Hive tables
hdfs dfs -mkdir /user/w205/final_proj;
