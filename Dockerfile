FROM ubuntu:18.04

RUN apt-get update &&\
    apt-get install -y curl

RUN mkdir -p /app/bin &&\
    mkdir /app/etcd-ca &&\
    curl -s -L -o /app/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 &&\
    curl -s -L -o /app/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 &&\
    chmod -R +x /app/bin

ENV PATH=$PATH:/app/bin
VOLUME /app/etcd-ca
WORKDIR /app/etcd-ca

COPY entrypoint.sh /app/entrypoint.sh

ENTRYPOINT [ "/app/entrypoint.sh" ]
