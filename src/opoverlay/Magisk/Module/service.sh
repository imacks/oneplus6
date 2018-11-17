#!/system/bin/sh

MODDIR=${0%/*}
sh -x /system/etc/opoverlay/opoverlay.sh | tee -a >/dev/null;
sync
exit 0

