# 1. Docker Image Commands
docker build -t <name> .
	Build an image from a Dockerfile.

docker pull <image>
	Pull an image from a registry (e.g., Docker Hub).

docker images
	List all images.

docker rmi <image>
	Remove an image.

# 2. Docker Container Commands
docker run -d -p <host_port>:<container_port> <image>
	Run a container in detached mode with port mapping.

docker ps
	List running containers.

docker ps -a
	List all containers (including stopped ones).

docker stop <container>
	Stop a running container.

docker start <container>
	Start a stopped container.

docker restart <container>
	Restart a container.

docker rm <container>
	Remove a stopped container.

docker exec -it <container> <command>
	Run a command in a running container (e.g., bash for interactive mode).

docker logs <container>
	View logs of a container.

# 3. Docker Network Commands
docker network ls
	List Docker networks.

docker network create <network>
	Create a new network.

# 4. Docker Volume Commands
docker volume ls
	List Docker volumes.

docker volume create <volume>
	Create a new volume.

# 5. Docker Compose Commands
docker-compose up
	Build and start services from docker-compose.yml.

docker-compose down
	Stop and remove services.

# 6. Docker System Commands
docker system prune
	Remove unused data (stopped containers, unused images, etc.).



## Docker Compose commands

## docker-compose build:
	Builds images defined in your docker-compose.yml from their Dockerfiles.
## docker-compose up:
	Builds (if needed), then starts containers.

## docker-compose up -d:
	Same as above, but runs in detached mode (in the background).

## docker-compose down:
	Stops and removes all services, networks, volumes (unless external).

## docker-compose stop:
	Stops all running containers (keeps volumes and networks).

## docker-compose start:
	Starts previously stopped containers.

## docker-compose restart:
	Restarts containers.


## How to get inside a container
To get inside a running Docker container, you can use the following command:

docker exec -it <container_name_or_id> bash

### Intentar conectar la DB con wordpress, ver pq no se conectan



## Intentar anadir config file a wp y asegurarme de que este escuchando en el puerto correcto