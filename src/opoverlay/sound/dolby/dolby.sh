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
log_message="--> Initiated Dolby Atmos"
echo $log_message | tee -a $opoverlay_script_logfile
}

MODDIR=${0%/*}
setenforce 0
SUPOLICY='supolicy --live'
$SUPOLICY "permissive audio_prop audioserver dolby_prop mediaserver priv_app"
$SUPOLICY "allow audioserver audioserver_tmpfs file *"
$SUPOLICY "allow mediaserver mediaserver_tmpfs file *"
$SUPOLICY "allow priv_app init unix_stream_socket *"
$SUPOLICY "allow priv_app property_socket sock_file *"
opoverlay_log &

exit 0
