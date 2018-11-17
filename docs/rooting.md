Hardware Boot Modes
===================
OnePlus 6 uses the following button combos to enter different modes:

Fastboot/bootloader mode
------------------------
1. Turn phone off.
2. Hold VolumeUp + Power until fastboot screen appears.

Recovery mode
-------------
1. Turn phone off
2. Hold VolumeDown + Power until vendor logo appears.

PC Drivers
==========
You need to install the following on you PC in order to program OnePlus 6:
- OnePlus 6 drivers
- [https://dl.google.com/android/repository/platform-tools-latest-windows.zip](Fastboot and ADB drivers)

Precaution
==========
Note the following before continuing:
1. Device battery level should be above 60%
2. Rooting will wipe your device. Backup your data first!

Prepare device for root
=======================
1. Enable developer options: `Settings` > `About phone`. Tap on Build number 7 times.
2. Enable usb debugging: `Settings` > `Developer options` > `Enable USB debugging`
3. Enable OEM unlocking: `Settings` > `Developer options` > `OEM Unlocking`
4. Enable advance reboot: `Settings` > `Developer options` > `Advanced Reboot`. You can now boot into other modes without using hardware button combos.

Unlock bootloader
=================
1. Put phone to fastboot mode
2. Connect phone to PC
3. Run command prompt on your PC. Admin not required.
4. `fastboot devices`. Your phone serial should show up.
5. `fastboot oem unlock`. Use volume up/down and power button to navigate and select. This will wipe your device.
6. Phone should reboot, show secure boot warning, reboot again to recovery, wipe data, and finally boot back to the OS.
7. Prep device for [#prepare-device-for-root](root again)

Flash custom recovery
=====================
OnePlus 6 uses the new AB partition scheme, so flashing recovery is different from before:
1. Put [https://dl.twrp.me/enchilada/](TWRP) zip version to device internal memory.
2. Put TWRP img on PC.
3. Boot phone to fastboot mode.
4. Run command prompt on your PC. Admin not required.
5. `fastboot boot twrp.img`. This will boot your phone temporarily to the custom recovery.
6. From your phone (now in TWRP), install the zip version of TWRP in internal memory. Now TWRP is installed permanantly.
7. Do not flash partial OTA deltas! It will soft brick your device. Always flash full roms only.

Root phone
==========
1. Put [https://github.com/topjohnwu/Magisk/releases](Magisk) on your internal memory.
2. Boot into recovery (TWRP).
3. Systemless root put modifications in the boot partition, so Google SafetyNet cannot detect whether the system is rooted. Continue without swiping right to enable systemless root.
4. Select language
5. Tap "Never show this screen on boot again"
6. Swipe "allow modification"
7. Swipe to confirm
8. Reboot system to finish.

EFS backup
==========
The EFS partition contains device unique information such as IMEI number, so backuping it up is very important.

1. Install [https://play.google.com/store/apps/details?id=jackpal.androidterm](terminal emulator) on your phone
2. Run terminal emulator:
```bash
su
dd if=/dev/block/sdf2 of=/sdcard/modemst1.bin bs=2048
dd if=/dev/block/sdf3 of=/sdcard/modemst2.bin bs=2048
```
3. Save `/sdcard/modemst1.bin` and `/sdcard/modemst2.bin` somewhere safe.
4. To restore, connect your phone to your PC, boot phone to fastboot mode, and issue the following commands on your PC:
```bash
fastboot flash modemst1 modemst1.bin
fastboot flash modemst2 modemst2.bin
fastboot reboot
```

Nandroid backup
===============
You can take a backup of your device OS using TWRP. Make sure you have eough internal storage space before backup.

1. Disable screen lock: `Settings` > `Security` > `Screen Lock` > `Swipe/None`. You will have problem getting into your phone from the backup if you forget this step.
2. Boot into recovery. Go to `Backup` and select all the listed partitions.
3. Label your backup.
4. Swipe to take backup. This can take about 5-7 minutes depending upon the size of data.
5. Reboot system when done.
6. Copy `/sdcard/TWRP/BACKUPS` from your internal memory to somewhere safe.
7. To restore, copy your backup to `/sdcard/TWRP/BACKUPS`.
8. Boot to recovery and go to `Restore` menu. Select the name of the backup.
9. Select the partitions to restore.
10. Swipe to restore. The process will take 5-7 minutes.
11. Reboot system when done.
