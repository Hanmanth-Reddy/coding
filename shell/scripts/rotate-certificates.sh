#!/bin/bash
SCRIPT_VERSION=v1.0.13

# Configurable Parameters

: "${DATE_FORMAT:="%Y-%m-%d %H:%I:%S,%3N"}"

echo "[$(date +"$DATE_FORMAT")][INFO] VERSION: $SCRIPT_VERSION"

# Command must be specified
# Supported COMMAND values: run, check, rollback, state, backup, cleanup
if [ -z "$COMMAND" ]; then
	echo "[$(date +"$DATE_FORMAT")][ERROR] Must provide a valid command as a system environment variable COMMAND. Supported commands include: run, check, rollback, state, backup, cleanup" 1>&2
	exit 1
fi

# Director entrypoint must be added, eg: "my-installation.my-director.com"
if [ -z "$DIRECTOR_ENTRYPOINT" ]; then
	echo "[$(date +"$DATE_FORMAT")][ERROR] Must provide a valid entrypoint for the director as a system environment variable DIRECTOR_ENTRYPOINT" 1>&2
	exit 1
fi

: "${DIRECTOR_PORT:=2112}"
: "${STOP_IF_EXTERNAL_TRUST_RELATIONSHIPS_EXIST:=false}"
: "${WAIT_MINUTES:=30}"
: "${MAX_PER_SECOND:=1}"
: "${MIN_CERT_VALIDITY_DAYS:=365}"
: "${DOCKER_ENDPOINT:="http://localhost:2375"}"
: "${OVERWRITE_EXISTING_BACKUP:=false}"
: "${RESTART_STATELESS:=true}"
: "${BYPASS_CLIENT_FORWARDER:=false}"
: "${DRY_RUN:=false}"

# PLATFORM_VERSION is autodetected, but can be overridden if e.g. the runner is using a non-release image
if [[ -z "$PLATFORM_VERSION" ]]; then
  PLATFORM_VERSION=$(docker inspect -f '{{ .Config.Image }}' frc-runners-runner | awk -F ':' '{print $NF}')
fi

if [ -n "$STEP_COMPLETED" ] && [ "${STEP_COMPLETED}" != "none" ]; then
	STEP_COMPLETED_ENV="--env STEP_COMPLETED=$STEP_COMPLETED"
fi

: "${IMAGE_TAG:="3.5.1"}"

: "${DOCKER_IMAGE:=$(docker inspect frc-runners-runner -f '{{ .Config.Image }}' | sed -e 's/\(.*:\?[0-9]*\):[^:]*/\1/')}"
ECE_IMAGE="${DOCKER_IMAGE}:${IMAGE_TAG}"

function validatePlatformVersion(){
	if [[ -z "$1" ]]; then
		echo "[$(date +"$DATE_FORMAT")][ERROR] Platform version not found [${1}]"
		exit 2
	else
		if [[ ! "$1" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]; then
			echo "[$(date +"$DATE_FORMAT")][ERROR] Platform version not valid [${1}]"
			exit 3
		fi
	fi
}

function validateUser(){
  ELASTIC_UID=$(docker exec frc-runners-runner sh -c 'echo $ELASTIC_UID')
  ELASTIC_GID=$(docker exec frc-runners-runner sh -c 'echo $ELASTIC_GID')

  CURRENT_UID=$(id -u)
  CURRENT_GID=$(id -g)

  if [[ "$CURRENT_UID" != "$ELASTIC_UID" ]]; then
    echo "[$(date +"$DATE_FORMAT")][ERROR] The script should be run with UID [$ELASTIC_UID] (current UID is [$CURRENT_UID])"
    exit 5
  fi
  if [[ "$CURRENT_GID" != "$ELASTIC_GID" ]]; then
    echo "[$(date +"$DATE_FORMAT")][ERROR] The script should be run with GID [$ELASTIC_GID] (current UID is [$CURRENT_GID])"
    exit 5
  fi
}

function findImage() {
	docker images --filter=reference="${1}" -q | wc -l
}

function pullECEImage(){
	if [[ "$(findImage ${1})" == 0 ]]; then
		echo "[$(date +"$DATE_FORMAT")][INFO] Required docker image missing - pulling it now"
		docker pull "$1"

		if [[ "$(findImage ${1})" == 0 ]]; then
			echo "[$(date +"$DATE_FORMAT")][ERROR] Required docker image could not be pulled. Please, pull docker image [${1}] and try again. Refer to https://www.elastic.co/guide/en/cloud-enterprise/2.11/ece-install-offline.html"
			exit 4
		fi
	fi
}

RUNNER_ID=$(docker exec frc-runners-runner sh -c 'echo $RUNNER_ID')
HOST_STORAGE_PATH=$(docker exec frc-runners-runner sh -c 'echo $HOST_STORAGE_PATH')

validatePlatformVersion "$PLATFORM_VERSION"
validateUser

EXTRA_HOST=$(docker inspect -f '{{ range .HostConfig.ExtraHosts }} --add-host {{.}} {{ end }}' frc-runners-runner)

CONTAINERS=$(docker ps --format '{{.Names}}' | awk -vORS=, '{ print $1 }' | sed 's/,$/\n/')

if [ "$(docker ps -q -f name=frc-directors-director)" ]; then
	SHELL_ZK_AUTH=$(docker exec frc-directors-director sh -c 'echo -n $FOUND_ZK_READWRITE' | awk -F ':' -v OFS=':' '$2 == "_" { $2 = "FOUND_ZK_READWRITE" }1')
	DIRECTOR_MANAGED_PATH="--env DIRECTOR_MANAGED_PATH=$HOST_STORAGE_PATH/$RUNNER_ID/services/zookeeper/managed"
	DIRECTOR_DATA_PATH="--env DIRECTOR_DATA_PATH=$HOST_STORAGE_PATH/$RUNNER_ID/services/zookeeper/data"
else
	SHELL_ZK_AUTH=$(docker exec frc-runners-runner sh -c 'echo $FOUND_RUNNERS_SHARED_ZK')
fi

if [ "$(docker ps -q -f name=frc-client-forwarders-client-forwarder)" ]; then
  CF_MANAGED_PATH="--env CF_MANAGED_PATH=$HOST_STORAGE_PATH/$RUNNER_ID/services/client-forwarder/managed"
  openssl x509 -checkend 0 -in $HOST_STORAGE_PATH/$RUNNER_ID/services/client-forwarder/managed/cert.pem > /dev/null 2>&1 && \
    openssl x509 -checkend 0 -in $HOST_STORAGE_PATH/$RUNNER_ID/services/client-forwarder/managed/ca-file.pem > /dev/null 2>&1
  if [[ $? -ne 0 || $BYPASS_CLIENT_FORWARDER == "true" ]]; then
    ZK_SERVERS=()
    for HOST_PORT in `cat $HOST_STORAGE_PATH/$RUNNER_ID/services/client-forwarder/managed/stunnel.conf | grep connect | cut -d '=' -f2`; do
      ZK_HOST=`echo $HOST_PORT | cut -d ':' -f1`
      ZK_PORT=$((`echo $HOST_PORT | cut -d ':' -f2` - 10000))
      ZK_SERVERS+=( "$ZK_HOST:$ZK_PORT" )
    done
    ZK_SERVERS=$(IFS=, ; echo "${ZK_SERVERS[*]}")
    ZK_SERVERS_ENV="--env ZOOKEEPER_SERVERS=$ZK_SERVERS/v1"
  fi
fi

if [ "$(docker ps -q -f name=frc-proxies-route-server)" ]; then
  ROUTE_SERVER_MANAGED_PATH="--env ROUTE_SERVER_MANAGED_PATH=$HOST_STORAGE_PATH/$RUNNER_ID/services/route-server/managed"
fi

if [[ $DRY_RUN == "true" ]]; then
  echo "[$(date +"$DATE_FORMAT")][INFO] Running in DRY mode, certificates won't be rotated"
fi

echo "[$(date +"$DATE_FORMAT")][INFO] COMMAND: $COMMAND"
echo "[$(date +"$DATE_FORMAT")][INFO] PLATFORM_VERSION: $PLATFORM_VERSION"
echo "[$(date +"$DATE_FORMAT")][INFO] RUNNER_ID: $RUNNER_ID"
echo "[$(date +"$DATE_FORMAT")][INFO] Director URL: http://$DIRECTOR_ENTRYPOINT:$DIRECTOR_PORT"
echo "[$(date +"$DATE_FORMAT")][INFO] CONTAINERS: $CONTAINERS"

pullECEImage "$ECE_IMAGE"

docker run \
--env SHELL_JAVA_OPTIONS='-Dfound.shell.exec=/elastic_cloud_apps/shell/scripts/rotateECECertificates.sc -Djute.maxbuffer=134217728' \
--env ELASTIC_UID=$(id -u) -e ELASTIC_GID=$(id -g) \
--env COMMAND=$COMMAND \
--env RUNNER_ID=$RUNNER_ID \
--env VERSION=$PLATFORM_VERSION \
--env CONTAINERS="$CONTAINERS" \
--env STOP_IF_EXTERNAL_TRUST_RELATIONSHIPS_EXIST=$STOP_IF_EXTERNAL_TRUST_RELATIONSHIPS_EXIST \
--env WAIT_MINUTES=$WAIT_MINUTES \
--env MAX_PER_SECOND=$MAX_PER_SECOND \
--env MIN_CERT_VALIDITY_DAYS=$MIN_CERT_VALIDITY_DAYS \
--env DIRECTOR_ENTRYPOINT=$DIRECTOR_ENTRYPOINT \
--env DIRECTOR_PORT=$DIRECTOR_PORT \
--env DOCKER_ENDPOINT=$DOCKER_ENDPOINT \
--env OVERWRITE_EXISTING_BACKUP=$OVERWRITE_EXISTING_BACKUP \
--env RESTART_STATELESS=$RESTART_STATELESS \
--env DRY_RUN=$DRY_RUN \
$STEP_COMPLETED_ENV \
--volume ~/.found-shell:/elastic_cloud_apps/shell/.found-shell \
--volume $HOST_STORAGE_PATH:$HOST_STORAGE_PATH \
--volume /var/run/docker.sock:/var/run/docker.sock \
--volume $(pwd):/hostpwd \
--env SHELL_ZK_AUTH=$SHELL_ZK_AUTH \
$CF_MANAGED_PATH \
$ROUTE_SERVER_MANAGED_PATH \
$DIRECTOR_MANAGED_PATH \
$DIRECTOR_DATA_PATH \
$ZK_SERVERS_ENV \
$EXTRA_HOST \
--rm -t --network="host" \
"$ECE_IMAGE" \
bash -c "socat TCP-LISTEN:2375,fork,bind=127.0.0.1,range=127.0.0.0/8 UNIX-CLIENT:/run/docker.sock > /dev/null 2>&1 & /elastic_cloud_apps/shell/run-shell.sh"
