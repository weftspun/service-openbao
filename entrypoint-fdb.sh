#!/usr/bin/env bash
set -euo pipefail

# Configure single-node FDB cluster
FDB_DATA="/bao/data/fdb"
FDB_LOG="/var/log/foundationdb"

# Create cluster file if not present (single-node)
if [ ! -f /etc/foundationdb/fdb.cluster ]; then
  mkdir -p /etc/foundationdb
  desc=$(dd if=/dev/urandom bs=8 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n' | head -c 16)
  id=$(dd if=/dev/urandom bs=8 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n' | head -c 16)
  echo "${desc}:${id}@127.0.0.1:4500" > /etc/foundationdb/fdb.cluster
  chmod 644 /etc/foundationdb/fdb.cluster
fi

mkdir -p "$FDB_DATA" "$FDB_LOG"

# Start FDB server in single-node mode
/usr/sbin/fdbserver \
  --listen-address 0.0.0.0:4500 \
  --public-address 127.0.0.1:4500 \
  --datadir "$FDB_DATA" \
  --logdir "$FDB_LOG" \
  --class storage \
  &

FDB_PID=$!

# Wait for FDB to be ready
for i in $(seq 1 30); do
  if fdbcli --exec "status minimal" 2>/dev/null | grep -q "available"; then
    break
  fi
  sleep 1
done

# Configure the database (idempotent)
fdbcli --exec "configure new single ssd" 2>/dev/null || true

echo "FoundationDB ready"

# Start OpenBao
exec dumb-init bao server -config=/bao/config/config.hcl
