storage "foundationdb" {
  api_version  = "730"
  cluster_file = "/etc/foundationdb/fdb.cluster"
  path         = "openbao"
  ha_enabled   = "false"
}

# Mutual TLS, enforced. tls_client_ca_file names the CA; the require flag is
# what makes a client cert mandatory — without it the listener accepts any
# TLS connection with no cert. Zero-trust: a 6PN neighbor is not trusted by
# position, it must present a cert this CA signed.
listener "tcp" {
  address                            = "[::]:8200"
  tls_cert_file                      = "/bao/data/tls/listener-cert.pem"
  tls_key_file                       = "/bao/data/tls/listener-key.pem"
  tls_client_ca_file                 = "/bao/data/tls/ca-chain.pem"
  tls_require_and_verify_client_cert = true
  tls_min_version                    = "tls13"
}

api_addr      = "https://weftspun-bao.internal:8200"
cluster_addr  = "https://weftspun-bao.internal:8201"
ui            = false
