#!/system/bin/sh

opoverlay_log()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done
sleep 10
log_folder="/sdcard/opoverlay/logs/"
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
log_message="--> granted app permissions"
echo $log_message | tee -a $opoverlay_script_logfile
}

grant_permissions()
{
ECHO "Set App Permissions"
sleep 5
safe_mount /data
find /data/opoverlay -name '*temp_opoverlay_perms*' -print0 | xargs -0 rm -f
}

grant_permissions &
opoverlay_log &
exit 0

