
# Istio Traffic Management Strategies

This document outlines various Istio routing strategies and policies like AB Testing, Blue-Green Deployments, Canary Releases, Circuit Breaking, Retry-Timeout, Fallback mechanisms, and Fault Injection using `VirtualService` and `DestinationRule`.

---

## 🧪 AB Testing

Used to route a specific group of users (based on headers) to a new version (v2), while the rest continue using the existing version (v1).

```yaml
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: my-service
spec:
  host: my-service
  subsets:
    - name: v1
      labels:
        version: v1
    - name: v2
      labels:
        version: v2
---
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service.default.svc.cluster.local
  http:
  - match:
    - headers:
        user-group:
          exact: "test-group"
    route:
    - destination:
        host: my-service
        subset: v2
  - route:
    - destination:
        host: my-service
        subset: v1
```

---

## 💙💚 Blue-Green Deployment

Route 100% of traffic to a specific version (v1), then switch to another (v2) once validated.

### Step 1: Route all traffic to Blue (v1)
```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service.default.svc.cluster.local
  http:
  - route:
    - destination:
        host: my-service
        subset: v1
      weight: 100
```

### Step 2: Shift all traffic to Green (v2)
```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service.default.svc.cluster.local
  http:
  - route:
    - destination:
        host: my-service
        subset: v2
      weight: 100
```

---

## 🐤 Canary Deployment

Gradually shift traffic from v1 to v2 by using weight-based distribution.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service.default.svc.cluster.local
  http:
  - route:
    - destination:
        host: my-service
        subset: v1
      weight: 90
    - destination:
        host: my-service
        subset: v2
      weight: 10
```

---

## 💣 Circuit Breaker (DestinationRule Level)

Protect services by automatically ejecting unhealthy instances.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: my-service
spec:
  host: my-service
  trafficPolicy:
    outlierDetection:
      consecutiveErrors: 7
      interval: 5s
      baseEjectionTime: 30s
      maxEjectionPercent: 50
```

---

## ⚖️ Traffic Shifting with Weight-Based Routing

Split traffic between two versions in defined proportions.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service.default.svc.cluster.local
  http:
  - route:
    - destination:
        host: my-service
        subset: v1
      weight: 90
    - destination:
        host: my-service
        subset: v2
      weight: 10
---
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: my-service
spec:
  host: my-service
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```

---

## 🔁 Retry, Timeout, Fallback with Circuit Breaker

Configure retries and fallbacks with timeout handling and circuit-breaking logic.

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
      weight: 80
    - destination:
        host: my-fallback-service
      weight: 20
  retries:
    attempts: 3
    perTryTimeout: 2s
  timeout: 5s
---
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: my-service
spec:
  host: my-service
  trafficPolicy:
    outlierDetection:
      consecutiveErrors: 5
      interval: 10s
      baseEjectionTime: 60s
      maxEjectionPercent: 100
```

---

## 🔄 Backend Retry with Timeout

Apply retry logic and timeout limits to a backend service.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: backend-service
spec:
  hosts:
  - backend
  http:
  - route:
    - destination:
        host: backend
    retries:
      attempts: 2
      perTryTimeout: 4s
---
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: backend-service
spec:
  hosts:
  - backend
  http:
  - route:
      - destination:
          host: backend
    timeout: 6s
    retries:
      attempts: 2
      perTryTimeout: 4s
```

---

## 🧨 Fault Injection with Retry and Fallback

Inject failures in a controlled way to test resilience.

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
        value: 20
      httpStatus: 503
  retries:
    attempts: 3
    perTryTimeout: 2s
  timeout: 5s
```

---

## ❌ Fault Injection - Abort

Simulate error responses (e.g., 500 Internal Server Error) for a percentage of requests.

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
          value: 10.0
        httpStatus: 500
```

---

## ⏱️ Fault Injection - Delay

Introduce artificial delays in service responses to simulate latency.

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
          value: 50.0
        fixedDelay: 5s
```

---

> 💡 These Istio configurations enable fine-grained traffic control and help validate system resilience under real-world failure conditions.
