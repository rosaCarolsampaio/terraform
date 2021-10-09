package main

import(
	"fmt"
	"./db"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
)

func main(){
	
	sess, err := session.NewSession(&aws.Config{
		Region: aws.String("eu-east-2"),
		Endpoint: aws.String("http://localstack:4566"),
	})
    if err != nil{
		fmt.Printf(" err There was an error starting a new session %+v\n", err)
	}

	svc := dynamodb.New(sess)
	db.CreateMyDBTable(sess, svc)
    
	item := Item{
		Year: 2021,
		Title: "rosa sampaio",
	}
	db.AddDBItem(item, svc)


	fmt.Println(" the end")
}