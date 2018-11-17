#!/system/bin/sh
#set -e

Dest=/magisk/opoverlay/
mfile=module.prop
sfile=post-fs-data.sh

opoverlay_log()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done
sleep 6
log_folder="/sdcard/opoverlay/logs/"
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
log_message="--> Recover OPOverlay Essentials Magisk Module "
echo $log_message | tee -a $opoverlay_script_logfile
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

opoverlay_Essentials_Recovery()
{
	rm -rf $Dest
	mkdir -p $Dest
	touch $Dest$mfile
	echo 'id=mkoverlay' >> $Dest$mfile
	echo 'name=Overlay ROM Essentials' >> $Dest$mfile
	echo 'version=v2' >> $Dest$mfile
	echo 'versionCode=1' >> $Dest$mfile
	echo 'author=iMacks' >> $Dest$mfile
	echo 'description=This is an essential requirement when you are running the Overlay ROM' >> $Dest$mfile
	echo 'template=1400' >> $Dest$mfile
	echo '' >> $Dest$mfile
	touch $Dest$sfile
	echo '#!/system/system/bin/sh' >> $Dest$sfile
	echo 'MODDIR=${0%/*}' >> $Dest$sfile
	echo 'if grep "opoverlay_scripts" "./init.rc"' >> $Dest$sfile
	echo 'then' >> $Dest$sfile
	echo 'sleep 1' >> $Dest$sfile
	echo 'else' >> $Dest$sfile
	echo 'sh -x /system/etc/opoverlay/opoverlay.sh | tee -a >/dev/null;' >> $Dest$sfile
	echo 'fi' >> $Dest$sfile
	echo '' >> $Dest$sfile
	echo 'sync' >> $Dest$sfile
	echo 'exit 0' >> $Dest$sfile
	echo '' >> $Dest$sfile
	set_perm_recursive 0 0 0755 0755 $Dest;
}

opoverlay_script()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay.sh ]; then
	sh /system/etc/opoverlay/opoverlay.sh
fi
}


if [ -e ./init.magisk.rc ]; then
	Dest=/magisk/opoverlay/
	if [ ! -e $Dest$sfile ]; then
		opoverlay_log &
		opoverlay_Essentials_Recovery &
	fi
fi

if [ -d /sbin/.core ]; then
	Dest=/sbin/.core/img/opoverlay/
	if [ ! -e $Dest$sfile ]; then
		opoverlay_log &
		opoverlay_Essentials_Recovery &
	fi
fi

opoverlay_script &

sync
exit 0
