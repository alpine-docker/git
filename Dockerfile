FROM alpine

LABEL maintainer="Bill Wang <ozbillwang@gmail.com>"

RUN apk --update add git less openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/* && \
    adduser -D -s /bin/sh -g "git user" git-user

VOLUME /git
WORKDIR /git

USER git-user

ENTRYPOINT ["git"]
CMD ["--help"]
