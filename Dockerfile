ARG PYTHON_VERSION=3
FROM python:${PYTHON_VERSION}-slim as build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

RUN pip install "poetry>=1.0.0,<=2.0.0" \
    && apt-get update \
    && apt-get install --no-install-recommends --yes make=* \
    && apt-get clean \
    && rm --recursive --force /var/lib/apt/lists/*

WORKDIR /build

COPY . ./

RUN poetry check \
    && make install-python-dependencies \
    && make lint-python \
    && make test-python \
    && make clean-python \
    && poetry config virtualenvs.in-project true \
    && poetry config virtualenvs.path .venv \
    && poetry install --no-interaction --no-root --no-dev


FROM python:${PYTHON_VERSION}-slim as run

LABEL maintainer="Felix Boerner <ich@felix-boerner.de>"

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

COPY --from=build /build/google_contacts_birthday_ical_calendar/ ./
COPY --from=build /build/.venv/ ./.venv/

ENV PATH="/app/.venv/bin:${PATH}"

RUN useradd appuser \
    && chown --recursive appuser /app
USER appuser

WORKDIR /data

ENTRYPOINT ["/app/converter.py"]

CMD ["--help"]
