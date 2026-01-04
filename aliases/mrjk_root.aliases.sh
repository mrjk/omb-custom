
if [ $(id -u) = 0 ]; then

	alias vih='vim /etc/hosts '
	alias vit='vim /etc/fstab '


	chroot_mount_system () {
		if [ -d $1 ]; then
			mount -t proc none $1/proc
			mount -obind /dev $1/dev
			mount -obind /sys $1/sys
			echo "Then: chroot $1 /bin/bash "
		else
			echo "Usage: chroot_mount_system <dir>"
		fi
	}

	alias iptlist='/sbin/iptables -L -n -v --line-numbers'
	alias iptlistin='/sbin/iptables -L INPUT -n -v --line-numbers'
	alias iptlistout='/sbin/iptables -L OUTPUT -n -v --line-numbers'
	alias iptlistfw='/sbin/iptables -L FORWARD -n -v --line-numbers'


fi
