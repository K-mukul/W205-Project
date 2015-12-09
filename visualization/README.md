# Data Visualization

## Hiveserver2

We will need to run Hiveserver2 to allow us to access our Hive tables from Tableau. Once the correct drivers are set up, run the Hiveserver using:

```$hive --service hiveserver2```

## Tableau

A packaged workbook is included to make viewing in Tableau easier (tweet-visualization_packaged.twbx). The tweet_visualizations.twb is the same workbook, only the data connections will need to be configured to reflect the Hiveserver that is currently running.
