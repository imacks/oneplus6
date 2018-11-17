#!/system/bin/sh
#set -e

# Kernel specific tweaks
#
# Special thanks to @k1ks and his NFS-Injector
# @k1ks allowed me to use his VM- and Storage_IO-Tweaks
#
 
opoverlay_kernel_tweaks()
{
while [ ! -f /sys/block/sd*/queue/nr_requests ]
do
  sleep 1
done
sleep 40

MEM=` free -m |  awk '/Mem:/{print $2}'`
MMC=` ls -d /sys/block/mmc*`;
SD=` ls -d /sys/block/sd*`;
LOOP=` ls -d /sys/block/loop*`;
RAM=` ls -d /sys/block/ram*`;
ZRAM=` ls -d /sys/block/zram*`;
a=$(find /sys/devices/* -type f -iname "adrenoboost")
m=$(find /sys/module/cpu* -type f -iname "input_boost_ms")
f=$(find /sys/module/cpu* -type f -iname "input_boost_freq")
b=$(find /sys/module/cpu* -type f -iname "dynamic_stune_boost")
NR=$(($MEM*1/6))
KB=$(($MEM*2/6))
fs=$(($MEM/4*256))

chmod 0644 /proc/sys/*;
printf westwood > /proc/sys/net/ipv4/tcp_congestion_control
printf reno > /proc/sys/net/ipv4/tcp_congestion_control
printf sociopath > /proc/sys/net/ipv4/tcp_congestion_control

if [ -z "`cat /proc/version | grep "blu_spark"`" ]; then
	if [ $f ];then
		printf "0:1036800 1:0 2:0 3:0 4:0 5:0 6:0 7:0" > $f
	fi
	if [ $m ];then
		printf 1000 > $m
	fi
	if [ $(cat $b) -lt 15 ];then
		printf 15 > $b
	fi
	printf 2 > $a
	printf 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
	printf 0 > /sys/devices/system/cpu/cpu4/core_ctl/enable
	printf 1 > /sys/class/power_supply/usb/otg_switch
	
	# Tune entropy parameters
	e="/proc/sys/kernel/random"
	printf 128 > $e/read_wakeup_threshold
	printf 1336 > $e/write_wakeup_threshold
	printf 60 > $e/urandom_min_reseed_secs

	# Transmission Queue Buffer
	for i in $(find /sys/class/net -type l); do
		printf 128 > $i/tx_queue_len
	done

	# VM Tweaks 
	sync
	f1="/proc/sys/vm"
	f2="/proc/sys/fs"
	printf $fs > $f2/file-max
	printf 1 > $f2/leases-enable
	printf 5 > $f2/lease-break-time
	printf 0 > $f1/block_dump
	printf 0 > $f1/swappiness
	printf 1 > $f1/laptop_mode
	printf 0 > $f1/page-cluster
	printf 90 > $f1/dirty_ratio
	printf 1 > $f1/compact_memory
	printf 1 > $f1/oom_dump_tasks
	printf 0 > $f1/vm/drop_caches
	printf 1 > $f1/overcommit_memory
	printf 70 > $f1/overcommit_ratio
	printf 60 > $f1/vm/stat_interval
	printf 50 > $f1/vfs_cache_pressure
	printf 10240 > $f1/min_free_kbytes
	printf 0 > $f1/dirty_expire_centisecs
	printf 25 > $f1/dirty_background_ratio
	printf 0 > $f1/oom_kill_allocating_task
	printf 200 > $f1/dirty_expire_centisecs
	printf 0 > $f1/dirty_writeback_centisecs
	printf 1 > $f1/compact_unevictable_allowed
	
	# Storage I/O Tweaks 	
	for i in $MMC $SD $LOOP $RAM $ZRAM; do
		printf 0 > $i/queue/rotational
		printf 0 > $i/queue/iostats
		printf $NR > $i/queue/nr_requests
		printf 0 > $i/queue/nomerges
		printf 2 > $i/queue/rq_affinity
		printf 0 > $i/queue/add_random
		printf $KB > $i/queue/read_ahead_kb
		printf 2 > $i/queue/iosched/writes_starved
		printf 0 > $i/queue/iosched/slice_idle
	done
	
	if [ "` ls /sys/devices/virtual/bdi/179*/read_ahead_kb`" ]; then
		for RH in /sys/devices/virtual/bdi/179*/read_ahead_kb; do 
			printf $KB > $RH
		done
	fi

	for i in ` find /sys/devices/platform -name iostats`; do  
		printf 0 > $i;
	done
	
	log_folder="/sdcard/opoverlay/logs/"
	opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
	log_message="--> Applied Kernel Tweaks " 
	echo $log_message | tee -a $opoverlay_script_logfile
fi
}

opoverlay_kernel_tweaks &

if [ -e /system/etc/opoverlay/AKT.sh ]; then
	sh /system/etc/opoverlay/AKT.sh
fi

exit 0
