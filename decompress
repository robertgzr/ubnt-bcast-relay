#!/bin/bash
echo
echo 'Self Extracting Installer'
echo
echo 'UBNT UDP Broadcast Relay'
echo

VERSION='1.0'

install_menu () {
	local IFS=' '
	local PS3='Enter option number and hit return => '
	local OPTIONS=('INSTALL' 'REMOVE' 'QUIT')
	shopt -s checkwinsize
	local COLUMNS=$(tput cols)

while true;
do
	echo -ne "Would you like to INSTALL, REMOVE or QUIT\n\n" | fold -s -w ${COLUMNS}
	select CHOICE in ${OPTIONS[@]}; do
		case ${REPLY} in
			1)		clear console
					sudo bash ./setup.sh
					return 1
					;;
			2)		clear console
					if /opt/vyatta/bin/yesno -n 'Do you want to completely remove UBNT UDP Broadcast Relay? [y/N]: '
					then
						sudo bash ./remove.sh
						break
					fi
					;;
			3|*)	return 0
					;;
		esac
	done
done
}

CDIR="$(pwd)"

# Make sure script runs as root
if [[ ${EUID} -ne 0 ]]; then
	echo "$0 must be run as sudo or root!"
	exit 1
fi

export TMPDIR=$(mktemp -d /tmp/selfextract.XXXXXX)

ARCHIVE=$(awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' $0)

tail -n+${ARCHIVE} $0 | tar xz -C "${TMPDIR}"

cd "${TMPDIR}"

install_menu

cd "${CDIR}"
rm -rf "${TMPDIR}"

exit 0

__ARCHIVE_BELOW__
