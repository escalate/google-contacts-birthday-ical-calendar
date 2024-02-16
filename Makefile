SHELL = /bin/bash
.SHELLFLAGS = -e -o pipefail -c
PROJECT = google_contacts_birthday_ical_calendar

.PHONY: install-python-dependencies
install-python-dependencies:
	poetry install --no-interaction --no-root --without dev

.PHONY: install-python-dev-dependencies
install-python-dev-dependencies:
	poetry install --no-interaction --no-root --only dev

.PHONY: lint-editorconfig
lint-editorconfig:
	ec

.PHONY: lint-dockerfile
lint-dockerfile:
	hadolint Dockerfile

.PHONY: lint-pyproject
lint-pyproject:
	poetry check

.PHONY: lint-python
lint-python:
	poetry run flake8 $(PROJECT)/

.PHONY: clean-python
clean-python:
	poetry run pyclean -v .

.PHONY: test-python
test-python:
	poetry run pytest --cov=$(PROJECT)/

.PHONY: build-docker-image
build-docker-image:
	docker-compose --file docker-compose.yml build
