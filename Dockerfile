FROM node:8.1.2-alpine
MAINTAINER Dustin Lyons <dlyons14@gmail.com>

CMD ["/bin/sh"]
CMD ["node"]
ENV STENO_OUT_PORT=3000
ENV STENO_IN_PORT=3010
ENV BOT_SERVER_PORT=5000
ENV STENO_VER=1.2.0
EXPOSE STENO_PORT
RUN apk add --no-cache bash curl unzip
RUN npm install -g pkg
RUN echo "Installing steno..."
RUN mkdir -p /steno     && cd /steno     && curl -fsSLO --compressed "https://github.com/slackapi/steno/archive/v$STENO_VER.zip"     && unzip "v$STENO_VER.zip"     && rm -f "v$STENO_VER.zip"     && cd "steno-$STENO_VER"     && npm install      && npm run clean     && npm run lint     && npm run build     && ln -s "/steno/steno-$STENO_VER/bin/steno" /usr/bin/steno
RUN echo "Installed steno."
RUN steno --version
ENTRYPOINT ["steno" "--replay", "--app localhost:$BOT_SERVER_PORT", "--out-port $STENO_OUT_PORT", "--in-port $STENO_IN_PORT", "--slack-replace-tokens"]
