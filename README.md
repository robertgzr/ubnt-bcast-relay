# [Multicast, Sonos, Phorus & Play-Fi Broadcast 255.255.255.255:<port> Discovery Solution](https://community.ubnt.com/t5/EdgeMAX/Multicast-Sonos-Phorus-amp-Play-Fi-Broadcast-255-255-255-255-lt/td-p/1259616)

## Licenses

* GNU General Public License, version 3
* GNU Lesser General Public License, version 3

## Features

* [UDP Packet Broadcast Relay](http://www.joachim-breitner.de/udp-broadcast-relay/) compiled for EdgeMAX MIPS64
* Integrated with EdgeOS CLI
* Can also be configured from the EdgeOS Web GUI
* Lightweight, very low overhead for home based networks

### This solution is designed to work on EdgeMAX routers. It has been tested up to EdgeOS v1.10.x

So, like many folk who like to segregate our SOHO home networks with VLANs, subnets, etc., I was frustrated at not being able to use iOS apps, Windows drivers etc. to find and use (in my case) a Play-Fi LAN streaming speaker system on my logical networks.

First, I was able to use IGMP-PROXY for the standard broadcast protocols across my VLANs, however, although systems (NAS, Printers, etc.) were happily broadcasting, the Phorus/Play-Fi 255.255.255.255:10102 broadcasts weren't reflected across the VLANs, which is actually a good thing in general, but not for my use case.

Here is my LAN equipment configuration:

ERL3 -> ToughSwitch 8-Pro (root switch) -> Cisco SG 200-08

Definitive Technology W9 WiFi/Wired speaker is on my home user network VLAN 5 and is located in my den

Office network is VLAN 6

In order to have devices on VLAN 6 discover and use the W9 on VLAN 5, I needed to rebroadcast 255.255.255.255 on port 10102. I accomplished this, by downloading and compiling [Joachim Breitner's brilliant udp-broadcast-relay](http://www.joachim-breitner.de/udp-broadcast-relay/) on my ERL3 and then integrating it into the CLI configuration.

YMMV and of course, there is always a risk using any non Ubiquiti approved/test software, but for those of us stuck with equipment that forces a home user paradigm on our networking, this may be the antidote.

## Installation

* upload install_ubnt_bcast_relay.v1.1 to your router

        curl -Lo /tmp/install_ubnt_bcast_relay.v1.1.tgz https://github.com/britannic/ubnt-bcast-relay/raw/master/ubnt_bcast_relay.1.1.setup.tgz
        cd /tmp
        sudo tar zxvf ./install_ubnt_bcast_relay.v1.1.tgz
        sudo bash ./install_ubnt_bcast_relay.v1.1
        select menu option #1 if installing for the first time
        select menu option #2 to completely remove ubnt_bcast_relay

## Removal

## Configuration

### Setup initial configuration

Using the network description above, here is a working example:

Run configure:

    set service bcast-relay id 1 description 'Play-Fi listener'
    set service bcast-relay id 1 interface eth0.5
    set service bcast-relay id 1 interface eth0.6
    set service bcast-relay id 1 port 10102
    commit
    save
    exit


This generates a configuration stanza like this:

    service {
        bcast-relay {
            id 1 {
                description "Play-Fi listener"
                interface eth0.5
                interface eth0.6
                port 10102
            }
        }
    }

### Remove configuration

Run configure
    delete service bcast-relay
    commit
    save
    exit

#### To clone UBNT Broadcast Relay:

    git clone https://github.com/britannic/ubnt-bcast-relay.git
