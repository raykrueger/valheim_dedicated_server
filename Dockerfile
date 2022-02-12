FROM steamcmd/steamcmd

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L --silent -o /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v3.10.0/gomplate_linux-amd64 \
    && chmod +x /usr/local/bin/gomplate

RUN steamcmd +login anonymous +force_install_dir /data +app_update 896660 +quit
WORKDIR /data
COPY start_server.sh ./

RUN chmod +x start_server.sh

ENV ADMINLIST='' \
    ADMINFILE='/root/.config/unity3d/IronGate/Valheim/adminlist.txt'

EXPOSE 2456-2457/udp

ENTRYPOINT ["./start_server.sh" ]
