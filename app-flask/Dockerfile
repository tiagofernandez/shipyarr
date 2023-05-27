# https://hub.docker.com/_/python
FROM python:3.11-slim

ADD . /app
WORKDIR /app

RUN pip install --upgrade pip && \
	pip install -r requirements/app.txt

CMD ["./run.sh"]
