FROM alpine

RUN apk fix && \
    apk --no-cache --update add git git-lfs less openssh && \
    git lfs install

VOLUME /git
WORKDIR /git

ENTRYPOINT ["git"]
CMD ["--help"]
