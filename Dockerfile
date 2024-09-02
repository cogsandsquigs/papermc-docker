FROM ubuntu:24.04

# Arguments for the build.
ARG MINECRAFT_VER=1.21.1
ARG PAPER_BUILD=57
ARG JAVA_VER=21

# Setup folders 
WORKDIR /minecraft

# Copy the start script
COPY ./start.sh ./

# Install Java
RUN apt-get update
RUN apt-get install -y wget openjdk-${JAVA_VER}-jdk-headless

# Download the Paper jar
RUN wget -O paper.jar https://papermc.io/api/v2/projects/paper/versions/${MINECRAFT_VER}/builds/${PAPER_BUILD}/downloads/paper-${MINECRAFT_VER}-${PAPER_BUILD}.jar

# Set working location into the server world folder
WORKDIR /minecraft/server

# Run it!
CMD ["sh", "../start.sh"]
