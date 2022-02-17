FROM docker:20.10.12-dind-alpine3.15

RUN set -x \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/v3.15/main" >> /etc/apk/repositories \
		&& apk update \
    && apk upgrade -U -a \
    && apk add --no-cache \
		jq \
    bash \
    tini \
    curl \
		nodejs \
		npm \
    docker-compose \
		udev \
		libstdc++ \
    chromium \
		harfbuzz \
		nss \
		freetype \
    ttf-freefont \
		font-noto-emoji \
		wqy-zenhei \
      \
      # Cleanup
      && apk del --no-cache make gcc g++ binutils-gold gnupg \
      && rm -rf /usr/include \
      && rm -rf /var/cache/apk/* /usr/share/man /tmp/* \
      && echo

COPY local.conf /etc/fonts/local.conf

COPY ./entrypoint.sh /entrypoint.sh

WORKDIR /eval

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

ENTRYPOINT ["tini", "--", "bash", "/entrypoint.sh"]