***
[TOC]
***

# `1. 设置固件类型` 
添加好虚拟机,设置固件类型为UEFI(vmware中可在指定虚拟机的设置->选项->高级-> 固件类型中设置模式).

# `2. 设置全屏为自动适应客户机`
启动archlinux,设置全屏为自动适应客户机(编辑->显示->全屏).

# `3. Verify the boot mode`
```
ls /sys/firmware/efi/efivars

如果目录存在,是UFI引导模式;否,BIOS模式.
```

# `4. Connect to the Internet`
```
# ping www.baidu.com

# ip link

# ip link set ens33 up
# dhcpcd ens33
```

# `5. Update mirrorlist`
```
pacman -Sy
pacman -S reflector
reflector --verbose -l 10 -p http --sort rate --save /etc/pacman.d/mirrorlist
```

# `6. Partition the disks`

```
//找到自己的硬盘设备/dev/nvme0n1
fdisk -l

//创建分区
fdisk /dev/nvme0n1
g
n
<Enter>
<Enter>
+200M
n
<Enter>
<Enter>
+200M
n
<Enter>
<Enter>
<Enter>
w

//Examine
lsblk
```

```
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

ext4文件系统的实现方式不同于fat,没有必要4K对齐.
```
```
//挂载系统位置
mount /dev/nvme0n1p3 /mnt

mkdir /mnt/boot
mount /dev/nvme0n1p2 /mnt/boot

mkdir /mnt/boot/EFI
mount /dev/nvme0n1p1 /mnt/boot/EFI

//Examine
lsblk
```

# `7. Install the base packages`

```
pacstrap /mnt base base-devel net-tools linux-headers
```

# `8. Fstab`

```
genfstab -U /mnt >> /mnt/etc/fstab
```

# `9. Chroot`

```
arch-chroot /mnt
```

# `10. Localization`

``` 
# vi /etc/locale.gen  ==> 删除 "en_US.UTF-8 UTF-8" "zh_CN.UTF-8 UTF-8" 前面的#号.
# locale-gen
```
```
echo LANG=en_US.UTF-8 >> /etc/locale.conf
```

# `11. Time zone`

```
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
vi /etc/localtime ==>CST-8 ==> CST-0
hwclock --systohc
date
```

# `12. Network configuration`
```
echo eit-pc >> /etc/hostname
```
```
vi /etc/hosts

127.0.0.1    localhost
::1		    localhost
127.0.1.1	eit-pc.localdomain	eit-pc
```

# `13. Initramfs`

```
# mkinitcpio -p linux
```

# `14. Root password`

```
# passwd
```

# `15. Add user`

```
# useradd -m -G wheel eit0
# passwd eit0

// remember to open sudo privillige for wheel group in /etc/sudoers
```

# `16. Boot loader`
```
# pacman -S grub efibootmgr
# grub-install --target=x86_64-efi --efi-directory=/boot/EFI --recheck
# grub-mkconfig -o /boot/grub/grub.cfg

这里可以与 "/etc/fstab" 对下,可能导致系统启动不了.
```

# `17. Reboot`

```
# exit
# umount -R /mnt
# reboot
```

# `18. i3`

```
$ sudo pacman -S xf86-input-vmmouse xf86-video-vmware mesa
$ sudo pacman -S xorg-server xorg-xinit
$ sudo pacman -S zsh xfce4-terminal feh compton i3-gaps
$ sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
$ sudo pacman -S i3  {3..5}
$ sudo chsh -s /bin/zsh

在.xinitrc添加如下内容                                   
exec i3
重启后startx进入图形界面
```

# `19. fonts`

```
$ sudo pacman -S wqy-zenhei ttf-fireflysung
$ sudo pacman -S firefox
$ sudo cp ~/Download/xxx.ttf /usr/share/fonts
$ sudo chmod 444  /usr/share/fonts/xxx.ttf
```

# `20. vm-tools`
```
点击虚拟机的安装wm-tools

$ sudo mkdir /mnt/vm-tools/
$ sudo mount /dev/cdrom/ /mnt/vm-tools/
$ ls /mnt/vm-tools/
$ tar -zxvf /mnt/vm-tools/VMwareTools.tar.gz
$ pwd
$ cd vmware-tools-distrib
$ ls
$ sudo for x in {0..6}; do mkdir -p /etc/init.d/rc${x}.d; done
$ sudo ./vmware-install.pl

$ sudo pacman -S asp
$ asp checkout open-vm-tools
$ cd open-vm-tools/repos/community-x86_64/
$ makepkg -s --asdeps

# cp vm* /usr/lib/systemd/system
# systemctl enable vmware-vmblock-fuse.service
# systemctl enable vmtoolsd.service

# reboot

# /etc/init.d/rc6.d/K99vmware-tools start
```

# `code dump`

```
examine limit of core dump:

$ ulimit -c -H
unlimited
$ ulimit -c -S
unlimited

$ su
# ulimit -c -S
0
# ulimit -c -H
unlimited

```

```
alter limit of core dump:

# echo "* soft core unlimited" > /etc/security/limits.conf
# echo "* hard core unlimited" >> /etc/security/limits.conf
# echo "root soft core unlimited" >> /etc/security/limits.conf
# echo "root hard core unlimited" >> /etc/security/limits.conf
```

```
set placement of core dump:

# echo "/tmp/core-%e-%t-%p-%s" > /proc/sys/kernel/core_pattern

%e: programe name
%t: time, seconds
%p: pid
%s: signal who cause the coredump
```

