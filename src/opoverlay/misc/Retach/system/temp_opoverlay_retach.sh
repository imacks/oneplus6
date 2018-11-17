#!system/bin/sh
#set -e

safe_mount() {
	IS_MOUNTED=$(cat /proc/mounts | grep "$1")
	if [ "$IS_MOUNTED" ]; then
  mount -o rw,remount $1
 else
  mount $1
	fi
}

disable_retach()
{
ECHO "Enable DailyHygiene Service" 
sleep 30
pm enable 'com.android.vending/com.google.android.finsky.hygiene.DailyHygiene$DailyHygieneService'
sleep 5
safe_mount /vendor
find /data/opoverlay -name '*temp_opoverlay_retach*' -print0 | xargs -0 rm -f
}

opoverlay_log()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done
sleep 10
log_folder="/sdcard/opoverlay/logs/"
log_message="--> Re-Activated Play Store Update Service at " 
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
echo $log_message `date "+%Y-%m-%d %H:%M:%S"` | tee -a $opoverlay_script_logfile
opoverlay_script_logfile=$log_folder"opoverlay_unregular.log"
echo $log_message `date "+%Y-%m-%d %H:%M:%S"` | tee -a $opoverlay_script_logfile
}

opoverlay_log &
disable_retach &
sync
exit 0

