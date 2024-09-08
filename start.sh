#!/bin/sh

# load the default environment variables
. /env-var-defaults.sh

# If the /data folder doesn't exist, create it.
mkdir -p /data

# change eula.txt to eula=$EULA
echo "eula=$EULA" >/data/eula.txt

## RCON ##

# RCON is only usable when RCON is set and RCON_PASS is set
if { [ $RCON ] && [ $RCON_PASS ]; }; then
	# Copy the server.properties file to the /minecraft folder IF it doesn't exist AND if
	# RCON is enabled. This enables RCON by default.
	if [ ! -f /minecraft/server.properties ]; then
		# Add the RCON settings to the server.properties file.
		echo "enable-rcon=true" >>/data/server.properties
		echo "rcon.password=$RCON_PASS" >>/data/server.properties
	else
		# Replace the RCON settings in the server.properties file.
		sed -i "s/enable-rcon=false/enable-rcon=true/g" /data/server.properties
		sed -i "s/rcon\.password=.*/rcon\.password=$RCON_PASS/g" /data/server.properties
	fi

	# Disable RCON if it's not set.
elif [ -f /minecraft/server.properties ]; then
	sed -i "s/enable-rcon=true/enable-rcon=false/g" /data/server.properties
fi

# If backups are enabled, add the backup script to the crontab.
if [ $BACKUPS ]; then
	# Add the backup script to the crontab.
	echo "$BACKUP_CRON python3 /backup.py" | crontab -

	# Start the cron daemon.
	crond
fi

# Now, run the server.
sh /run-server.sh
