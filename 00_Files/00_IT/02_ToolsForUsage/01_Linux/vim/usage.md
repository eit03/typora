***
[TOC]
***

# `final configuration`

```
# vim /etc/vimrc

" highlight
set cursorline
highlight CursorLine cterm=NONE ctermbg=235

" line number
set number
```



# `highlight`

```
" highlight
set cursorline
highlight CursorLine cterm=NONE ctermbg=235

在vim命令模式下:hi可以看颜色表
```

# `line number`

```
" line number
set number
```

# `hex display`

```
vim:
:%!xxd -g 1 表示每1个字节为1组
:%!xxd -g 2 表示每2个字节为1组(默认)
:%!xxd -g 4 表示每4个字节为1组
:%!xxd -r 将vim恢复成原来的显示
man xxd可以获得xxd的帮助文件

hexdump:
hexdump -C [-s <skip_offset>] [-n <length>] <file>
```

