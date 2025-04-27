
# Python Programming Language - Core Topics

---
## 🔹 2. Variables & Data Types
- **Variable declaration & assignment**
    ```python
    x = 5
    name = "Hanmanth"
    pi = 3.14
    ```
- **Common data types:**
  - `int`, `float`, `bool`, `str`, `None`(special type) 
  - `list`(mutable), `tuple`(immutable), `set`, `dict`
- **Type casting** (`int("10")`, `str(5)` etc.)
  Type casting means **converting one data type into another manually**.
  ```python
  num_str = "123"
  num_int = int(num_str)  # convert string to int

  value = 5
  value_str = str(value)  # convert int to string


  float("3.14")  # converts string to float → 3.14
  bool(0)        # converts 0 to False
  list("abc")    # converts string to list → ['a', 'b', 'c']
  ``` 


- **Dynamic typing**
  **No explicit type declaration** needed (dynamic typing). The type is decided automatically at runtime based on the value you assign.
  ```pyhton 
  x = 5      # int
  x = "five" # now x is str
  ```

✅ **Dynamic Typing** = Python auto-handles types
✅ **Type Casting** = You manually convert types


## 🔹 3. Operators
- Arithmetic (`+`, `-`, `*`, `/`, `%`, `**`)
- Comparison (`==`, `!=`, `>`, `<`)
- Logical (`and`, `or`, `not`)
- Assignment (`=`, `+=`, `-=`)
- Membership (`in`, `not in`)
- Identity (`is`(==), `is not`(!=))

## 🔹 4. Control Flow
- Conditional Statements:
  - `if`, `elif`, `else`
- Loops:
  - `for` loop
  - `while` loop
  - Loop control: `break`, `continue`, `pass`
- Use match (Python 3.10+) for cleaner conditionals where needed.
  ```python 
  match command:
    case "start":
        start_app()
    case "stop":
        stop_app()
    case _:
        print("Unknown command")
  ```
- comprehension
  - list comprehension 
  - dictionary comprehension

[detailed explanation](python_oop_concepts.md)

## 🔹 5. Functions
- Defining and calling functions (`def my_func():`)
- Parameters and return values
- Default and keyword arguments
  ```python
    def greet(name, greeting="Hello"):
      print(f"{greeting}, {name}!")

    greet("Hanmanth")
    greet("Hanmanth", "Good evening")
    greet(name="Hanmanth",greeting="Good to see you")
  ```
- `*args` and `**kwargs`
  - `*args` lets you accept a **variable number of positional arguments**. `args` will be a tuple of all extra arguments.
  - ✅ *args is used when you don't know how many arguments you'll get.
    ```python
      def add_numbers(*args):
        total = 0
        for num in args:
            total += num
        return total

      print(add_numbers(1, 2, 3, 4))  # Output: 10

    ```

  - `**kwargs` lets you accept a **variable number of named arguments**. `kwargs` will be a dictionary (dict) of key-value pairs.
  - ✅ **kwargs is useful when you don't know what "named data" you'll receive.
    ```python
    def describe_person(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")


    describe_person(name="Hanmanth", age=30, city="Hyderabad")

    ```
- Use **type hints(also called type annotations)** to make code easier to understand
  -  Without hints:
    ```python
    def add_numbers(a, b):
        return a + b
    ```
  -  With type hints:
    ```python
    def add_numbers(a: int, b: int) -> int:
        return a + b
    ```
- **Lambda** functions is a small anonymous function (anonymous = no name).

  -  **No** `def` **keyword** needed.

  -  **No function name** when defining (but you can assign it to a variable).

  -  **Only ONE expression** (no loops, no multiple lines inside lambda).

  -  **Return is automatic** (no need to write return).

  ```python 
  lambda arguments: expression
  ```
Normal function:
  ```python 
  def add(x, y):
    return x + y

  print(add(2, 3))  # Output: 5
```
Same using lambda:

```python 
add = lambda x, y: x + y
print(add(2, 3))  # Output: 5

```
another example:
```python
multiply = lambda a, b: a * b
print(multiply(4, 5))  # Output: 20
```
map() + lambda
filter() + lambda
reduce() + lambda

## 🔹 6. Data Structures
- **List**: `append()`, `pop()`, slicing, list comprehensions
- **Tuple**: immutable collections
- **Set**: unique elements
- **Dictionary**: key-value pairs

## 🔹 7. Exception Handling
- `try`, `except`, `finally`, `raise`
- Handling specific exceptions

## 🔹 8. Object-Oriented Programming (OOP)
- Classes and objects
- Constructor (`__init__`)
- Instance vs class variables
- Inheritance
- Polymorphism
- Encapsulation
- Special methods like `__str__`, `__len__`

[detailed explanation](python_oop_concepts.md)

## 🔹 9. Modules & Packages
- Importing modules (`import math`, `from os import path`)
- Creating custom modules
- Using `pip` to install packages
- Virtual environments


## 🔹 10. File Handling
- Reading/writing files (`open()`, `read()`, `write()`, `with`)
- Working with file paths (`os`, `pathlib`)
- Always use with statement to manage files (auto closes even if error happens).
  ```python 
  with open('file.txt', 'r') as file:
    content = file.read()
  ```
  - Handle file exceptions carefully:
  ```python
  try:
    with open('data.csv', 'r') as file:
        data = file.read()
  except FileNotFoundError:
    print("File not found!")
    ```




## 🔹 11. Libraries and Frameworks (bonus!)
- **Standard Library**: `math`, `random`, `datetime`, etc.
- **Popular Libraries**:
  - **Data**: `pandas`, `numpy`
  - **Web**: `flask`, `django`
  - **AI/ML**: `tensorflow`, `torch`, `scikit-learn`


## 🔹 12. Advanced Concepts (optional depending on level)
- Decorators
- Generators
- Iterators
- Context Managers
- Multithreading / multiprocessing
- Async programming (`async`, `await`)

## 🔹 13. Python Keywords & Built-in Statements

### 🧪 Assertions & Testing
- `assert`: Used for debugging and testing.  
  Example: `assert x > 0, "x must be positive"`

### ⚙️ Memory & Object Management
- `del`: Deletes a variable or object.  
  Example: `del my_list[2]`

### 🧠 Generators & Coroutines
- `yield`: Turns a function into a generator.  
  Example:
  ```python
  def count_up():
      yield 1
      yield 2
  ```

### 🌐 Scope & Namespaces
- `global`: Declares that a variable is global.
- `nonlocal`: Used inside nested functions to refer to a variable in the enclosing function.

### 🧵 Concurrency & Asynchronous Programming
- `async`, `await`: For asynchronous code execution.  
  Example:
  ```python
  async def fetch():
      await some_io()
  ```

### 🧩 Class & Function Definitions
- `def`, `class`
- `return`, `yield`
- `lambda`: for anonymous functions

### 🎛️ Control Statements
- `if`, `else`, `elif`, `for`, `while`, `break`, `continue`, `pass`

### 🛠️ Exception Handling
- `try`, `except`, `finally`, `raise`

### 📌 Others
- `with`: Context manager (used with file operations, locks, etc.)
- `is`: Identity check
- `in`: Membership check
- `True`, `False`, `None`
