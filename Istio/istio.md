# ISTO

- Virtual services
- Destination rules
- Gateways
- Service entries
- Sidecars


---

## Gateway ---> Ingress
## ServiceEntry  ----> Egress 
## VirtualServices ---> Routing Rules - timeouts, retries, Fallback, Traffic Routing 
timeouts, retries, Fallback 
Traffic Routing:
	Header-based routing
	Path-based routing
	Weight-based routing (or) Traffic Shifting (or) Traffic Splitting
    Traffic Mirroring

#### ⏱️ Timeouts:
```yaml
http:
  - route:
      - destination:
          host: my-service
    timeout: 3s  # Request will timeout after 3 seconds
```

#### 🔁 Retries
```yaml
http:
  - route:
      - destination:
          host: my-service
    retries:
      attempts: 3           # Try up to 3 times
      perTryTimeout: 2s     # Each retry waits 2 seconds

```

#### 🚨 Fallback
```yaml
http:
  - route:
      - destination:
          host: primary-service
        weight: 80
      - destination:
          host: fallback-service
        weight: 20
```

#### 🧭 Header-Based Routing

```yaml
http:
  - match:
      - headers:
          user-group:
            exact: "beta"
    route:
      - destination:
          host: my-service
          subset: v2
```

#### 🌐 Path-Based Routing
``` yaml
http:
  - match:
      - uri:
          prefix: "/api"
    route:
      - destination:
          host: api-service
```

#### 🔁 Weight-based routing (or) Traffic Shifting (or) Traffic Splitting:
**Purpose:** Gradually shift traffic between different versions of a service (canary, blue-green)
```yaml
http:
  - route:
      - destination:
          host: my-service
          subset: v1
        weight: 80
      - destination:
          host: my-service
          subset: v2
        weight: 20
```

#### 👀 Traffic Mirroring:
**Purpose:** Send a copy of live traffic to a different service without affecting the user experience.
```yaml
http:
  - route:
      - destination:
          host: my-service
    mirror:
      host: my-service-v2
    mirrorPercentage:
      value: 100.0   # Can mirror 100% or partial
```

## DestinationRules --> 💥 Circuit Breaker , ⚖️ Load Balancing, 🎯 Session Affinity
#### ⚖️ Load Balancing:
**Load Balancing:** Round Robin is the default load balancing algorithm in Istio.You don’t need to explicitly define it because Istio uses it by default.you can configure load balancing algorithms and session affinity in the DestinationRule resource.
    - Round Robin (default)
    - Least Connection
    - Random
    - Weighted Least Request

**Note:** Istio uses Round Robin by default. You can override it explicitly like this:

```yaml
trafficPolicy:
  loadBalancer:
    simple: LEAST_CONN  # Or RANDOM, or ROUND_ROBIN
```

#### 💥 Circuit Breaker 
```yaml
trafficPolicy:
  outlierDetection:
    consecutiveErrors: 5
    interval: 10s
    baseEjectionTime: 30s
```
#### 🎯 Session Affinity
**Purpose:** Ensures that a client is always routed to the same service instance during a session.
```yaml
trafficPolicy:
  loadBalancer:
    consistentHash:
      httpHeaderName: "user-id"  # Sticky session based on header value
```



---
Security:
Mutual TLS (mTLS)
Service-to-Service Authentication
Authorization (RBAC)

Policy Enforcement:
	Quota Management:
	Traffic Control Policies: You can set policies for circuit breakers, outlier detection, and other service-level policies
	Request Routing: You can control traffic flows, prioritize traffic, or limit access to certain endpoints.

---

**Purpose of Fault Injection in Resilience Testing:**
In real-world, distributed systems services fail in many ways — **slow responses, network issues, or complete failures**. 

**Fault injection** simulates these failures deliberately, so you can see how your system reacts to them before they happen in production.

By injecting faults (like delays or errors/aborts) into a service, you can observe how dependent services react, and validate the mechanisms designed to make your system resilient, such as:

**Retries:** Does the frontend retry if the backend is slow or fails?
**Fallbacks:** Does the frontend have a fallback if the backend is down? Does it handle the error gracefully (e.g., fallback 
data/serve cached data [OR] return a default response [OR] error message)?
**Circuit Breakers:** Does the frontend stop calling the backend when it's consistently failing?


In the examples, the faults are injected into the backend service. However, we're testing the frontend service to see how it handles the backend being slow or failing. We want to ensure that the frontend doesn’t crash, hang, or pass the problem along to the user in a bad way (like showing error pages).


 ---   

# 🔧 Istio Features – Simplified Cheat Sheet

A quick and simple breakdown of what Istio can do for your microservices.

---

## 1. 🚦 Traffic Management
Control **how traffic flows** between services.

- **Load Balancing**: Evenly distribute requests (round-robin, least requests, etc.).
- **Smart Routing**: A/B testing, canary, blue-green.
- **Fault Injection**: Simulate errors (delays or 503s) to test service resilience.
- **Retries & Timeouts**: Retry failed calls and avoid long waits.

👉 *Helps ensure services are reliable and traffic is well managed.*

---

## 2. 🔐 Security
Protect your services with **encryption, identity, and access control**.

- **mTLS**: Encrypt traffic between services.
- **AuthN & AuthZ**: Verify identity (AuthN) and allow/deny access (AuthZ).
- **JWT Support**: Secure APIs with JSON Web Tokens.
- **RBAC**: Limit access based on user roles.

👉 *Makes your service mesh secure out of the box.*

---

## 3. 📊 Observability
Understand what’s happening inside your system.

- **Metrics**: Get stats like success rate, latency (Prometheus).
- **Tracing**: Follow requests across services (Jaeger/Zipkin).
- **Logging**: Collect logs centrally.
- **Dashboards**: Visualize health & performance (Grafana, Kiali).

👉 *Helps detect issues fast and monitor health.*

---

## 4. 🔍 Service Discovery
Services can **find each other** automatically.

- **Dynamic Discovery**: No need to hardcode service locations.

👉 *Crucial for scalable and dynamic environments like Kubernetes.*

---

## 5. 🛡️ Resilience & Reliability
Make your services tougher.

- **Circuit Breakers**: Stop calling broken services.
- **Rate Limiting**: Don’t overload a service.
- **Outlier Detection**: Remove unhealthy pods from rotation.

👉 *Helps your app stay alive even when parts are failing.*

---

## 6. 🌐 Multi-Cluster & Mesh Expansion
Scale across clusters and clouds.

- **Multi-Cluster Support**: Manage services across many Kubernetes clusters.
- **Mesh Federation**: Let multiple meshes talk to each other.

👉 *Great for enterprise, hybrid, and multi-cloud setups.*

---

## 7. 🚪 Ingress & Egress Control
Manage what comes in and goes out.

- **Ingress Gateway**: Entry point to your mesh from the outside.
- **Egress Gateway**: Control outbound traffic from your services.

👉 *Protects your mesh and manages external traffic.*

---

## 8. 📏 Policy Enforcement
Apply rules and limits.

- **Quotas**: Set usage limits per service or user.
- **Custom Policies**: Enforce business logic or compliance needs.

👉 *Keeps your services compliant and under control.*

---

## 9. 🆔 Service Identity & Authentication
Give every service a **secure identity**.

- **Service Identity**: Each service gets a unique identity.
- **Identity Federation**: Integrate with external identity providers.

👉 *Useful for secure comms and audits.*

---

## 10. 🧩 Plugin Extensibility
Add custom behavior to Istio.

- **Envoy Filters**: Inject custom logic into traffic (e.g., transformations, logging).

👉 *Handy for advanced or niche use cases.*

---

## 11. ⚙️ Config Management & Automation
Control Istio with code.

- **CRDs (Custom Resources)**: Define all configs declaratively.
- **Canary Config Updates**: Slowly roll out changes safely.

👉 *Makes config updates safer and automated.*

---

✅ *Use Istio to make your system secure, observable, and resilient — all without changing your app code!*






---
# Commands

## 📦 Installation & Profiles

### Profiles Overview
A **profile** in Istio is a set of configurations that determines:
- Which components get installed (Istiod, gateways, telemetry, etc.)
- How they are configured

```bash
# List all available profiles
istioctl profile list

# Dump the default profile to a YAML file
istioctl profile dump default > istio-default.yaml

# Dump the demo profile
istioctl profile dump demo > istio-demo.yaml

# Install Istio using a specific profile
istioctl install --set profile=default -y
istioctl install --set profile=demo -y

# Install Istio using YAML generated from profile
istioctl install -f istio-default.yaml
istioctl install -f istio-demo.yaml

# Generate manifest and apply directly
istioctl manifest generate | kubectl apply -f -

# Enable tracing in the mesh
istioctl manifest generate --set meshConfig.enableTracing=true | kubectl apply -f -

# Generate and apply the demo profile
istioctl manifest generate --set profile=demo | kubectl apply -f -
```

## 🔍 Dashboards & Observability
```bash
# Launch Istio Dashboards
istioctl dashboard kiali
istioctl dashboard grafana
istioctl dashboard jaeger
```

## 🚀 Auto-Completion
```bash
# Enable Bash auto-completion
istioctl completion bash
```

## 🛠️ YAML Validation
```bash
# Validate Istio resource definitions
istioctl validate -f my-istio.yaml
```

## 🧩 Sidecar Injection
```bash
# Enable automatic sidecar injection in a namespace
kubectl label namespace default istio-injection=enabled

# Manually inject sidecar into a pod definition
istioctl kube-inject -f app.yaml | kubectl apply -f -
```

## 🧰 Debug & Troubleshooting Tools
```bash
# Check proxy (envoy) sync status
istioctl proxy-status

# Inspect proxy configuration
istioctl proxy-config all POD_NAME.NAMESPACE
istioctl proxy-config route POD_NAME.NAMESPACE
istioctl proxy-config listener POD_NAME.NAMESPACE
istioctl proxy-config endpoint POD_NAME.NAMESPACE
istioctl proxy-config log POD_NAME.NAMESPACE

# Analyze entire Istio config
istioctl analyze

# Check runtime authZ policies
istioctl authz

# Generate a bug report bundle
istioctl bug-report
```

## 🧱 Component Operations
```bash
# Upgrade Istio
istioctl upgrade

# Uninstall Istio
istioctl uninstall

# Verify Istio installation
istioctl verify-install
```

## 🌐 Multi-Cluster / Remote Cluster Setup
```bash
# Create remote secrets for multi-cluster
istioctl create-remote-secret

# Remote cluster management
istioctl remote-clusters
```

## ⚙️ Operator & Tags (Advanced)
```bash
# Istio operator commands
istioctl operator

# Use revision tags
istioctl tag
```

---
