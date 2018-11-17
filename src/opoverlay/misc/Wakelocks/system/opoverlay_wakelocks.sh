#!/system/bin/sh
#set -e

MODDIR=${0%/*}

opoverlay_wakelocks()
{
sleep 15
pm enable 'com.google.android.gms/.update.SystemUpdateService'
sleep 1
pm disable 'com.google.android.gsf/.update.SystemUpdateService'
sleep 1
pm disable 'com.google.android.gms/.update.SystemUpdateActivity'
sleep 1
pm disable 'com.google.android.gms/.update.SystemUpdateService$ActiveReceiver'
sleep 1
pm disable 'com.google.android.gms/.update.SystemUpdateService$Receiver'
sleep 1
pm disable 'com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver'
sleep 1
pm disable 'com.google.android.gsf/.update.SystemUpdateActivity'
sleep 1
pm disable 'com.google.android.gsf/.update.SystemUpdatePanoActivity'
sleep 1
pm disable 'com.google.android.gsf/.update.SystemUpdateService$Receiver'
sleep 1
pm disable 'com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver'	
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.analytics.AnalyticsReceiver'
sleep 1
pm disable 'com.google.android.gms/com.google.android.location.internal.AnalyticsSamplerReceiver'
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.measurement.AppMeasurementInstallReferrerReceiver'
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.measurement.AppMeasurementReceiver'
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.measurement.PackageMeasurementReceiver'
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.measurement.AppMeasurementService'
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.measurement.service.MeasurementBrokerService'
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.measurement.PackageMeasurementService'
sleep 1
pm disable 'com.android.vending/com.google.android.gms.measurement.AppMeasurementReceiver'
sleep 1
pm disable 'com.android.vending/com.google.firebase.iid.FirebaseInstanceIdInternalReceiver'
sleep 1
pm disable 'com.android.vending/com.google.firebase.iid.FirebaseInstanceIdReceiver'	
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.gcm.nts.SchedulerInternalReceiver'
sleep 1
pm disable 'com.google.android.gms/com.google.android.gms.gcm.nts.SchedulerReceiver'
log_folder="/sdcard/opoverlay/logs/"
opoverlay_script_logfile=$log_folder"opoverlay_scripts.log"
log_message="--> Block Google Wakelocks" 
echo $log_message | tee -a $opoverlay_script_logfile
}

opoverlay_wakelocks &
sync
exit 0

