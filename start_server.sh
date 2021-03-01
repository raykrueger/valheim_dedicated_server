export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

rando () {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1
}

if [ -z ${SERVER_NAME+x} ]; then
  SERVER_NAME="Valheim Dedicated Server by raykrueger"
fi

if [ -z ${SERVER_PASSWORD+x}]; then
  SERVER_PASSWORD=$( rando )
fi

echo "Updating game server"
steamcmd +login anonymous +force_install_dir /data +app_update 896660 +quit

echo "Starting server PRESS CTRL-C to exit"

printf "\n\nServer name is \"$SERVER_NAME\"\n"
printf "Server password is $SERVER_PASSWORD\n\n"

# NOTE: The -port argument is a lie. The game will be listening on port+1
# If -port is 2456, the game will be listening on 2457.
./valheim_server.x86_64 -name $SERVER_NAME -port 2456 -world "Dedicated" -password $SERVER_PASSWORD -public 1
