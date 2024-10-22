FROM alpine:3.20

# Metadata
LABEL org.opencontainers.image.title="papermc-docker"
LABEL org.opencontainers.image.description="A container for running a PaperMC Minecraft server."
LABEL org.opencontainers.image.authors="Ian Pratt <ianjdpratt@gmail.com>"
LABEL org.opencontainers.image.url="https://github.com/cogsandsquigs/papermc-docker"
LABEL org.opencontainers.image.documentation="https://github.com/cogsandsquigs/papermc-docker"
LABEL org.opencontainers.image.source="https://github.com/cogsandsquigs/papermc-docker"
LABEL org.opencontainers.image.licenses="MIT"

# Arguments for the build.
ARG MINECRAFT_VER=1.21.1
ARG PAPER_BUILD=128
ARG JAVA_VER=21

# Expose port(s) for the server
# Minecraft
EXPOSE 25565 
# RCON
EXPOSE 25575 

# Install required dependencies for MC, Paper, + plugins, backup, etc.
RUN apk add --no-cache python3 py3-pip rcon openrc eudev udev-init-scripts openjdk${JAVA_VER}-jre-headless wget libstdc++ gcompat

# Enable Glibc compatibility
ENV LD_PRELOAD=/lib/libgcompat.so.0

# Startup udev
RUN rc-update add udev sysinit
RUN rc-update add udev-trigger sysinit
RUN rc-update add udev-settle sysinit
RUN rc-update add udev-postmount default

# Probably not needed, but just in case.
WORKDIR /

# Download the Paper jar
RUN wget -O paper.jar https://papermc.io/api/v2/projects/paper/versions/${MINECRAFT_VER}/builds/${PAPER_BUILD}/downloads/paper-${MINECRAFT_VER}-${PAPER_BUILD}.jar

# Copy all the files into the container
# NOTE: This is down here b/c the scripts are often updated.
COPY ./* .

# Add dependencies for the backup script
RUN pip3 install -r /requirements.txt --break-system-packages

# Run it!
CMD ["sh", "/start.sh"]

