.PHONY: build run

build:
	docker build -t raykrueger/valheim .

run: build
	docker run --rm -it -e ADMINLIST='1111,2222,3333' -p 2456:2456/udp -p 2457:2457/udp raykrueger/valheim

shell: build
	docker run --rm -it -e ADMINLIST='1111,2222,3333' --entrypoint /bin/bash raykrueger/valheim
