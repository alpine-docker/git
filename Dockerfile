FROM alpine

LABEL maintainer Bill Wang <ozbillwang@gmail.com>

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk --update --no-cache add git less openssh-client 

VOLUME /git
WORKDIR /git

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--help"]
