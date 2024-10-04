#### python
FROM python:3.12-slim AS python

#### base
FROM python AS base

ARG POETRY_VERSION="1.8.3"
ENV POETRY_VIRTUALENVS_PATH=".venv" \
    POETRY_VIRTUALENVS_IN_PROJECT="true"

RUN pip install --no-cache-dir --disable-pip-version-check "poetry==${POETRY_VERSION}" \
    && apt-get update \
    && apt-get install --no-install-recommends --yes make=* \
    && apt-get clean \
    && rm --recursive --force /var/lib/apt/lists/*

RUN useradd --create-home appuser

#### build
FROM base AS build

WORKDIR /build

COPY . ./

RUN make lint-pyproject \
    && make install-python-dependencies

#### test
FROM build AS test

RUN make install-python-dev-dependencies \
    && make test-python

#### release
FROM python AS release

LABEL maintainer="Felix Boerner <ich@felix-boerner.de>"

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1

RUN useradd appuser

COPY --from=build --chown=appuser:appuser /build/google_contacts_birthday_ical_calendar/ /app/
COPY --from=build --chown=appuser:appuser /build/.venv/ /app/.venv/

WORKDIR /data
USER appuser
ENV PATH="/app/.venv/bin:${PATH}"
ENTRYPOINT ["/app/converter.py"]
CMD ["--help"]
