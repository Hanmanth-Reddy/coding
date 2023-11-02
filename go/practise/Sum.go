package main

import (
	"fmt"
)

func main() {
	var num1, num2 int

	fmt.Println("Enter first number:")
	fmt.Scan(&num1)
	fmt.Println("Enter second number:")
	fmt.Scan(&num2)

	sum := num1 + num2

	fmt.Println("sum: \n", sum)

}
