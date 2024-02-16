#!/bin/bash

# Экспорт переменных окружения для подключения к базе данных
export DB_HOST=dpg-cn781dg21fec73fkca90-a
export DB_PORT=5431
export DB_NAME=postgres_test_fcb1
export DB_USER=postgres_test
export DB_PASS=VR8KrGocgPOkgW8fYrLFTowU7kkDOjDN

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
gunicorn main:app --workers 1 --worker-class uvicorn.workers.UvicornWorker --bind=0.0.0.0:8000
