# raykrueger/valheim

A Valheim dedicated server in a container — up and running in one command.

Run a persistent Valheim world on your own hardware without wrestling with
SteamCMD, libraries, or restart scripts. This image (running game version
0.214.2) installs the server at build time, updates it from Steam at every
start, and handles server naming, password, and admin list for you.

```
docker run -d -p 2456:2456/udp -p 2457:2457/udp -v valheim_world:/root/.config/unity3d/IronGate/Valheim raykrueger/valheim
```

## Ports

The server uses two UDP ports (per Iron Gate's official guide): `2456` for
game traffic and `2457` (port + 1) for the Steam server list/query. Forward
both, or your server will accept players but never appear in the server list.

## Configuration

All configuration is done with environment variables at run time.

| Variable | Default | Purpose |
|----------|---------|---------|
| `SERVER_NAME` | `Valheim Dedicated Server by raykrueger` | Name shown in the server list |
| `SERVER_PASSWORD` | random 8-character string | Join password |
| `ADMINLIST` | empty | Comma-separated Steam IDs with admin privileges |

If you don't set `SERVER_PASSWORD`, one is generated at startup and printed
to the container logs (`docker logs <container>`).

```
docker run -d -p 2456:2456/udp -p 2457:2457/udp -v valheim_world:/root/.config/unity3d/IronGate/Valheim -e SERVER_NAME="My Valheim Server" -e SERVER_PASSWORD=BooshBooshBoosh -e ADMINLIST=1234,5678 raykrueger/valheim
```

## Persistence

World saves, `adminlist.txt`, and friends are written to
`/root/.config/unity3d/IronGate/Valheim` inside the container. Mount a
volume there to keep them across container starts and stops:

```
-v valheim_world:/root/.config/unity3d/IronGate/Valheim
```

If you pass a name (like `valheim_world`), Docker stores the volume where it
stores all volumes (usually `/var/lib/docker/volumes`). If you pass a
fully-qualified path, Docker mounts that path directly.

## Building

To build the image locally:

```
docker build -t valheim .
docker run -d -p 2456:2456/udp -p 2457:2457/udp -v valheim_world:/root/.config/unity3d/IronGate/Valheim valheim
```

A `Makefile` with `build`, `run`, and `shell` targets is included for local
development.

## Running on AWS

If you'd rather not run this on your own hardware, the
[@raykrueger/cdk-valheim-server](https://github.com/raykrueger/cdk-valheim-server)
AWS Cloud Development Kit library builds an Amazon ECS cluster that runs
this container on AWS Fargate. Note that AWS costs apply — this is not free.

## I was here

Note that I built this in my free time. This has nothing to do with Iron
Gate AB, Coffee Stain Publishing, or my employer.

Enjoy!
-Ray

## License

[Apache License 2.0](LICENSE)
