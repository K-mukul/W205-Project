#!/bin/bash
cd data
ls *.log | grep -v `date --iso` | while read f; do gzip $f && aws s3 cp $f.gz s3://mids-205-finalproject/; done
