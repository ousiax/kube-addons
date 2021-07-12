FROM nginx:1.21.1-alpine
label maintainer="ROY XU <qqbuby@gamil.com>"

COPY ./heartbeat.gif /usr/share/nginx/html/heartbeat.gif

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
