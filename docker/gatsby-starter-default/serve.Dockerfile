ARG NODE_VER=12-buster-slim

FROM node:$NODE_VER AS build

WORKDIR /tmp

COPY package.json yarn.lock ./

RUN yarn install && \
    yarn cache clean

COPY . ./

RUN yarn build:clean

# Production build
FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*
COPY ./docker/nginx /etc/nginx
COPY --chown=nginx:nginx --from=build /tmp/public /usr/share/nginx/html

EXPOSE 80
