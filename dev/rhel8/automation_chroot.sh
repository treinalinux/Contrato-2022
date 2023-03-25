#!/bin/bash
#
# Name.......: Chroot automation
# Create.....: Alan da Silva Alves
# Create at..: 03/25/2023
# Description: Create or Enable chroot
#
################################################################################
################################################################################

name_chroot=${1}
action_chroot=${2}

################################################################################
################################################################################

function create_chroot() {
	mkdir -vp ${PWD}/{workdir,merged_etc}
	create_chroot=$(yum --releasever=/ --installroot=/${name_chroot} install autofs sudo ksh zsh httpd -y)
}

# mount important
function mount_chroot() {
	mount -v -t proc proc /${name_chroot}/proc/
	mount -v -t sysfs sys /${name_chroot}/sys/
	mount -v -o bind /dev/null /${name_chroot}/dev/null
}

# layer for write chroot
function mount_overlay() {
	t_overlay=$(mount -v -t overlay overlay -olowerdir=etc_template,upperdir=/etc/rw_layer_src,workdir=workdir merged_etc)
	mount -v -o bind ${PWD}/merged_etc /${name_chroot}/etc
}

################################################################################
################################################################################

clear

echo ":::"
echo ":::"
echo ":::"

# create or start chroot already exists
if [[ ${action_chroot} == "criar" ]]; then
	create_chroot
	mount_chroot
	mount_overlay
elif [[ ${action_chroot} == "iniciar" ]]; then
	mount_chroot
	mount_overlay
else
	echo -e "Você precisar informar o nome do chroot e a ação que deseja executar:\n'-> criar'\n'-> iniciar'"
fi

echo ":::"
echo ":::"
echo ":::"
