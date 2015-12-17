DROP TABLE IF EXISTS raw_tweets_sentiment;
DROP TABLE IF EXISTS tweets_sentiment;

CREATE EXTERNAL TABLE raw_tweets_sentiment
(json STRING)

STORED AS TEXTFILE
LOCATION '/user/w205/final_proj/raw_tweets_sentiment';

LOAD DATA LOCAL INPATH 'tweet-sentiment_output.log'
OVERWRITE INTO TABLE raw_tweets_sentiment;

CREATE TABLE tweets_sentiment AS
SELECT
get_json_object(json, "$.text") as text,
get_json_object(json, "$.date") as created_at,
unix_timestamp(get_json_object(json, "$.date"), "EEE MMM d HH:mm:ss Z yyyy") as ts_created,
get_json_object(json, "$.score") as score
FROM raw_tweets_sentiment;
