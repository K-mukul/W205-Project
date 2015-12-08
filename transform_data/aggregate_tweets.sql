DROP TABLE IF EXISTS hourly_tweets;

CREATE TABLE hourly_tweets AS
SELECT
from_unixtime(ts_created, "yyyy-MM-dd HH") as hour,
COUNT(ts_created) as count
FROM tweets
GROUP BY from_unixtime(ts_created, "yyyy-MM-dd HH");
