
# Go Programming Language - Complete End-to-End Guide

---

# 🔹 Introduction to Go

- Designed at Google.
- Fast compilation, concurrency support, simple syntax.
- Popular for backend systems, microservices, cloud, DevOps tools.

Install Go: https://golang.org/dl/

Check version:
```bash
go version
```

Run Go code:
```bash
go run filename.go
```

Build executable:
```bash
go build filename.go
```

---

# 🔹 Basics

## Hello World
```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

---

# 🔹 Variables & Data Types

## Variable Declaration
```go
var name string = "Hanmanth"
var age int = 30
```

Short-hand declaration:
```go
city := "Hyderabad"
```

## Data Types
- int, float32, float64
- string
- bool
- arrays, slices, maps, structs

Type Conversion:
```go
var a int = 5
var b float64 = float64(a)
```

Zero values: Variables are initialized to their zero value if not explicitly assigned.

---

# 🔹 Constants
```go
const Pi = 3.14
const Greeting = "Hello"
```

---

# 🔹 Functions

Basic function:
```go
func add(x int, y int) int {
    return x + y
}
```

Multiple return values:
```go
func swap(a, b string) (string, string) {
    return b, a
}
```

Variadic function:
```go
func sum(nums ...int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    return total
}
```

---

# 🔹 Control Flow

## if/else
```go
if age > 18 {
    fmt.Println("Adult")
} else {
    fmt.Println("Minor")
}
```

## switch
```go
switch day := 3; day {
case 1:
    fmt.Println("Monday")
case 2:
    fmt.Println("Tuesday")
default:
    fmt.Println("Other day")
}
```

## for loop
```go
for i := 0; i < 5; i++ {
    fmt.Println(i)
}
```

Infinite loop:
```go
for {
    fmt.Println("Looping forever")
}
```

---

# 🔹 Arrays, Slices, and Maps

## Arrays
```go
var arr [3]int = [3]int{1, 2, 3}
```

## Slices
```go
s := []int{1, 2, 3}
s = append(s, 4)
```

## Maps
```go
m := map[string]int{"apple": 5, "banana": 7}
fmt.Println(m["apple"])
```

Delete key:
```go
delete(m, "apple")
```

---

# 🔹 Structs and Methods

## Structs
```go
type Person struct {
    name string
    age  int
}
```

## Creating and accessing structs
```go
p := Person{"Hanmanth", 30}
fmt.Println(p.name)
```

## Methods
```go
func (p Person) greet() string {
    return "Hello, my name is " + p.name
}
```

---

# 🔹 Pointers
```go
func increment(x *int) {
    *x = *x + 1
}

num := 5
increment(&num)
fmt.Println(num)  // 6
```

---

# 🔹 Interfaces

Define interface:
```go
type Shape interface {
    Area() float64
}
```

Implement interface:
```go
type Circle struct {
    radius float64
}

func (c Circle) Area() float64 {
    return 3.14 * c.radius * c.radius
}
```

---

# 🔹 Error Handling

Basic error handling:
```go
import "errors"

func divide(a, b int) (int, error) {
    if b == 0 {
        return 0, errors.New("cannot divide by zero")
    }
    return a / b, nil
}
```

Use it:
```go
result, err := divide(10, 0)
if err != nil {
    fmt.Println(err)
} else {
    fmt.Println(result)
}
```

---

# 🔹 Packages & Modules

Initialize module:
```bash
go mod init myproject
```

Create a package:
```go
package greet

import "fmt"

func Hello(name string) {
    fmt.Println("Hello", name)
}
```

Import and use package:
```go
import "myproject/greet"

greet.Hello("Hanmanth")
```

---

# 🔹 File Handling

Write to file:
```go
import (
    "os"
)

func main() {
    file, _ := os.Create("test.txt")
    defer file.Close()
    file.WriteString("Hello File")
}
```

Read from file:
```go
import (
    "fmt"
    "os"
)

func main() {
    data, _ := os.ReadFile("test.txt")
    fmt.Println(string(data))
}
```

---

# 🔹 Goroutines and Channels (Concurrency)

## Goroutines
```go
func printMsg(msg string) {
    for i := 0; i < 5; i++ {
        fmt.Println(msg)
    }
}

func main() {
    go printMsg("Hello")
    printMsg("World")
}
```

## Channels
```go
func worker(done chan bool) {
    fmt.Println("Working...")
    done <- true
}

func main() {
    done := make(chan bool)
    go worker(done)
    <-done
}
```

---

# 🔹 Defer, Panic, Recover

## defer
```go
func main() {
    defer fmt.Println("world")
    fmt.Println("hello")
}
```

## panic and recover
```go
func main() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("Recovered from panic:", r)
        }
    }()

    panic("Something went wrong!")
}
```

---

# 🔹 Best Practices

- Always check errors.
- Keep functions short.
- Use clear and meaningful variable names.
- Modularize your code.
- Use gofmt to auto-format code.
- Prefer channels over shared memory.
- Comment your code properly.

Format code:
```bash
gofmt -w .
```

Linting:
```bash
golint
```

---

# 🔹 Conclusion

- Go is simple yet powerful.
- Master basics, then dive into concurrency, microservices, performance optimization.
- Build real projects to sharpen skills!

---

# 🔹 Sample Full Program
```go
package main

import (
    "fmt"
    "errors"
)

func divide(a, b int) (int, error) {
    if b == 0 {
        return 0, errors.New("cannot divide by zero")
    }
    return a / b, nil
}

func main() {
    result, err := divide(10, 2)
    if err != nil {
        fmt.Println(err)
    } else {
        fmt.Println("Result:", result)
    }
}
```
---

# 🌟 Happy Learning Go! 🌟
