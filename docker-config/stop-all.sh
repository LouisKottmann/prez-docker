#!/bin/bash

set -e

CURRENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

"$CURRENT_DIR"/stop.sh gitlab
"$CURRENT_DIR"/stop.sh nginx
"$CURRENT_DIR"/stop.sh mumble
"$CURRENT_DIR"/stop.sh transmission
"$CURRENT_DIR"/stop.sh redis
"$CURRENT_DIR"/stop.sh postgres
