1. $ sudo pacman -S xf86-input-synaptics

2. $ mv -f /usr/share/X11/xorg.conf.d/70-synaptics.conf /etc/X11/xorg.conf.d

3. ```
   Section "InputClass"
       Identifier "touchpad"
       Driver "synaptics"
       MatchIsTouchpad "on"
           # configures which mouse-button is reported on a non-corner, one 
           # finger tap.
           Option "TapButton1" "1"
           # configures which mouse-button is reported on a non-corner, two 
           # finger tap
           Option "TapButton2" "3"
           # configures which mouse-button is reported on a non-corner, three
           # finger tap
           Option "TapButton3" "2"
           ...
   EndSection
   ```
