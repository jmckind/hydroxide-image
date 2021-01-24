# https://hub.docker.com/layers/golang/library/golang/1.15.7-alpine/images/sha256-c81e0b82383205bef03149ad96bb4fe3c7c8946241297931f2472d11f70498c7
FROM docker.io/golang@sha256:c81e0b82383205bef03149ad96bb4fe3c7c8946241297931f2472d11f70498c7 AS builder

ENV GO111MODULE=on

RUN apk add --no-cache git tini && \
    cd /go/src && \
    git clone https://github.com/emersion/hydroxide.git && \
    cd hydroxide && \
    CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' ./cmd/hydroxide && \
    cp hydroxide /sbin/

EXPOSE 1025/tcp # smtp
EXPOSE 1143/tcp # imap
EXPOSE 8080/tcp # carddav

ENTRYPOINT ["/sbin/tini", "--", "/sbin/hydroxide"]
