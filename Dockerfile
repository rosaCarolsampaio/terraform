FROM golang:1.15

WORKDIR /home/rosasilva/go/src/testing/lo/
COPY . .

RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils 2>&1

RUN apt-get -y install git lsb-release

#Install Go tools
#RUN go get -d -v  pkg.go.dev/golang.org/x/lint/golint 2>&1 \
#    && pkg.go.dev/golang.org/x/tools/cmd/gopls

RUN  go get -d -v golang.org/x/lint/golint  \
     github.com/jmespath/go-jmespath \
     github.com/aws/aws-sdk-go/aws \
     github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute \
	 github.com/aws/aws-sdk-go/service \ 
     
#RUN go install -v ./...
#CMD ["app", "go", "run", "main.go"]