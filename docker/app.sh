#!/bin/bash

while !</dev/tcp/db/5431;
do sleep 1;
done;
alembic upgrade head

gunicorn main:app --workers 1 --worker-class uvicorn.workers.UvicornWorker --bind=0.0.0.0:8000
