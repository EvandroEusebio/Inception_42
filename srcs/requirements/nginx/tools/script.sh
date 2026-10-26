#!/bin/bash

set -e

mkdir -p /etc/nginx/ssl

openssl req -x509 -noenc -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/nginx.key \
  -out /etc/nginx/ssl/nginx.crt \
  -days 365 \
  -subj "/C=AO/ST=Luanda/L=Luanda/O=Inception/CN=$DOMAIN_NAME" \
  -addext "subjectAltName=DNS:$DOMAIN_NAME,DNS:localhost"

chmod 600 /etc/nginx/ssl/nginx.key

#which nginx

nginx -t

exec nginx -g "daemon off;"
