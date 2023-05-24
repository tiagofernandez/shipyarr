#!make
-include .env
export

ifeq (, $(shell which go))
    $(error "Please install Go: https://golang.org/doc/install")
endif

.DEFAULT_GOAL := help
.PHONY: help

bench: ## Run benchmarks.
	go test -bench ./...

build: clean ## Compile packages and dependencies.
	go build

clean: ## Remove build files and cached files.
	go clean

cover: ## Run test coverage checks.
	go test -cover ./...

cover-report: ## Generate test coverage report.
	go test ./... -coverprofile cover.out
	go tool cover -html cover.out

format: ## Format the source code.
	go fmt ./...

help: # https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Download modules and install dependencies.
	go mod download
	go mod verify
	cat tools.go | grep _ | awk -F '"' '{print $$2"@latest"}' | xargs -I % go install -v %

lint: ## Run lint inspections.
	go vet ./...

test: ## Run unit tests.
	go test -v ./...

run: build ## Run the main application.
	go run .

run-dev: ## Run with live reload.
	gin --port ${PORT} --immediate run main.go

shell: ## Start a Go REPL (https://github.com/x-motemen/gore).
	gore -autoimport

#  ____             _             
# |  _ \  ___   ___| | _____ _ __ 
# | | | |/ _ \ / __| |/ / _ \ '__|
# | |_| | (_) | (__|   <  __/ |   
# |____/ \___/ \___|_|\_\___|_|   

IMAGE := shipyarr/service-gin
VERSION := latest

docker-debug: ## Debug the running container.
	docker exec -ti $(shell docker ps | grep $(IMAGE):$(VERSION) | awk '{print $$1}') /bin/sh

docker-image: ## Build the Docker image.
	docker build --rm=true -t $(IMAGE):$(VERSION) .

docker-run: ## Run a detached container.
	docker run --restart=always -p $(PORT):$(PORT) -d $(IMAGE):$(VERSION)

docker-run-shell: ## Run an interactive container.
	docker run -p $(PORT):$(PORT) -ti $(IMAGE):$(VERSION) /bin/sh

docker-stop: ## Stop the detached container.
	docker stop $(shell docker ps | grep $(IMAGE):$(VERSION) | awk '{print $$1}')
