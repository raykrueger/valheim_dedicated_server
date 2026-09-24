#!/usr/bin/env bash

export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

rando () {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1
}

if [ -z ${SERVER_NAME+x} ]; then
  SERVER_NAME="Valheim Dedicated Server by raykrueger"
fi

if [ -z ${SERVER_PASSWORD+x} ]; then
  SERVER_PASSWORD=$( rando )
fi

echo "Updating game server"
steamcmd +force_install_dir /data +login anonymous +app_update 896660 +quit

echo "Starting server PRESS CTRL-C to exit"

printf "\n\nServer name is \"$SERVER_NAME\"\n"
printf "Server password is $SERVER_PASSWORD\n\n"

mkdir -p "$(dirname "$ADMINFILE")"
GOMPLATE_SUPPRESS_EMPTY=true gomplate -i '{{range (.Env.ADMINLIST | strings.Split ",")}}{{.}}{{print "\n"}}{{end}}' -o $ADMINFILE

# NOTE: Per Iron Gate's official guide, Valheim uses the -port value AND
# port+1, both over UDP. With -port 2456: players connect on 2456 (game
# traffic) and 2457 is used for the Steam server list/query. Forward both.
exec ./valheim_server.x86_64 -name $SERVER_NAME -port 2456 -world "Dedicated" -password $SERVER_PASSWORD -public 1
