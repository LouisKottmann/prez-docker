#!/bin/bash

set -e

name="$1"
cid="lilith_"$name""
echo "Stopping "$cid"..."
docker stop --time=30 "$cid"
while docker top "$cid" >/dev/null 2>&1; do
  echo "Waiting for "$cid" container to stop..."
  sleep 1
done
echo ""$cid" stopped"
