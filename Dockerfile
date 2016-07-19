FROM alpine:latest
ENV REFRESHED_AT 2016-06-21
ENV VAULT_VERSION 0.6.0

# x509 expects certs to be in this file only.
RUN apk update && apk add openssl ca-certificates curl && rm -rf /var/cache/apk/*

RUN wget -qO /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
      unzip -d /bin /tmp/vault.zip && rm /tmp/vault.zip && chmod 755 /bin/vault

EXPOSE 8200
ENV VAULT_ADDR="http://127.0.0.1:8200"

COPY config.hcl /config.hcl
COPY init.sh /init.sh

ENTRYPOINT ["/bin/vault"]
CMD ["server", "-config=/config.hcl"]
