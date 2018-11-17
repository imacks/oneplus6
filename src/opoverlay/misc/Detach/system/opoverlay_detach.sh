#!/system/bin/sh
#set -e

opoverlay_detaching()
{
if [ -e /system/etc/opoverlay/detach.sh ]; then
	sleep 20
	#pm enable 'com.android.vending/com.google.android.finsky.hygiene.DailyHygiene$DailyHygieneService'
	#pm disable 'com.android.vending/com.google.android.finsky.hygiene.DailyHygiene$DailyHygieneService'
	echo "-----------------------------------------"
	echo "-> Stopped Play Store Update Services and detached modded apps from Play Store"
	echo "-----------------------------------------"
fi
}

opoverlay_log()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done
sleep 10
log_folder="/sdcard/opoverlay/logs/"
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
log_message="--> Stopped Play Store Update Service" 
echo $log_message | tee -a $opoverlay_script_logfile
log_message="--> Detached modded apps "
echo $log_message | tee -a $opoverlay_script_logfile
}

opoverlay_log &
opoverlay_detaching &
exit 0

