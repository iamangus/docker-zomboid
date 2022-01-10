FROM cm2network/steamcmd

#sudo mkdir /gameserver && \

RUN /home/steam/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType linux +force_install_dir /home/steam/gameserver +login anonymous +app_update 380870 validate +quit

# Set the current working directory
#WORKDIR /gameserver

RUN chown -R 1000:1000 /home/steam/gameserver/

RUN ls /home/steam/gameserver/

RUN ls /home/steam/gameserver/*

# Run as a non-root user by default
ENV PGID 1000
ENV PUID 1000

# Expose necessary ports
EXPOSE 8766/udp
EXPOSE 16261/udp

ENTRYPOINT [ "/bin/bash", "/home/steam/gameserver/start-server.sh"]
