DROP TABLE IF EXISTS raw_tweets;
DROP TABLE IF EXISTS tweets;

CREATE EXTERNAL TABLE raw_tweets
(json STRING)

STORED AS TEXTFILE
LOCATION '/user/w205/final_proj/raw_tweets';

LOAD DATA LOCAL INPATH 'clean-tweets_all_2015-mm-dd.log'
OVERWRITE INTO TABLE raw_tweets;

CREATE TABLE tweets AS
SELECT
get_json_object(json, "$.text") as text,
get_json_object(json, "$.date") as created_at,
unix_timestamp(get_json_object(json, "$.date"), "EEE MMM d HH:mm:ss Z yyyy") as ts_created
FROM raw_tweets;
