FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*
COPY ./docker/nginx /etc/nginx
COPY --chown=nginx:nginx public /usr/share/nginx/html

EXPOSE 80
