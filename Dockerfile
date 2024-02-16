FROM python:3.11

RUN mkdir /fastapi_app

WORKDIR /fastapi_app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

RUN chmod a+x docker/*.sh docker/app.sh  # Убедитесь, что скрипт app.sh исполняемый

# Используйте скрипт app.sh в качестве точки входа или команды
CMD ["./docker/app.sh"]
