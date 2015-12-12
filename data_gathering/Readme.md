# Data Gathering

The code in this directory was used to gather twitter data. The following
steps are a quick-start guide to getting it all running in a local virtual
environment. In practice this code was deployed to an AWS EC2 Instance.

## Add your twitter credentials

    mv twitter-api-keys-example.yml twitter-api-keys.yml
    vim twitter-api-keys.yml

## Launch the example

Ensure your host operating system has Vagrant (vagrantup.com) and git installed.
Then in this directory, launch the Vagrant VM.

    vagrant up

Vagrant will:

* download a base Ubuntu Trusty Linux image
* use ansible to install and configure necessary dependencies
* add the data collector as a supervisord managed application
* launch the data collect

Once it's up and running you should see data flowing into the data directory.

## Manually tarting the data collect

If you want to run the data collector directly, it is here. Some configuration
variables at the top of the file will need to be changed if running it outside
of the vagrant vm.

    vagrant ssh
    python /vagrant/twitter-stream-to-file.py

## Moving collected data to S3

First, install and configure awscli.

    # again from within the vagrant vm
    sudo apt-get install awscli
    awscli configure
    # As prompted enter in the credentials for our S3 bucket (sent separately)

The following command was added to a nightly crontab.

    /vagrant/move-data-to-s3.sh

## Kafka

Install scripts and code to use Kafka are included here, but were not necessary
for this data collection. Writing to files and moving them to S3 on a daily basis
worked fine for collecting this volume of data.