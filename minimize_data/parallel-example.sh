#!/bin/bash
processes=$1
ls -1 /vagrant/sample-data | parallel -P $processes /vagrant/parallel-clean-tweets.py /vagrant/sample-data/{}
