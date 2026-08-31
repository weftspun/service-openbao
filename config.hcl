storage "raft" {
  path = "/bao/data"
  node_id = "bao-sjc-1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true
}

api_addr     = "http://weftspun-bao.internal:8200"
cluster_addr = "http://weftspun-bao.internal:8201"

disable_mlock = true

ui = false
