SHELL := /bin/bash
COMPOSE := docker-compose -f docker-compose.yml
IMAGE := makeomatic/alpine-node:5.4.0

build: system

system:
	docker build -t makeomatic/redis-trib ./alpine-system

push:
	docker push makeomatic/alpine-redis
	docker push makeomatic/redis-trib

pull:
	$(COMPOSE) pull
	$(COMPOSE) -f development.yml pull



up: COMPOSE := $(COMPOSE) -f development.yml
up:
	PWD=./tests IMAGE=$(IMAGE) DIR=/src $(COMPOSE) up

dev:
	docker-compose -f docker-compose.yml -f development.yml $(filter-out $@,$(MAKECMDGOALS))

prod: COMPOSE := $(COMPOSE) -f production.yml $(filter-out $@,$(MAKECMDGOALS))


clean: COMPOSE := $(COMPOSE) -f development.yml
clean:
	$(COMPOSE) stop
	$(COMPOSE) rm -f

%: ;

.PHONY: rabbitmq system push prod dev pull
