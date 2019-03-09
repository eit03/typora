***
[toc]
***

# `1. Deploy environment:`

```
$ cd ~/linux-0.11
$ git clone https://github.com/tinyclub/linux-0.11-lab

$ sudo apt install vim cscope exuberant-ctags build-essential qemu lxterminal
$ sudo apt install bochs vgabios bochsbios bochs-doc bochs-x
$ sudo apt install libltdl7 bochs-sdl bochs-term
$ sudo apt install graphviz cflow
```

# `2. make image:`

```
$ uname -a
Linux eit-ubuntu-pc 4.18.0-15-generic #16~18.04.1-Ubuntu SMP
Thu Feb 7 14:06:04 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

$ cd linux-0.11-lab/

$ ls
0.11  book  callgraph  COPYING  doc  examples  images  Makefile
Makefile.cg  Makefile.emu  Makefile.head  Makefile.help
Makefile.tags  README.md  rootfs  src  TODO.md  tools

$ make help
[sudo] password for eit:
-----Linux 0.11 Lab (http://tinylab.org/linux-0.11-lab)-----

     :: Compile ::

     make --generate a kernel floppy Image with a fs on hda1
     make clean -- clean the object files
     make distclean -- only keep the source code files

     :: Test ::

     make start -- start the kernel in vm (qemu/bochs)
     make start-fd -- start the kernel with fs in floppy
     make start-hd -- start the kernel with fs in hard disk
     make start-hd G=0 -- start with curses based terminal, instead of SDL


     :: Debug ::

     make debug -- debug the kernel in qemu/bochs & gdb at port 1234
     make debug-fd -- debug the kernel with fs in floppy
     make debug-hd -- debug the kernel with fs in hard disk

     make debug DST=boot/bootsect.sym -- debug bootsect
     make debug DST=boot/setup.sym    -- debug setup

     make boot BOCHS=bochs-debugger VM=bochs -- debug with bochs internal debugger

     make switch             -- switch the emulator: qemu and bochs
     make boot VM=qemu|bochs -- switch the emulator: qemu and bochs

     :: Read ::

     make cscope -- genereate the cscope index databases
     make tags -- generate the tag file
     make cg -- generate callgraph of the default main entry
     make cg f=func d=dir|file b=browser -- generate callgraph of func in file/directory

     :: More ::

     >>> README.md <<<

     ~ Enjoy It ~

-----Linux 0.11 Lab (http://tinylab.org/linux-0.11-lab)-----

--->  Linux Kernel Lab (http://tinylab.org/linux-lab)   <---

// debug infos for preprocess macro
$ vim src/Makefile.head
31   CFLAGS  = -gdwarf-2 -g3 -m32 -fno-builtin -fno-stack-protector -fomit-frame-pointer -fstrength-reduce #-Wall

$ make
RAMDISK_START=256 tools/build.sh boot/bootsect boot/setup kernel.bin Image
```

# `3. start:`

```
$ make debug

ctrl + alt + t
$ gdb --quiet src/kernel.sym
```