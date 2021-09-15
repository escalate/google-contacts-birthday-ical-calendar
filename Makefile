SHELL = /bin/bash -eo pipefail

.PHONY: install-python-dependencies
install-python-dependencies:
	poetry install --no-interaction

.PHONY: update-python-dependencies
update-python-dependencies:
	poetry update

.PHONY: lock-python-dependencies
lock-python-dependencies:
	poetry lock

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
	poetry run flake8

.PHONY: clean-python
clean-python:
	poetry run pyclean -v .

.PHONY: test-python
test-python:
	poetry run pytest --cov=google_contacts_birthday_ical_calendar/

.PHONY: build-docker-image
build-docker-image:
	docker build \
	--pull \
	--rm \
	--tag googlecontactsbirthdayicalcalendar:latest \
	.

.PHONY: versions
versions:
	python --version
	pip --version
	poetry --version
