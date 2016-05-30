#!/bin/bash
set -e

# Initial Setup
export DEBIAN_FRONTEND=noninteractive

netcalc(){
	local IFS='.' ip i
	local -a oct msk

	read -ra oct <<<"$1"
	read -ra msk <<<"$2"

	for i in ${!oct[@]}; do
		ip+=( "$(( oct[i] & msk[i] ))" )
	done

	echo "${ip[*]}"
}


# Get hostname and network settings
export MYHOST=$(hostname)
export MYIP=$(ip add | grep 'global' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')
export MYNETSUBMASK=$(ifconfig | grep -w inet | grep -v 127.0.0.1 | awk '{print $4}' | cut -d ":" -f 2)
export MYCIDR=$(ip add | grep 'global' | grep -oE '\/[0-9]+' | cut -d/ -f 2)
export MYNETADDR=$(netcalc $myip $mynetsubmask)

# Set POSTFIX Vars Default values
#
# POSTFIX Configuration:
# 0 - No Configuration
# 1 - Internet Site
# 2 - Internet with smarthost
# 3 - Satellite system
# 4 - Local only
export POSTFIX_CONFIG=${POSTFIX_CONFIG:-"1"} # Set 'Internet Site' Postfix configuration as default

export POSTFIX_DOMAIN=${POSTFIX_DOMAIN:-"example.org"} # Default domain name

# System Admin account for 'postmaster', 'root', etc mail to be redirected to
export POSTFIX_ADMACCT=${POSTFIX_ADMACCT:-""}

# Accepted domains to distribute mail
export POSTFIX_ACCPTDOMAINS=${POSTFIX_ACCPTDOMAINS:-"localhost.localdomain, localhost"}

# Synced updates on mail queue?
export POSTFIX_SYNC=${POSTFIX_SYNC:-"0"}

# Relay networks
export POSTFIX_RELAYNETS=${POSTFIX_RELAYNETS:-"127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 $MYNETADDR/$MYCIDR"}

# Mailbox size limit (in bytes)
export POSTFIX_MAILBOXLIMIT=${POSTFIX_MAILBOXLIMIT:-"51200000"} # Default size

# Char to define local address extension.
export POSTFIX_LOCALEXTCHAR=${POSTFIX_LOCALEXTCHAR:-"+"}

# POSTFIX Enabled protocols:
# 0 - all
# 1 - IPV6
# 2 - IPV4
export POSTFIX_PROTOS=${POSTFIX_PROTOS:-"0"} # Set both protocols as default




if []; then

fi

if []; then
	if []; then

	fi

	exec gosu postfix "$@"

	echo
	echo 'Postfix init process complete; ready for start up.'
	echo

fi

exec "$@"
