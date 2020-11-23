ARG NODE_VER=12-buster-slim

FROM node:$NODE_VER

RUN apt-get update && \
    apt-get install gosu && \
    rm -rf /var/lib/apt/lists/*

USER node

RUN mkdir /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node package.json yarn.lock ./

RUN yarn install && \
    yarn cache clean

COPY --chown=node:node . ./

USER root

COPY docker/gatsby-starter-default/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
EXPOSE 8000

CMD yarn develop
