How to modify TWRP Splash
=========================
Here's how to modify the boot splash if TWRP.

1. Take the image apart by dragging the `.img` version of twrp to "Android Image Kitchen\unpackimg.bat". This will create a couple more folders in the "Android Image Kitchen" directory.
2. Modify "ramdisk\twres\images\splashlogo.png".
3. Double click "Android Image Kitchen\repackimg.bat". This will create `image-new.img` and `ramdisk-new-cpio.gz`
4. Extract the `.zip` version of TWRP into a directory. Extract `ramdisk-new-cpio.gz` and replace the extracted `.cpio` file as `ramdisk-twrp.cpio` in the twrp directory.
5. Run `twrp\MakeFlashZip.bat`. Choose the extracted directory in step 4, and the program will create a zip file.
6. Copy the flash zip created in step 5 to your phone.
7. Put `image-new.img` in `\platform-tools`. Put your phone in fastboot mode and boot off the new image: `fastboot boot image-new.img`.
8. If it worked, proceed to flash the zip file in your phone's internal memory.
9. Wipe your cache and reboot.
10. Reboot into recovery. You should see the new logo.
11. Reflash magisk root, wipe cache and reboot.
