
# 🚦 Istio Fault Injection — Testing for Real-World Failures

## 💡 Purpose of Fault Injection in Testing Resilience

In real-world distributed systems, **failures happen all the time** — a service might become slow, unresponsive, or go completely down.

**Fault Injection** helps simulate these problems **before they happen in production**, so you can build confidence in your system’s **resilience**.

### 🔍 What are we trying to test?
By injecting artificial faults (like delays or error codes), you can verify how your **frontend or upstream services react**.

- ✅ **Retries** – Does the frontend **retry** if the backend is slow or fails?
- ✅ **Fallbacks** – Does it show **cached or default data**, or just crash?
- ✅ **Circuit Breakers** – Does it stop calling the backend if it's always broken?

---

## 🧪 Fault Injection — Abort with Retry & Fallback

Simulates **random failures (503 errors)** in 20% of the traffic. Useful for testing retry logic and fallback services.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service
  http:
  - route:
    - destination:
        host: my-service
      weight: 100
    - destination:
        host: my-fallback-service
      weight: 0
  fault:
    abort:
      percentage:
        value: 20         # Simulate failure in 20% of requests
      httpStatus: 503     # Return 503 (Service Unavailable)
  retries:
    attempts: 3           # Try 3 times before giving up
    perTryTimeout: 2s     # Each retry waits 2s
  timeout: 5s             # Total timeout is 5s
```

➡️ **What happens?**
- 20% of calls to `my-service` fail with a 503.
- If a call fails, Istio retries up to 3 times (with 2s each).
- If all retries fail, it gives up after 5s.
- You can also route to `my-fallback-service` (like a dummy response service).

---

## ❌ Fault Injection — Abort Only

This injects **random HTTP 500 errors** into 10% of traffic to test how your app handles backend failures.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: backend-fault-injection
spec:
  hosts:
  - backend
  http:
  - route:
    - destination:
        host: backend
    fault:
      abort:
        percentage:
          value: 10.0        # Fail 10% of requests
        httpStatus: 500      # Internal Server Error
```

➡️ **Test Case:** Can your frontend gracefully handle 500 errors from backend?

---

## ⏳ Fault Injection — Delay

This simulates a **slow backend** by injecting a 5-second delay in 50% of requests.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: backend-fault-injection
spec:
  hosts:
  - backend
  http:
  - route:
    - destination:
        host: backend
    fault:
      delay:
        percentage:
          value: 50.0         # Delay 50% of the requests
        fixedDelay: 5s        # Delay them by 5 seconds
```

➡️ **Test Case:** Will your frontend timeout? Retry? Show a spinner? Give up?

---

## ✅ Summary

| Fault Type   | What It Does                          | Why It Matters                              |
|--------------|----------------------------------------|---------------------------------------------|
| **Abort**    | Forces HTTP error responses (e.g. 500) | Tests error handling and fallback behavior  |
| **Delay**    | Injects latency (slow response)        | Tests timeout/retry logic                   |
| **Combined** | Abort + Retry + Fallback               | Simulates complex real-world outages        |

---

> 🧠 **Pro Tip**: You’re not testing the service where you inject faults… You’re testing the **upstream service** to make sure it behaves **gracefully** when things go wrong.
