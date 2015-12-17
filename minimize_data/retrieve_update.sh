echo Retrieve data from: $1

# Concatenate strings to create S3 filename
myfilename='tweets-keywords-v1-'$1'.log.gz';
s3location='s3://mids-205-finalproject/'$myfilename;

# Retrieve file from S3
aws s3 cp $s3location .;

# Unzip file
echo Unzipping $myfilename;
gunzip $myfilename;

# Run file through clean-tweets.py
echo Cleaning $myfilename;
python clean-tweets-update.py $1;

# Remove original .log file
#rm 'tweets-keywords-v1-'$1'.log';

# Concatenate clean-tweets_all
echo Concatenating tweets
cat clean-tweets_all.log 'clean-tweets_'$1'.log' > 'clean-tweets_all_'$1'.log';

# Remove standalone date file
cp 'clean-tweets_'$1'.log' ../sentiment_analysis
