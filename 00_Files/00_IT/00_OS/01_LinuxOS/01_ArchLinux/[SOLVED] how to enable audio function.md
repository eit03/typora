# `ALSA`
**ALSA** is the short words of Advance Linux Sound Achitecture.  

**ALSA** provides kernel driven sound card drivers. Besides the sound device  
drivers, ALSA also bundles a user space driven library for application  
developers. They can then use those ALSA drivers for high level API development.  
This enables direct (kernel) interaction with sound devices through  
ALSA libraries.  

# `install ALSA Utilities`
Install the alsa-utils pakage. This contains **amixer** and **alsamixer**  
utilities. **amixer** is a shell command to change the audio settings, and the  
**alsamixer** is more intuitive user interface to do that.  

# `set audio`
```
$ alsamixer
```
Left and right keys can change items.  
Up and down keys can change metrix of sound.  
M key can toggle mute efficts.  