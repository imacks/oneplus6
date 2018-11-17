#!/sbin/sh
#set -e

#
# Thanks to @klenamenis for the script base
# 

name=$1
tweak=/tmp/misc/Tweaks/build/$name
build=/tmp/Magisk/Module/system.prop

chmod 0666 $build
echo "" >> $build

## loop trough $tweak

## read only lines matching valid entry pattern (someVAR=someVAL, !someSTR, @someENTR|someSTR, $someVAR=someVAL)
sed -r '/(^#|^ *$|^BACKUP=)/d;/(.*=.*|^\!|^\@.*\|.*|^\$.*\|.*)/!d' $tweak | while read line
do
	## if line to be removed
	if echo $line | grep -q "^\!"
	then
		entry=${line#?}		
		## remove from $build if present
		grep -q $entry $build && (sed -i "/$entry/d" $build)
	## if appendix to existing entry
	elif echo $line | grep -q "^\@"
	then
		entry=${line#?}
		var=$(echo $entry | cut -d\| -f1)
		app=$(echo $entry | cut -d\| -f2)
		## append string to $var's value if present in $build
		grep -q $var $build && (sed -i "s/^$var=.*$/&$app/" $build)
	## if change of existing value
	elif echo $line | grep -q '^\$'
	then
		entry=${line#?}
		var=$(echo $entry | cut -d\| -f1)
		new=$(echo $entry | cut -d\| -f2)
		## change $var's value only if $var present in $build
		[ $(grep $var $build) = $var=$new ] || (sed -i "s/^$var=.*$/$var=$new/" $build)
	else
		var=$(echo $line | cut -d= -f1)
		## if variable already present in $build
		if grep -q $var $build
		then
			## override value in $build if different
			grep -q $(grep $var $tweak) $build || (sed -i "s/^$var=.*$/$line/" $build)
		## else append entry to $build
		else
			echo $line >> $build
		fi
	fi
done

## trim empty lines of $build
sed -i "/^ *$/d" $build
chmod 0644 $build

