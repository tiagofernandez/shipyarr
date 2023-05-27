#!make
include .env
export

include ../Makefile

clean: ## Delete compilation files.
	find . -type f -name '*.pyc' -delete

cover: ## Run test coverage checks.
	pytest --cov

cover-report: ## Generate test coverage report.
	pytest --cov --cov-report html
	open htmlcov/index.html

format: ## Format the source code.
	black .

install: ## Download and install requirements.
	pip install --upgrade pip
	pip install -r requirements/dev.txt

lint: ## Run lint inspections.
	ruff check . --fix

test: ## Run unit tests.
	pytest

run: ## Run the main application.
	flask --app wsgi run --host=0.0.0.0 --port=$(PORT)

run-dev: ## Run the development server in debug mode.
	flask run --port=$(PORT) --debug

venv: ## Install a local virtual environment.
	python -m venv venv

shell: ## Run a shell in the app context.
	flask shell
