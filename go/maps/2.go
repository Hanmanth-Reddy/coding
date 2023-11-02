package main

import "fmt"

func main() {
	salaries := map[string]int32{
		"Alice":   50000,
		"Bob":     60000,
		"Charlie": 75000,
	}
	fmt.Println(salaries)
	keys := make([]string, 0, len(salaries))
	values := make([]int32, 0, len(salaries))
	for k, v := range salaries {
		keys = append(keys, k)
		values = append(values, v)
	}
	fmt.Println(keys)
	fmt.Println(values)

}
