#### build
ARG PYTHON_VERSION="3"
FROM python:${PYTHON_VERSION}-slim as build

WORKDIR /build

ARG POETRY_VERSION="1.2.2"
ENV POETRY_VIRTUALENVS_PATH=".venv" \
    POETRY_VIRTUALENVS_IN_PROJECT="true"

RUN pip install --no-cache-dir --disable-pip-version-check "poetry==${POETRY_VERSION}" \
    && apt-get update \
    && apt-get install --no-install-recommends --yes make=* \
    && apt-get clean \
    && rm --recursive --force /var/lib/apt/lists/*

COPY . ./

RUN make lint-pyproject \
    && make install-python-dependencies

#### test
FROM build as test
RUN make install-python-dev-dependencies \
    && make lint-python \
    && make test-python

#### release
FROM python:${PYTHON_VERSION}-slim as release

LABEL maintainer="Felix Boerner <ich@felix-boerner.de>"

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app
RUN useradd appuser
COPY --from=build --chown=appuser:appuser /build/google_contacts_birthday_ical_calendar/ ./
COPY --from=build --chown=appuser:appuser /build/.venv/ ./.venv/

WORKDIR /data
USER appuser
ENV PATH="/app/.venv/bin:${PATH}"
ENTRYPOINT ["/app/converter.py"]
CMD ["--help"]
