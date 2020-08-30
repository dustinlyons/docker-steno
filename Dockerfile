FROM node:8.1.2-alpine
MAINTAINER Dustin Lyons <dlyons14@gmail.com>
CMD ["/bin/sh"]
CMD ["node"]
ENV STENO_VER=1.2.0
EXPOSE 3000
RUN apk add --no-cache bash curl unzip
RUN npm install -g pkg
RUN echo "Installing steno..."
RUN mkdir -p /steno     && cd /steno     && curl -fsSLO --compressed "https://github.com/slackapi/steno/archive/v$STENO_VER.zip"     && unzip "v$STENO_VER.zip"     && rm -f "v$STENO_VER.zip"     && cd "steno-$STENO_VER"     && npm install      && npm run clean     && npm run lint     && npm run build     && ln -s "/steno/steno-$STENO_VER/bin/steno" /usr/bin/steno
RUN echo "Installed steno."
RUN steno --version
ENTRYPOINT ["steno" "--record"]
