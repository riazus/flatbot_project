PROD_COMPOSE_FILE	=	docker-compose.yml

DOCKER		=	docker compose
OPTIONS		=	#-d

_RESET		=	\e[0m
_RED		=	\e[31m
_GREEN		=	\e[32m
_YELLOW		=	\e[33m
_CYAN		=	\e[36m

all: prod

prod:
	$(DOCKER) -f $(PROD_COMPOSE_FILE) up --build $(OPTIONS)

parser:
	$(DOCKER) -f $(PROD_COMPOSE_FILE) up --build $(OPTIONS) flatbot_parser db

tg:
	$(DOCKER) -f $(PROD_COMPOSE_FILE) up --build $(OPTIONS) flatbot_tg db

clean:
	$(DOCKER) -f $(PROD_COMPOSE_FILE) down

fclean: clean
	$(DOCKER) -f $(PROD_COMPOSE_FILE) down --rmi all --volumes --remove-orphans

clean-dev:
	#rm -rf ./flatbot/node_modules ./flatbot/dist
	#rm -rf ./flatbot_tg/node_modules ./flatbot_tg/dist

clean-docker:
	docker system prune
	docker volume prune

mclean: fclean clean-dev clean-docker

re: mclean all

.PHONY: dev prod tg parser clean fclean clean-dev clean-docker mclean
