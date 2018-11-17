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
log_message="--> Fstrim Partitions "
echo $log_message | tee -a $opoverlay_script_logfile
}

opoverlay_log &
fstrim -v /cache;
fstrim -v /data;

