# Spinnaker Installation


## 1. Using halyard
### a. Using Debian VM
```
curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh

sudo bash InstallHalyard.sh

hal -v

### hal command reference doc:
https://spinnaker.io/docs/reference/halyard/commands/

## To purge/clean up deployment
hal deploy clean

## To Uninstall Halyard
sudo ~/.hal/uninstall.sh
```

### b. Using Docker Container
```
mkdir ~/.hal

docker run -p 8084:8084 -p 9000:9000 \
    --name halyard --rm \
    -v ~/.hal:/home/spinnaker/.hal \
    -it \
    us-docker.pkg.dev/spinnaker-community/docker/halyard:stable
	
docker exec -it halyard bash

source <(hal --print-bash-completion)

### docker run -d --name halyard \
          -v ~/.hal:/home/spinnaker/.hal 
		  -v ~/.kube/config:/home/spinnaker/.kube/config 
		  gcr.io/spinnaker-marketplace/halyard:stable
```

### hal commands to install spinnaker on Kubernetes

```
#### Set Kubernetes as the cloud provider
hal config provider kubernetes enable

#### Add a kubernetes account
hal config provider kubernetes account add my-k8s  --context $(kubectl config current-context)

#### Enable artifacts
hal config features edit --artifacts true

#### Choose where to install Spinnaker
hal config deploy edit --type distributed --account-name my-k8s

#### Install minio in kubernetes cluster
#### using Helm v3+
```
kubectl create ns spinnaker
helm repo add 
helm install minio --namespace spinnaker --set accessKey="myaccesskey" --set secretKey="mysecretkey" --set persistence.enabled=false stable/minio
```
using Helm v2
```
helm install --name minio --namespace spinnaker --set accessKey="myaccesskey" --set secretKey="mysecretkey" --set persistence.enabled=false stable/minio
```

### For minio, disable s3 versioning
mkdir ~/.hal/default/profiles
echo "spinnaker.s3.versioning: false" > ~/.hal/default/profiles/front50-local.yml

### Set the storage type to minio/s3
hal config storage s3 edit --endpoint http://minio:9000 --access-key-id "myaccesskey" --secret-access-key "mysecretkey"
hal config storage s3 edit --path-style-access true
hal config storage edit --type s3

### Choose spinnaker version to install
hal version list
hal config version edit --version <desired-version>

### Deploy Spinnaker in Kubernetes Cluster
hal deploy apply

### Change the service type to either Load Balancer or NodePort
kubectl -n spinnaker edit svc spin-deck
kubectl -n spinnaker edit svc spin-gate

### Update config and redeploy
hal config security ui edit --override-base-url "http://<LoadBalancerIP>:9000"
hal config security api edit --override-base-url "http://<LoadBalancerIP>:8084"
hal deploy apply


### If you used NodePort
hal config security ui edit --override-base-url "http://<worker-node-ip>:<nodePort>"
hal config security api edit --override-base-url "http://worker-node-ip>:<nodePort>"
hal deploy apply

```

```
