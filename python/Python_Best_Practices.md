# 🏆 Python Best Practices for Arrays, Dictionaries, and General Coding

---

## 1. Use **List Comprehensions** for cleaner and faster array operations

**Bad way:**

```python
numbers = []
for i in range(10):
    numbers.append(i * i)
```

**Good way (list comprehension):**

```python
numbers = [i * i for i in range(10)]
```
✅ List comprehensions are faster and much more readable.
---

## 2. Use **Dictionary Comprehensions** too!

**Bad way:**

```python
squares = {}
for i in range(5):
    squares[i] = i * i
```

**Good way:**

```python
squares = {i: i * i for i in range(5)}
```

---

## 3. Always **use **`` when accessing a dictionary safely

Instead of risking a `KeyError`:

```python
my_dict = {"apple": 5}

# Bad: Might crash
count = my_dict["banana"]

# Good: Safe access
count = my_dict.get("banana", 0)
```
✅ .get() lets you provide a default value.
---

## 4. Prefer **enumerate()** when looping over lists with index

**Instead of:**

```python
for i in range(len(my_list)):
    print(i, my_list[i])
```

**Use:**

```python
for idx, value in enumerate(my_list):
    print(idx, value)
```
✅ Cleaner and avoids mistakes.
---

## 5. Prefer **zip()** when looping over two arrays

**Instead of:**

```python
for i in range(len(list1)):
    print(list1[i], list2[i])
```

**Use:**

```python
for a, b in zip(list1, list2):
    print(a, b)
```

---

## 6. Use **defaultdict** if you're counting or grouping

Instead of messy checks:

```python
counts = {}
for word in words:
    if word in counts:
        counts[word] += 1
    else:
        counts[word] = 1
```

**Use:**

```python
from collections import defaultdict

counts = defaultdict(int)
for word in words:
    counts[word] += 1
```

---

## 7. Use **type hints(also called type annotations)** to make code easier to understand

Without hints:

```python
def add_numbers(a, b):
    return a + b
```

With type hints:

```python
def add_numbers(a: int, b: int) -> int:
    return a + b
```
✅ Helps you and others read your code better (and tools like IDEs can catch bugs earlier).
---

## 8. **Name your variables clearly**, avoid single letters (unless in loops)

Bad:

```python
d = {"n": 5}
```

Good:

```python
fruit_counts = {"apple": 5}
```
✅ Clear names make it easy to understand even months later.
---

## 9. **Write small functions**, avoid very long ones

- A function should ideally do **one** thing.
- Break up large functions if needed.

---

## 10. **Handle errors properly** using `try/except`

Instead of letting programs crash:

```python
try:
    result = my_dict["some_key"]
except KeyError:
    result = "default"
```
✅ Especially important when working with APIs, files, databases, etc.
---
## 16. Best Practices for Logging

- Avoid using `print()` for anything except very simple scripts.

- Use the `logging` module for all production-level apps.

Example:
```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

logger.info("Application started")
logger.warning("This is a warning")
logger.error("This is an error")
```
Logging advantages:

- Configurable log levels (DEBUG, INFO, WARNING, ERROR, CRITICAL)

- Log to files, consoles, remote servers

- Better control over output formatting
---

# Quick Example Putting It All Together

```python
from collections import defaultdict
from typing import List, Dict

def count_words(words: List[str]) -> Dict[str, int]:
    word_count = defaultdict(int)
    for word in words:
        word_count[word] += 1
    return dict(word_count)

words = ["apple", "banana", "apple", "orange", "banana", "apple"]

print(count_words(words))
```

```Python
from collections import defaultdict
from typing import List, Dict
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def count_words(words: List[str]) -> Dict[str, int]:
    """Counts the frequency of words in a list."""
    word_count = defaultdict(int)
    for word in words:
        word_count[word] += 1
    return dict(word_count)

words = ["apple", "banana", "apple", "orange", "banana", "apple"]

if __name__ == "__main__":
    logger.info("Starting word count...")
    print(count_words(words))
```	
---

