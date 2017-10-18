FROM nginx:latest
LABEL maintainer="magiclobster@mailbox.org"
RUN rm -rf /etc/nginx/conf.d/*

COPY default.conf /etc/nginx/conf.d/

RUN mkdir -p /srv/www/default
COPY www/* /srv/www/default/

WORKDIR /etc/nginx/conf.d/