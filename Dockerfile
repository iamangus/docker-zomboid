FROM cm2network/steamcmd

RUN sudo mkdir /gameserver && \
    steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /gameserver +login anonymous +app_update 380870 validate +quit

# Set the current working directory
WORKDIR /gameserver

RUN chown -R 1000:1000 /gameserver/

RUN ls /gameserver/

RUN ls /gameserver/*

# Run as a non-root user by default
ENV PGID 1000
ENV PUID 1000

# Expose necessary ports
EXPOSE 8766/udp
EXPOSE 16261/udp

ENTRYPOINT [ "/bin/bash", "/gameserver/start-server.sh"]
