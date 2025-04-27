
# Go Programming Language - Advanced Topics Guide

---

# 🔹 Generics (Go 1.18+)

Generics allow writing flexible and reusable code.

Example:
```go
package main

import "fmt"

func PrintSlice[T any](s []T) {
    for _, v := range s {
        fmt.Println(v)
    }
}

func main() {
    PrintSlice([]int{1, 2, 3})
    PrintSlice([]string{"a", "b", "c"})
}
```

- `T` is a type parameter.
- `any` means any type.

---

# 🔹 Unit Testing in Go

Go has a built-in `testing` package.

Basic test:
```go
package main

import "testing"

func Add(a, b int) int {
    return a + b
}

func TestAdd(t *testing.T) {
    result := Add(2, 3)
    if result != 5 {
        t.Errorf("Expected 5, got %d", result)
    }
}
```

Run tests:
```bash
go test
```

---

# 🔹 Benchmarking

Example benchmark:
```go
func BenchmarkAdd(b *testing.B) {
    for i := 0; i < b.N; i++ {
        Add(1, 2)
    }
}
```
Run benchmarks:
```bash
go test -bench=.
```

---

# 🔹 Concurrency Patterns

## Buffered Channels
```go
ch := make(chan int, 2)
ch <- 1
ch <- 2
fmt.Println(<-ch)
fmt.Println(<-ch)
```

## Select Statement

Wait on multiple channel operations:
```go
select {
case msg1 := <-ch1:
    fmt.Println("Received", msg1)
case msg2 := <-ch2:
    fmt.Println("Received", msg2)
default:
    fmt.Println("No message received")
}
```

## Worker Pool Example

```go
package main

import (
    "fmt"
    "sync"
)

func worker(id int, jobs <-chan int, results chan<- int, wg *sync.WaitGroup) {
    defer wg.Done()
    for j := range jobs {
        fmt.Println("Worker", id, "processing job", j)
        results <- j * 2
    }
}

func main() {
    jobs := make(chan int, 5)
    results := make(chan int, 5)
    var wg sync.WaitGroup

    for w := 1; w <= 3; w++ {
        wg.Add(1)
        go worker(w, jobs, results, &wg)
    }

    for j := 1; j <= 5; j++ {
        jobs <- j
    }
    close(jobs)

    wg.Wait()
    close(results)

    for r := range results {
        fmt.Println("Result:", r)
    }
}
```

---

# 🔹 Dependency Management (Go Modules)

- Initialize:
```bash
go mod init myproject
```
- Add dependency:
```bash
go get github.com/gorilla/mux
```
- Update dependency:
```bash
go get -u github.com/gorilla/mux
```
- Tidy up unused modules:
```bash
go mod tidy
```

---

# 🔹 Best Go Project Structure

Recommended structure:
```bash
/myproject
    /cmd
        /app
            main.go
    /pkg
        /service
            logic.go
    /internal
        /auth
            auth.go
    /api
        handlers.go
    go.mod
    go.sum
    README.md
```

- `cmd/` - entry points
- `pkg/` - reusable packages
- `internal/` - private code
- `api/` - API definitions

---

# 🔹 Advanced Interface Usage

Interfaces with multiple methods:
```go
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

type ReadWriter interface {
    Reader
    Writer
}
```

Empty interface:
```go
func describe(i interface{}) {
    fmt.Printf("Type: %T, Value: %v
", i, i)
}
```

Use type assertions:
```go
value, ok := i.(string)
```

---

# 🔹 Building Microservices with Go

- Lightweight HTTP servers using `net/http`
- Use `gorilla/mux` for routers
- JSON encoding/decoding: `encoding/json`
- Use `Docker` to containerize

Simple API:
```go
import (
    "encoding/json"
    "net/http"
)

type Message struct {
    Text string `json:"text"`
}

func handler(w http.ResponseWriter, r *http.Request) {
    json.NewEncoder(w).Encode(Message{"Hello, World!"})
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
```

---

# 🔹 Bonus: Real-world Usage

| Area          | Usage in Go                        |
|---------------|-------------------------------------|
| Docker        | Docker Engine is written in Go      |
| Kubernetes    | Kubernetes core is in Go            |
| DevOps Tools  | Terraform, Prometheus in Go         |
| Cloud Native  | Microservices, APIs, CLI tools      |

---

# 🔹 Conclusion

- Master concurrency and modules.
- Write idiomatic Go ("Effective Go").
- Practice writing clean, tested, documented code.

---

# 📚 Resources

- [Go by Example](https://gobyexample.com/)
- [Effective Go](https://go.dev/doc/effective_go)
- [The Go Programming Language Book](https://www.gopl.io/)

---

# 🚀 Keep Going with Go! 🚀
