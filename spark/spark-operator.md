# Spark:

## Add spark-operator helm repo & install spark operator 

helm repo add spark-operator https://kubeflow.github.io/spark-operator
helm repo update


helm install spark-operator spark-operator/spark-operator \
    --namespace spark-operator \
    --create-namespace \
    --set webhook.enable=true
	--set batchScheduler.enable=true
	//--set operatorImageName=spark-operator/spark-operator
	//--set "sparkJobNamespaces={test-ns}"


# Volcano:

## Add volcano helm repo & install volcano

helm repo add volcano-sh https://volcano-sh.github.io/helm-charts
helm repo update

helm install volcano volcano-sh/volcano -n volcano-system --create-namespace


## Create spark ServiceAccount

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: spark
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: spark-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["*"]
- apiGroups: [""]
  resources: ["services"]
  verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: spark-role-binding
  namespace: default
subjects:
- kind: ServiceAccount
  name: spark
  namespace: default
roleRef:
  kind: Role
  name: spark-role
  apiGroup: rbac.authorization.k8s.io
  
  
## Clone kubeflow/spark-operator git repo & build sparkctl command
git clone https://github.com/kubeflow/spark-operator.git
cd spark-operator/sparkctl


go build -o sparkctl