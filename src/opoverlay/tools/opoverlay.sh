#!/sbin/sh
#set -e

JobType=$1
ObjectType=$2
Source=$3
Dest=""
Dest=$4
#opoverlay=/data/media/0/opoverlay
opoverlay=/sdcard/opoverlay
MagiskProps=/tmp/Magisk/Module
logfile​=/tmp/shjob.log


if [ ! -e $logfile ]; then
	Echo "OPOverlay Recovery Logfile" > $logfile
	Echo " " >> $logfile
fi

echo "*** "$1" - "$2" - "$3" - "$4" ***" 

safe_mount /system
if [ -f /system/system/build.prop ]; then
	sysfolder=/system/system
else
	sysfolder=/system
fi

safe_mount() {
	umount -f $1
	mount -w $1
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


restore_con() { 
  for i in $sysfolder/bin/toybox $sysfolder/toolbox $sysfolder/bin/toolbox; do
    LD_LIBRARY_PATH=$sysfolder/lib $i restorecon -R $*;
  done;
  restorecon -R $*;
}

system_survive() {
	safe_mount /system
	mkdir -p /tmp/save$1/
	cp -Rf $1/* /tmp/save$1/
}

resolve_link() {
	if [ -z "$1" ] || [ ! -e $1 ] ; then return 1 ; fi
	local VAR=$1
	while [ -h $VAR ] ; do
		VAR=$(readlink $VAR)
	done
	echo $VAR
}

fill_zero() {
	echo $1 | grep "/dev/block/" >/dev/null || return
	dd bs=4096 if=/dev/zero of=$1 2>/dev/null
}

is_mounted() { mountpoint -q "$1"; }

mount_image() {
  ui_print "- Mounting $1 to $2"
  [ -d "$2" ] || mkdir -p "$2"
  if (! is_mounted $2); then
    LOOPDEVICE=
    for LOOP in 0 1 2 3 4 5 6 7; do
      if (! is_mounted $2); then
        LOOPDEVICE=/dev/block/loop$LOOP
        [ -f "$LOOPDEVICE" ] || mknod $LOOPDEVICE b 7 $LOOP 2>/dev/null
        losetup $LOOPDEVICE $1
        if [ "$?" -eq "0" ]; then
          mount -t ext4 -o loop $LOOPDEVICE $2
          #is_mounted $2 || /system/bin/toolbox mount -t ext4 -o loop $LOOPDEVICE $2
          #is_mounted $2 || /system/bin/toybox mount -t ext4 -o loop $LOOPDEVICE $2
        fi
        is_mounted $2 && break
      fi
    done
  fi
}


if [ "$JobType" = "mount" ]; then
	if [ "$ObjectType" = "m" ]; then
		safe_mount $Source
	fi
	
	if [ "$ObjectType" = "u" ]; then
		umount -f $Source
	fi	
fi

if [ "$JobType" = "survive" ]; then
	if [ "$ObjectType" = "b" ]; then
		if [ "$Source" = "/vendor/overlay" ] && [ -d /system/vendor/overlay ]; then
			if find /system/vendor/overlay -mindepth 1 | read; then
				system_survive $Source
			else
				safe_mount /data
				rm -rf /data/system/theme
				rm -rf /data/resource-cache
			fi
		fi
		system_survive $Source
	fi
	
	if [ "$ObjectType" = "r" ]; then
		cp -Rf /tmp/save/system/* $sysfolder/
	fi
	
	if [ "$ObjectType" = "bs" ]; then
		if [ "$Source" = "AKT" ]; then
			mkdir -p /tmp/save/system/system/etc/AKT/
			mkdir -p /tmp/save/system/system/etc/init.d/
			mkdir -p /tmp/save/system/system/su.d/
			mkdir -p /tmp/save/system/system/bin/
			cp -f /system/system/bin/AKT /tmp/save/system/system/bin/AKT
			cp -f /system/system/etc/init.d/99AKT /tmp/save/system/system/etc/init.d/99AKT
			cp -f /system/system/su.d/99AKT /tmp/save/system/system/su.d/99AKT
			cp -Rf /system/system/etc/AKT/* /tmp/save/system/system/etc/AKT/
		fi
	fi
fi

if [ "$JobType" = "cp" ]; then
	if [ "$ObjectType" = "d" ]; then
		#$bbox cp -rf $Source/* $Dest
		mkdir -p $Dest
		cp -Rf $Source/* $Dest
	fi
	
	if [ "$ObjectType" = "f" ]; then
		mkdir -p $Dest
		cp -f $Source $Dest
	fi
fi

if [ "$JobType" = "mv" ]; then
	if [ "$ObjectType" = "d" ]; then
		mv -rf $Source/* $Dest
	fi
	
	if [ "$ObjectType" = "f" ]; then
		mv -f $Source $Dest
	fi
fi

if [ "$JobType" = "rm" ]; then
	if [ "$ObjectType" = "d" ]; then
		rm -rf $Source
	fi
	
	if [ "$ObjectType" = "f" ]; then
		rm -f $Source
	fi
fi

if [ "$JobType" = "mkdir" ]; then
	mkdir -p $ObjectType
fi

if [ "$JobType" = "deviceid" ]; then
	DeviceID="/tmp/DeviceID.prop"
	rm -f $DeviceID
	if [ "$ObjectType" == "cheeseburger" ]; then
		echo -e "DeviceID.check=1" | tee $DeviceID
		echo -e "DeviceID.name=$ObjectType" | tee -a $DeviceID
	elif [ "$ObjectType" == "dumpling" ]; then
		echo -e "DeviceID.check=1" | tee $DeviceID
		echo -e "DeviceID.name=$ObjectType" | tee -a "cheeseburger"		
	elif [ "$ObjectType" == "enchilada" ]; then
		echo -e "DeviceID.check=1" | tee $DeviceID
		echo -e "DeviceID.name=$ObjectType" | tee -a $DeviceID
	else
		echo -e "DeviceID.check=0" | tee $DeviceID
	fi	
fi

if [ "$JobType" = "debloat" ]; then
	safe_mount /system
	safe_mount /data
	if [ ! -e /data/opoverlay/temp_opoverlay_apps2data.sh ]; then
		mkdir -p /data/opoverlay/
		cp -Rf /tmp/misc/apps2data/system/* /data/opoverlay/
	fi
	if [ -e $sysfolder$Source ]; then
		DebloatFolder=/tmp/debloat/system
		mkdir -p $DebloatFolder/bin/
		mkdir -p $DebloatFolder/etc/
		mkdir -p $DebloatFolder/media/
		mkdir -p $DebloatFolder/reserve/
		if [ "$ObjectType" = "d" ]; then
			mkdir -p $DebloatFolder$Source/
			cp -rf $sysfolder$Source/* $DebloatFolder$Source/
			cp -f /tmp/.replace $DebloatFolder$Source/.replace
		fi
		
		if [ "$ObjectType" = "f" ]; then
			cp -f $sysfolder$Source $DebloatFolder$Source
		fi
		
		if [ $Dest != "" ] && [ $Dest != "youtube.ignore" ]; then
			sed -i '/ECHO "Deinstall Apps"/ a\
pm uninstall -k '$Dest /data/opoverlay/temp_opoverlay_apps2data.sh
		fi
		
		if [ "$ObjectType" = "k" ] && [ $Source == "YouTube" ]; then
			sed -i '/com.google.android.youtube/d' ./data/opoverlay/temp_opoverlay_apps2data.sh
		fi
		if [ "$ObjectType" = "k" ] && [ $Source == "Gmail" ]; then
			sed -i '/com.google.android.gm/d' ./data/opoverlay/temp_opoverlay_apps2data.sh
		fi
		
		if [ "$ObjectType" = "final" ]; then
			files="$(find -L "$DebloatFolder" -type f)"
			echo "Count: $(echo -n "$files" | wc -l)"
			echo "$files" | while read file; do
			  cat /dev/null > "$file"
			done
			cd $DebloatFolder
			find . -depth -type d -exec rmdir {} +;
		fi
		
		case "$Source" in
			*YouTube*)
			safe_mount /data
			rm -f /data/system/package_cache/1/YouTube* /data/dalvik-cache/arm64/system@app@YouTube@YouTube.apk@classes.*dex;
			;;
		esac
	fi
fi

if [ "$JobType" = "bootani" ]; then
	if [ -f /sdcard/opoverlay/bootanimation.zip ]; then
		mkdir -p /tmp/system/media/
		cp -f /sdcard/opoverlay/bootanimation.zip /tmp/system/media/bootanimation.zip
	fi
fi

if [ "$JobType" = "lib" ]; then
	#mkdir -p $Dest'/'$ObjectType'/lib/arm64/' | tee -a $logfile
	#/tmp/7za e -y $Dest'/'$ObjectType'/'$ObjectType'.apk' 'lib/arm64*' -o$Dest'/'$ObjectType'/lib/arm64/' | tee -a $logfile
	mkdir -p $Dest'/'$ObjectType'/lib/arm/' | tee -a $logfile
	/tmp/7za e -y $Dest'/'$ObjectType'/'$ObjectType'.apk' 'lib/arm64*' -o$Dest'/'$ObjectType'/lib/arm/' | tee -a $logfile
fi

if [ "$JobType" = "magisk" ]; then
	safe_mount /system
	safe_mount /data
	if [ "$ObjectType" = "check" ]; then
		if [ ! -f /data/adb/magisk.img ]; then
			mkdir -p /data/adb/magisk/
			/sbin/make_ext4fs -b 4096 -l 64M /data/adb/magisk.img;
			touch /sdcard/opoverlay/logs/magisk_image_replace.log
			echo "Generated a new Magisk IMG" > /sdcard/opoverlay/logs/magisk_image_replace.log
			set_perm 0 0 0644 "/data/adb/magisk.img";
		fi
	fi
	
	if [ "$ObjectType" = "module" ] && [ "$Source" = "ini" ]; then	
		MagiskIMG=/data/adb/magisk.img;
		mnt=/tmp/Mgsk;
		modname=opoverlay;
		sh /tmp/tools/mgsk.sh $Source | tee -a $logfile
		mount_image $MagiskIMG $mnt;		
		rm -rf $mnt/$modname/
		mkdir -p $mnt/$modname/system/;
		cp -rf $MagiskProps/* $mnt/$modname/;
		cp -rf /tmp/debloat/system/* $mnt/$modname/system/;
		cp -rf /tmp/system/* $mnt/$modname/system/;
		set_perm_recursive 0 0 0755 0755 $mnt/$modname
		set_perm_recursive 0 0 0755 0644 $mnt/$modname/system
		set_perm_recursive 0 0 0755 0777 $mnt/$modname/system/etc/opoverlay
		set_perm_recursive 0 2000 0755 0777 $mnt/$modname/system/xbin
		chcon -hR 'u:object_r:system_file:s0' $mnt/$modname
		sleep 1
		umount -f $mnt;
	fi
	
	if [ "$ObjectType" = "module" ] && [ "$Source" = "maint" ]; then	
		sh /tmp/tools/mgsk.sh $Source | tee -a $logfile
	fi	
	
	if [ "$ObjectType" = "final" ]; then
		mkdir -p /cache/recovery/
		touch /cache/recovery/command
		echo 'boot-recovery ' > /cache/recovery/command
		echo '--update_package=/sdcard/opoverlay/Magisk.zip' >> /cache/recovery/command
		safe_mount /system
		reboot recovery
	fi
fi

if [ "$JobType" = "prop" ]; then
	safe_mount /data
	PropLoc=/tmp/opoverlay.prop.location
	touch $PropLoc
	echo "location = 0" > $PropLoc
	if [ -f /sdcard/opoverlay.profile ]; then
		cp -f /sdcard/opoverlay.profile /tmp/opoverlay.profile
		echo "location = 1" > $PropLoc
	fi
	if [ -f /sdcard/opoverlay/opoverlay.profile ]; then
		cp -f /sdcard/opoverlay/opoverlay.profile /tmp/opoverlay.profile
		echo "location = 2" > $PropLoc		
	fi	
	if [ -f /storage/usbotg/opoverlay.profile ]; then
		cp -f /storage/usbotg/opoverlay.profile /tmp/opoverlay.profile
		echo "location = 3" > $PropLoc
	fi
fi

if [ "$JobType" = "StarWars" ]; then
	safe_mount /sys
	chmod 777 /sys/module/param_read_write/parameters/cust_flag
	if [ "$ObjectType" = "0" ]; then
		echo 0 > /sys/module/param_read_write/parameters/cust_flag
	fi
	if [ "$ObjectType" = "1" ]; then
		echo 2 > /sys/module/param_read_write/parameters/cust_flag
	fi
	chmod 444 /sys/module/param_read_write/parameters/cust_flag
fi

if [ "$JobType" = "Xposed" ]; then
	rm -rf /tmp/xposed
	mkdir -p /tmp/xposed/system/
	#cp -Rf /tmp/apps/Xposed/$ObjectType/installer/system/* $sysfolder/
	mv -f /tmp/apps/Xposed/$ObjectType/framework/system/* /tmp/xposed/system
	sh /tmp/tools/xposed.sh
fi

if [ "$JobType" = "detach" ]; then
	safe_mount /data
	
	if [ "$ObjectType" = "enable" ]; then
		sed -i 's/#pm disable/pm disable/g' /tmp/system/etc/opoverlay/opoverlay_detach.sh
	fi
	
	if [ "$ObjectType" = "disable" ]; then
		sed -i 's/#pm enable/pm enable/g' /tmp/system/etc/opoverlay/opoverlay_detach.sh
	fi
	
	if [ "$ObjectType" = "YouTube" ]; then
		sed -i '12s/^/pm enable com.android.vending\n/' /tmp/system/etc/opoverlay/opoverlay_recurring.sh
		sed -i '12s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/library.db \"DELETE from ownership where doc_id = '"'"com.google.android.youtube"'"'"\;\n/' /tmp/system/etc/opoverlay/opoverlay_recurring.sh
		sed -i '12s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/localappstate.db \"UPDATE appstate SET auto_update = '"'"2"'"' where package_name = '"'"com.google.android.youtube"'"'"\;\n/' /tmp/system/etc/opoverlay/opoverlay_recurring.sh
		sed -i '12s/^/am force-stop com.android.vending\n/' /tmp/system/etc/opoverlay/opoverlay_recurring.sh
		#sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/library.db \"DELETE from ownership where doc_id = '"'"com.google.android.youtube"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
		#sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/localappstate.db \"UPDATE appstate SET auto_update = '"'"2"'"' where package_name = '"'"com.google.android.youtube"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh		
		touch tmp/system/etc/opoverlay/youtube.flg
	fi
	
	if [ "$ObjectType" = "GoogleCamera" ]; then
		#sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/library.db \"DELETE from ownership where doc_id = '"'"com.google.android.youtube"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
		#sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/localappstate.db \"DELETE from appstate where package_name = '"'"com.google.android.youtube"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
		sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/library.db \"DELETE from ownership where doc_id = '"'"com.google.android.GoogleCamera"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
		#sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/localappstate.db \"DELETE from appstate where package_name = '"'"com.google.android.GoogleCamera"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
	fi
	
	if [ "$ObjectType" = "GoogleDialer" ]; then
		sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/library.db \"DELETE from ownership where doc_id = '"'"com.google.android.dialer"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
		#sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/localappstate.db \"DELETE from appstate where package_name = '"'"com.google.android.dialer"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
	fi
		
	if [ "$ObjectType" = "GearWatch" ]; then
		sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/library.db \"DELETE from ownership where doc_id = '"'"com.samsung.android.app.watchmanager"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
		#sed -i '24s/^/\/system\/xbin\/sqlite3\ \/data\/data\/com.android.vending\/databases\/localappstate.db \"DELETE from appstate where package_name = '"'"com.samsung.android.app.watchmanager"'"'"\;\n/' /tmp/system/etc/opoverlay/detach.sh
	fi
fi

if [ "$JobType" = "perms" ]; then
	safe_mount /data
	if [ ! -e /data/opoverlay/temp_opoverlay_perms.sh ]; then
		cp -Rf /tmp/misc/perms/system/* /data/opoverlay/
	fi
	if [ "$ObjectType" = "Dialer" ]; then
		sed -i '/ECHO "Set App Permissions"/ a\
pm grant com.google.android.contacts android.permission.READ_CALENDAR\
pm grant com.google.android.contacts android.permission.READ_CALL_LOG\
pm grant com.google.android.contacts android.permission.ACCESS_FINE_LOCATION\
pm grant com.google.android.contacts android.permission.READ_EXTERNAL_STORAGE\
pm grant com.google.android.contacts android.permission.ACCESS_COARSE_LOCATION\
pm grant com.google.android.contacts android.permission.READ_PHONE_STATE\
pm grant com.google.android.contacts android.permission.SEND_SMS\
pm grant com.google.android.contacts android.permission.CALL_PHONE\
pm grant com.google.android.contacts android.permission.WRITE_CONTACTS\
pm grant com.google.android.contacts android.permission.CAMERA\
pm grant com.google.android.contacts android.permission.WRITE_CALL_LOG\
pm grant com.google.android.contacts android.permission.PROCESS_OUTGOING_CALLS\
pm grant com.google.android.contacts android.permission.GET_ACCOUNTS\
pm grant com.google.android.contacts android.permission.WRITE_EXTERNAL_STORAGE\
pm grant com.google.android.contacts android.permission.RECORD_AUDIO\
pm grant com.google.android.contacts android.permission.READ_CONTACTS\
settings put secure dialer_default_application com.google.android.dialer\
appops set com.google.android.dialer SYSTEM_ALERT_WINDOW allow\
pm grant com.google.android.dialer android.permission.READ_CALENDAR\
pm grant com.google.android.dialer android.permission.READ_CALL_LOG\
pm grant com.google.android.dialer android.permission.ACCESS_FINE_LOCATION\
pm grant com.google.android.dialer android.permission.READ_EXTERNAL_STORAGE\
pm grant com.google.android.dialer android.permission.ACCESS_COARSE_LOCATION\
pm grant com.google.android.dialer android.permission.READ_PHONE_STATE\
pm grant com.google.android.dialer android.permission.SEND_SMS\
pm grant com.google.android.dialer android.permission.CALL_PHONE\
pm grant com.google.android.dialer android.permission.WRITE_CONTACTS\
pm grant com.google.android.dialer android.permission.CAMERA\
pm grant com.google.android.dialer android.permission.WRITE_CALL_LOG\
pm grant com.google.android.dialer android.permission.PROCESS_OUTGOING_CALLS\
pm grant com.google.android.dialer android.permission.GET_ACCOUNTS\
pm grant com.google.android.dialer android.permission.WRITE_EXTERNAL_STORAGE\
pm grant com.google.android.dialer android.permission.RECORD_AUDIO\
pm grant com.google.android.dialer android.permission.READ_CONTACTS\
pm grant com.google.android.dialer com.android.voicemail.permission.ADD_VOICEMAIL' /data/opoverlay/temp_opoverlay_perms.sh
	fi
	
	if [ "$ObjectType" = "AdAway" ]; then
		sed -i '/ECHO "Set App Permissions"/ a\
pm grant org.adaway android.permission.WRITE_EXTERNAL_STORAGE' /data/opoverlay/temp_opoverlay_perms.sh
	fi
	
	if [ "$ObjectType" = "Substratum" ]; then
		sed -i '/ECHO "Set App Permissions"/ a\
appops set projekt.substratum SYSTEM_ALERT_WINDOW allow\		
pm grant projekt.substratum android.permission.WRITE_EXTERNAL_STORAGE' /data/opoverlay/temp_opoverlay_perms.sh
	fi
	
	if [ "$ObjectType" = "Dolby" ]; then
		sed -i '/ECHO "Set App Permissions"/ a\
pm grant com.dolby android.permission.WRITE_EXTERNAL_STORAGE' /data/opoverlay/temp_opoverlay_perms.sh
	fi

	if [ "$ObjectType" = "Viper" ]; then
		sed -i '/ECHO "Set App Permissions"/ a\
pm grant com.pittvandewitt.viperfx android.permission.WRITE_EXTERNAL_STORAGE' /data/opoverlay/temp_opoverlay_perms.sh
	fi	
	
	if [ "$ObjectType" = "GoogleCamera" ]; then
		sed -i '/ECHO "Set App Permissions"/ a\
pm grant com.google.android.Pixel2Mod android.permission.READ_CALENDAR\
pm grant com.google.android.Pixel2Mod android.permission.READ_CALL_LOG\
pm grant com.google.android.Pixel2Mod android.permission.ACCESS_FINE_LOCATION\
pm grant com.google.android.Pixel2Mod android.permission.READ_EXTERNAL_STORAGE\
pm grant com.google.android.Pixel2Mod android.permission.ACCESS_COARSE_LOCATION\
pm grant com.google.android.Pixel2Mod android.permission.READ_PHONE_STATE\
pm grant com.google.android.Pixel2Mod android.permission.SEND_SMS\
pm grant com.google.android.Pixel2Mod android.permission.CALL_PHONE\
pm grant com.google.android.Pixel2Mod android.permission.WRITE_CONTACTS\
pm grant com.google.android.Pixel2Mod android.permission.CAMERA\
pm grant com.google.android.Pixel2Mod android.permission.WRITE_CALL_LOG\
pm grant com.google.android.Pixel2Mod android.permission.PROCESS_OUTGOING_CALLS\
pm grant com.google.android.Pixel2Mod android.permission.GET_ACCOUNTS\
pm grant com.google.android.Pixel2Mod android.permission.WRITE_EXTERNAL_STORAGE\
pm grant com.google.android.Pixel2Mod android.permission.RECORD_AUDIO\
pm grant com.google.android.Pixel2Mod android.permission.READ_CONTACTS' /data/opoverlay/temp_opoverlay_perms.sh
	fi		
	
	if [ "$ObjectType" = "YouTube" ]; then
		sed -i '/ECHO "Set App Permissions"/ a\
pm grant com.google.android.youtube android.permission.READ_CALENDAR\
pm grant com.google.android.youtube android.permission.READ_CALL_LOG\
pm grant com.google.android.youtube android.permission.ACCESS_FINE_LOCATION\
pm grant com.google.android.youtube android.permission.READ_EXTERNAL_STORAGE\
pm grant com.google.android.youtube android.permission.ACCESS_COARSE_LOCATION\
pm grant com.google.android.youtube android.permission.READ_PHONE_STATE\
pm grant com.google.android.youtube android.permission.SEND_SMS\
pm grant com.google.android.youtube android.permission.CALL_PHONE\
pm grant com.google.android.youtube android.permission.WRITE_CONTACTS\
pm grant com.google.android.youtube android.permission.CAMERA\
pm grant com.google.android.youtube android.permission.WRITE_CALL_LOG\
pm grant com.google.android.youtube android.permission.PROCESS_OUTGOING_CALLS\
pm grant com.google.android.youtube android.permission.GET_ACCOUNTS\
pm grant com.google.android.youtube android.permission.WRITE_EXTERNAL_STORAGE\
pm grant com.google.android.youtube android.permission.RECORD_AUDIO\
appops set com.google.android.youtube SYSTEM_ALERT_WINDOW allow\
pm grant com.google.android.youtube android.permission.READ_CONTACTS' /data/opoverlay/temp_opoverlay_perms.sh
	fi	
fi


if [ "$JobType" = "apps2data" ]; then
	safe_mount /data
	if [ ! -e /data/opoverlay/temp_opoverlay_apps2data.sh ]; then
		mkdir -p /data/opoverlay/
		cp -Rf /tmp/misc/apps2data/system/* /data/opoverlay/
	fi

	if [ "$ObjectType" = "opoverlay" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
mkdir -p /sdcard/opoverlay/\
mkdir -p /sdcard/TWRP/\
cp -rf /data/media/opoverlay/* /sdcard/opoverlay\
rm -rf /data/media/opoverlay\
cp -rf /data/media/TWRP/* /sdcard/TWRP\
rm -rf /data/media/TWRP\
mv -f /data/media/opoverlay_* /sdcard' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "Magisk" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=magisk\
PackName=com.topjohnwu.magisk\
pm uninstall -k $PackName\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "Substratum" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=Substratum\
PackName=projekt.substratum\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "Caffeinate" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=Caffeinate\
PackName=xyz.omnicron.caffeinate\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "K-Manager" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=K-Manager\
PackName=kpchuck.k_klock\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "Ozone" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=Ozone\
PackName=com.ungeeked.ozone\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "ViPER4AndroidFX" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=ViPER4AndroidFX\
PackName=com.pittvandewitt.viperfx\
pm uninstall com.audlabs.viperfx\
pm uninstall com.vipercn.viper4android_v2\
pm uninstall com.audlabs.viperfx\
pm uninstall com.pittvandewitt.viperfx' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "AdAway" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=AdAway\
PackName=org.adaway\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	
	
	if [ "$ObjectType" = "NovaLauncher" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=NovaLauncher\
PackName=com.teslacoilsw.launcher\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	

	
	if [ "$ObjectType" = "GoogleCamera" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=GoogleCamera\
PackName=com.google.android.GoogleCamera\
ind $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi

	
	if [ "$ObjectType" = "GoogleCameraOP5" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=GoogleCamera\
PackName=com.google.android.Pixel2ModUrnyx05\
pm uninstall -k $PackName\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "MoreLocale" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=morelocale\
PackName=jp.co.c_lis.ccl.morelocale\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	
	
	if [ "$ObjectType" = "GoogleCameraFix" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=Gcam_Helper\
PackName=com.example.hemant.gcamhelper\
pm uninstall -k $PackName\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	
	
	
	if [ "$ObjectType" = "GoogleDialer" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=GoogleDialer\
PackName=com.google.android.dialer\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	
	
	if [ "$ObjectType" = "GoogleContacts" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=GoogleContacts\
PackName=com.google.android.contacts\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	
	
	if [ "$ObjectType" = "Pixel_LiveWallpapers" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=Pixel_LiveWallpapers\
PackName=com.breel.wallpapers\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	

	if [ "$ObjectType" = "Webview" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=AndroidSystemWebview\
PackName=com.google.android.webview\
am force-stop $PackName\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	
	
	if [ "$ObjectType" = "Caffeine" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=Caffeine\
PackName=co.bipolardesign.quickcaffeine\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi		

	if [ "$ObjectType" = "Xposed" ] && 	[ "$Source" = "u" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=Xposed\
PackName=de.robv.android.xposed.installer\
pm uninstall $PackName' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi

	if [ "$ObjectType" = "Xposed" ] && 	[ "$Source" != "u" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=Xposed\
PackName=de.robv.android.xposed.installer\
pm uninstall -k $PackName\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	

	
	if [ "$ObjectType" = "Dialer" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=GoogleDialer\
PackName=com.google.android.dialer\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
AppName=GoogleContacts\
PackName=com.google.android.contacts\
find $TempDir -name $AppName'"'"*.apk"'"' -maxdepth 1 -print0 | xargs -0 pm install' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "MagiskManager" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
/system/xbin/7za "x" "-y" "/data/opoverlay/MagiskManager.7z" "*" "-o/sdcard/"' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
	
	if [ "$ObjectType" = "GoogleCameraFix" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
/system/xbin/7za "x" "-y" "/data/opoverlay/FixGCam-by-aillez.7z" "*" "-o/sdcard/"' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi	
	
	if [ "$ObjectType" = "ViPER4Android" ] && [ "$Source" = "Essentials" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
/system/xbin/7za "x" "-y" "/data/opoverlay/V4A_Essentials.7z" "*" "-o/sdcard/"' /data/opoverlay/temp_opoverlay_apps2data.sh		
	fi
	
	if [ "$ObjectType" = "ViPER4Android" ] && [ "$Source" = "Complete" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
/system/xbin/7za "x" "-y" "/data/opoverlay/V4A_Complete.7z" "*" "-o/sdcard/"' /data/opoverlay/temp_opoverlay_apps2data.sh		
	fi
	
	if [ "$ObjectType" = "StarWars" ]; then
		sed -i '/ECHO "Install-Deinstall Apps"/ a\
/system/xbin/7za "x" "-y" "/data/opoverlay/StarWars.7z" "*" "-o/sdcard/"' /data/opoverlay/temp_opoverlay_apps2data.sh
	fi
fi


if [ "$JobType" = "sd" ]; then
#	set_perm_recursive 1023 1023 0775 0664 "/data/media";
	safe_mount /data
	if [ -f /data/system/packages.xml ]; then
		set_perm_recursive 1023 1023 0775 0664 "/data/media";
		set_perm 1023 1023 0770 "/data/media" "/data/media/0";
		restore_con /data/media/0;
		set_perm_recursive 0 0 0777 0664 "/data/media/0/TWRP";
		set_perm_recursive 1023 1023 0777 0664 "/data/media/0/TWRP/BACKUPS";
		restorecon -FR /data/media/0
	fi
fi

if [ "$JobType" = "ini" ]; then
	safe_mount /system
	safe_mount /data
	if [ -f /data/system/packages.xml ]; then
		rm -f /data/opoverlay/clean.flag
	fi
	for DETECT in USERDATA SYSTEM VENDOR CACHE DATA userdata system vendor cache data; do
		for PARTITION in $(ls -Rl /dev/block | grep -w $DETECT | cut -d">" -f2 | cut -d" " -f2); do /tmp/tools/tune2fs -o journal_data_writeback $PARTITION; done
		for PARTITION in $(find /dev/block -name $DETECT); do /tmp/tools/tune2fs -o journal_data_writeback $PARTITION; done
	done
	if [ -f /tmp/system/priv-app/AdAway/AdAway.apk ] && [ -f $sysfolder/etc/hosts ]; then
		cp -f /tmp/apps/AdAway/etc/hosts $sysfolder/etc/hosts
		set_perm 0 0 0644 $sysfolder/etc/hosts
	fi
fi


if [ "$JobType" = "forcedecryption" ]; then
	safe_mount /vendor
	sed -i 's/fileencryption=ice/encryptable=ice/g' /vendor/etc/fstab.qcom
fi


if [ "$JobType" = "perm" ]; then
	safe_mount /data
	set_perm_recursive 0 0 0755 0755 "/data/opoverlay"
fi

if [ "$JobType" = "init" ]; then
	safe_mount /system
	safe_mount /data
	#set_perm_recursive 0 0 0755 0755 "$sysfolder/etc/opoverlay";
	#sh /tmp/misc/core/system/etc/opoverlay/opoverlay_init.sh
fi


if [ "$JobType" = "k" ]; then
	if [ "$ObjectType" = "a" ]; then
		mkdir -p $Dest
		cp -f $opoverlay/$Source $Dest/anykernel.zip
	fi

	if [ "$ObjectType" = "u" ]; then
		mkdir -p $Dest
		cp -f $opoverlay/anykernel_unknown/$Source $Dest/anykernel.zip
	fi
	
	if [ "$ObjectType" = "e" ]; then
		# ElementalX Kernel"
		unzip -o $opoverlay/$Source "boot/*" -d $Dest
		mv -f /tmp/boot/* /tmp
		cp -f /tmp/tools/kernels/init.elementalx.rc /tmp/init.elementalx.rc
		cp -f /tmp/tools/busybox /tmp/busybox
		set_perm_recursive 0 0 0777 0777 $Dest;
	fi
	
	if [ "$ObjectType" = "b" ]; then
		# blu_spark Kernel"
		safe_mount /system
		mkdir -p /tmp/blu/
		unzip -o $opoverlay/$Source "kernel/*" -d $Dest
		unzip -o $opoverlay/$Source "system/*" -d /tmp/blu
		cp -Rf /tmp/blu/system/* $sysfolder/
		set_perm_recursive 0 0 0777 0777 $Dest;
		cp -Rf /tmp/kernel/* /tmp/
		rm -f "$sysfolder/lib/modules/qca_cld3/qca_cld3_wlan.ko"
	fi
fi

if [ "$JobType" = "busybox" ]; then
	/tmp/7za e -y '/tmp/busybox/bbox.zip' '/*arm64' -o'/tmp/tools/'
	cd /tmp/tools
	mv busybox-arm64 busybox
	set_perm_recursive 0 0 0777 0777 "/tmp";
fi

if [ "$JobType" = "arise" ]; then
	sed -i '1s/^/arise=1\n/' /tmp/sound/sound3/Wishlist/arise_customize.prop
	
	if [ "$ObjectType" = "V4A" ]; then
		sed -i '1s/^/install.v4a_2.5.0.5=true\n/' /tmp/sound/sound3/Wishlist/arise_customize.prop
	fi
	
	if [ "$ObjectType" = "atmos" ]; then
		sed -i '1s/^/install.atmos=true\n/' /tmp/sound/sound3/Wishlist/arise_customize.prop
	fi
	
	if [ "$ObjectType" = "ddplus" ]; then
		sed -i '1s/^/install.ddplus=true\n/' /tmp/sound/sound3/Wishlist/arise_customize.prop
	fi	
fi

if [ "$JobType" = "sound" ]; then
	safe_mount /system
	safe_mount /vendor
	if [ "$ObjectType" = "viper" ]; then
		sed -i 's/^libraries {/libraries {\n  v4a_fx {\n    path \/system\/lib\/soundfx\/libv4a_fx_ics.so\n  }/g' $sysfolder/etc/audio_effects.conf
		sed -i 's/^effects {/effects {\n  v4a_standard_fx {\n    library v4a_fx\n    uuid 41d3c987-e6cf-11e3-a88a-11aba5d5c51b\n  }/g' $sysfolder/etc/audio_effects.conf
		sed -i 's/^libraries {/libraries {\n  v4a_fx {\n    path \/system\/lib\/soundfx\/libv4a_fx_ics.so\n  }/g' /vendor/etc/audio_effects.conf
		sed -i 's/^effects {/effects {\n  v4a_standard_fx {\n    library v4a_fx\n    uuid 41d3c987-e6cf-11e3-a88a-11aba5d5c51b\n  }/g' /vendor/etc/audio_effects.conf
	fi
	if [ "$ObjectType" = "viperfx" ]; then
		set_perm 0 0 0644 $sysfolder/etc/audio_effects.conf;
		set_perm 0 0 0644 "/vendor/etc/audio_effects.conf"
		set_perm 0 0 0644 "/vendor/lib/soundfx/libv4a_fx_ics.so"
		set_perm 0 0 0644 $sysfolder/etc/audio_effects.conf;
		set_perm 0 0 0644 $sysfolder/etc/permissions/privapp-permissions-com.pittvandewitt.viperfx.xml;
	fi
fi

if [ "$JobType" = "build.prop" ]; then
	if [ "$ObjectType" = "tasker" ]; then
		safe_mount /system
		sed -i '1s/^/#modversion this line enables Tasker root support\n/' $MagiskProps/system.prop
	fi
	
	if [ "$ObjectType" = "rom" ]; then
		safe_mount /system
		safe_mount /vendor
		PropFile="/system/system/build.prop"				
		if [ "$(grep -i 'ro.build.soft.version=W.' $PropFile)" ]; then
			VersionInfo=$(grep -i 'ro.build.soft.version' $PropFile | cut -f2 -d'=');
			RomVer=$(grep -i 'ro.build.soft.version' $PropFile | cut -f2 -d'=');
			BetaVer="$(printf $VersionInfo | tail -c 2)";
			if [ "$(grep -i 'ro.rom.version=OP6_H2_BETA' $PropFile)" ] || [ "$(grep -i 'ro.oxygen.version=OP6_O2_BETA_05' $PropFile)" ]; then
				ReplaceStr=ro.build.fingerprint=OnePlus/OnePlus6/OnePlus6:9/PKQ1.180716.001/1810122000:user/release-keys
				sed -i "/ro.build.fingerprint=OnePlus/c $ReplaceStr" $PropFile
				set_perm 0 0 0644 "$PropFile"
			fi
			if [ "$BetaVer" \< "11" ]; then
				ReplaceStr=ro.build.fingerprint=OnePlus/OnePlus6/OnePlus6:9/PKQ1.180716.001/1809150000:user/release-keys
				sed -i "/ro.build.fingerprint=OnePlus/c $ReplaceStr" $PropFile
				set_perm 0 0 0644 "$PropFile"
			fi
		fi
		sed -i 's/Rom_Version_Info/'$Source'/g' $MagiskProps/post-fs-data.sh
		sed -i 's/RomFriendlyName/Overlay ROM for OnePlus/g' $MagiskProps/module.prop
		sed -i 's/RomVersion/'$Source'/g' $MagiskProps/module.prop
		touch "/sdcard/opoverlay/logs/opoverlay_unregular.log"
		echo " " | tee -a "/sdcard/opoverlay/logs/opoverlay_unregular.log"
		echo "<<==========================================>>" | tee -a "/sdcard/opoverlay/logs/opoverlay_unregular.log"
		echo ">>> Flashed " $Source | tee -a "/sdcard/opoverlay/logs/opoverlay_unregular.log"
		log_folder="/sdcard/opoverlay/logs/"
		opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
		mkdir -p $log_folder
		rm -f $opoverlay_script_logfile
		sleep 1
		touch $opoverlay_script_logfile
		echo " " > $opoverlay_script_logfile
	fi
fi

if [ "$JobType" = "wifi" ]; then
	if [ "$ObjectType" = "CB" ]; then
		safe_mount /vendor
		mkdir -p /tmp/system/vendor/etc/wifi/
		cp -f /vendor/etc/wifi/WCNSS_qcom_cfg.ini /tmp/system/vendor/etc/wifi/WCNSS_qcom_cfg.ini
		sed -i $'/gChannelBondingMode5GHz=1/a\gChannelBondingMode24GHz=1' /tmp/system/vendor/etc/wifi/WCNSS_qcom_cfg.ini
	fi
fi

if [ "$JobType" = "cam.mod" ]; then
		safe_mount /vendor
		sed -i '/    <CamcorderProfiles cameraId="0">/ a\
 <!-- CAMCORDER_QUALITY_HIGH_SPEED_HIGH/720P : 720p@120fps; 27.0 Mbps -->\
        <EncoderProfile quality="highspeedhigh" fileFormat="mp4" duration="30">\
            <Video codec="h264"\
                   bitRate="27000000"\
                   width="1280"\
                   height="720"\
                   frameRate="120" />\
            <!-- audio setting is ignored -->\
            <Audio codec="aac"\
                   bitRate="96000"\
                   sampleRate="48000"\
                   channels="2" />\
        </EncoderProfile>\
\
        <EncoderProfile quality="highspeed720p" fileFormat="mp4" duration="30">\
            <Video codec="h264"\
                   bitRate="27000000"\
                   width="1280"\
                   height="720"\
                   frameRate="120" />\
            <!-- audio setting is ignored -->\
            <Audio codec="aac"\
                   bitRate="96000"\
                   sampleRate="48000"\
                   channels="2" />\
        </EncoderProfile>\
\
        <!-- CAMCORDER_QUALITY_HIGH_SPEED_HIGH/1080P : 1080p@60fps; 34.0 Mbps -->\
        <EncoderProfile quality="highspeed1080p" fileFormat="mp4" duration="30">\
            <Video codec="h264"\
                   bitRate="34000000"\
                   width="1920"\
                   height="1080"\
                   frameRate="60" />\
            <!-- audio setting is ignored -->\
            <Audio codec="aac"\
                   bitRate="96000"\
                   sampleRate="48000"\
                   channels="2" />\
        </EncoderProfile>' /vendor/etc/media_profiles.xml
fi

if [ "$JobType" = "stereo.mod" ]; then
	safe_mount /vendor
	sed -i '/    <path name="deep-buffer-playback quat_i2s">/ a\
	<ctl name="SLIMBUS_0_RX Audio Mixer MultiMedia1" value="1" />\
	<ctl name="SLIM RX0 MUX" value="AIF_MIX1_PB" />\
	<ctl name="SLIM_0_RX Channels" value="One" />\
	<ctl name="RX INT0_1 MIX1 INP0" value="RX0" />\
	<ctl name="RX INT0 DEM MUX" value="CLSH_DSM_OUT" />\
	<ctl name="EAR PA Gain" value="G_8_DB" />\
	<ctl name="RX0 Digital Volume" value="98" />\
	<ctl name="RX0 HPF cut off" value="MIN_3DB_150Hz"/>' /vendor/etc/mixer_paths_tasha.xml
fi

if [ "$JobType" = "extsdrw" ]; then
	safe_mount /system
	safe_mount /data
	mkdir -p /tmp/system/etc/permissions/
	cp -f $sysfolder/etc/permissions/platform.xml /tmp/system/etc/permissions/platform.xml
	sed -i '/<permission name="android.permission.WRITE_EXTERNAL_STORAGE" \/>/ a\
	<group gid="sdcard_r" \/>\
	<group gid="sdcard_rw" \/>\
	<group gid="media_rw" \/>' /tmp/system/etc/permissions/platform.xml
	if [ -e /sdcard/opoverlay/AKT.sh ]; then
		cp -f /sdcard/opoverlay/AKT.sh /tmp/system/etc/opoverlay/AKT.sh
	fi
fi

if [ "$JobType" = "cleaning" ]; then
	safe_mount /data
	safe_mount /cache
	safe_mount /system
	safe_mount /vendor
	
	if [ -e /sdcard/opoverlay/logs/opoverlay_scripts.log ]; then
		rm -f /sdcard/opoverlay/logs/opoverlay_scripts.log
	fi
	if [ -e /sdcard/opoverlay/logs/su.d_folder_scripts.log ]; then
		rm -f /sdcard/opoverlay/logs/su.d_folder_scripts.log
	fi
	if [ -e /sdcard/opoverlay/logs/init.d_folder_scripts.log ]; then
		rm -f /sdcard/opoverlay/logs/init.d_folder_scripts.log
	fi	
	
	if [ "$ObjectType" = "m" ]; then
		rm -rf  /data/Magisk.apk /data/magisk.apk /data/magisk_merge.img /data/magisk_debug.log /data/busybox /data/magisk /data/custom_ramdisk_patch.sh /data/property/*magisk* 2>/dev/null
	fi		
	
	if [ "$ObjectType" = "s" ]; then
		rm -rf /data/app/me.phh.superuser* /data/data/me.phh.superuser* /data/su /data/.supersu /data/stock_boot_*.img.gz /data/SuperSU.apk /data/app/eu.chainfire.supersu*;
	fi
	
	if [ "$ObjectType" = "b" ]; then
		rm -rf /su/xbin /su/bin /magisk/phh/bin;
	fi	
fi

if [ "$JobType" = "WipeCache" ]; then
	safe_mount /data
	safe_mount /cache
	rm -rf /cache/*	
	rm -rf /data/dalvik-cache/*
	rm -rf /data/system/package_cache/1/*
	rm /data/resource-cache/overlays.list
fi

if [ "$JobType" = "scales" ]; then
	safe_mount /data
	cp -Rf /tmp/misc/Scales/system/* /data/opoverlay/		
	sed -i '17s/^/settings put global window_animation_scale '$ObjectType'\;\n/' /data/opoverlay/temp_opoverlay_scales.sh
	sed -i '17s/^/settings put global transition_animation_scale '$ObjectType'\;\n/' /data/opoverlay/temp_opoverlay_scales.sh
	sed -i '17s/^/settings put global animator_duration_scale '$ObjectType'\;\n/' /data/opoverlay/temp_opoverlay_scales.sh
fi

if [ "$JobType" = "wipe" ]; then
	if [ "$ObjectType" = "kernel" ]; then
		BOOT=$(resolve_link $(find /dev/block/platform -type l -iname boot))
		fill_zero $BOOT
	fi
fi

if [ "$JobType" = "flash" ]; then
	safe_mount /data
	
	if [ "$ObjectType" = "system" ]; then
		sh -x /tmp/tools/res.sh | tee -a /tmp/shjob.log
		system_a=$(resolve_link $(find /dev/block/platform -type l -iname system_a))
		vendor_a=$(resolve_link $(find /dev/block/platform -type l -iname vendor_a))
		unzip -p $opoverlay'/'$Source "opoverlay/images/system.img" | dd bs=4096 of=$system_a
		unzip -p $opoverlay'/'$Source "opoverlay/images/vendor.img" | dd bs=4096 of=$vendor_a
	fi
	
	if [ "$ObjectType" = "logo" ]; then
		LOGO_a=$(resolve_link $(find /dev/block/platform -type l -iname LOGO_a))
		dd if=/tmp/misc/Logo/$Source/LOGO.img bs=4096 of="$LOGO_a"
	fi
	
	if [ "$ObjectType" = "kernel" ]; then
		boot_a=$(resolve_link $(find /dev/block/platform -type l -iname boot_a))
		boot_b=$(resolve_link $(find /dev/block/platform -type l -iname boot_b))
		fill_zero $BOOT
		dd if=/tmp/firmware/boot.img bs=4096 of="$boot_a"
		dd if=/tmp/firmware/boot.img bs=4096 of="$boot_b"
	fi
	
	if [ "$ObjectType" = "firmware" ]; then
		abl_a=$(resolve_link $(find /dev/block/platform -type l -iname abl_a))
		aop_a=$(resolve_link $(find /dev/block/platform -type l -iname aop_a))
		bluetooth_a=$(resolve_link $(find /dev/block/platform -type l -iname bluetooth_a))
		cmnlib_a=$(resolve_link $(find /dev/block/platform -type l -iname cmnlib_a))
		cmnlib64_a=$(resolve_link $(find /dev/block/platform -type l -iname cmnlib64_a))
		devcfg_a=$(resolve_link $(find /dev/block/platform -type l -iname devcfg_a))
		dsp_a=$(resolve_link $(find /dev/block/platform -type l -iname dsp_a))
		dtbo_a=$(resolve_link $(find /dev/block/platform -type l -iname dtbo_a))
		fw_4j1ed_a=$(resolve_link $(find /dev/block/platform -type l -iname fw_4j1ed_a))
		fw_4u1ea_a=$(resolve_link $(find /dev/block/platform -type l -iname fw_4u1ea_a))
		hyp_a=$(resolve_link $(find /dev/block/platform -type l -iname hyp_a))
		keymaster_a=$(resolve_link $(find /dev/block/platform -type l -iname keymaster_a))
		LOGO_a=$(resolve_link $(find /dev/block/platform -type l -iname LOGO_a))
		modem_a=$(resolve_link $(find /dev/block/platform -type l -iname modem_a))
		oem_stanvbk_a=$(resolve_link $(find /dev/block/platform -type l -iname oem_stanvbk_a))
		qupfw_a=$(resolve_link $(find /dev/block/platform -type l -iname qupfw_a))
		storsec_a=$(resolve_link $(find /dev/block/platform -type l -iname storsec_a))
		tz_a=$(resolve_link $(find /dev/block/platform -type l -iname tz_a))
		vbmeta_a=$(resolve_link $(find /dev/block/platform -type l -iname vbmeta_a))
		xbl_a=$(resolve_link $(find /dev/block/platform -type l -iname xbl_a))
		xbl_config_a=$(resolve_link $(find /dev/block/platform -type l -iname xbl_config_a))
		
		abl_b=$(resolve_link $(find /dev/block/platform -type l -iname abl_b))
		aop_b=$(resolve_link $(find /dev/block/platform -type l -iname aop_b))
		bluetooth_b=$(resolve_link $(find /dev/block/platform -type l -iname bluetooth_b))
		cmnlib_b=$(resolve_link $(find /dev/block/platform -type l -iname cmnlib_b))
		cmnlib64_b=$(resolve_link $(find /dev/block/platform -type l -iname cmnlib64_b))
		devcfg_b=$(resolve_link $(find /dev/block/platform -type l -iname devcfg_b))
		dsp_b=$(resolve_link $(find /dev/block/platform -type l -iname dsp_b))
		dtbo_b=$(resolve_link $(find /dev/block/platform -type l -iname dtbo_b))
		fw_4j1ed_b=$(resolve_link $(find /dev/block/platform -type l -iname fw_4j1ed_b))
		fw_4u1ea_b=$(resolve_link $(find /dev/block/platform -type l -iname fw_4u1ea_b))
		hyp_b=$(resolve_link $(find /dev/block/platform -type l -iname hyp_b))
		keymaster_b=$(resolve_link $(find /dev/block/platform -type l -iname keymaster_b))
		LOGO_b=$(resolve_link $(find /dev/block/platform -type l -iname LOGO_b))
		modem_b=$(resolve_link $(find /dev/block/platform -type l -iname modem_b))
		oem_stanvbk_b=$(resolve_link $(find /dev/block/platform -type l -iname oem_stanvbk_b))
		qupfw_b=$(resolve_link $(find /dev/block/platform -type l -iname qupfw_b))
		storsec_b=$(resolve_link $(find /dev/block/platform -type l -iname storsec_b))
		tz_b=$(resolve_link $(find /dev/block/platform -type l -iname tz_b))
		vbmeta_b=$(resolve_link $(find /dev/block/platform -type l -iname vbmeta_b))
		xbl_b=$(resolve_link $(find /dev/block/platform -type l -iname xbl_b))
		xbl_config_b=$(resolve_link $(find /dev/block/platform -type l -iname xbl_config_b))


		dd if=/tmp/firmware/abl.img bs=4096 of="$abl_a" 
		dd if=/tmp/firmware/aop.img bs=4096 of="$aop_a" 
		dd if=/tmp/firmware/bluetooth.img bs=4096 of="$bluetooth_a" 
		dd if=/tmp/firmware/cmnlib.img bs=4096 of="$cmnlib_a" 
		dd if=/tmp/firmware/cmnlib64.img bs=4096 of="$cmnlib64_a" 
		dd if=/tmp/firmware/devcfg.img bs=4096 of="$devcfg_a" 
		dd if=/tmp/firmware/dsp.img bs=4096 of="$dsp_a" 
		dd if=/tmp/firmware/dtbo.img bs=4096 of="$dtbo_a" 
		dd if=/tmp/firmware/fw_4j1ed.img bs=4096 of="$fw_4j1ed_a" 
		dd if=/tmp/firmware/fw_4u1ea.img bs=4096 of="$fw_4u1ea_a" 
		dd if=/tmp/firmware/hyp.img bs=4096 of="$hyp_a" 
		dd if=/tmp/firmware/keymaster.img bs=4096 of="$keymaster_a" 
		dd if=/tmp/firmware/LOGO.img bs=4096 of="$LOGO_a" 
		dd if=/tmp/firmware/modem.img bs=4096 of="$modem_a" 
		dd if=/tmp/firmware/oem_stanvbk.img bs=4096 of="$oem_stanvbk_a" 
		dd if=/tmp/firmware/qupfw.img bs=4096 of="$qupfw_a" 
		dd if=/tmp/firmware/storsec.img bs=4096 of="$storsec_a" 
		dd if=/tmp/firmware/tz.img bs=4096 of="$tz_a" 
		dd if=/tmp/firmware/vbmeta.img bs=4096 of="$vbmeta_a"
		dd if=/tmp/firmware/xbl.img bs=4096 of="$xbl_a" 
		dd if=/tmp/firmware/xbl_config.img bs=4096 of="$xbl_config_a" 
		
		dd if=/tmp/firmware/abl.img bs=4096 of="$abl_b" 
		dd if=/tmp/firmware/aop.img bs=4096 of="$aop_b" 
		dd if=/tmp/firmware/bluetooth.img bs=4096 of="$bluetooth_b" 
		dd if=/tmp/firmware/cmnlib.img bs=4096 of="$cmnlib_b" 
		dd if=/tmp/firmware/cmnlib64.img bs=4096 of="$cmnlib64_b" 
		dd if=/tmp/firmware/devcfg.img bs=4096 of="$devcfg_b" 
		dd if=/tmp/firmware/dsp.img bs=4096 of="$dsp_b" 
		dd if=/tmp/firmware/dtbo.img bs=4096 of="$dtbo_b" 
		dd if=/tmp/firmware/fw_4j1ed.img bs=4096 of="$fw_4j1ed_b" 
		dd if=/tmp/firmware/fw_4u1ea.img bs=4096 of="$fw_4u1ea_b" 
		dd if=/tmp/firmware/hyp.img bs=4096 of="$hyp_b" 
		dd if=/tmp/firmware/keymaster.img bs=4096 of="$keymaster_b" 
		dd if=/tmp/firmware/LOGO.img bs=4096 of="$LOGO_b" 
		dd if=/tmp/firmware/modem.img bs=4096 of="$modem_b" 
		dd if=/tmp/firmware/oem_stanvbk.img bs=4096 of="$oem_stanvbk_b" 
		dd if=/tmp/firmware/qupfw.img bs=4096 of="$qupfw_b" 
		dd if=/tmp/firmware/storsec.img bs=4096 of="$storsec_b" 
		dd if=/tmp/firmware/tz.img bs=4096 of="$tz_b" 
		dd if=/tmp/firmware/vbmeta.img bs=4096 of="$vbmeta_b"
		dd if=/tmp/firmware/xbl.img bs=4096 of="$xbl_b" 
		dd if=/tmp/firmware/xbl_config.img bs=4096 of="$xbl_config_b" 
	fi
fi

sync
exit 0


