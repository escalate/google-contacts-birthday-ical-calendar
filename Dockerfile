#### python
FROM python:3.14-slim AS python

RUN useradd --create-home python-user

#### base
FROM python AS base

ARG POETRY_VERSION="2.2.1"
ENV POETRY_VIRTUALENVS_PATH=".venv" \
    POETRY_VIRTUALENVS_IN_PROJECT="true"

RUN pip install --no-cache-dir --disable-pip-version-check poetry==${POETRY_VERSION} \
    && apt-get update \
    && apt-get install --no-install-recommends --yes make=* \
    && apt-get clean \
    && rm --recursive --force /var/lib/apt/lists/*

#### build
FROM base AS build

WORKDIR /build

COPY . ./

RUN make lint-project-config \
    && make install-project-dependencies

#### test
FROM build AS test

RUN make install-project-dev-dependencies \
    && make test-project

#### release
FROM python AS release

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1

COPY --from=build --chown=python-user:python-user /build/src/ /app/
COPY --from=build --chown=python-user:python-user /build/.venv/ /app/.venv/

WORKDIR /app
USER python-user
ENV PATH="/app/.venv/bin:${PATH}"
ENTRYPOINT ["/app/cli.py"]
CMD ["--help"]
