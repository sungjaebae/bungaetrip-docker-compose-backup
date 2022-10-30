#!/bin/bash
domain=gogetter.kr
SSL_Path=/etc/letsencrypt/live/$domain

mkdir -p ./certbot/conf/live/$domain

docker-compose -f docker-compose.production.yml run --rm --entrypoint "\
    openssl req -x509 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout '$SSL_Path/privkey.pem' \
    -out '$SSL_Path/fullchain.pem' \
    -subj '/CN=localhost'" certbot


#### bungaetrip.com 인증서 받기
domain2=bungaetrip.com
SSL_Path2=/etc/letsencrypt/live/$domain2

mkdir -p ./certbot/conf/live/$domain2

docker-compose -f docker-compose.production.yml run --rm --entrypoint "\
    openssl req -x509 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout '$SSL_Path2/privkey.pem' \
    -out '$SSL_Path2/fullchain.pem' \
    -subj '/CN=localhost'" certbot
docker-compose -f docker-compose.production.yml up --force-recreate -d nginx

docker-compose -f docker-compose.production.yml run --rm --entrypoint "\
  rm -rf /etc/letsencrypt/live/$domain && \
  rm -rf /etc/letsencrypt/archive/$domain && \
  rm -rf /etc/letsencrypt/renewal/$domain.conf" certbot


docker-compose -f docker-compose.production.yml run --rm --entrypoint "\
  rm -rf /etc/letsencrypt/live/$domain2 && \
  rm -rf /etc/letsencrypt/archive/$domain2 && \
  rm -rf /etc/letsencrypt/renewal/$domain2.conf" certbot

docker-compose -f docker-compose.production.yml  run --rm --entrypoint "\
    certbot certonly --webroot -w /var/www/certbot \
    --email hsm0156@gmail.com \
    -d $domain \
    -d www.$domain \
    --rsa-key-size 4096 \
    --agree-tos \
    --no-eff-email \
    --force-renewal" certbot


docker-compose -f docker-compose.production.yml  run --rm --entrypoint "\
    certbot certonly --webroot -w /var/www/certbot \
    --email hsm0156@gmail.com \
    -d $domain2 \
    -d www.$domain2 \
    --rsa-key-size 4096 \
    --agree-tos \
    --no-eff-email \
    --force-renewal" certbot

docker-compose -f docker-compose.production.yml exec nginx nginx -s reload