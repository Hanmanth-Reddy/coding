helm repo add spinnaker https://opsmx.github.io/spinnaker-helm/
helm repo update
kubectl create namespace opsmx-oss
helm install oss-spin spinnaker/spinnaker -n opsmx-oss --timeout 600s
kubectl -n oss-spin get pods
kubectl -n opsmx-oss get pods
kubectl -n opsmx-oss port-forward svc/spin-deck 9000

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
		
---------
If you want to access Spinnaker with https, make sure cert-manager is installed in the Kubernetes cluster. You need to create an issuer and need to add the following annotations and tls section in the ingress file.		
annotations:
acme.cert-manager.io/http01-edit-in-place: "true"
cert-manager.io/issue-temporary-certificate: "true"
cert-manager.io/issuer: ISSUER		

-----------
tls:
- hosts:
  - isd.demoserver.opsmx.net
  secretName: oes-ui-ingress
----
Ingress

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    ingress.kubernetes.io/ssl-redirect: "true"
    kubernetes.io/ingress.class: nginx
    acme.cert-manager.io/http01-edit-in-place: "true"
    cert-manager.io/issue-temporary-certificate: "true"
    cert-manager.io/issuer: ISSUER
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
  tls:
  - hosts:
    - spinnaker.DNS.COM
    secretName: deck-ingress

## Setting up Load balancer in the cluster to allow traffic to Spinnaker spin services	
kubectl -n oss-spin patch svc spin-deck -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get service spin-deck-ui
http://52.147.219.48:9000

sudo apt-get install  containerd.io -y