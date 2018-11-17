#!/system/bin/sh
#set -e

opoverlay_tweaks()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done

settings put global development_settings_enabled 1
settings put global op_voice_recording_supported_by_mcc 1
settings put global adb_enabled 1
settings put global install_non_market_apps 1
settings put global usb_mass_storage_enabled 1

resetprop -n dalvik.vm.heapgrowthlimit 512m

# LMK Tweaks
chmod 644 /proc/sys/vm/swappiness
chmod 644 /sys/module/lowmemorykiller/parameters/minfree
chmod 644 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
printf 0 > /proc/sys/vm/swappiness
printf 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
printf "19658,39316,58974,78632,98290,117948" > /sys/module/lowmemorykiller/parameters/minfree

# Net Tweaks
sysctl -e -w net.ipv4.tcp_ecn=1
sysctl -e -w net.ipv4.tcp_fack=1
sysctl -e -w net.ipv4.tcp_sack=1
sysctl -e -w net.ipv4.tcp_timestamps=1
sysctl -e -w net.ipv4.tcp_fin_timeout=45
sysctl -e -w net.ipv4.conf.all.rp_filter=2
sysctl -e -w net.ipv4.tcp_synack_retries=3
sysctl -e -w net.ipv4.tcp_window_scaling=1
sysctl -e -w net.ipv4.tcp_moderate_rcvbuf=1
sysctl -e -w net.ipv4.tcp_no_metrics_save=1
sysctl -e -w net.ipv4.tcp_keepalive_intvl=45
sysctl -e -w net.ipv4.tcp_keepalive_probes=9
sysctl -e -w net.ipv4.conf.default.rp_filter=2
sysctl -e -w net.ipv4.tcp_challenge_ack_limit=999

for DETECT in USERDATA SYSTEM VENDOR CACHE DATA userdata system vendor cache data; do
	for PARTITION in $(ls -Rl /dev/block | grep -w $DETECT | cut -d">" -f2 | cut -d" " -f2); do /system/xbin/tune2fs -o journal_data_writeback $PARTITION; done
	for PARTITION in $(find /dev/block -name $DETECT); do /system/xbin/tune2fs -o journal_data_writeback $PARTITION; done
done

sleep 15
log_folder="/sdcard/opoverlay/logs/"
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
log_message="--> Applied OPOverlay Tweaks " 
echo $log_message | tee -a $opoverlay_script_logfile
opoverlay_script_logfile=$log_folder"su.d_folder_scripts.log"
echo `date "+%Y-%m-%d %H:%M:%S"` $output_su | tee $opoverlay_script_logfile
opoverlay_script_logfile=$log_folder"init.d_folder_scripts.log"
echo `date "+%Y-%m-%d %H:%M:%S"` $output_init | tee $opoverlay_script_logfile
}

opoverlay_inits()
{
sleep 2
if [ ! -e /data/su.img ]; then
	/system/xbin/run-parts /system/su.d
fi
/system/xbin/run-parts /system/etc/init.d
}

opoverlay_tweaks &
opoverlay_inits &
if [ ! -e /data/su.img ]; then
	output_su=$(/system/xbin/run-parts /system/su.d)
fi
output_init=$(/system/xbin/run-parts /system/etc/init.d)
echo "-----------------------------------------"
echo "-> Applied OPOverlay Tweaks"
echo "-----------------------------------------"

exit 0

