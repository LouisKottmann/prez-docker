#!/bin/bash

set -e

name="$1"
cid="lilith_"$name""
echo "Starting "$cid"..."
docker rm "$cid" || :
sh -c "$(cat /home/baboon/docker/"$cid"/command.txt)"
while ! docker top "$cid" >/dev/null 2>&1; do
  echo "Waiting for "$cid" container to be ready..."
  sleep 1
done
echo ""$cid" started"
