SHELL = /bin/bash
.SHELLFLAGS = -e -o pipefail -c

## Dependencies

.PHONY: install-project-dependencies
install-project-dependencies:
	poetry install --no-interaction --no-root --without dev

.PHONY: install-project-dev-dependencies
install-project-dev-dependencies:
	poetry install --no-interaction --no-root --only dev

.PHONY: update-project-dependencies
update-project-dependencies:
	poetry update

.PHONY: lock-project-dependencies
lock-project-dependencies:
	poetry lock

## Lint

.PHONY: lint-project-config
lint-project-config:
	poetry check

## Build

.PHONY: build-docker-image
build-docker-image: clean-python-venv clean-python-cache
	docker compose --file docker-compose.yml build

## Clean

.PHONY: clean
clean: clean-python-venv clean-python-cache

.PHONY: clean-python-venv
clean-python-venv:
	rm --recursive --force .venv/

.PHONY: clean-python-cache
clean-python-cache:
	find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete

## Test

.PHONY: test-project
test-project:
	poetry run pytest

.PHONY: test-docker-image
test-docker-image: clean-python-venv clean-python-cache
	docker compose --file docker-compose.test.yml build google-contacts-birthday-ical-calendar-test

.PHONY: run-docker-image
run-docker-image: clean-python-venv clean-python-cache
	docker compose --file docker-compose.yml run --rm google-contacts-birthday-ical-calendar --help
