FROM python:3.11

RUN mkdir /fastapi_app

WORKDIR /fastapi_app

COPY requirements.txt .

RUN pip install -r requirements.txt

# Установка netcat для использования в app.sh
RUN apt-get update && \
    apt-get install -y netcat-openbsd && \
    apt-get clean

COPY . .

RUN chmod a+x docker/*.sh

# Здесь используется скрипт app.sh в качестве точки входа
CMD ["./docker/app.sh"]
