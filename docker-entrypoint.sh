#!/bin/bash
set -e
. /venv/bin/activate

exec gunicorn --bind 0.0.0.0:8080 --timeout 90 albinear.main:app -k uvicorn.workers.UvicornWorker
