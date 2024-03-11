#!/bin/sh

openssl req -x509 \
    -nodes \
    -newkey rsa:2048 -keyout dev.test.key \
    -days 3650 \
    -out dev.test.crt \
    -subj "/C=CN/ST=Shanghai/L=Shanghai/O=Global Security/OU=IT Department/CN=dev.test" \
    -addext "subjectAltName=DNS:dev.test,DNS:*.dev.test"
