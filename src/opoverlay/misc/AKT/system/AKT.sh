#!/system/system/bin/sh
#set -e

#Interactive Governor tweaks for OnePlus 5.
#Stock are the stock settings from Stock kernel
#Scripts made by Senthil360 and Asiier and changed by Mostafa Wael
#Credits for @Asiier/@Mostafa Wael/@Senthil360/@patalao
#TWEAKS_BEGIN

log_folder="/sdcard/opoverlay/logs/"
mkdir -p $log_folder
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
log_message="--> Applied AKT Burnout Profile " 
echo $log_message | tee -a $opoverlay_script_logfile
echo ""
echo --------------------------------------------
echo Applying 'Burnout R1' profile
echo enjoy the blast
echo Advanced Kernel Settings
echo --------------------------------------------
sleep 0.5
echo "Device: One Plus 5 & S835 Devices"
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sleep 0.3
echo Checking Android version...
if grep -q 'ro.build.version.sdk=25' /system/system/build.prop; then
	echo Android Nougat 7.1.X detected!
	sleep 0.3
	echo N detected... Applying proper settings
fi
if grep -q 'ro.build.version.sdk=24' /system/system/build.prop; then
	echo Android Nougat 7.0.X detected!
	sleep 0.3
	echo N detected... Applying proper settings
fi
if grep -q 'ro.build.version.sdk=26' /system/system/build.prop; then
	echo Android Oreo 8.0.0 detected!
	sleep 0.3
	echo O detected... Settings may not act as expected!
fi
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sleep 0.3
#Apply settings to LITTLE cluster
echo Applying settings to LITTLE Cluster...
sleep 0.5
#Temporarily change permissions to governor files for the LITTLE cluster to enable Interactive governor
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
#Grab Maximum Achievable Frequency for the LITTLE Cluster
#maxfreq=$(cat "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq")                
#if test $maxfreq -eq 1593600; then
    #Temporarily change permissions to governor files for the Big cluster to set the maximum frequency to 1593MHz
#    echo No LITTLE Cluster Overclocking detected. 
#    echo Applying appropriate values.
#    chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
#    echo 1593600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq     #Core 0 Maximum Frequency = 1593MHz         
#    chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
#    echo 1478400 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq #Set overclock max frequency compatible hispeed_freq
#elif test $maxfreq -eq 1728000; then
    #Temporarily change permissions to governor files for the Little cluster to set the maximum frequency to 1728MHz
#    echo LITTLE Cluster Overclocking detected. 
#    echo Applying appropriate values.
#    chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
#    echo 1728000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq     #Core 0 Maximum Frequency = 1728MHz         
#    chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
#    echo 1593600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq #Set normal max frequency hispeed_freq
#else
#    echo "===================================================="
#    echo Do not underclock!!! Set the clock speed to max and re-run the script.
#    echo "===================================================="
#fi
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/*
echo 80000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 83 1824000:95 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 1171200 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 
echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 79000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fast_ramp_down
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 80000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
if [ -e "/sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction" ]; then
    chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
fi
sleep 0.5
#Apply settings to Big cluster
echo Applying settings to BIG Cluster
sleep 0.2
#Temporarily change permissions to governor files for the BIG cluster to enable Interactive governor
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
#Grab Maximum Achievable Frequency for the Big Cluster
#maxfreq=$(cat "/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq")                
#if test $maxfreq -eq 2150400; then
    #Temporarily change permissions to governor files for the Big cluster to set the maximum frequency to 2150MHz
#    echo No BIG Cluster Overclocking detected. 
#    echo Applying appropriate values.
#    chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
#    echo 2150400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq     #Core 2 Maximum Frequency = 2150MHz         
#    chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
#    chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
#    echo 2073600 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 
#chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
#Set overclock max frequency compatible target_loads
#elif test $maxfreq -eq 2265600; then
    #Temporarily change permissions to governor files for the Big cluster to set the maximum frequency to 2265MHz
#    echo BIG Cluster Overclocking detected. 
#    echo Applying appropriate values.
#    chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
#    echo 2265600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq     #Core 2 Maximum Frequency = 2265MHz         
#    chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
#    chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
#    echo 2150400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 
#    chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
#else
#    echo "===================================================="
#    echo Do not underclock!!! Set the clock speed to max and re-run the script.
#    echo "===================================================="
#Set normal max frequency target_loads
#fi
sleep 0.5
#Tweak Interactive Governor
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/*
echo 80000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo 70 1190400:75 1574400:80 1958400:90 2112000:99 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo 10000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo 1574400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
echo 80 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo 79000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fast_ramp_down
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
echo 80000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
if [ -e "/sys/devices/system/cpu/cpu4/cpufreq/interactive/enable_prediction" ]; then
    chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/enable_prediction
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/enable_prediction
fi
sleep 0.2
echo "=========================================="
#Checking whether you are using a Sultanxda based ROM or not
echo "=========================================="
#Checking whether you are using a Sultanxda based ROM or not
echo Checking ROM...
sleep 0.2
echo Applying appropriate values.
if [ -e "/sys/kernel/cpu_input_boost/enabled" ]; then
    echo Disabling Input Boost for the LITTLE cluster and for the BIG Cluster and custom thermal driver of Sultanxda
    chmod 644 /sys/kernel/cpu_input_boost/enabled
    echo 0 > /sys/kernel/cpu_input_boost/enabled
    chmod 644 /sys/kernel/msm_thermal/enabled
    echo 0 > /sys/kernel/msm_thermal/enabled
else
    echo Tweaking Input Boost for the LITTLE cluster and for the BIG Cluster
    chmod 644 /sys/module/cpu_boost/parameters/input_boost_freq
    echo 0:1171200 1:0 2:0 3:0 4:0 5:0 6:0 7:0 > /sys/module/cpu_boost/parameters/input_boost_freq
    chmod 644 /sys/module/cpu_boost/parameters/input_boost_ms
    echo 1000 > /sys/module/cpu_boost/parameters/input_boost_ms
fi
sleep 0.3
echo "=========================================="
#Disable TouchBoost
echo Disabling TouchBoost
    if [ -e "/sys/module/msm_performance/parameters/touchboost" ]; then
    chmod 644 /sys/module/msm_performance/parameters/touchboost
    echo 0 > /sys/module/msm_performance/parameters/touchboost
else
    echo "*Not supported for your current Kernel*"
fi
#Disable BCL
#echo Disabling BCL and Removing Perfd
#echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
#Enable Core Control and Disable MSM Thermal Throttling allowing for longer sustained performance
#echo Disabling Aggressive CPU Thermal Throttling
#echo 1 > /sys/module/msm_thermal/core_control/enabled
#echo N > /sys/module/msm_thermal/parameters/enabled
#Tweak HMP Scheduler
sleep 0.3
echo Tweaking HMP Scheduler
echo 2 > /proc/sys/kernel/sched_window_stats_policy
echo 45 > /proc/sys/kernel/sched_downmigrate
echo 80 > /proc/sys/kernel/sched_upmigrate
echo 3 > /proc/sys/kernel/sched_spill_nr_run
echo 60 > /proc/sys/kernel/sched_spill_load
echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
echo 1000000 > /proc/sys/kernel/sched_rt_period_us
echo 5 > /proc/sys/kernel/sched_ravg_hist_size
echo 15 > /proc/sys/kernel/sched_init_task_load
echo 0 > /proc/sys/kernel/sched_restrict_cluster_spill
echo 100 > /proc/sys/kernel/sched_rr_timeslice_ms
if [ -e "/proc/sys/kernel/sched_enable_power_aware" ]; then
    echo 1 > /proc/sys/kernel/sched_enable_power_aware
fi
if [ -e "/proc/sys/kernel/sched_small_wakee_task_load" ]; then
	echo 10 > /proc/sys/kernel/sched_small_wakee_task_load
fi
if [ -e "/proc/sys/kernel/sched_wakeup_load_threshold" ]; then
	echo 110 > /proc/sys/kernel/sched_wakeup_load_threshold
fi
if [ -e "/proc/sys/kernel/sched_big_waker_task_load" ]; then
	echo 25 > /proc/sys/kernel/sched_big_waker_task_load
fi
if [ -e "/proc/sys/kernel/sched_freq_dec_notify" ]; then
	echo 500000 > /proc/sys/kernel/sched_freq_dec_notify
fi
if [ -e "/proc/sys/kernel/sched_freq_inc_notify" ]; then
	echo 100000 > /proc/sys/kernel/sched_freq_inc_notify
fi
if [ -e "/proc/sys/kernel/sched_boost" ]; then
	echo 1 > /proc/sys/kernel/sched_boost
fi
#Tweaks for other various Settings
sleep 0.5
echo "=========================================="
echo Tweaking other various Settings
echo ·I/O Values
if [ -d /sys/block/sda ] || [ -d /sys/devices/virtual/block/dm-0 ]; then
	if [ -e /sys/devices/virtual/block/dm-0/queue/scheduler ]; then
		DM_PATH=/sys/devices/virtual/block/dm-0/queue
	fi
	if [ -e /sys/block/sda/queue/scheduler ]; then
		DM_PATH=/sys/block/sda/queue
	fi
	string=$DM_PATH/scheduler;
	Cfq_Available=false;
	if  $BB grep 'cfq' $string; then
		 Cfq_Available=true;
	fi
	if [ "$Cfq_Available" == "true" ]; then
		if [ -e $DM_PATH/scheduler_hard ]; then
		   echo cfq > $DM_PATH/scheduler_hard
		fi
		echo cfq > $DM_PATH/scheduler
		sleep 2
		echo 2 > $DM_PATH/iosched/back_seek_penalty
		echo 0 > $DM_PATH/iosched/group_idle
		echo 0 > $DM_PATH/iosched/slice_idle
		echo 1 > $DM_PATH/iosched/low_latency
		echo 8 > $DM_PATH/iosched/quantum
		echo 300 > $DM_PATH/iosched/target_latency
	fi
	if [ "$Cfq_Available" = "false" ]; then
		if grep -q 'ro.build.flavor=cm_oneplus3-userdebug' /system/system/build.prop; then
			echo CFQ not avalible, setting 'Noop' instead...
		if [ -e $DM_PATH/scheduler_hard ]; then
				echo noop > $DM_PATH/scheduler_hard
			fi
			echo noop > $DM_PATH/scheduler
		else
			echo CFQ not avalible, setting 'ZEN' instead...		
		if [ -e $DM_PATH/scheduler_hard ]; then
				echo zen > $DM_PATH/scheduler_hard
			fi
			echo zen > $DM_PATH/scheduler
		fi
	fi
fi
for i in /sys/block/../devices/soc/624000.ufshc/host0/target0:0:0/0:0:0:[0-4]/block/*/queue; do
  string4=$($BB readlink -f $i/scheduler | cut -d 'q' -f1 | cut -d 'k' -f2 | cut -d '/' -f2 | tr a-z A-Z)
  string5=$($BB cat $i/scheduler | cut -d ']' -f1 | cut -d '[' -f2 | $BB tr a-z A-Z)
  if [ "$string5" == "NOOP" ]; then
      echo "Leaving $string4 block at default $string5"
      echo ""
      sleep 0.1
  fi
  if [ "$string5" != "NOOP" ]; then
      echo "Changing $string4 block I/O scheduler"
      if [ -e $i/scheduler_hard ]; then
          echo cfq > $i/scheduler_hard
      fi
      echo cfq > $i/scheduler
      echo ""
      sleep 2
      # Initialize string 6 to avoid reference conflicts
      string6=$($BB cat $i/scheduler | cut -d ']' -f1 | cut -d '[' -f2)
      if [ "$string6" == "cfq" ]; then
         echo 2 > $i/iosched/back_seek_penalty
         echo 0 > $i/iosched/group_idle
         echo 0 > $i/iosched/slice_idle
         echo 1 > $i/iosched/low_latency
         echo 8 > $i/iosched/quantum
         echo 300 > $i/iosched/target_latency
    fi
  fi
done
if [ -e "$DM_PATH/iostats" ]; then
	echo 0 > $DM_PATH/iostats
fi
if [ -e "$DM_PATH/rq_affinity" ]; then
	echo 1 > $DM_PATH/rq_affinity
fi
if [ -e "/sys/block/dm-0/bdi/read_ahead_kb" ]; then
	echo 128 > /sys/devices/virtual/block/dm-0/bdi/read_ahead_kb
fi
if [ -e "/sys/block/sda/bdi/read_ahead_kb" ]; then
	echo 128 > /sys/block/sda/bdi/read_ahead_kb
fi
if [ -e "/sys/module/lowmemorykiller/parameters/enable_adaptive_lmk" ]; then
chmod 666 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
chown root /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
fi
if [ -e "/sys/module/lowmemorykiller/parameters/enable_adaptive_lmk" ]; then
	echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
else
	echo ' *Adaptive LMK is not present on your Kernel* '
fi
echo ·TCP Values
string2=/proc/sys/net/ipv4/tcp_available_congestion_control
if $BB grep 'cubic' $string2; then
   echo cubic > /proc/sys/net/ipv4/tcp_congestion_control
else
	echo cubic not avilable, using westwood
	echo westwood > /proc/sys/net/ipv4/tcp_congestion_control 
fi
sleep 1
echo ------------------------------------------------------------
echo 'Burnout R1 ' Successfully Applied!
echo "Burnout R1" > /data/system/current_profile
echo   You may now tweak them further
echo    using EXKM or Kernel Adiutor
echo ------------------------------------------------------------
echo ""
echo " Done,  press ENTER then close"
sleep 4

#################################################
#Modded by Mostafa_Wael, All thanks to patalao, Asiier and Senthil360
#Please say thanks and give proper credits if you're using this profile. 
#Credits
#*soniCron *Alcolawl *RogerF81 *Asiier *Mostafa Wael *Senthil360 and all of those that have share their profiles on Nexus 5X/6P Advanced Interactive Tweaks respective threads. 
