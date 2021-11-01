#!/bin/bash

awslocal lambda invoke --function-name  hello --cli-binary-format raw-in-base64-out --payload '{"key": "value"}' out
sed -i'' -e 's/"//g' out
sleep 15
awslocal logs get-log-events --log-group-name /aws/lambda/hello --log-stream-name $(cat out) --limit 5