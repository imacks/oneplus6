#!/sbin/sh

sh -x /tmp/tools/opoverlay.sh $1 $2 $3 $4 | tee -a /tmp/shjob.log
exit 0
