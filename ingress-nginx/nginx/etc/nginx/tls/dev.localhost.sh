#!/bin/sh

openssl req -x509 \
    -nodes \
    -newkey rsa:4096 -keyout dev.localhost.key \
    -days 3650 \
    -out dev.localhost.pem \
    -subj "/C=CN/ST=Shanghai/L=Shanghai/O=Global Security/OU=IT Department/CN=dev.localhost" \
    -addext "subjectAltName=DNS:dev.localhost,DNS:*.dev.localhost"
