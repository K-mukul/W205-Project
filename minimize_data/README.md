## Packages needed for this application
AWS CLI

```$pip install awscli```

## Note: To access data from S3, you will need credentials for our S3 bucket. Sent separately.
------------------------------
# Cleaning and filtering the original data set
After collecting our data set, we need to clean and minimize it, since we collected about 10GB of data per day.  To minimize and clean the data, we chose to only include tweets that had "black friday" or "blackfriday" (case insensitive) in the tweet. We did this because we were interested in how Twitter users were reacting to Black Friday.

We ran this on the course AMI ucbw205_complete_plus_postgres_PY2.7.

Since we collected so much raw data, we cleaned/filtered and put the smaller files into S3. Although it is possible to pull the raw tweet files and clean them using the files in this folder, we do not recommend running the steps below. We recommend only running the retrive_data.sh file, which will download the filtered, cleaned data sets.

### Download the raw data from s3 to "minimize_data" folder
### THESE FILES ARE AROUND 10GB EACH
```
aws s3 cp s3://mids-205-finalproject/tweets-keywords-v1-2015-11-24.log.gz .
aws s3 cp s3://mids-205-finalproject/tweets-keywords-v1-2015-11-25.log.gz .
aws s3 cp s3://mids-205-finalproject/tweets-keywords-v1-2015-11-26.log.gz .
aws s3 cp s3://mids-205-finalproject/tweets-keywords-v1-2015-11-27.log.gz .
aws s3 cp s3://mids-205-finalproject/tweets-keywords-v1-2015-11-28.log.gz .
aws s3 cp s3://mids-205-finalproject/tweets-keywords-v1-2015-11-29.log.gz .
aws s3 cp s3://mids-205-finalproject/tweets-keywords-v1-2015-11-30.log.gz .
```

### Unzip everything in "data" folder
### THESE FILES ARE COMPRESSED TO 12%, they are about 65GB uncompressed.
```
gunzip tweets-keywords-v1-2015-11-24.log.gz
gunzip tweets-keywords-v1-2015-11-25.log.gz
gunzip tweets-keywords-v1-2015-11-26.log.gz
gunzip tweets-keywords-v1-2015-11-27.log.gz
gunzip tweets-keywords-v1-2015-11-28.log.gz
gunzip tweets-keywords-v1-2015-11-29.log.gz
gunzip tweets-keywords-v1-2015-11-30.log.gz
```

### Filter all tweets for only those that have "black friday" or "blackfriday" in them
```python clean-tweets.py```

# Working with cleaned data
### Retrieving data from S3
To retrieve the cleaned data directly from S3, run the following script with our AWS credentials:

```$bash retrieve_data.sh```

### Loading data into Hive
We loaded the data into Hive to do data transformations on the clean data set.

```$hive -f load_tweets.sql```

## Running a parallelized version of the cleaner filter

An example of a parallized version of the cleaner is include showing how to clean
the tweets faster using GNU Parallel.

To run the example, ensure your local machine has vagrant installed (vagrantup.com)
then, while in this directory start the Vagrant vm, log in, run the example script.

    vagrant up
    vagrant ssh
    cd /Vagrant
    ./parallel-example.sh 2

The argument to ./paralell-example.sh is the number of processes to run. This command
will run on a few megabytes of sample data stored in /vagrant/sample-data. Note: the vagrant vm
is provisioned with only 2 cores (as seen in the Vagrantfile), so it's not that great.
Here are the results of running the example with different numbers of processes. Results will vary depending on
the machine you run this on but as shown below more processes do decrease the time to
process even this small sample data set.

    vagrant@w205-final-minimize-data-example:/vagrant$ time ./parallel-example.sh 1 > /dev/null

    real	0m1.479s
    user	0m0.880s
    sys	0m0.332s
    vagrant@w205-final-minimize-data-example:/vagrant$ time ./parallel-example.sh 2 > /dev/null

    real	0m0.966s
    user	0m1.178s
    sys	0m0.291s
    vagrant@w205-final-minimize-data-example:/vagrant$ time ./parallel-example.sh 3 > /dev/null

    real	0m0.938s
    user	0m1.075s
    sys	0m0.419s
    vagrant@w205-final-minimize-data-example:/vagrant$ time ./parallel-example.sh 4 > /dev/null

    real	0m0.885s
    user	0m1.022s
    sys	0m0.415s
