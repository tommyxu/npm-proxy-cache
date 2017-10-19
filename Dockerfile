#TAG npmproxy

FROM mhart/alpine-node

ADD package.json package-lock.json /tmp/

RUN cd /tmp && \
    npm install --production --from-lock-file && \
    mkdir -p /opt/npm-proxy-cache && \
    cp -a /tmp/node_modules /opt/npm-proxy-cache && \
    mkdir -p /opt/npm-proxy-cache/cache

WORKDIR /opt/npm-proxy-cache

ADD . /opt/npm-proxy-cache

EXPOSE 80

VOLUME /cache

CMD ["./entrypoint.sh"]

RUN chmod +x ./entrypoint.sh

