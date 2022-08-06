#!/bin/bash
SSL_Path=/etc/letsencrypt/live/localhost
domain=localhost

mkdir -p ./certbot/conf/live/$domain

docker-compose -f docker-compose.local.yml run --rm --entrypoint "\
    openssl req -x509 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout '$SSL_Path/privkey.pem' \
    -out '$SSL_Path/fullchain.pem' \
    -subj '/CN=localhost'" certbot

docker-compose -f docker-compose.local.yml up --force-recreate -d nginx