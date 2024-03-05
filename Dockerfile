FROM alpine

RUN apk fix && \
    apk --no-cache --update add git git-lfs gpg less openssh patch && \
    git lfs install && \
    adduser -D -s /bin/sh -g git-user git-user

VOLUME /git
WORKDIR /git

ENTRYPOINT ["git"]
CMD ["--help"]
