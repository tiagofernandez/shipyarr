#!/bin/sh

export $(grep -v '^#' .env | xargs)
flask --app wsgi run --host=0.0.0.0 --port=${PORT}
