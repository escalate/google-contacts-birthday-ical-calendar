SHELL = /bin/bash
.SHELLFLAGS = -e -o pipefail -c
PROJECT = google_contacts_birthday_ical_calendar

## Project Maintenance

.PHONY: install-python-dependencies
install-python-dependencies:
	poetry install --no-interaction --no-root --without dev

.PHONY: install-python-dev-dependencies
install-python-dev-dependencies:
	poetry install --no-interaction --no-root --only dev

.PHONY: update-python-dependencies
update-python-dependencies:
	poetry update

.PHONY: lock-python-dependencies
lock-python-dependencies:
	poetry lock

.PHONY: clean-python-venv
clean-python:
	rm --recursive --force .venv/

## Linting

.PHONY: lint-pyproject
lint-pyproject:
	poetry check

.PHONY: lint-python
lint-python:
	poetry run flake8 -v $(PROJECT)/ tests/

## Testing

.PHONY: test-python
test-python:
	poetry run pytest --cov=$(PROJECT)/

## Docker Build

.PHONY: build-docker-image
build-docker-image:
	docker-compose --file docker-compose.yml build

## Test & Execution

.PHONY: test-docker-image
test-docker-image: clean-python-venv
	docker-compose -f docker-compose.test.yml build $(PROJECT)

.PHONY: run-docker-image
run-docker-image: clean-python-venv
	docker-compose -f docker-compose.yml run $(PROJECT) --help
