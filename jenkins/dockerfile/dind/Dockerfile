FROM docker:dind

RUN apk add --no-cache \
    curl \
    iproute2

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x ./kubectl
RUN mv ./kubectl ./bin/kubectl
