 #!/bin/bash

 
awslocal configure set region $DEFAULT_REGION
awslocal dynamodb create-table --table-name Music --attribute-definitions AttributeName=Artist,AttributeType=S AttributeName=SongTitle,AttributeType=S --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
awslocal dynamodb put-item --table-name Music --item  file://src/script/item_table.json  --return-consumed-capacity TOTAL 
awslocal dynamodb list-tables 
awslocal dynamodb query --table-name Music --key-conditions file://src/script/query_table.json