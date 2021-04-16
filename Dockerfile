FROM alpine:3.10.2
USER root

ENV KUBE_VERSION="v1.18.14"
ENV KUBECTX_VERSION="0.6.3"
ENV ARK_VERSION="0.10.2"

# Install tools
RUN apk update \
    && apk add bash \
    && apk add ncurses \
    && apk add sed \
    && apk add tar \
    && apk add jq \
    && apk add git \
    && apk add zip \
    && apk add grep \
    && apk add wget \
    && apk add curl \
    && apk add less \
    && apk add nodejs \
    && apk add python \
    && apk add py-pip \
    && apk add groff \
    && apk add less \
    && apk add mailcap \
    && rm -rf /var/cache/apk/*

# Install Docker
RUN apk add docker \
    && apk add openrc \
    && rc-update add docker boot

# Install kubectl
RUN curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install kubectx and kubens
RUN curl -L -o /usr/local/bin/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/kubectx \
    && curl -L -o /usr/local/bin/kubens https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/kubens \
    && chmod +x /usr/local/bin/kubectx \
    && chmod +x /usr/local/bin/kubens

# Install yq
RUN curl -L -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/2.3.0/yq_linux_amd64 \
    && chmod +x /usr/local/bin/yq

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
