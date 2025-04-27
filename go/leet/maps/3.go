package main

import "fmt"

func main() {
	salaries := map[string]int32{
		"Alice":   500000,
		"Bob":     1100000,
		"Charlie": 705000,
	}
	salaries["Hanmanth"] = 1000000

	fmt.Println(salaries)
	fmt.Println("Hanmanth salary:", salaries["Hanmanth"])

	sal, exists := salaries["Bob"]
	if exists {
		fmt.Println("Key is exists and his sal is", sal)
	}
}
