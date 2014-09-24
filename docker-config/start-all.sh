#!/bin/bash

set -e

CURRENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

"$CURRENT_DIR"/start.sh postgres
"$CURRENT_DIR"/start.sh redis
"$CURRENT_DIR"/start.sh transmission
"$CURRENT_DIR"/start.sh mumble
"$CURRENT_DIR"/start.sh nginx
"$CURRENT_DIR"/start.sh gitlab
