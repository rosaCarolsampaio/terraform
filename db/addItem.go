package db

import (
    "github.com/aws/aws-sdk-go/aws"
    "github.com/aws/aws-sdk-go/service/dynamodb"
    "github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"

    "fmt"
	"os"
)
// Create struct to hold info about new item
type Item struct {
    Year   int
    Title  string
}

func AddDBItem(item Item, svc *dynamodb.DynamoBD){
	av, err := dynamodbattribute.MarshallMap(item)
	input := &dynamodb.PutItemInput{
		Item: av,
		TableName: aws.String("Novies"),
	}
	_, err = svc.PutItem(input)
	if err != nil{
		fmt.Printf(" Got error calling PutItem: %+v\n", err)
		fmt.Println(err.Error())
		os.Exit(1  )
	}
	fmt.Println("Successfully added item to table")
}