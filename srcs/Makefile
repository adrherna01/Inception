# Makefile for Inception Docker setup

# Variables
COMPOSE=docker-compose

# Default target
all: up

# Start the services
up:
	mkdir -p ./data/db
	mkdir -p ./data/wp
	$(COMPOSE) up -d

build:
	$(COMPOSE) build

# Stop the services
down:
	$(COMPOSE) down

# Rebuild everything
re:
	$(COMPOSE) down --volumes
	$(COMPOSE) up -d

rm:
	$(COMPOSE) down --volumes --remove-orphans
	docker image rm $$(docker images -q) || true
	rm -rf /Users/adrherna/Desktop/Ince_git/srcs/data/db
	rm -rf /Users/adrherna/Desktop/Ince_git/srcs/data/wp


# View logs
logs:
	$(COMPOSE) logs -f

wp:
	docker exec -it wp bash

db:
	docker exec -it db bash

nginx:
	docker exec -it nginx bash

# Clean volumes
clean:
	docker volume rm $$(docker volume ls -q)

.PHONY: all up down re logs wp db clean