# Spinnaker Setup Using Helm:

## Non-Gitops Method:
### Add helm repo, and install Spinnaker
```
helm repo add spinnaker https://opsmx.github.io/spinnaker-helm/
helm repo update

kubectl create namespace opsmx-oss

helm install oss-spin spinnaker/spinnaker -n opsmx-oss --timeout 600s
```

## Access Deck using port-forward [or] Setup Ingress
kubectl -n opsmx-oss port-forward svc/spin-deck 9000

```bash
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    ingress.kubernetes.io/ssl-redirect: "true"
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"
  labels:
    chart: spinnaker-2.2.14
  name: spinnaker-deck
spec:
  rules:
  - host: spinnaker.DNS.COM
    http:
      paths:
      - backend:
          service:
            name: spin-deck
            port:
              number: 9000
        path: /
        pathType: ImplementationSpecific
```		


## Gitops Method: