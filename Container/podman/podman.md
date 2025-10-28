ls /etc/containers/


| **Use Case**                 | **Docker Command**                   | **Equivalent Podman Command**        |
| ---------------------------- | ------------------------------------ | ------------------------------------ |
| Run a container              | `docker run -it alpine`              | `podman run -it alpine`              |
| List running containers      | `docker ps`                          | `podman ps`                          |
| List all containers          | `docker ps -a`                       | `podman ps -a`                       |
| List images                  | `docker images`                      | `podman images`                      |
| Stop a container             | `docker stop mycontainer`            | `podman stop mycontainer`            |
| Remove a container           | `docker rm mycontainer`              | `podman rm mycontainer`              |
| Remove an image              | `docker rmi myimage`                 | `podman rmi myimage`                 |
| Pull an image                | `docker pull nginx`                  | `podman pull nginx`                  |
| Push an image                | `docker push myrepo/image:tag`       | `podman push myrepo/image:tag`       |
| Show container logs          | `docker logs mycontainer`            | `podman logs mycontainer`            |
| Copy files from/to container | `docker cp file.txt container:/path` | `podman cp file.txt container:/path` |
| View container processes     | `docker top mycontainer`             | `podman top mycontainer`             |
| Build image                  | `docker build -t myimage .`          | `podman build -t myimage .`          |
| Tag image                    | `docker tag image newtag`            | `podman tag image newtag`            |
| Inspect image/container      | `docker inspect myimage`             | `podman inspect myimage`             |
| Prune unused resources       | `docker system prune`                | `podman system prune`                |




| **Podman-Only Feature**     | **Command**                           | **Purpose**                                              |
| --------------------------- | ------------------------------------- | -------------------------------------------------------- |
| Create pods                 | `podman pod create`                   | Native pod support (multiple containers sharing network) |
| Generate systemd unit files | `podman generate systemd`             | Runs containers as systemd services                      |
| Kube YAML generation        | `podman generate kube`                | Converts containers/pods to Kubernetes YAML              |
| Play Kubernetes YAML        | `podman play kube file.yaml`          | Run containers/pods from kube YAML                       |
| Run in rootless mode        | `podman --remote` or unprivileged use | No root needed to run containers                         |




## 🧠 Architectural Differences
| Feature             | Docker          | Podman                       |
| ------------------- | --------------- | ---------------------------- |
| Daemon              | Yes (`dockerd`) | No daemon – runs as CLI only |
| Rootless support    | Limited         | Native                       |
| Systemd integration | Manual          | Native (`generate systemd`)  |
| Pod support         | No              | Yes                          |
| Kubernetes YAML     | Limited         | Generate and run             |
| OCI Compliance      | Yes             | Yes                          |

| Aspect               | **Docker**                    | **Podman**                                      |
| -------------------- | ----------------------------- | ---------------------------------------------   |
| Daemon required      | ✅ Yes (`dockerd`)             | ❌ No daemon (daemonless architecture)        |
| Rootless containers  | ⚠️ Limited support            | ✅ Native support                              |
| Compatible CLI       | ✅ `docker`                    | ✅ Mostly CLI-compatible with `docker`        |
| Compose support      | ✅ Native via `docker-compose` | ✅ Via `podman-compose` (or Docker Compose)   |
| Systemd integration  | ⚠️ Manual setup               | ✅ Built-in `podman generate systemd`          |
| Pods (K8s-style)     | ❌ No native pods              | ✅ Native pod concept                         |
| Socket API           | ✅ Docker socket (default)     | ⚠️ Optional with `podman system service`      |
| Default installation | ✅ Widely available            | ⚠️ Older versions in distros, upstream needed |
| OCI Compliance       | ✅ Yes                         | ✅ Yes                                        |




## 🌐 Docker-Compatible API (Optional in Podman)
| Task                    | Podman Command                   | Description                   |
| ----------------------- | -------------------------------- | ----------------------------- |
| Start socket API        | `podman system service --time=0` | Expose Docker-compatible API  |
| Use remote client       | `podman-remote --url=...`        | CLI for remote Podman service |
| List remote connections | `podman system connection list`  | View saved remote targets     |
