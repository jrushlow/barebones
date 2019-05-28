BASEDIR := $(shell pwd)
.DEFAULT_GOAL:=help

.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Application

.PHONY: setup

setup: files install build## Setup the application

.PHONY: files
files:
	mkdir -p ./src ./tests ./public ./routes ./templates
	touch ./.env
	cp ./.docker/env.dist ./.docker/.env

##@ Composer

install: vendor ## Run composer install

outdated: ## Check is there are any outdated dependencies
	composer outdated

vendor: composer.json $(composer.lock)
	composer validate
	composer install

##@ Docker

COMPOSE_FILE := $(BASEDIR)/.docker/docker-compose.yml

.PHONY: build
build: ## Build docker images
	docker-compose -f $(COMPOSE_FILE) --project-directory ./.docker build

.PHONY: up
up: ## Start docker containers
	docker-compose -f $(COMPOSE_FILE) --project-directory ./.docker up -d

.PHONY: down
down: ## Stop and remove docker containers/networks
	docker-compose -f $(COMPOSE_FILE) --project-directory ./.docker down