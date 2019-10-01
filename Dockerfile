FROM golang:1.12.6-alpine3.10 AS golang
RUN apk --no-cache add git
RUN GOOS=linux GARCH=amd64 CGO_ENABLED=0 go get github.com/genuinetools/reg

FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install --yes --no-install-recommends curl git && \
    apt-get install --yes python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# yq
RUN pip3 install yq

# jq
RUN curl -L --silent --fail -o /usr/local/bin/jq \
    https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
    chmod +x /usr/local/bin/jq

# reg
COPY --from=golang /go/bin/reg /usr/local/bin/reg

# helm
RUN curl -L --silent --fail https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz | tar -xvz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -r linux-amd64 && \
    helm init --client-only

# helmfile
RUN curl -L --silent --fail -o /usr/local/bin/helmfile \
    https://github.com/roboll/helmfile/releases/download/v0.85.3/helmfile_linux_amd64 && \
	chmod +x /usr/local/bin/helmfile

# lab
RUN curl -L --silent --fail https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | bash

COPY rootfs /

RUN which bash yq jq reg curl grep cut tail awk git sort head helm lab
