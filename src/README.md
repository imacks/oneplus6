1. 7zip the contents of the `opoverlay` folder. 
- Make sure the root directory inside the archive is not `/opoverlay/`.
- Compress options: 7z, normal. lzma2
- Rename output from `opoverlay.7z` to `opoverlay` (remove the extension)

2. Copy `opoverlay` file in step 1 to `romoverlay/META-INF/com/google/android/aroma/tmp`.

3. 7zip the contents of `romoverlay` folder
- Make sure the root directory inside the archive is not `/romoverlay/`.
- Compress options: zip, normal, deflate

4. Copy the output zip file in step 3 to `/sdcard/Download` of your rooted phone.

5. Copy `opoverlay.profile` to `/sdcard/` of your rooted phone.

6. Boot to TWRP.

7. Flash zip file from step 4 in `/sdcard/Download/`.

8. (Optional) Wipe cache

9. Reboot and enjoy
