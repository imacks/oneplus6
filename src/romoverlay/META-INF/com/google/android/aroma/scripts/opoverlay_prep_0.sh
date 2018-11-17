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


#kernel_repo=/data/media/0/opoverlay

#safe_mount /data
#if [ ! -d $kernel_repo ]; then
#	mkdir -p $kernel_repo
#	cp -rf /data/media/opoverlay/* $kernel_repo/
	#rm -rf /data/media/opoverlay
	#cp -rf /data/media/TWRP/* /data/media/0/TWRP/
#fi


