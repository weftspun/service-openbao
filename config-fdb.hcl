storage "foundationdb" {
  api_version  = "730"
  cluster_file = "/etc/foundationdb/fdb.cluster"
  path         = "openbao"
  ha_enabled   = "false"
}

listener "tcp" {
  address            = "[::]:8200"
  tls_cert_file      = "/bao/data/tls/listener-cert.pem"
  tls_key_file       = "/bao/data/tls/listener-key.pem"
  tls_client_ca_file = "/bao/data/tls/ca-chain.pem"
}

listener "tcp" {
  address     = "[::]:8300"
  tls_disable = true
}

api_addr      = "https://weftspun-bao.internal:8200"
cluster_addr  = "https://weftspun-bao.internal:8201"
ui            = false
