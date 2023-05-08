#!/usr/bin/env bash

# Integrates with the No-IP API to fetch the WAN IP address of this host and
# update the dynamic DNS entry.

wan=$(curl -s http://ip1.dynupdate.no-ip.com/)
hostname=${ddns_hostname}
url="http://dynupdate.no-ip.com/nic/update?hostname=$hostname&myip=$wan"
auth="${ddns_username}:${ddns_password}"

curl -s --user $auth $url