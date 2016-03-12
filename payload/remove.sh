#!/bin/bash

# This script uninstalls the udp-bcast-relay

# You must be root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

progname='udp-bcast-relay'
target='/config/scripts'

echo "Stopping ubnt-bcast-relay service"
${target}/ubnt-bcast-relay.pl --stop

# Delete files
echo "Removing udp-bcast-relay from /opt/vyatta/sbin/"
rm /opt/vyatta/sbin/udp-bcast-relay
echo "Removing udp-bcast-relay.pl from ${target}/ubnt-bcast-relay.pl"
rm ${target}/ubnt-bcast-relay.pl
echo "Removing ubnt-bcast-relay templates from ${basedir}/templates-cfg/service/"
rm -rf /opt/vyatta/share/vyatta-cfg/templates/service/bcast-relay

# Finished
echo "Uninstall of $progname complete."

