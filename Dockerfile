FROM python:3.13-slim

RUN /usr/sbin/useradd --create-home --shell /bin/bash --user-group python

ARG DEBIAN_FRONTEND=noninteractive
RUN /usr/bin/apt-get update \
 && /usr/bin/apt-get install --assume-yes ffmpeg \
 && rm -rf /var/lib/apt/lists/*

USER python
RUN /usr/local/bin/python -m venv /home/python/venv

ENV PATH="/home/python/venv/bin:${PATH}" \
    PYTHONUNBUFFERED="1"

COPY --chown=python:python requirements.txt /home/python/docker-yt-dlp/requirements.txt
RUN /home/python/venv/bin/pip install --no-cache-dir --requirement /home/python/docker-yt-dlp/requirements.txt

ENTRYPOINT ["/home/python/venv/bin/yt-dlp"]

LABEL org.opencontainers.image.authors="William Jackson <william@subtlecoolness.com>" \
      org.opencontainers.image.source="https://github.com/williamjacksn/docker-yt-dlp"
