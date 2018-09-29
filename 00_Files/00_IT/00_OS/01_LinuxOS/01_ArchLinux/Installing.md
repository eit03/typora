

1. Verify the boot mode

   ```
   ls /sys/firmware/efi/efivars
   
   如果目录存在,是UFI引导模式;否,BIOS模式.
   vmware中可在指定虚拟机的设置->选项->高级-> 固件类型中设置模式.
   ```

2. Connect to the Internet

   ```
   # ping www.baidu.com
   
   # ip link
   
   # ip link set ens33 up
   # dhcpcd ens33
   ```

3. Update mirrorlist

   ```
   pacman -Sy
   pacman -S reflector
   reflector --verbose -l 10 -p http --sort rate --save /etc/pacman.d/mirrorlist
   ```

4. Partition the disks

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
   mount /dev/nvme0n1p2 /mnt
   
   mkdir /mnt/boot/EFI
   mount /dev/nvme0n1p1 /mnt
   ```

5. Install the base packages

   ```
   pacstrap /mnt base base-devel net-tools linux-headers
   ```

6. Fstab

   ```
   genfstab -U /mnt >> /mnt/etc/fstab
   ```

7. Chroot

   ```
   arch-chroot /mnt
   ```

8. Time zone

   ```
   ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
   hwclock --systohc
   date
   ```

9. Localization

   ``` 
   vim /etc/locale.gen  ==> 删除 "en_US.UTF-8 UTF-8" "zh_CN.UTF-8 UTF-8" 前面的#号.
   locale-gen
   ```

   ```
   echo LANG=en_US.UTF-8 >> /etc/locale.conf
   ```

10. Network configuration

    ```
    echo eit-pc >> /etc/hostname
    ```

    ```
    vi /etc/hosts
    
    127.0.0.1    localhost
    ::1		    localhost
    127.0.1.1	eit-pc.localdomain	eit-pc
    
    ```

11. Initramfs

    ```
    # mkinitcpio -p linux
    ```

12. Root password

    ```
    # passwd
    ```

13. Add user

    ```
    # useradd -m -g users eit0
    # passwd eit0
    # nano /etc/sudoers  ==> 添加 "eit0 ALL=(ALL) ALL" 
    ```

14. Boot loader

    ```
    # pacman -S grub efibootmgr
    # grub-install --target=x86_64-efi --efi-directory=/boot/EFI --recheck
    # grub-mkconfig -o /boot/grub/grub.cfg
    
    这里可以与 "/mnt/etc/fstab" 对下,可能导致系统启动不了.
    ```

15. Reboot

    ```
    # exit
    # umount -R /mnt
    # reboot
    ```

16. connect net

    ```
    $ sudo ip link
    $ sudo ip link set ens33 up
    $ sudo dhcpcd ens33
    ```

17. vmtools

    ```
    pacman -S xorg-server xorg-xinit
    pacman -S zsh xfce4-terminal feh compton i3-gaps
    useradd -m -g users -G wheel -s /bin/zsh username
    su username
    sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
    
    在.xinitrc添加如下内容
    exec compton -b &
    exec fcitx &                                     
    exec i3 -V >> ~/.config/i3/log/i3log-$(date +'%F-%k-%M-%S') 2>&1
    重启后startx进入图形界面
    ```



    ```
    $ sudo pacman -S xf86-video-vmware
    $ sudo pacman -S xorg-server xorg-xinit 
    $ sudo pacman -S zsh xfce4-terminal feh compton i3-gaps
    ```
    
    ```
    点击虚拟机的安装wm-tools
    
    $ mkdir /mnt/vm-tools/
    $ sudo mount /dev/cdrom/ /mnt/vm-tools/
    $ ls /mnt/vm-tools/
    $ tar -zxvf /mnt/vm-tools/VMwareTools.tar.gz
    $ pwd
    $ cd vmware-tools-distrib
    $ ls
    $ sudo for x in {0..6}; do mkdir -p /etc/init.d/rc${x}.d; done
    $ sudo ./vmware-install.pl
    ```