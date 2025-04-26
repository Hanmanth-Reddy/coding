
# 📘 Context Managers in Python (`with` Statement)

---

## ✅ What is a Context Manager?

A context manager in Python allows you to manage resources like files, network connections, locks, etc., efficiently and safely using the `with` keyword.

---

## 🔥 Benefits of Using `with`

- Automatically manages resources (like closing files)
- Cleaner and shorter code
- Prevents resource leaks
- Exception-safe

---

## 📂 1. File Handling

```python
with open('file.txt', 'r') as f:
    data = f.read()
# Automatically closed here
```

---

## 🧵 2. Thread Locks
Context managers help manage thread or process locks:

```python
from threading import Lock

lock = Lock()

with lock:
    # Critical section
    do_something()
```

---

## 🗃️ 3. Database Connections
Automatically commits or rolls back transactions, and closes the connection:

```python
import sqlite3

with sqlite3.connect('example.db') as conn:
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
```

---

## 🌐 4. Network Sockets
Ensures socket is closed properly:

```python
import socket

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect(('example.com', 80))
    s.sendall(b'GET / HTTP/1.1\r\n\r\n')
```

---

## 📄 5. Temporary Files
No need to manually delete them:

```python
import tempfile

with tempfile.TemporaryFile() as tmp:
    tmp.write(b'Temp data')
```

---

## 🧪 6. Unit Testing (Mocking)
For unit tests using unittest.mock:	

```python
from unittest.mock import patch

with patch('module.function') as mock_func:
    mock_func.return_value = 'test'
```

---

## 🛠️ 7. Custom Context Managers
You can build your own using a class or the contextlib module:

### Using a class:

```python
class MyManager:
    def __enter__(self):
        print("Start")
    def __exit__(self, exc_type, exc_val, exc_tb):
        print("End")

with MyManager():
    print("Inside block")
```

### Using `contextlib`:

```python
from contextlib import contextmanager

@contextmanager
def my_context():
    print("Start")
    yield
    print("End")

with my_context():
    print("Inside block")
```

---
