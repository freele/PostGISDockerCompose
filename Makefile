COMPOSE := docker-compose -f docker-compose.yml

push:
	docker push makeomatic/alpine-redis
	docker push makeomatic/redis-trib

pull:
	$(COMPOSE) pull
	$(COMPOSE) -f development.yml pull

dev:
	docker-compose -f docker-compose.yml -f development.yml $(filter-out $@,$(MAKECMDGOALS))

prod: COMPOSE := $(COMPOSE) -f production.yml $(filter-out $@,$(MAKECMDGOALS))

psql-connect:
	psql -d gis -h 192.168.99.100 -p 25432 -U docker

clean: COMPOSE := $(COMPOSE) -f development.yml
clean:
	$(COMPOSE) stop
	$(COMPOSE) rm -f

%: ;

.PHONY: push prod dev pull
