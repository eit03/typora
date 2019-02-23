1. Win+R, cmd
2. DiskPart
3. listdisk
4. select disk <usb_number>
5. clean
6. create partition primary
7. select partition 1
8. active
9. format fs=ntfs quick
10. exit