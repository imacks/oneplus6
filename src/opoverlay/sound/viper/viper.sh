#!/system/bin/sh
MODPATH=${0%/*}
SEINJECT=magiskpolicy
MAGISK=true
ROOT=""
SYS=/system
VEN=/system/vendor
LIBDIR=/system/vendor
MODID=ViPER4AndroidFX

opoverlay_log()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done
sleep 10
log_folder="/sdcard/opoverlay/logs/"
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
log_message="--> Initiated Viper4Android"
echo $log_message | tee -a $opoverlay_script_logfile
}

if [ "$SEINJECT" != "/sbin/sepolicy-inject" ]; then
  $SEINJECT --live "allow audioserver audioserver_tmpfs file { read write execute }" "allow audioserver system_file file execmod" "allow mediaserver mediaserver_tmpfs file { read write execute }" "allow mediaserver system_file file execmod" "allow audioserver unlabeled file { read write execute open getattr }" "allow hal_audio_default hal_audio_default process execmem" "allow hal_audio_default hal_audio_default_tmpfs file execute" "allow hal_audio_default audio_data_file dir search"
else
  $SEINJECT -s audioserver -t audioserver_tmpfs -c file -p read,write,execute -l
  $SEINJECT -s audioserver -t system_file -c file -p execmod -l
  $SEINJECT -s mediaserver -t mediaserver_tmpfs -c file -p read,write,execute -l
  $SEINJECT -s mediaserver -t system_file -c file -p execmod -l
  $SEINJECT -s audioserver -t unlabeled -c file -p read,write,execute,open,getattr -l
  $SEINJECT -s hal_audio_default -t hal_audio_default -c process -p execmem -l
  $SEINJECT -s hal_audio_default -t hal_audio_default_tmpfs -c file -p execmem -l
  $SEINJECT -s hal_audio_default -t audio_data_file -c dir -p search -l
fi
am start -a android.intent.action.MAIN -n com.pittvandewitt.viperfx/.main.StartActivity
killall com.pittvandewitt.viperfx
killall audioserver
killall mediaserver
opoverlay_log &

