***
[TOC]
***

# `final configuration`

```
$ sudo vim ~/.config/i3/config

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+q layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# bar
bar {
	status_command i3status
	
	# bar mode
	mode hide  
	hidden_state hide 
	# hotkey display bar
  modifier Mod1  
  
  #bar height
	height 16  
}

# do not hide window border near to screen edge 
hide_edge_borders none
# set all tiling windows border to 2 pixel
for_window [tiling] border pixel 2
# set all floating windows border to 2 pixel
for_window [floating] border pixel 2

# set desktop bkground image
exec_always --no-startup-id feh --bg-fill /home/eit/background.jpg
# compton
exec compton &
```




```
$ sudo pacman -S xf86-input-vmmouse xf86-video-vmware mesa
$ sudo pacman -S xorg-server xorg-xinit
$ sudo pacman -S xfce4-terminal feh compton i3
$ sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc

在.xinitrc添加如下内容                                 
exec i3
注释其它冲突界面,dwm..
重启后startx进入图形界面
```




