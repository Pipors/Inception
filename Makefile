# Makefile for Docker Compose project


all: up
	@echo "\033[93m Image built successfully!🎉\033[0m"
#Stops the Docker Compose services
down:
	@echo "\033[91mstopping...⌛\033[0m"
	docker compose -f srcs/docker-compose.yml down

#starts the Docker Compose services in detached mode
up: build
	@echo "\033[92m launching...⌛\033[0m"
	@./srcs/requirements/tools/init-dir.sh
	docker compose -f srcs/docker-compose.yml up -d


#Stops the Docker Compose services and removes the volumes
clean:
	@echo "\033[91mcleaning...⌛\033[0m"
	docker compose -f srcs/docker-compose.yml down --rmi all

#Removes the volumes and the data
fclean: clean
	docker compose -f srcs/docker-compose.yml down --volumes --remove-orphans
	docker system prune
	docker system df
	sudo rm -rf ~/data

re: fclean build up

# Targets
build:
	@echo "\033[92m░░███╗░░██████╗░██████╗░███████╗\033[0m███╗░░░███╗███████╗██████╗░"
	@echo "\033[92m░████║░░╚════██╗╚════██╗╚════██║\033[0m████╗░████║██╔════╝██╔══██╗"
	@echo "\033[92m██╔██║░░░█████╔╝░█████╔╝░░░░██╔╝\033[0m██╔████╔██║█████╗░░██║░░██║"
	@echo "\033[92m╚═╝██║░░░╚═══██╗░╚═══██╗░░░██╔╝░\033[0m██║╚██╔╝██║██╔══╝░░██║░░██║"
	@echo "\033[92m███████╗██████╔╝██████╔╝░░██╔╝░░\033[0m██║░╚═╝░██║███████╗██████╔╝"
	@echo "\033[92m╚══════╝╚═════╝░╚═════╝░░░╚═╝░░░\033[0m╚═╝░░░░░╚═╝╚══════╝╚═════╝░"
	@echo "\033[92m building...⌛\033[0m"

.PHONY: build up down
