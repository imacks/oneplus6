#!/sbin/sh
#set -e

safe_mount() {
	IS_MOUNTED=$(cat /proc/mounts | grep "$1")
	if [ "$IS_MOUNTED" ]; then
  mount -o rw,remount $1
 else
  mount $1
	fi
}

# replace_line <file> <line replace string> <replacement line>
replace_line() {
  if [ ! -z "$(grep "$2" $1)" ]; then
    line=`grep -n "$2" $1 | head -n1 | cut -d: -f1`;
    sed -i "${line}s;.*;${3};" $1;
  fi;
}

safe_mount /data

device_state="/sdcard/opoverlay/logs/device.state.log"
mkdir -p /sdcard/opoverlay/logs
if [ -f $device_state ]; then
	rm -f $device_state
fi
touch $device_state
#echo -e "data.state=" | tee -a $device_state
#echo -e "data.protection=" | tee -a $device_state
#echo -e " " | tee -a $device_state

if [ ! -f /data/.layout_version ] && [ ! -f /data/system/packages.xml ]; then
	echo -e "data.state=formatted" | tee -a $device_state
fi

if [ -f /data/.layout_version ] && [ ! -f /data/system/packages.xml ]; then
	echo -e "data.state=wiped" | tee -a $device_state
fi

if [ -f /data/.layout_version ] && [ -f /data/system/packages.xml ]; then
	echo -e "data.state=dirty" | tee -a $device_state
fi

if [ -d /data/unencrypted ]; then
	echo -e "data.protection=encrypted" | tee -a $device_state
else
	echo -e "data.protection=decrypted" | tee -a $device_state
fi




