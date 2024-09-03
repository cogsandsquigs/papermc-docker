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
ARG PAPER_BUILD=57
ARG JAVA_VER=21

# Probably not needed, but just in case.
WORKDIR /

# Copy all the files into the container
COPY ./* ./

# Install required dependencies for MC, Paper, + plugins
RUN apk add --no-cache openrc eudev udev-init-scripts openjdk${JAVA_VER}-jre-headless wget libstdc++

# Startup udev
RUN rc-update add udev sysinit
RUN rc-update add udev-trigger sysinit
RUN rc-update add udev-settle sysinit
RUN rc-update add udev-postmount default

# Download the Paper jar
RUN wget -O paper.jar https://papermc.io/api/v2/projects/paper/versions/${MINECRAFT_VER}/builds/${PAPER_BUILD}/downloads/paper-${MINECRAFT_VER}-${PAPER_BUILD}.jar

# Set working location into the server world folder
WORKDIR /minecraft

# Run it!
CMD ["sh", "../start.sh"]
