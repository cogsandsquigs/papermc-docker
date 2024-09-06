#!/usr/bin/env sh

# Default the EULA to `FALSE`, so that the server doesn't start if the EULA hasn't been accepted.
: "${EULA:=FALSE}"
# Enable RCON by default.
: "${RCON:=TRUE}"

# If the /minecraft folder doesn't exist, create it.
mkdir -p /minecraft

# change eula.txt to eula=$EULA
echo "eula=$EULA" >/minecraft/eula.txt

## RCON ##

# RCON is only usable when RCON is set and RCON_PASS is set
if { [ $RCON ] && [ $RCON_PASS ]; }; then
	# Copy the server.properties file to the /minecraft folder IF it doesn't exist AND if
	# RCON is enabled. This enables RCON by default.
	if [ ! -f /minecraft/server.properties ]; then
		# Add the RCON settings to the server.properties file.
		echo "enable-rcon=true" >>/minecraft/server.properties
		echo "rcon.password=$RCON_PASS" >>/minecraft/server.properties
	else
		# Replace the RCON settings in the server.properties file.
		sed -i "s/enable-rcon=false/enable-rcon=true/g" /minecraft/server.properties
		sed -i "s/rcon\.password=.*/rcon\.password=$RCON_PASS/g" /minecraft/server.properties
	fi

	# Disable RCON if it's not set.
elif [ -f /minecraft/server.properties ]; then
	sed -i "s/enable-rcon=true/enable-rcon=false/g" /minecraft/server.properties
fi

# Now, run the server.
sh /run-server.sh
