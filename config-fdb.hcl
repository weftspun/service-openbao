storage "foundationdb" {
  api_version  = "730"
  cluster_file = "/etc/foundationdb/fdb.cluster"
  path         = "openbao"
  ha_enabled   = "false"
}

listener "tcp" {
  address     = "[::]:8200"
  tls_disable = true
}

api_addr      = "http://weftspun-bao.internal:8200"
cluster_addr  = "http://weftspun-bao.internal:8201"
ui            = false
