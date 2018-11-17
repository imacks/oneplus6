#!/sbin/sh
#set -e

safe_mount() {
	IS_MOUNTED=$(cat /proc/mounts | grep "$1")
	if [ "$IS_MOUNTED" ]; then
  mount -o rw,remount $1
 else
  mount $1
	fi
}

safe_mount /data

sed -i "s|ForceDecryption = 1|ForceDecryption = 0|g" /tmp/aroma-data/saved.profile


