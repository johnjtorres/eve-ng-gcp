#!/bin/sh

gcp_tune() {
	cd /sys/class/net/
	for i in ens*; do echo 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="'$(cat $i/address)'", ATTR{type}=="1", KERNEL=="ens*", NAME="'$i'"'; done >/etc/udev/rules.d/70-persistent-net.rules
	sed -i -e 's/NAME="ens.*/NAME="eth0"/' /etc/udev/rules.d/70-persistent-net.rules
	sed -i -e 's/ens4/eth0/' /etc/netplan/50-cloud-init.yaml
	apt-mark hold linux-image-gcp
	mv /boot/vmlinuz-*gcp /root
	update-grub2
}

# GCP
dmidecode -t bios | grep -q Google && gcp_tune
