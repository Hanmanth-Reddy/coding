# Jenkins installtion
```
## https://artifacthub.io/packages/helm/jenkinsci/jenkins

helm repo add jenkins https://charts.jenkins.io
helm repo update

helm install [RELEASE_NAME] jenkins/jenkins [flags]
helm install jenkins jenkins/jenkins --create-namespace --namespace=jenkins

## admin user password
kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode && echo
```

## Jenkins Ingress 
```bash
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: jenkins-ingress
  namespace: jenkins
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - host: dashboard.jenkins.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: jenkins
            port:
              number: 8080
```

## Enable Spinnaker , Jenkins Integration
```
hal config ci jenkins enable

###hal config ci jenkins master add my-jenkins-master \
  --address http://<jenkins-url>:8080 \
  --username <jenkins-username> \
  --password

hal config ci jenkins master add my-jenkins-master \
  --address http://jenkins.jenkins.svc.cluster.local:8080 \
  --username admin \
  --password 3HRdp9DN9LoUf9x5tYq8QI

hal deploy apply
```

## To test Spinnaker and Jenkins integration
kubectl exec -it -n jenkins jenkins-0 -- curl -s http://spin-gate.spinnaker.svc.cluster.local:8084/health