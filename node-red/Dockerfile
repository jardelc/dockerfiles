FROM nodered/node-red:4.0

USER root

RUN apk add --no-cache openssh-client git

USER node-red

COPY settings.js /usr/src/node-red/node_modules/node-red/settings.js

EXPOSE 1880

COPY start.sh /usr/src/node-red/start.sh

USER root

# Set permissions and ownership
RUN chmod +x /usr/src/node-red/start.sh && \
    chown node-red:root /usr/src/node-red/start.sh

USER node-red

ENTRYPOINT ["/usr/src/node-red/start.sh"]