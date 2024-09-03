#!/usr/bin/env sh

# Default the EULA to `FALSE`, so that the server doesn't start if the EULA hasn't been accepted.
: "${EULA:=FALSE}"
# Defaults to 4GB of memory.
: "${MEM:=4G}"

# change eula.txt to eula=$EULA
echo "eula=$EULA" >eula.txt

# Check if the file ./config/paper-global.yml exists.
# If so, move `paper-global.yml` to the server folder so we can enable certain settings right away.
# NOTE: We can't run this in the Dockerfile because it won't be preserved when mounting a volume.
if [ ! -f "./config/paper-global.yml" ]; then
	# If the config folder doesn't exist, create it.
	if [ ! -d "./config" ]; then
		mkdir -p ./config
	fi

	mv ../paper-global.yml ./config/paper-global.yml
fi

# Command to run the minecraft server, generated from here: https://docs.papermc.io/misc/tools/start-script-gen, with
# `../server.jar` as the server jar file (as this is in a separate folder).
java -Xms4096M -Xmx4096M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar ../paper.jar --nogui
