# ISTO


## Installtion:
- Download istioctl command and setup PATH

- 
istioctl profile list 
```text
A **profile** in Istio is a set of configurations that determines **which components get installed** and **how they’re configured** (like Istiod, ingress/egress gateways, telemetry, etc.).
```

istioctl profile dump default > istio-default.yaml
istioctl install -f istio-default.yaml

istioctl profile dump demo > istio-demo.yaml
istioctl install -f istio-demo.yaml


istioctl install --set profile=demo -y
istioctl install --set profile=default -y


#### Generate a default( --set profile=default) Istio installation
istioctl manifest generate |kubectl apply -f -

#### Enable Tracing
istioctl manifest generate --set meshConfig.enableTracing=true | kubectl apply -f -

#### Generate the demo profile
istioctl manifest generate --set profile=demo | kubectl apply -f -




admin

analyze
authz
bug-report
proxy-config
proxy-status

completion
create-remote-secret
dashboard
experimental
operator
remote-clusters
tag
uninstall
upgrade
verify-install



#### To check YAML defintion 
istioctl validate -f my-istio.yaml


#### To enable Istio envoy-proxy container enable
kubectl label namespace default istio-injection=enabled

#### Manual Injestion to an app
istioctl kube-inject -f app.yaml | kubectl apply -f -

## Debug commands 
istoctl proxy-status
istioctl proxy-config all|route|listener|endpoint|log pod.namespace
istioctl analyze
istioctl authz
istioctl bug-report