# Использование официального образа Python как базового
FROM python:3.11

# Установка netcat для использования в app.sh
RUN apt-get update && apt-get install -y netcat-openbsd && apt-get clean

# Создание директории приложения
RUN mkdir /fastapi_app

# Установка рабочей директории
WORKDIR /fastapi_app

# Копирование файла зависимостей в контейнер
COPY requirements.txt .

# Установка зависимостей
RUN pip install -r requirements.txt

# Обновление bcrypt до последней версии
RUN pip install --upgrade bcrypt

# Копирование всего приложения в контейнер
COPY . .

# Делаем файлы скриптов исполняемыми
RUN chmod +x /fastapi_app/docker/app.sh

# Указываем скрипт для запуска приложения
CMD ["/fastapi_app/docker/app.sh"]
