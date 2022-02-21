FROM node:14-alpine

USER node
COPY --chown=node:node server.js /opt
WORKDIR /opt

EXPOSE 3000
ENTRYPOINT ["node", "server.js"]
