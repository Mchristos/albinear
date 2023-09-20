## Usage ##
# docker build -t albinear .
# docker run -p 8080:8080 albinear

# 1. Build stage: install dependencies with Poetry into a venv 
FROM python:3.10 AS builder
WORKDIR /app
RUN pip install poetry~="1.5.1"
COPY pyproject.toml ./pyproject.toml
COPY poetry.lock ./poetry.lock
RUN python -m venv /venv
RUN . /venv/bin/activate && poetry install --no-dev --no-root --verbose

# 2. App stage: create app image with code, models, venv etc
FROM python:3.10-slim-bullseye as app
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
COPY --from=builder /venv /venv
# COPY ./models /app/models
COPY albinear/ ./albinear
COPY docker-entrypoint.sh docker-entrypoint.sh
CMD ["./docker-entrypoint.sh"]
