# Spinnaker Setup Using Helm:

## Non-Gitops Method: Add helm repo, and install Spinnaker
```
helm repo add spinnaker https://opsmx.github.io/spinnaker-helm/
helm repo update

kubectl create namespace spinnaker

helm install spinnaker spinnaker/spinnaker -n spinnaker --create-namespace --timeout 600s --debug
```

### Access Deck using port-forward [or] Setup Ingress
kubectl -n opsmx-oss port-forward svc/spin-deck 9000

### Ingress option-1 for spin-deck
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
### Ingress option-2 for spin-deck
```bash
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: spin-deck-ingress
  namespace: spinnaker
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: deck.spinnaker.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: spin-deck
            port:
              number: 9000
```

## Gitops Method:
