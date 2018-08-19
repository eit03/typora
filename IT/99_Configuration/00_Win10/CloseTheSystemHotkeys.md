***

[TOC]

***

# `关闭Win系列热键:`

1. `Win+R`打开注册表.
2. 定位到目录:`Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`.
3. 目录下新建`String Value`类型的值`DisabledHotkeys`.
4. 在值的`Value data`中写入D可以禁用`Win+D`;也可以是组合,如:D1234567890,可以禁用`Win+D`&`Win+1`&`Win+...`等等;不过要重启`Explorer`才会生效,也只有当前用户被配制.


# `关闭Ctrl+Space热键`

1. `Win+R`打开注册表.

2. 定位到目录:`Computer\HKEY_CURRENT_USER\Control Panel\Input Method\Hot Keys\00000010`.

3. 修改值`Key Modifiers`内容`02 c0 00 00` --> `00 c0 00 00`.  

   修改值`Virtual Key`内容`20 00 00 00` --> `ff 00 00 00`.  