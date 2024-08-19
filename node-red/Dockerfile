FROM nodered/node-red:4.0

USER root

RUN apk add --no-cache openssh-client git

COPY settings.js /usr/src/node-red/node_modules/node-red/settings.js

COPY start.sh /usr/src/node-red/start.sh

RUN chmod +x /usr/src/node-red/start.sh && \
    chown node-red:root /usr/src/node-red/start.sh

USER node-red

EXPOSE 1880

ENTRYPOINT ["/usr/src/node-red/start.sh"]