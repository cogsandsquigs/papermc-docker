#!/bin/sh

# load the default environment variables
. /env-var-defaults.sh

rcon -H localhost -p 25575 -P $RCON_PASS $@
