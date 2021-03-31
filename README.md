# raykrueger/valheim

A dedicated Valheim game server running in a container.

## Summary

A very basic Valheim server, running 0.148.7.

```
docker run -d -p 2456:2456/udp -v valheim_world:/root/.config/unity3d/IronGate/Valheim raykrueger/valheim
```

## Server name and password

If you do not customize the server name and password at startup a password
will be randomly generated at startup. The name is hardcoded, you'll want to
change that.

```
Server name is "Valheim Dedicated Server by raykrueger"
Server password is (random gibberish here)
```

You can set environment variables, at run time, to change the server name and
password.

```
docker run -d -p 2456:2456/udp -v valheim_world:/root/.config/unity3d/IronGate/Valheim -e SERVER_NAME="My Valheim Server" -e SERVER_PASSWORD=BooshBooshBoosh raykrueger/valheim
```

## Persistence

The Valheim world save files are written to this path inside the container
`/root/.config/unity3d/IronGate/Valheim`. In order to persist those files
between container starts and stops, it is best to store them in a separate
volume. That is done using `docker run -v`. If a /fully/qualified/path is
given Docker will mount that point inside the container. If only a name is
given, as is in our example, Docker will store that where it stores all
volumes (usually /var/lib/docker/volumes).

## Building

If you'd like to build this container and run it locally...

```
docker build -t valheim .
docker run -d -p 2456:2456/udp -v valheim_world:/root/.config/unity3d/IronGate/Valheim valheim
```

Note that you can leave the raykrueger part out, because you're not me, and you're local names don't matter.

## Running on AWS

If you're interested in running this container on AWS, I have also built an
AWS Cloud Development Kit library that will help. The
[@raykrueger/cdk-valheim-server](https://github.com/raykrueger/cdk-valheim-server)
library will build an Amazon ECS cluster that runs this container on AWS
Fargate. Note that AWS costs will apply, this will not run for free.

## I was here

Note that I built this in my free time. This has nothing to do with Iron Gate AB, Coffee Stain Publishing, or my employer.

Enjoy!
-Ray
