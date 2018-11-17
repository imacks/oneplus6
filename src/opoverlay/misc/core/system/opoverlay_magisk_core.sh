#!/system/bin/sh
#set -e

opoverlay_log()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done
sleep 10
log_folder="/sdcard/opoverlay/logs/"
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
log_message="--> Check Magisk folder structure "
echo $log_message | tee -a $opoverlay_script_logfile
}

opoverlay_log &

Dest=/magisk/.core/
sfile=hidelist

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

opoverlay_magisk_core_Recovery()
{
	mkdir -p $Dest
	mkdir -p $Dest'post-fs-data.d/'
	mkdir -p $Dest'props/'
	mkdir -p $Dest'service.d/'
	touch $Dest$sfile
	echo 'com.google.android.gms.unstable' >> $Dest$sfile
	set_perm_recursive 0 0 0755 0755 $Dest;
	set_perm 0 0 0666 $Dest$sfile;
}

if [ -e ./init.magisk.rc ]; then
	Dest=/magisk/.core/
	if [ ! -e $Dest$sfile ]; then
		opoverlay_magisk_core_Recovery &
	fi
fi

if [ -d /sbin/.core ]; then
	Dest=/sbin/.core/img/.core/
	if [ ! -e $Dest$sfile ]; then
		opoverlay_magisk_core_Recovery &
	fi
fi

sync
exit 0


