MASTER1=
MASTER2=
MASTER3=
PROXY_IP=
PROXY_PORT=6443

## Execute this on MASTER1
kubeadm init --control-plane-endpoint "${PROXY_IP}:${PROXY_PORT" \
--pod-network-cidr "192.168.0.0/16" --service-cidr "10.96.0.0/12" --upload-certs

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  export KUBECONFIG=/etc/kubernetes/admin.conf


## Install helm 
wget https://get.helm.sh/helm-v3.15.4-linux-amd64.tar.gz
tar -C /usr/bin -xzf helm*.tar.gz 

## Install CNI, here we are installing Calico
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/calico.yaml

## Install Spark operator
helm repo add spark-operator https://kubeflow.github.io/spark-operator helm repo update

helm install spark-operator spark-operator/spark-operator \
--namespace spark-operator \
--create-namespace \
--set webhook.enable=true \
--set batchScheduler.enable=true 

## Install volcano 
helm repo add volcano-sh https://volcano-sh.github.io/helm-charts helm repo update

helm install volcano volcano-sh/volcano -n volcano-system --create-namespace

## Install spark SA
kubectl apply -f - <<EOF
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
EOF

## Install go and build sparkctl from soure code
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

git clone https://github.com/kubeflow/spark-operator.git && cd spark-operator/sparkctl
go build -o sparkctl
mv sparkctl /usr/bin



## Join other Masters 
CERT_KEY=$(ssh root@${MASTER1} "kubeadm init phase upload-certs --upload-certs  | tail -n 1")
JOIN_CMD=$(ssh root@${MASTER1} "kubeadm token create --print-join-command")
ssh root@MASTER2 "${JOIN_CMD} -control-plane --certificate-key ${CERT_KEY}"
ssh root@MASTER3 "${JOIN_CMD} -control-plane --certificate-key ${CERT_KEY}"