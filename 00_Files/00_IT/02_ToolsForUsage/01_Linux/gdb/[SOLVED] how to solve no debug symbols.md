***
[toc]
***


# `1. Search debug symbols packages`

``` text
$ sudo apt list | grep dbg | grep x11

freerdp-x11-dbg/juniper 1.1.0~git20140921.1.440916e+dfsg1-5kord1 amd64
libx11-6-dbg/juniper 2:1.6.3-1kord2 amd64
libx11-xcb1-dbg/juniper 2:1.6.3-1kord2 amd64
python-pyqt5.qtx11extras-dbg/juniper 5.5.1+dfsg-3kord4 amd64
python3-pyqt5.qtx11extras-dbg/juniper 5.5.1+dfsg-3kord4 amd64
qtx11extras5-dbg/juniper 5.5.1-3build1kord amd64

```

# `2. Install`

``` text
$ sudo apt install libx11-6-dbg
```

# `3. Debug`

``` text
(gdb) p ((XEvent*)$rsi)->xkey
$3 = {
    type = 3,
    serial = 3951,
    send_event = 0,
    display = 0x32a7ad0,
    window = 60817437,
    root = 641,
    subwindow = 0,
    time = 1846969,
    x = 318,
    y = 440,
    x_root = 1106,
    y_root = 662,
    state = 0,
    keycode = 38,
    same_screen = 1
}
```