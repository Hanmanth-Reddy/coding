
# Python Programming Language - Core Topics

---

## 🔹 2. Variables & Data Types
- Variable declaration & assignment
- Common data types:
  - `int`, `float`, `bool`, `str`
  - `list`, `tuple`, `set`, `dict`
- Type casting (`int("10")`, `str(5)` etc.)
- Dynamic typing

## 🔹 3. Operators
- Arithmetic (`+`, `-`, `*`, `/`, `%`, `**`)
- Comparison (`==`, `!=`, `>`, `<`)
- Logical (`and`, `or`, `not`)
- Assignment (`=`, `+=`, `-=`)
- Membership (`in`, `not in`)
- Identity (`is`, `is not`)

## 🔹 4. Control Flow
- Conditional Statements:
  - `if`, `elif`, `else`
- Loops:
  - `for` loop
  - `while` loop
  - Loop control: `break`, `continue`, `pass`

## 🔹 5. Functions
- Defining and calling functions (`def my_func():`)
- Parameters and return values
- Default and keyword arguments
- `*args` and `**kwargs`
- Lambda functions

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

## 🔹 9. Modules & Packages
- Importing modules (`import math`, `from os import path`)
- Creating custom modules
- Using `pip` to install packages
- Virtual environments

## 🔹 10. File Handling
- Reading/writing files (`open()`, `read()`, `write()`, `with`)
- Working with file paths (`os`, `pathlib`)

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
