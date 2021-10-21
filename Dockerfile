FROM docker:20.10.9-dind-alpine3.14

ENV EVAL_CONTAINER_NAME=trybe-docker-eval

RUN docker run --privileged -d --name $EVAL_CONTAINER_NAME mjgargani/docker:dind-trybe1.0

RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache --update \
    nodejs>14 \
    npm>8 \
    curl>7 \
    docker-compose>1 \
      \
      # Cleanup
      && apk del --no-cache make gcc g++ binutils-gold gnupg \
      && rm -rf /usr/include \
      && rm -rf /var/cache/apk/* /root/.node-gyp /usr/share/man /tmp/* \
      && echo

COPY entrypoint.sh /entrypoint.sh
COPY evaluator.js /evaluator.js

ENTRYPOINT ["/entrypoint.sh"]
