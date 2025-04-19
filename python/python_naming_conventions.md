
# 🐍 Python Naming Conventions (PEP 8)

---

## 🔸 1. Variables
- Use **lowercase** letters with **underscores**.
```python
user_name = "Hanmanth"
total_price = 499.99
```

---

## 🔸 2. Constants
- Use **UPPERCASE** letters with **underscores**.
```python
PI = 3.14159
MAX_CONNECTIONS = 100
```

---

## 🔸 3. Functions
- Use **lowercase_with_underscores**.
```python
def send_email():
    pass

def calculate_area(radius):
    return PI * radius ** 2
```

---

## 🔸 4. Classes
- Use **PascalCase (CapWords)**.
```python
class UserAccount:
    pass

class MyCustomException(Exception):
    pass
```

---

## 🔸 5. Methods
- Same as functions: **lowercase_with_underscores**.
```python
class User:
    def get_full_name(self):
        return f"{self.first_name} {self.last_name}"
```

---

## 🔸 6. Private Variables & Methods
- Start with a **single underscore** `_` to indicate it's for internal use.
```python
class Example:
    def __init__(self):
        self._internal_counter = 0
```

---

## 🔸 7. Strongly Private (Name Mangling)
- Prefix with **double underscore** `__`.
```python
class Secret:
    def __init__(self):
        self.__password = "top_secret"
```

---

## 🔸 8. Modules & Files
- Use all **lowercase** letters. Underscores if needed.
```bash
user.py
data_utils.py
```

---

## 🔸 9. Packages
- Use all **lowercase**, no underscores preferred.
```bash
analytics/
payments/
```

---

## 🔸 10. Global & Nonlocal
- Use `global` and `nonlocal` for modifying variables from enclosing scopes (use sparingly).

---

## 💡 Tips
- Avoid names like `l`, `O`, or `I` — they can be confused with numbers.
- Use meaningful names: `user_id` is better than `u`.
- Stick to convention! It makes collaboration and maintenance easier.
