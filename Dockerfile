FROM steamcmd/steamcmd:centos

RUN yum -y install curl wget tar bzip2 gzip unzip python3 binutils bc jq tmux glibc.i686 libstdc++ libstdc++.i686 tree

RUN mkdir /gameserver && \
    steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /gameserver +login anonymous +app_update 380870 validate +quit

# Set the current working directory
WORKDIR /gameserver

RUN chown -R 1000:1000 /gameserver/

RUN tree /gameserver

# Run as a non-root user by default
ENV PGID 1000
ENV PUID 1000

# Expose necessary ports
EXPOSE 8766/udp
EXPOSE 16261/udp

ENTRYPOINT [ "/bin/bash", "/gameserver/steam/steamapps/common/Project\ Zomboid\ Dedicated\ Server\/start-server.sh"]
