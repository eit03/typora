# ``

``` text

b XNextEvent


b XNextEvent if event->xkey.type == (long)2 && event->xkey.keycode == 33

event->xkey.type == 2       ==> KeyPress
event->xkey.keycode == 52   ==> 'z'
                    == 33   ==> 'p'
                    == 37   ==> ctrl

QWidget::event
*(short*)($rsi+0x10) == 6 && *(int*)($rsi+0x20) == 0x50
```