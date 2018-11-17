#!/system/bin/sh
#set -e

log_folder="/sdcard/opoverlay/logs/"
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
rm -f $opoverlay_script_logfile
sleep 1
touch $opoverlay_script_logfile
echo " " >> $opoverlay_script_logfile

opoverlay_log()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done
sleep 10
rom_info1=$(getprop ro.build.display.id);
rom_info2=$(getprop ro.crypto.state);
rom_info3=$(getenforce);
rom_info4=$(date +%Y-%m-%d_%H:%M:%S);
echo " " | tee -a $opoverlay_script_logfile
sed -i '1s/^/'$rom_info1'\n/' $opoverlay_script_logfile
sed -i '2s/^/-> Device is '$rom_info2' running SELinux '$rom_info3' <--\n/' $opoverlay_script_logfile
sed -i '3s/^/\<<==========================================>>\n/' $opoverlay_script_logfile
sed -i '4s/^/--> OPOverlay Scripts started at '$rom_info4' <--\n/' $opoverlay_script_logfile
sed -i '5s/^/\<<==========================================>>\n/' $opoverlay_script_logfile
}

opoverlay_tweaks()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay_tweaks.sh ]; then
	sh /system/etc/opoverlay/opoverlay_tweaks.sh
fi
}

opoverlay_detach()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay_detach.sh ]; then
	sh /system/etc/opoverlay/opoverlay_detach.sh
fi
if [ -e /system/etc/opoverlay/youtube.flg ] &&  [ -n "$(find /data/app -maxdepth 1 -name com.google.android.youtube* -print)" ]; then
	pm uninstall -k com.google.android.youtube
	echo "--> Reverted update back to YouTube Vanced" >> $opoverlay_script_logfile
fi
}

opoverlay_wakelocks()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay_wakelocks.sh ]; then
	sh /system/etc/opoverlay/opoverlay_wakelocks.sh
fi
}

opoverlay_repeat()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay_recurring.sh ]; then
	sh /system/etc/opoverlay/opoverlay_recurring.sh
fi
}


opoverlay_scales()
{
sleep 1
if [ -e /data/opoverlay/temp_opoverlay_scales.sh ]; then
	sh /data/opoverlay/temp_opoverlay_scales.sh
fi
}

opoverlay_fstrim()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay_fstrim.sh ]; then
	sh /system/etc/opoverlay/opoverlay_fstrim.sh
fi
}


opoverlay_deepsleep()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay_deepsleep.sh ]; then
	sh /system/etc/opoverlay/opoverlay_deepsleep.sh
fi
}

opoverlay_udetach()
{
sleep 1
if [ -e /data/opoverlay/temp_opoverlay_retach.sh ]; then
	sh /data/opoverlay/temp_opoverlay_retach.sh
fi
}

opoverlay_uwakelocks()
{
sleep 1
if [ -e /data/opoverlay/temp_opoverlay_wakelocks.sh ]; then
	sh /data/opoverlay/temp_opoverlay_wakelocks.sh
fi
}

opoverlay_script_maintenance()
{
sleep 5
if [ -e ./init.magisk.rc ] || [ -d /sbin/.core ]; then
	if grep "opoverlay_scripts" "./init.rc"
	then
		sh /system/etc/opoverlay/opoverlay_essentials.sh
	fi
fi
}

opoverlay_clean_flag()
{
if [ -e /data/opoverlay/clean_flag ]; then
	sleep 120
	rm -f /data/opoverlay/clean.flag
fi
}

opoverlay_sound_mod()
{
sleep 1
if [ -e /system/etc/opoverlay/viper.sh ]; then
	sh /system/etc/opoverlay/viper.sh
fi
if [ -e /system/etc/opoverlay/dolby.sh ]; then
	sh /system/etc/opoverlay/dolby.sh
fi
}


opoverlay_DNS_mod()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay_DNS_tweaks.sh ]; then
	sh /system/etc/opoverlay/opoverlay_DNS_tweaks.sh
fi
}

opoverlay_kernel()
{
sleep 1
if [ -e /system/etc/opoverlay/opoverlay_kernels.sh ]; then
	sh /system/etc/opoverlay/opoverlay_kernels.sh
fi
}

opoverlay_apps2data()
{
sleep 1
if [ -e /data/opoverlay/temp_opoverlay_apps2data.sh ]; then
	sh /data/opoverlay/temp_opoverlay_apps2data.sh
fi
}


opoverlay_perms()
{
sleep 1
if [ -e /data/opoverlay/temp_opoverlay_perms.sh ]; then
	sh /data/opoverlay/temp_opoverlay_perms.sh
fi
}

opoverlay_wait_booted()
{
while [ "$(getprop sys.boot_completed)" != "1" ]
do
  sleep 1
done
opoverlay_clean_flag &
opoverlay_detach &
opoverlay_kernel &
opoverlay_repeat &
opoverlay_wakelocks &
opoverlay_uwakelocks &
opoverlay_udetach &
opoverlay_apps2data &
opoverlay_perms &
if [ "$(getprop ro.crypto.state)" == "unencrypted" ] && [ -d /data/unencrypted ]; then
	rm -rf /data/unencrypted
fi
}

opoverlay_log &
opoverlay_tweaks &
opoverlay_sound_mod &
opoverlay_scales &
opoverlay_DNS_mod &
opoverlay_wait_booted &
opoverlay_fstrim &
opoverlay_deepsleep &
#opoverlay_script_maintenance &
exit 0

