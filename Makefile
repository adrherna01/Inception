COMPOSE=docker compose

all: up

up:
	cd srcs && $(COMPOSE) up -d

build:
	mkdir -p /home/$(USER)/data/db
	mkdir -p /home/$(USER)/data/wp
	echo "Directories for MariaDB and Wordpress where created"
	cd srcs && $(COMPOSE) build

down:
	cd srcs && $(COMPOSE) down

stop:
	cd srcs && $(COMPOSE) stop

re:
	cd srcs
	$(COMPOSE) down
	$(COMPOSE) up -d

rm:
	sudo rm  -rf /home/adrherna/data
	systemctl stop docker
	systemctl start docker

ls:
	docker volume ls
	docker image ls
	docker network ls
	docker ps -a


stat:
	systemctl status docker

logs:
	cd srcs && $(COMPOSE) logs -f

wp:
	docker exec -it wp bash

db:
	docker exec -it db bash

nginx:
	docker exec -it nginx bash

clean:
	docker volume rm $$(docker volume ls -q)

.PHONY: all up down re logs wp db clean