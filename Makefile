COMPOSE=docker-compose

all: up

up: build
	cd srcs && $(COMPOSE) up -d

build:
	mkdir -p /home/$(USER)/data/db
	mkdir -p /home/$(USER)/data/wp
	chmod 777 /home/$(USER)/data/db;
	chmod 777 /home/$(USER)/data/wb;
	echo "Directories for MariaDB and Wordpress where created"
	cd srcs && $(COMPOSE) build

down:
	cd srcs && $(COMPOSE) down

stop:
	cd srcs && $(COMPOSE) stop

re:
	$(COMPOSE) down
	$(COMPOSE) up -d

logs:
	$(COMPOSE) logs -f

wp:
	docker exec -it wp bash

db:
	docker exec -it db bash

nginx:
	docker exec -it nginx bash

clean:
	docker volume rm $$(docker volume ls -q)

.PHONY: all up down re logs wp db clean