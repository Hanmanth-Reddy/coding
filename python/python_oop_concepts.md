
# Python Object-Oriented Programming (OOP) Concepts

## 🔥 Core OOP Concepts in Python

1. **Class**
2. **Object**
3. **Encapsulation**
4. **Abstraction**
5. **Inheritance**
6. **Polymorphism**

---

## 1. Class — Blueprint of an Object

A class is a template or blueprint for creating objects.

```python
class Car:
    def start(self):
        print("Car started")
```

---

## 2. Object — Instance of a Class

An object is a real-world entity created from a class.

```python
my_car = Car()
my_car.start()
```

---

## 3. Encapsulation — Hiding internal details

Keeps data safe from direct access. Achieved using private/protected attributes.

```python
class BankAccount:
    def __init__(self, balance):
        self.__balance = balance  # private attribute

    def deposit(self, amount):
        self.__balance += amount

    def get_balance(self):
        return self.__balance

acc = BankAccount(1000)
acc.deposit(500)
print(acc.get_balance())  # ✅ 1500
# print(acc.__balance)   ❌ AttributeError
```

---

## 4. Abstraction — Hiding complex implementation

Show only essential features. Achieved via abstract base classes or simple method hiding.

```python
from abc import ABC, abstractmethod

class Vehicle(ABC):
    @abstractmethod
    def start(self):
        pass

class Car(Vehicle):
    def start(self):
        print("Car started")

v = Car()
v.start()
```

---

## 5. Inheritance — Reuse Code from Parent Class

Child class inherits methods/attributes from parent. Promotes code reusability.

```python
class Vehicle:
    def move(self):
        print("Vehicle is moving")

class Bike(Vehicle):
    def wheels(self):
        print("Two wheels")

b = Bike()
b.move()     # from parent
b.wheels()   # from child
```

---

## 6. Polymorphism — Same Interface, Different Behavior

- Method Overriding (in child class)
- Python also supports Duck Typing

```python
class Animal:
    def speak(self):
        print("Animal speaks")

class Dog(Animal):
    def speak(self):
        print("Dog barks")

def call_speak(animal):
    animal.speak()

call_speak(Dog())  # Dog barks
```

---

## 📦 BONUS: Other OOP Features in Python

| Feature              | Description                     |
|----------------------|---------------------------------|
| `__init__()`         | Constructor                     |
| `__str__()`          | Printable string representation |
| `@property`          | Getter/setter decorator         |
| `super()`            | Call parent method              |
| Multiple Inheritance | Inherit from multiple classes   |
| Operator Overloading | Redefine `+`, `*`, etc.         |

---

## 🧠 Real-World Analogy

Let’s say we have:
- **Class**: Blueprint of a Car
- **Object**: A specific car like `my_car = Car()`
- **Encapsulation**: Keeping engine internals private
- **Abstraction**: Start button — we don’t know how engine ignites, but it starts
- **Inheritance**: An `ElectricCar` inherits everything from `Car` but overrides `start()`
- **Polymorphism**: All cars have `start()` but behavior differs for petrol vs electric

---





---

# 🔐 Access Specifiers in Python

Python uses naming conventions instead of strict access control:

| Access Type     | Convention           | Access From                       |
|------------------|----------------------|------------------------------------|
| **Public**       | `variable`           | Accessible from anywhere           |
| **Protected**    | `_variable`          | Internal use only, but still accessible |
| **Private**      | `__variable`         | Name-mangled to prevent outside access |

### 🔹 Example:
```python
class Sample:
    def __init__(self):
        self.public_var = "I'm Public"
        self._protected_var = "I'm Protected"
        self.__private_var = "I'm Private"

    def show(self):
        print(self.__private_var)

obj = Sample()
print(obj.public_var)        # ✅ Accessible
print(obj._protected_var)    # ⚠️ Can access, but not recommended
# print(obj.__private_var)   # ❌ AttributeError
obj.show()                   # ✅ Accessed within class
```

To access private variable:
```python
print(obj._Sample__private_var)  # Not recommended
```

---

# 🌀 Polymorphism in Python

### ✅ What is Polymorphism?

Polymorphism = "Many forms" — same method behaves differently depending on context.

### 🔹 Types of Polymorphism:

| Type                    | Description                          |
|-------------------------|--------------------------------------|
| **Duck Typing**         | Based on behavior, not class type    |
| **Operator Overloading**| Custom behavior for operators        |
| **Method Overriding**   | Redefine a parent method in child    |
| **Method Overloading**  | Not directly supported in Python     |

---

## ✅ Duck Typing Example

```python
class Dog:
    def speak(self):
        print("Woof")

class Cat:
    def speak(self):
        print("Meow")

def animal_sound(animal):
    animal.speak()

animal_sound(Dog())  # Woof
animal_sound(Cat())  # Meow
```

---

## ✅ Operator Overloading Example

```python
class Point:
    def __init__(self, x):
        self.x = x

    def __add__(self, other):
        return Point(self.x + other.x)

    def __str__(self):
        return f"Point({self.x})"

p1 = Point(10)
p2 = Point(20)
print(p1 + p2)  # Point(30)
```

| Operator | Method       |
|----------|--------------|
| `+`      | `__add__()`  |
| `-`      | `__sub__()`  |
| `*`      | `__mul__()`  |
| `==`     | `__eq__()`   |
| `str()`  | `__str__()`  |

---

## ✅ Method Overriding

```python
class Bird:
    def sound(self):
        print("Generic bird sound")

class Parrot(Bird):
    def sound(self):
        print("Parrot says hello")

b = Bird()
p = Parrot()

b.sound()  # Generic bird sound
p.sound()  # Parrot says hello
```

---

## ⚠️ Simulated Method Overloading in Python

Python does NOT support it natively, but you can simulate:

### Using default arguments:
```python
class Demo:
    def greet(self, name=None):
        if name:
            print(f"Hello, {name}")
        else:
            print("Hello")

obj = Demo()
obj.greet()           # Hello
obj.greet("Hanmanth") # Hello, Hanmanth
```

### Using `*args`, `**kwargs`:
```python
def add(*args):
    return sum(args)

print(add(1, 2))       # 3
print(add(1, 2, 3))    # 6
```

---

# 🔚 Summary

| Concept           | Description                                     |
|------------------|-------------------------------------------------|
| `public_var`      | Accessible from anywhere                        |
| `_protected_var`  | Internal use only, still accessible             |
| `__private_var`   | Name-mangled, not accessible directly           |
| Duck Typing       | Behavior depends on methods, not types         |
| Operator Overload | Custom `+`, `-`, `==` using special methods     |
| Method Override   | Child class changes inherited method behavior  |
| Method Overload   | Simulated with default args or *args, **kwargs |

---









---

# 🧊 Abstraction in Python

## ✅ What is Abstraction?

**Abstraction** is one of the core principles of Object-Oriented Programming (OOP). It means **hiding the internal details and showing only the necessary features** of an object.

> Think of a car. You use the steering, accelerator, and brakes — but you don't need to understand the internal combustion engine to drive it.

---

## 🧠 Why Use Abstraction?

- Reduce complexity
- Improve code readability
- Enhance maintainability
- Enforce coding contracts using abstract methods

---

## 🔧 Abstraction in Python

Python provides abstraction using the **`abc`** module (Abstract Base Class).

### 👉 `ABC` and `@abstractmethod`

- `ABC` is a helper class that lets you define **abstract base classes**.
- `@abstractmethod` marks a method that **must be overridden** in a child class.

---

## 🔹 Example:

```python
from abc import ABC, abstractmethod

class Vehicle(ABC):
    @abstractmethod
    def start(self):
        pass

    @abstractmethod
    def stop(self):
        pass

class Car(Vehicle):
    def start(self):
        print("Car is starting")

    def stop(self):
        print("Car is stopping")

# v = Vehicle()       ❌ TypeError: Can't instantiate abstract class
my_car = Car()
my_car.start()        # ✅ Car is starting
```

---

## ⚠️ Rules for Abstraction

1. Abstract classes cannot be instantiated directly.
2. Any class inheriting from an abstract class must implement all abstract methods.
3. You can have **concrete methods** (non-abstract) in abstract classes too.

---

## 🔹 Abstract Class with Concrete Method

```python
from abc import ABC, abstractmethod

class Device(ABC):
    @abstractmethod
    def power_on(self):
        pass

    def plug_in(self):
        print("Device plugged in")

class Laptop(Device):
    def power_on(self):
        print("Laptop is booting")

l = Laptop()
l.plug_in()      # ✅ Device plugged in
l.power_on()     # ✅ Laptop is booting
```

---

## 🧩 Real-Life Analogy

| Real-World Object | Abstraction |
|------------------|-------------|
| TV Remote        | Buttons abstract complex circuits |
| ATM Machine      | UI hides transaction processing  |
| Car              | Steering wheel abstracts drivetrain |

---

## 🧾 Summary

| Concept              | Description                                          |
|----------------------|------------------------------------------------------|
| `ABC`                | Abstract Base Class from `abc` module                |
| `@abstractmethod`    | Decorator to declare a method that must be overridden|
| Can't Instantiate    | Abstract classes can't be used directly              |
| Real-world Usage     | APIs, UI Interfaces, Drivers                         |

---

