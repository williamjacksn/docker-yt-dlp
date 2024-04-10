FROM python:3.12.3-alpine3.19

RUN /sbin/apk add --no-cache ffmpeg
RUN /usr/sbin/adduser -g python -D python

USER python
RUN /usr/local/bin/python -m venv /home/python/venv

ENV PATH="/home/python/venv/bin:${PATH}" \
    PYTHONUNBUFFERED="1"

COPY --chown=python:python requirements.txt /home/python/docker-yt-dlp/requirements.txt
RUN /home/python/venv/bin/pip install --no-cache-dir --requirement /home/python/docker-yt-dlp/requirements.txt

ENTRYPOINT ["/home/python/venv/bin/yt-dlp"]

LABEL org.opencontainers.image.authors="William Jackson <william@subtlecoolness.com>" \
      org.opencontainers.image.source="https://github.com/williamjacksn/docker-yt-dlp"
