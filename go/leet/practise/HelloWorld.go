package main

import (
	"fmt"
)

var name string
var val bool

func main() {

	var id int
	no := 16
	id = 50
	name1 := "Hanmanth Reddy Patukuri"
	val1 := true

	//map
	var salaries map[string]int
	empSlaries := map[string]int16{
		"emp1": 2000,
		"emp2": 3000,
		"emp3": 4000,
	}

	//Slice
	var names []string
	names1 := []string{
		"abc", "def", "ghi"}

	fmt.Println(id)
	fmt.Println(no)

	fmt.Println(name)
	fmt.Println(name1)

	fmt.Println(val)
	fmt.Println(val1)

	fmt.Println(salaries)
	fmt.Println(empSlaries)

	fmt.Println(names)
	fmt.Println(names1)
	/* fmt.Println("Hellow, World") */
}
