FROM alpine

LABEL maintainer Bill Wang <ozbillwang@gmail.com>

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk --update add git less openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

VOLUME /git
WORKDIR /git

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--help"]
