FROM ghcr.io/openbao/openbao:latest

COPY config.hcl /bao/config/config.hcl

EXPOSE 8200 8201

ENTRYPOINT ["bao"]
CMD ["server", "-config=/bao/config/config.hcl"]
