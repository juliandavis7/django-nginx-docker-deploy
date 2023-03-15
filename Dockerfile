FROM python:3.9-alpine3.12
LABEL maintainer="juldavis"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./scripts /scripts
COPY ./app /app

WORKDIR /app

EXPOSE 8000

RUN python -m venv /py && \
  /py/bin/pip install --upgrade pip && \
  apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers && \
  /py/bin/pip install -r /requirements.txt && \
  apk del .tmp-build-deps && \
  adduser \
    --disabled-password \
    --no-create-home \
    django-user && \
  mkdir -p /vol/web/media && \
  mkdir -p /vol/web/static && \
  chown -R django-user:django-user /vol && \
  chmod -R 755 /vol && \
  chmod -R +x /scripts

ENV PATH="/scripts:/py/bin:$PATH"

USER django-user

CMD ["run.sh"]
