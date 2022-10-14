#!/bin/bash
#localhost 인증서만 생성함
domain=localhost
SSL_Path=/etc/letsencrypt/live/$domain

docker-compose -f docker-compose.dev.yml run --rm --entrypoint "\
  rm -rf /etc/letsencrypt/live/$domain && \
  rm -rf /etc/letsencrypt/archive/$domain && \
  rm -rf /etc/letsencrypt/renewal/$domain.conf" certbot

mkdir -p ./certbot/conf/live/$domain

docker-compose -f docker-compose.dev.yml run --rm --entrypoint "\
    openssl req -x509 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout '$SSL_Path/privkey.pem' \
    -out '$SSL_Path/fullchain.pem' \
    -subj '/CN=localhost'" certbot
docker-compose -f docker-compose.dev.yml up --force-recreate -d nginx