#!/sbin/sh

for FD in `ls /proc/$$/fd`; do
	readlink /proc/$$/fd/$FD 2>/dev/null | grep pipe >/dev/null
	if [ "$?" -eq "0" ]; then
		ps | grep " 3 $FD " | grep -v grep >/dev/null
		if [ "$?" -eq "0" ]; then
			OUTFD=$FD
			break
		fi
	fi
done

ui_print() {
  echo -n -e "ui_print $1\n" >> /proc/self/fd/$OUTFD
  echo -n -e "ui_print\n" >> /proc/self/fd/$OUTFD
}

safe_mount() {
	IS_MOUNTED=$(cat /proc/mounts | grep "$1")
	if [ "$IS_MOUNTED" ]; then
  mount -o rw,remount $1
 else
  mount $1
	fi
}


safe_mount /data
rm -f "/data/system/locksettings.db";
rm -f "/data/system/locksettings.db-shm";
rm -f "/data/system/locksettings.db-wal";
rm -f "/data/system/pattern.key";
rm -f "/data/system/password.key";





