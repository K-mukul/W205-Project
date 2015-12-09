#!/bin/bash
cd /data/sard-twitter
ls *.log | grep -v `date --iso` | while read f; do gzip $f && aws s3 cp $f.gz s3://mids-205-finalproject/; done
