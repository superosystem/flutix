package main

import (
	"fmt"

    "encoding/json"
	pb "github.com/gusrylmubarok/alpha-restful-golang/ch6-protocol-buffers-grpc/protofiles"
)

func main() {
	p := &pb.Person{
		Id:    1234,
		Name:  "Roger F",
		Email: "rf@example.com",
		Phones: []*pb.Person_PhoneNumber{
			{Number: "555-4321", Type: pb.Person_HOME},
		},
	}
	body, _ := json.Marshal(p)
	fmt.Println(string(body))
}