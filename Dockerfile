FROM steamcmd/steamcmd:centos

RUN yum -y install curl wget tar bzip2 gzip unzip python3 binutils bc jq tmux glibc.i686 libstdc++ libstdc++.i686

RUN mkdir /gameserver && \
    steamcmd +@sSteamCmdForcePlatformType linux +login anonymous +force_install_dir /gameserver +app_update 380870 validate +quit

# Symlink log file to stdout
#RUN ln -sf /proc/1/fd/1 /tmp/valheim_log.txt

# Set the current working directory
WORKDIR /gameserver

RUN chown -R 1000:1000 /gameserver/

# Run as a non-root user by default
ENV PGID 1000
ENV PUID 1000

# Expose necessary ports
EXPOSE 8766/udp
EXPOSE 16261/udp

#CMD [ "bash", "./valheim_server.x86_64 -name "TestingServer" -port 2456 -nographics -batchmode -world "TestingWorld" -password "testtest" -public 1"]
#ENTRYPOINT ["./valheim_server.x86_64","-name","TestingServer","-port","2456","-nographics","-batchmode","-world","TestingWorld","-password","testtest","-public","1"]
ENTRYPOINT [ "/bin/bash", "/gameserver/steam/steamapps/common/Project\ Zomboid\ Dedicated\ Server\/start-server.sh"]
