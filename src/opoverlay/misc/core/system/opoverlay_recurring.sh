#!/system/bin/sh
#set -e

opoverlay_recurring()
{
sleep 30
while [ true ]  
do
settings put global op_voice_recording_supported_by_mcc 1
sleep 1800
done
}

opoverlay_recurring &
sync
exit 0
