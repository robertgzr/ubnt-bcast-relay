VERSION := 2.0

DEVICE := ER-X
ifeq ($(DEVICE),ER-X)
TARGET := mipsel-linux-gnueabi
endif

all: ubnt-bcast-relay_$(DEVICE).tgz

# source/udp-bcast-relay/: 
# 	git clone https://github.com/nomeata/udp-broadcast-relay $@

source/udp-bcast-relay/udp-broadcast-relay: source/udp-bcast-relay/
	$(MAKE) -C source/udp-bcast-relay/ \
		clean \
		udp-broadcast-relay CC="zig cc -target $(TARGET)"

ubnt-bcast-relay/: source/udp-bcast-relay/udp-broadcast-relay
	cp -r payload $@
	cp -r source/udp-bcast-relay/udp-broadcast-relay $@/binaries/udp-bcast-relay
	printf '%s' $(VERSION) > $@/version

ubnt-bcast-relay_$(DEVICE).tgz: ubnt-bcast-relay/
	tar -cvzf $@ ubnt-bcast-relay/
	rm -rf ubnt-bcast-relay/
