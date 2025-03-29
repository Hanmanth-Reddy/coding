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

### 
