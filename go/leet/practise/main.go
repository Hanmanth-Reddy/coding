package main

import (
	"fmt"
)

func main() {

	//var msg string = "Hello, world"

	msg := "Hello, World"
	names := []string{"Hanmanth Reddy Patukuri", "Namratha Patukuri", "Srihith Reddy Patukuri", "Dhruthi Reddy Patukuri"}

	fmt.Println(msg)
	fmt.Println(names)

	for index, name := range names {
		fmt.Println("index", index, "\tname:", name)
	}
}
