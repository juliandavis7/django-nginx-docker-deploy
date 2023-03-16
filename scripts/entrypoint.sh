#!/bin/sh

set -e

# django management command that will collect all static files and put them in the static root
python manage.py collectstatic --noinput

# runs our application using uWSGI
# socket = TCP socket on port 8000, used to reference proxy when we forward the request
# master = run as master, in the foreground
uwsgi --socket :9000 --master --enable-threads --module app.wsgi