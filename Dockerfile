FROM alpine

RUN apk fix
RUN apk --update add git git-lfs less openssh && \
    git lfs install && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

VOLUME /git
WORKDIR /git

ENTRYPOINT ["git"]
CMD ["--help"]
