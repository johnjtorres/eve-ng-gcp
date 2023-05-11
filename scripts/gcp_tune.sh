#!/bin/sh

cd /sys/class/net/
for i in ens*; do echo 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="'$(cat $i/address)'", ATTR{type}=="1", KERNEL=="ens*", NAME="'$i'"'; done >/etc/udev/rules.d/70-persistent-net.rules
sed -i -e 's/NAME="ens.*/NAME="eth0"/' /etc/udev/rules.d/70-persistent-net.rules
sed -i -e 's/ens4/eth0/' /etc/netplan/50-cloud-init.yaml
apt-mark hold linux-image-gcp
mv /boot/vmlinuz-*gcp /root
update-grub2

sed -i -e 's/#\?DNS=.*/#DNS=/' /etc/systemd/resolved.conf
sed -i -e 's/#\?FallbackDNS=.*/#FallbackDNS=/' /etc/systemd/resolved.conf
cat > /etc/network/interfaces << EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
iface eth0 inet manual
auto pnet0
iface pnet0 inet dhcp
    pre-up ip link set dev eth0 up
    bridge_ports eth0
    bridge_stp off

# Cloud devices
iface eth1 inet manual
auto pnet1
iface pnet1 inet manual
    bridge_ports eth1
    bridge_stp off

iface eth2 inet manual
auto pnet2
iface pnet2 inet manual
    bridge_ports eth2
    bridge_stp off

iface eth3 inet manual
auto pnet3
iface pnet3 inet manual
    bridge_ports eth3
    bridge_stp off

iface eth4 inet manual
auto pnet4
iface pnet4 inet manual
    bridge_ports eth4
    bridge_stp off

iface eth5 inet manual
auto pnet5
iface pnet5 inet manual
    bridge_ports eth5
    bridge_stp off

iface eth6 inet manual
auto pnet6
iface pnet6 inet manual
    bridge_ports eth6
    bridge_stp off

iface eth7 inet manual
auto pnet7
iface pnet7 inet manual
    bridge_ports eth7
    bridge_stp off

iface eth8 inet manual
auto pnet8
iface pnet8 inet manual
    bridge_ports eth8
    bridge_stp off

iface eth9 inet manual
auto pnet9
iface pnet9 inet manual
    bridge_ports eth9
    bridge_stp off
EOF

# remove netplan config if needed
rm -f /etc/netplan/* || true

#tune GCP network start
sed -i -e 's/.*CONFIGURE_INTERFACES=.*/CONFIGURE_INTERFACES=no/' /etc/default/networking

# Cleaning
rm -rf /etc/ssh/ssh_host_* /root/.Xauthority /root/.ssh /root/.bash_history /tmp/ssh* /tmp/netio* /tmp/vmware* /opt/ovf/ovf_vars /opt/ovf/ovf.xml /root/.bash_history /root/.cache
find /var/log -type f -exec rm -f {} \;
find /var/lib/apt/lists -type f -exec rm -f {} \;
find /opt/unetlab/data/Logs -type f -exec rm -f {} \;
touch /var/log/wtmp
chown root:utmp /var/log/wtmp
chmod 664 /var/log/wtmp
apt-get clean
dpkg-reconfigure openssh-server

# set mysql TZ to UTC
echo "SET GLOBAL time_zone = '+00:00' ;" | mysql -u root --password=eve-ng mysql