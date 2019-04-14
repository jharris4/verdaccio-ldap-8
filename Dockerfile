FROM node:8-alpine

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
    chmod +x /usr/local/bin/dumb-init

ENV APPDIR=/usr/local/app

ENV VERDACCIO_BUILD_REGISTRY=https://registry.npmjs.org

WORKDIR $APPDIR

copy config.yaml config.yaml
COPY package.json package.json
COPY yarn.lock yarn.lock

RUN yarn config set registry $VERDACCIO_BUILD_REGISTRY && \
    yarn install

COPY verdaccio-ldap-fix.js .
RUN node verdaccio-ldap-fix.js
RUN rm verdaccio-ldap-fix.js

VOLUME ["/verdaccio"]

ENV USER=verdaccio \
    USERID=9999 \
    GROUP=verdaccio \
    GROUPID=9999

RUN addgroup -g "$GROUPID" "$GROUP" && \
    adduser -D -u "$USERID" -G "$GROUP" "$USER" && \
    chown -R "$USERID:$GROUPID" "$APPDIR"

USER "$USER"

ENV PORT 4873
ENV PROTOCOL http

EXPOSE $PORT

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD $APPDIR/node_modules/.bin/verdaccio --config $APPDIR/config.yaml --listen $PROTOCOL://0.0.0.0:$PORT
