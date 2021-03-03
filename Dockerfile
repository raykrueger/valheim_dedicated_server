FROM steamcmd/steamcmd

RUN steamcmd +login anonymous +force_install_dir /data +app_update 896660 +quit
WORKDIR /data
COPY start_server.sh start_dedicated_server.sh
COPY adminlist.txt /root/.config/unity3d/IronGate/Valheim/adminlist.txt
EXPOSE 2456-2457/udp

ENTRYPOINT ["/bin/bash", "./start_dedicated_server.sh" ]
