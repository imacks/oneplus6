#!/system/bin/sh

check_values()
{
while [ "$(getprop ro.product.model)" == "" ]
do
  sleep 0.1
done
if [ ! "$(getprop ro.build.version.sdk)" == "28" ] && [ "$(getprop ro.build.user)" == "OnePlus" ]; then
	resetprop -v -n "ro.build.display.id" "Rom_Version_Info"
	#resetprop -v -n "ro.product.model" "$(getprop ro.product.model) + Rom_Version_Info"
	#resetprop -v -n "ro.build.version.release" "$(getprop ro.build.version.release) + Rom_Version_Info"		
else
	resetprop -v -n "ro.build.display.id" "Rom_Version_Info"
	#resetprop -v -n "ro.product.model" "$(getprop ro.product.model) + Rom_Version_Info"	
fi
}

check_values &

