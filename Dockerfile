FROM python:3.11

# Создание директории приложения
RUN mkdir /fastapi_app

# Установка рабочей директории
WORKDIR /fastapi_app

# Копирование файла requirements и установка зависимостей
COPY requirements.txt .
RUN pip install -r requirements.txt

# Копирование всего приложения в контейнер
COPY . .

# Установка netcat для использования в app.sh
RUN apt-get update && apt-get install -y netcat-openbsd && apt-get clean

# Установка прав на исполнение для скриптов
RUN chmod a+x docker/*.sh

# Запуск скрипта app.sh при старте контейнера
CMD ["./docker/app.sh"]

