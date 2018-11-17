#!/sbin/sh
#set -e

Trigger=$1

# Detect whether in boot mode
ps | grep zygote | grep -v grep >/dev/null && BOOTMODE=true || BOOTMODE=false
$BOOTMODE || ps -A 2>/dev/null | grep zygote | grep -v grep >/dev/null && BOOTMODE=true
$BOOTMODE || id | grep -q 'uid=0' || BOOTMODE=true

# Add Magisk busybox to PATH
$BOOTMODE && export PATH="/sbin/.core/busybox:/dev/magisk/bin:$PATH"

# Default permissions
umask 022

#$MODID=opoverlay;

##########################################################################################
# Functions
##########################################################################################

ui_prints() {
  $BOOTMODE && echo -e "$1" || echo -e "ui_print $1\nui_print" >> /proc/self/fd/$OUTFD
}

grep_prop() {
  REGEX="s/^$1=//p"
  shift
  FILES=$@
  [ -z "$FILES" ] && FILES='/system/build.prop'
  sed -n "$REGEX" $FILES 2>/dev/null | head -n 1
}

is_mounted() { mountpoint -q "$1"; }

mount_image() {
  ui_print "- Mounting $1 to $2"
  [ -d "$2" ] || mkdir -p "$2"
  if (! is_mounted $2); then
    LOOPDEVICE=
    for LOOP in 0 1 2 3 4 5 6 7; do
      if (! is_mounted $2); then
        LOOPDEVICE=/dev/block/loop$LOOP
        [ -f "$LOOPDEVICE" ] || mknod $LOOPDEVICE b 7 $LOOP 2>/dev/null
        losetup $LOOPDEVICE $1
        if [ "$?" -eq "0" ]; then
          mount -t ext4 -o loop $LOOPDEVICE $2
		  is_mounted $2 || /system/bin/toolbox mount -t ext4 -o loop $LOOPDEVICE $2
          is_mounted $2 || /system/bin/toybox mount -t ext4 -o loop $LOOPDEVICE $2
        fi
        is_mounted $2 && break
      fi
    done
  fi
}

set_perm() {
  chown $2:$3 "$1" || exit 1
  chmod $4 "$1" || exit 1
  [ -z "$5" ] && chcon 'u:object_r:system_file:s0' "$1" || chcon $5 "$1"
}

set_perm_recursive() {
  find "$1" -type d 2>/dev/null | while read dir; do
	set_perm "$dir" $2 $3 $4 $6
  done
  find "$1" -type f -o -type l 2>/dev/null | while read file; do
	set_perm "$file" $2 $3 $5 $6
  done
}

mktouch() {
  mkdir -p ${1%/*} 2>/dev/null
  [ -z "$2" ] && touch "$1" || echo "$2" > "$1"
  chmod 644 $1
}

request_size_check() {
  reqSizeM=`du -s $1 | cut -f1`
  reqSizeM=$((reqSizeM / 1024 + 1))
}

request_zip_size_check() {
  reqSizeM=`unzip -l "$1" | tail -n 1 | awk '{ print int($1 / 1048567 + 1) }'`
}

image_size_check() {
  e2fsck -yf $1 >&2
  curBlocks=`e2fsck -n $1 2>/dev/null | grep $1 | cut -d, -f3 | cut -d\  -f2`;
  curUsedM=`echo "$curBlocks" | cut -d/ -f1`
  curSizeM=`echo "$curBlocks" | cut -d/ -f1`
  curFreeM=$(((curSizeM - curUsedM) * 4 / 1024))
  curUsedM=$((curUsedM * 4 / 1024 + 1))
  curSizeM=$((curSizeM * 4 / 1024))
}

##########################################################################################
# Flashable update-binary preparation
##########################################################################################

OUTFD=$2
ZIP="$3"

readlink /proc/$$/fd/$OUTFD 2>/dev/null | grep /tmp >/dev/null
if [ "$?" -eq "0" ]; then
  OUTFD=0

  for FD in `ls /proc/$$/fd`; do
	readlink /proc/$$/fd/$FD 2>/dev/null | grep pipe >/dev/null
	if [ "$?" -eq "0" ]; then
	  ps | grep " 3 $FD " | grep -v grep >/dev/null
	  if [ "$?" -eq "0" ]; then
		OUTFD=$FD
		break
	  fi
	fi
  done
fi

# This path should work in any cases
TMPDIR=/dev/tmp

INSTALLER=$TMPDIR/install
MOUNTPATH=$TMPDIR/magisk_img
$BOOTMODE && IMGNAME=magisk_merge.img || IMGNAME=magisk.img
[ -d /data/adb/magisk ] && IMG=/data/adb/$IMGNAME || IMG=/data/$IMGNAME

if [ ! -d /data/adb/magisk ] && [ ! -d /data/magisk ]; then
	ui_print " "
	ui_print "(!) No Magisk installation found or installed version is not supported"
	ui_print " "
	exit 1
fi

# Initial cleanup
rm -rf $TMPDIR 2>/dev/null
mkdir -p $INSTALLER 2>/dev/null



MODID="`grep_prop id $INSTALLER/module.prop`"
TMP_MODPATH=$MOUNTPATH/$MODID
MODPATH=$TMP_MODPATH
 

# Find MODPATH
if $BOOTMODE; then
	for loop_device in /dev/block/loop*; do
		if losetup $loop_device 2>/dev/null | grep -q '\(/data/.*magisk.img\)'; then
			for MountPoint in $(grep $loop_device /proc/mounts | awk '{print $2}' | grep -v '/system'); do
				if [ -d "$MountPoint/.core" ] || [ -d "$MountPoint/lost+found" ]; then
					MountPoint=$MountPoint
					MODPATH=$MountPoint/$MODID
					mkdir -p $MODPATH 2>/dev/null
					break 2
				fi
			done
		fi
	done

	if [ ! -d "$MountPoint" ]; then
	echo -e "(!) Magisk mount point not found"
	  exit 1
  fi

  if ! is_mounted $MountPoint; then
	ui_print "(!) Magisk is not activated!... abort"
	exit 1
  fi

fi

##########################################################################################
# Configs
##########################################################################################

# Set to true if you need to enable Magic Mount
# Most mods would like it to be enabled
AUTOMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=false

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=false

ModVersion="`grep_prop version $INSTALLER/module.prop`"

# List all directories you want to directly replace in the system
# Check the documentations for more info about how Magic Mount works, and why you need this

# This is an example
REPLACE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here, it will override the example above
# !DO NOT! remove this if you don't need to replace anything, leave it empty as it is now
REPLACE="
"

set_permissions() {
  # Only some special files require specific permissions
  # The default permissions should be good enough for most cases

  # Here are some examples for the set_perm functions:

  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm_recursive  $MODPATH/system/lib       0       0       0755            0644

  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm  $MODPATH/system/bin/app_process32   0       2000    0755         u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0       2000    0755         u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0       0       0644
	set_perm_recursive  $TMP_MODPATH  0  0  0755  0644
}

##########################################################################################
# Main
##########################################################################################

# Print mod name
print_modname

# Please leave this message in your flashable zip for credits :)
ui_print "******************************"
ui_print "Powered by Magisk (@topjohnwu)"
ui_print "******************************"

$BOOTMODE || ui_print "- Mounting partitions"
# mount -o ro /system 2>/dev/null
# mount -o ro /vendor 2>/dev/null
# mount /data 2>/dev/null
# mount /cache 2>/dev/null

# if [ ! -f '/system/build.prop' ]; then
#   ui_print "(!) Failed: /system could not be mounted!"
#   exit 1
# fi

# API=`grep_prop ro.build.version.sdk`
# ABI=`grep_prop ro.product.cpu.abi | cut -c-3`
# ABI2=`grep_prop ro.product.cpu.abi2 | cut -c-3`
# ABILONG=`grep_prop ro.product.cpu.abi`

# ARCH=arm
# IS64BIT=false
# if [ "$ABI" = "x86" ]; then ARCH=x86; fi;
# if [ "$ABI2" = "x86" ]; then ARCH=x86; fi;
# if [ "$ABILONG" = "arm64-v8a" ]; then ARCH=arm64; IS64BIT=true; fi;
# if [ "$ABILONG" = "x86_64" ]; then ARCH=x64; IS64BIT=true; fi;

# You can get the Android API version from $API, the CPU architecture from $ARCH
# Useful if you are creating Android version / platform dependent mods

if ! is_mounted /data; then
  IMG=/cache/$IMGNAME
  ui_print " "
  ui_print "***********************************"
  ui_print "*      !! Data unavailable !!     *"
  ui_print "* Magisk detection is impossible  *"
  ui_print "* Installation will still proceed *"
  ui_print "*  But please make sure you have  *"
  ui_print "*        Magisk installed!!       *"
  ui_print "***********************************"
  ui_print " "
fi

if [ "$Trigger" = "ini" ]; then
	request_size_check "/tmp/system";
	echo $reqSizeM
fi

if [ -f "$IMG" ]; then
  ui_print "- $IMG detected!"
  image_size_check $IMG
  if [ "$reqSizeM" -gt "$curFreeM" ]; then
	SIZE=$(((reqSizeM + curUsedM) / 32 * 32 + 64))
	ui_print "- Resizing $IMG to ${SIZE}M..."
	resize2fs $IMG ${SIZE}M >&2
  fi
else
  SIZE=$((reqSizeM / 32 * 32 + 64));
  ui_print "- Creating $IMG with size ${SIZE}M"
  make_ext4fs -l ${SIZE}M $IMG >&2
  image_size_check $IMG
fi

mount_image $IMG $MOUNTPATH
if ! is_mounted $MOUNTPATH; then
  ui_print "(!) $IMG mount failed... abort"
  exit 1
fi

##########################################################################################
# Module space
##########################################################################################

##########################################################################################


ui_print "- Setting permissions"
#set_permissions

$BOOTMODE || ui_print "- Unmounting partitions"

umount $MOUNTPATH
losetup -d $LOOPDEVICE
rmdir $MOUNTPATH


if [ "$Trigger" = "maint" ]; then	
	#Shrink the image if possible
	image_size_check $IMG
	NEWDATASIZE=$((curUsedM / 32 * 32 + 32))
	if [ "$curSizeM" -gt "$NEWDATASIZE" ]; then
	  ui_print "- Shrinking $IMG to ${NEWDATASIZE}M..."
	  resize2fs $IMG ${NEWDATASIZE}M >&2
	fi
fi

ui_print "- Done"
ui_print " "

exit 0
