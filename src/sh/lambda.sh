#!/bin/bash

 # copy the files and create trust:
    #- awslocal s3 mb s3://$LOCALSTACK_S3_BUCKET_NAME
awslocal s3api put-object --bucket $LOCALSTACK_S3_BUCKET_NAME --key lambda
awslocal s3 cp ./src/ s3://$LOCALSTACK_S3_BUCKET_NAME --recursive --acl public-read-write
curl -v http://localstack:4566/$LOCALSTACK_S3_BUCKET_NAME/index.js | true

# create role:
awslocal iam create-role --role-name lambda-example --assume-role-policy-document file://src/script/trust-policy.json
    
#attach the policy - a permission to role
awslocal iam attach-role-policy --role-name lambda-example --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

#Create the function:
zip -r function.zip index.js 
awslocal lambda create-function --function-name hello --zip-file fileb://function.zip --handler index.handler --runtime nodejs12.x --role arn:aws:iam::000000000000:role/lambda-example

# other way: awslocal lambda create-function --function-name hello  --code S3Bucket=$LOCALSTACK_S3_BUCKET_NAME,S3Key=function.zip  --handler "src/index.handler"  --runtime "nodejs12.x"  --region $AWS_DEFAULT_REGION --memory-size "128"  --role arn:aws:iam::000000000000:role/lambda-example 
awslocal lambda update-function-code --function-name hello --zip-file fileb://function.zip


#check
awslocal lambda list-functions --region $AWS_DEFAULT_REGION
awslocal lambda get-function  --region $AWS_DEFAULT_REGION --function-name hello
awslocal lambda invoke --function-name  arn:aws:lambda:eu-west-2:000000000000:function:hello out --log-type Tail

#awslocal logs get-log-events --log-group-name /aws/lambda/hello --log-stream-name $(cat out) --limit 5