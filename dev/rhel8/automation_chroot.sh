#!/bin/bash
#
# Name.......: Chroot automation
# Create.....: Alan da Silva Alves
# Create at..: 03/25/2023
# Description: Create or Enable chroot
# Version....: 0.4
#
#
################################################################################
# Definition of variables
################################################################################

HELP="

 Help of use of automation chroot overlay
	
 	You need to be logged in as the root user to perform operations.

 	create or -c 	for create NEW croot environment
 	enable or -e 	for loader chroot already existing
 	install or -i 	for install new packages on chroot already existing
	show or -s	for show mount overlay of chroot 

	Example:

	- create NEW croot environment:
	# automation_chroot_overlay NAME_YOUR_CHROOT create

	- loader chroot already existing:
	# automation_chroot_overlay NAME_YOUR_CHROOT_ALREADY_EXISTING enable

	- install packages on chroot already existing:
	# automation_chroot_overlay NAME_YOUR_CHROOT_ALREADY_EXISTING install
	# Which packages do you want to install in the chroot NAME_YOUR_CHROOT_ALREADY_EXISTING? write list packages  (Ex. ypbind rpcbind oddjob-mkhomedir autofs sudo ksh zsh httpd)

	- show chroot already existing:
	# automation_chroot_overlay NAME_YOUR_CHROOT_ALREADY_EXISTING show

"

name_chroot=${1}
action_chroot=${2}
account_system_maps="your_account_system_maps"
path_tools_of_teams="root/tools/teams"

################################################################################
# Definition of functions
################################################################################


function install_pkg_chroot() {
	read -p "Which packages do you want to install in the chroot ${name_chroot}? " packages
	yum --releasever=/ --installroot=/${name_chroot} install -y $packages
}

function create_chroot() {
	mkdir -vp ${PWD}/{workdir,merged_etc}
	install_pkg_chroot
	mkdir -vp /${name_chroot}/dev/pts
	mkdir -vp /${name_chroot}/home/${account_system_maps}
	mkdir -vp /${name_chroot}/${path_tools_of_teams}
}

function mount_chroot() {
	mount -v -t proc proc /${name_chroot}/proc/
	mount -v -t sysfs sys /${name_chroot}/sys/
	mount -v -o bind /dev/pts /${name_chroot}/dev/pts
	mount -v -o bind /dev/null /${name_chroot}/dev/null
	mount -v -o bind /home/${account_system_maps} /${name_chroot}/home/${account_system_maps}
	mount -v -o bind /${path_tools_of_teams} /${name_chroot}/${path_tools_of_teams}
}

function mount_overlay() {
	t_overlay=$(mount -v -t overlay overlay -olowerdir=etc_template,upperdir=/etc/rw_src,workdir=workdir merged_etc)
	mount -v -o bind ${PWD}/merged_etc /${name_chroot}/etc
}

function show_overlay() {
	echo ":::"
	df -hT |head -1; df -hT | grep overlay
	echo ":::"
}


################################################################################
# Main execution
################################################################################

clear

echo ":::"
echo ":::"

if [[ ${action_chroot} == "create" ]] || [[ ${action_chroot} == "-c" ]]; then
	create_chroot
	mount_chroot
	mount_overlay
	show_overlay
elif [[ ${action_chroot} == "enable" ]] || [[ ${action_chroot} == "-e" ]] ; then
	mount_chroot
	mount_overlay
	show_overlay
elif [[ ${action_chroot} == "install" ]] || [[ ${action_chroot} == "-i" ]] ; then
	install_pkg_chroot
elif [[ ${action_chroot} == "show" ]] || [[ ${action_chroot} == "-s" ]] ; then
	show_overlay
else
	echo "${HELP}"
fi

echo ":::"
echo ":::"
