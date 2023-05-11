#!/bin/sh
iptables-save -c > /etc/iptables.rules
if [ -f /etc/iptables.rules ]; then
    iptables-restore < /etc/iptables.rules
fi
exit 0