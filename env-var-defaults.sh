#!/bin/sh

# Default values for environment variables.

# Defaults to 4GB of memory.
: "${MEM:=4G}"
# Default the EULA to `FALSE`, so that the server doesn't start if the EULA hasn't been accepted.
: "${EULA:=FALSE}"
# Enable RCON by default.
: "${RCON:=true}"
# Defaults to "password". Should be changed!
: "${RCON_PASS:=pass}"
# Number of backups to keep. Defaults to 3.
: "${NUM_BACKUPS:=3}"
# Backup cron schedule. Defaults to "0 0 * * *".
: "${BACKUP_CRON:="0 0 * * *"}"
