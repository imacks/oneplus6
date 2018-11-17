#!/sbin/sh

#
# This script installs the Xposed framework files to the system partition.
# The Xposed Installer app is needed as well to manage the installed modules.
#
# Thanks to arter97 and Chainfire for the base and logic of this script!
#

OUTFD=$2
ZIP=$3

SYSTEMLIB=/system/lib

readlink /proc/$$/fd/$OUTFD 2>/dev/null | grep /tmp >/dev/null
if [ "$?" -eq "0" ]; then
  # rerouted to log file, we don't want our ui_print commands going there
  OUTFD=0

  # we are probably running in embedded mode, see if we can find the right fd
  # we know the fd is a pipe and that the parent updater may have been started as
  # 'update-binary 3 fd zipfile'
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
fi

ui_print() {
  echo -n -e "ui_print $1\n" >> /proc/self/fd/$OUTFD
  echo -n -e "ui_print\n" >> /proc/self/fd/$OUTFD
}


ch_con() {
  LD_LIBRARY_PATH=$SYSTEMLIB /system/toolbox chcon -h u:object_r:system_file:s0 $1
  LD_LIBRARY_PATH=$SYSTEMLIB /system/bin/toolbox chcon -h u:object_r:system_file:s0 $1
  chcon -h u:object_r:system_file:s0 $1
  LD_LIBRARY_PATH=$SYSTEMLIB /system/toolbox chcon u:object_r:system_file:s0 $1
  LD_LIBRARY_PATH=$SYSTEMLIB /system/bin/toolbox chcon u:object_r:system_file:s0 $1
  chcon u:object_r:system_file:s0 $1
}

ch_con_ext() {
  LD_LIBRARY_PATH=$SYSTEMLIB /system/toolbox chcon $2 $1
  LD_LIBRARY_PATH=$SYSTEMLIB /system/bin/toolbox chcon $2 $1
  chcon $2 $1
}

ln_ext() {
  LD_LIBRARY_PATH=$SYSTEMLIB /system/toolbox ln -s $1 $2
  LD_LIBRARY_PATH=$SYSTEMLIB /system/bin/toolbox ln -s $1 $2
  ln -s $1 $2
}

set_perm() {
  chown $1.$2 $4
  chown $1:$2 $4
  chmod $3 $4
  ch_con $4
  ch_con_ext $4 $5
}

cp_perm() {
  rm $5
  cat $4 > $5
  set_perm $1 $2 $3 $5 $6
}

install_and_link() {
  TARGET=$1
  XPOSED="${1}_xposed"
  BACKUP="${1}_original"
  if [ ! -f "/tmp/xposed/$XPOSED" ]; then
    return
  fi
  cp_perm $2 $3 $4 /tmp/xposed/$XPOSED $XPOSED $5
  if [ ! -f $BACKUP ]; then
    mv $TARGET $BACKUP
    ln_ext $XPOSED $TARGET
  fi
}

install_overwrite() {
  TARGET=$1
  if [ ! -f "/tmp/xposed/$TARGET" ]; then
    return
  fi
  BACKUP="${1}.orig"
  NO_ORIG="${1}.no_orig"
  if [ ! -f $TARGET ]; then
    echo -n > $NO_ORIG
  elif [ ! -f $BACKUP -a ! -f $NO_ORIG ]; then
    mv $TARGET $BACKUP
  fi
  cp_perm $2 $3 $4 /tmp/xposed/$TARGET $TARGET $5
}

ui_print "******************************"
ui_print "Xposed framework installer zip"
ui_print "for Samsung Touchwiz by arter97"
ui_print "******************************"

ui_print "- Checking environment"
API=$(cat /system/build.prop | grep "ro.build.version.sdk=" | dd bs=1 skip=21 count=2)
ABI=$(cat /system/build.prop /default.prop | grep -m 1 "ro.product.cpu.abi=" | dd bs=1 skip=19 count=3)
ABILONG=$(cat /system/build.prop /default.prop | grep -m 1 "ro.product.cpu.abi=" | dd bs=1 skip=19)
ABI2=$(cat /system/build.prop /default.prop | grep -m 1 "ro.product.cpu.abi2=" | dd bs=1 skip=20 count=3)

XVERSION=$(grep -m 1 "^version=" /tmp/xposed/system/xposed.prop | dd bs=1 skip=8)
XARCH=$(grep -m 1 "^arch=" /tmp/xposed/system/xposed.prop | dd bs=1 skip=5)
XMINSDK=$(grep -m 1 "^minsdk=" /tmp/xposed/system/xposed.prop | dd bs=1 skip=7)
XMAXSDK=$(grep -m 1 "^maxsdk=" /tmp/xposed/system/xposed.prop | dd bs=1 skip=7)

ARCH=arm
IS64BIT=false
RC=0
if [ "$ABI" = "x86" ]; then ARCH=x86; fi;
if [ "$ABI2" = "x86" ]; then ARCH=x86; fi;
if [ "$API" -eq "$API" ]; then
  if [ "$API" -ge "21" ]; then
    if [ "$ABILONG" = "arm64-v8a" ]; then ARCH=arm64; SYSTEMLIB=/system/lib64; IS64BIT=true; fi;
    if [ "$ABILONG" = "x86_64" ]; then ARCH=x64; SYSTEMLIB=/system/lib64; IS64BIT=true; fi;
  fi
fi

#ui_print "DBG [$API] [$ABI] [$ABI2] [$ABILONG] [$ARCH] [$XARCH] [$XMINSDK] [$XMAXSDK] [$XVERSION]"

ui_print "  Xposed version: $XVERSION"

XVALID=true

if ($XVALID); then

  # The included core-libart.jar has 3 different versions.
  # 1 : Firmwares with appStartup
  # 2 : Firmwares without appStartup
  # 3 : Firmwares without isMdfEnforced
  if unzip -p /system/framework/core-libart.jar | grep -q appStartup; then
    LIBARTJAR=core-libart1.jar
  else
    LIBARTJAR=core-libart2.jar
  fi
  if ! unzip -p /system/framework/core-libart.jar | grep -q isMdfEnforced; then
    LIBARTJAR=core-libart3.jar
  fi

  ui_print "- Placing files"

  cat /system/bin/toolbox > /system/toolbox
  chmod 0755 /system/toolbox
  ch_con /system/toolbox

  cp_perm 0 0 0644 /tmp/xposed/system/xposed.prop /system/xposed.prop
  cp_perm 0 0 0644 /tmp/xposed/system/framework/XposedBridge.jar /system/framework/XposedBridge.jar

	install_and_link  /system/bin/app_process32               0 2000 0755 u:object_r:zygote_exec:s0
	install_overwrite /system/bin/dex2oat                     0 2000 0755 u:object_r:dex2oat_exec:s0
	install_overwrite /system/bin/dexdiag                     0 2000 0755
	install_overwrite /system/bin/dexlist                     0 2000 0755
	install_overwrite /system/bin/dexoptanalyzer              0 2000 0755 u:object_r:dexoptanalyzer_exec:s0
	install_overwrite /system/bin/oatdump                     0 2000 0755
	install_overwrite /system/bin/patchoat                    0 2000 0755 u:object_r:dex2oat_exec:s0
	install_overwrite /system/bin/profman                     0 2000 0755 u:object_r:profman_exec:s0

  cp /system/build.prop /system/build.prop.bak
  sed -i -e "/dalvik.vm.dex2oat-filter/d" /system/build.prop
  sed -i -e "/dalvik.vm.image-dex2oat-filter/d" /system/build.prop

  echo "dalvik.vm.dex2oat-filter=everything" >> /system/build.prop
  echo "dalvik.vm.image-dex2oat-filter=everything" >> /system/build.prop

  ui_print "  (installing $LIBARTJAR)"
  mv /tmp/xposed/system/framework/$LIBARTJAR /tmp/xposed/system/framework/core-libart.jar
  install_overwrite /system/framework/core-libart.jar       0    0 0644

	install_overwrite /system/lib/libart.so                   0    0 0644
	install_overwrite /system/lib/libart-compiler.so          0    0 0644
	install_overwrite /system/lib/libart-dexlayout.so         0    0 0644
	install_overwrite /system/lib/libart-disassembler.so      0    0 0644
	install_overwrite /system/lib/libsigchain.so              0    0 0644
	install_overwrite /system/lib/libopenjdkjvm.so            0    0 0644
	install_overwrite /system/lib/libopenjdkjvmti.so          0    0 0644
	install_nobackup  /system/lib/libxposed_art.so            0    0 0644
  if ($IS64BIT); then
	  install_and_link  /system/bin/app_process64             0 2000 0755 u:object_r:zygote_exec:s0
	  install_overwrite /system/lib64/libart.so               0    0 0644
	  install_overwrite /system/lib64/libart-compiler.so      0    0 0644
	  install_overwrite /system/lib64/libart-dexlayout.so     0    0 0644
	  install_overwrite /system/lib64/libart-disassembler.so  0    0 0644
	  install_overwrite /system/lib64/libsigchain.so          0    0 0644
	  install_overwrite /system/lib64/libopenjdkjvm.so        0    0 0644
	  install_overwrite /system/lib64/libopenjdkjvmti.so      0    0 0644
	  install_nobackup  /system/lib64/libxposed_art.so        0    0 0644
  fi

  rm /system/toolbox
else
  ui_print "! Please download the correct package"
  ui_print "! for your platform/ROM!"
  RC=1
fi

ui_print "- Done !"
sync
exit $RC
