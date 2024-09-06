#!/bin/sh

: "${RCON_PASS:=password}"

rcon -H localhost -p 25575 -P $RCON_PASS $@
