#!make
include .env
export

include ../Makefile

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
	gin --port $(PORT) --immediate run main.go

shell: ## Start a Go REPL.
	gore -autoimport
