#!/bin/bash

# Ожидание доступности базы данных
echo "Ожидание доступности базы данных на $DB_HOST:$DB_PORT..."
while ! nc -z $DB_HOST $DB_PORT; do
  sleep 1
done
echo "База данных доступна."

# Применение миграций Alembic
echo "Применение миграций Alembic..."
alembic upgrade head

# Запуск приложения FastAPI через Gunicorn
echo "Запуск FastAPI приложения через Gunicorn..."
exec gunicorn main:app --workers 1 --worker-class uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
