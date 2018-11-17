#!/system/bin/sh
#set -e

safe_mount() {
	IS_MOUNTED=$(cat /proc/mounts | grep "$1")
	if [ "$IS_MOUNTED" ]; then
  mount -o rw,remount $1
 else
  mount $1
	fi
}

TempDir=/data/opoverlay

Apps2Data()
{
sleep 5
safe_mount /data
ECHO "Install-Deinstall Apps"
ECHO "Deinstall Apps"
sleep 30
safe_mount /data
find /data/opoverlay -name '*temp_opoverlay_apps2data*' -print0 | xargs -0 rm -f
sleep 30
rm -rf $TempDir
log_folder="/sdcard/opoverlay/logs/"
log_message="--> Installed User Apps " 
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
echo $log_message | tee -a $opoverlay_script_logfile
opoverlay_script_logfile=$log_folder"opoverlay_unregular.log"
echo $log_message `date "+%Y-%m-%d %H:%M:%S"` | tee -a $opoverlay_script_logfile
}

Apps2Data &
sync
exit 0

