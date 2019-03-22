
``` text
// single line
(gdb) b *0x00007ffff3754bb0 if ((XEvent*)$rsi)->xkey.type == (long)3 && ((XEvent*)$rsi)->xkey.keycode == 52

// more line
(gdb) b *0x00007ffff3754bb0 if \
((XEvent*)$rsi)->xkey.type == (long)3 && \
((XEvent*)$rsi)->xkey.keycode == 52

Breakpoint 5 at 0x7ffff3754bb0
...
Thread 1 "wps" hit Breakpoint 5, 0x00007ffff3754bb0 in ?? () from \
/opt/kingsoft/wps-office/office6/libQtCore.so.4
```