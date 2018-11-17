#!/sbin/sh

zipname=$1

safe_mount() {
	IS_MOUNTED=$(cat /proc/mounts | grep "$1")
	if [ "$IS_MOUNTED" ]; then
  mount -o rw,remount $1
 else
  mount $1
	fi
}

set_perm() {
  uid=$1; gid=$2; mod=$3;
  shift 3;
  chown $uid.$gid $*; chown $uid:$gid $*;
  chmod $mod $*;
}

set_perm_recursive() {
  uid=$1; gid=$2; dmod=$3; fmod=$4;
  shift 4;
  until [ ! "$1" ]; do
    chown -R $uid.$gid $1; chown -R $uid:$gid $1;
    find "$1" -type d -exec chmod $dmod {} +;
    find "$1" -type f -exec chmod $fmod {} +;
    shift;
  done;
}

safe_mount /data
/tmp/7za e -y '/sdcard/opoverlay/'$zipname 'opoverlay/misc/*' -o'/tmp/'
set_perm_recursive 0 0 0755 0755 "/tmp";
/tmp/7za x -y /tmp/res '*' -o'/tmp/'

exit 0
