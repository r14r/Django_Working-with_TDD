HERE           := ${CURDIR}
NAME_CONTAINER := playground_django_tdd
NAME_APP       := app  

build:
	docker build -t $(NAME_CONTAINER) .

run:
	docker run -v ./workspace:/workspace -it --rm $(NAME_CONTAINER) /bin/bash

up:
	docker-compose up -d

down:
	docker-compose down	

exec:
	docker-compose exec $(NAME_APP) /bin/bash
