up:
	docker-compose up -d

down:
	docker-compose down

downup:
	docker-compose down && docker-compose up -d

start:
	docker-compose start

stop:
	docker-compose stop

restart:
	docker-compose restart

build:
        docker-compose -f docker-compose.yml up --build

fullsetup:
        sudo ./setup.sh

logs:
ifdef ENV
	docker-compose -f docker-compose.yml logs --tail 250 -f ${ENV}
else
	docker-compose -f docker-compose.yml logs --tail 250 -f synapse
endif
