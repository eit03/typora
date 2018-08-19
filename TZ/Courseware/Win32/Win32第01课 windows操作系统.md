***
[TOC]
***

# `1. Windows四大模块程序`

## `1.1 控制台程序`
> 没有自己的窗口,dos-显示或者运行程序,入口mian().

## `1.2 窗口程序`
> 有自己的窗口,win32,mfc,qt,入口WinMain().

## `1.3 动态库`
> 后缀dll,不可以单独运行,直接注入到可执行程序中;入口函数DllMain,不是必须.

## `1.4 静态库`
> 以lib为后缀的程序,只用来存储代码和数据;执行程序直接赋值代码,没有入口函数.

# `2. 编译链接流程`
## `2.1 编辑器`
> 用来写编写代码的软件,可记事本程序,或其他可编辑的软件.

## `2.2 编译器`
> Cl.exe把代码翻译成目标文件obj,(cl.exe 源文件名)-产生obj.

## `2.3 链接器`
>link.exe –把obj文件和lib或dll文件链接成exe文件(link.exe obj的文件名 lib库名)
运行: 执行exe程序

## `2.4 资源编辑器`
> rc.exe 资源文件名 (资源包括图片图标 光标 菜单)
> (案例: 用记事本写代码,编译运行后得到结果)

# `3. 第一个win32应用程序`

```
#include <windows.h>


int __stdcall WinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPSTR lpCmdLine, _In_ int nShowCmd)
{
    MessageBoxW(0, L"这是内容", L"这是标题", MB_YESNO);

    return 0;
}
```

# `4. 编码方式`
1. 从windowsNT开始,windows完全使用unicode来构建,所以核心函数(创建窗口,显示文本,字符串处理)都提供了unicode版本;
2. 在window中,函数通常有两个版本,一个带w(wide)结尾和带A(ASNI)结尾的;MessageBoxA(….)MessageBoxW(…),通常情况,我们只接使用MessageBox就可以,如果是unicode编码方式会有一个UNICODE的宏,会直接根据条件编译调用后缀是W版本的;
3. windows API函数(openFile ,winExec等)只兼容于ANSI,不兼容unicode编码,所以需要转换成unicode效率低下并且转换是有可能有bug,所以用Createprocess和createfile替换;
4. ANSI中字符串处理      strlen(…) 
   Unicode中字符串处理   wcslen(…)
   兼容版本字符串处理函数   _tcslen();
5. unicode编码方式是两个字节代表一个字符,需要在字符串前加L,或者加_T(字符串)----兼容版本, sizeof(L“TANZHOU”) = 16;
6. 运行安全检查:添加头文件strsafe.h;
   Scanf 警告不安全,可能会操作一块不可以操作的内存.导致内存错误,所以微软重新提供_s的安全版本;
7. 修改unicode编码方式:
   菜单Project --> 最后一子菜单 --> Configuration Properties --> General --> Project Defaults -->Character Set.

# `5. 杂项知识`
## `5.1 messagebox详解`
```
Int MessageBox(
    HWND hWnd,//窗口句柄
    LPCSTR lpTt,//中间显示字符串
    LPCSTR lpCap,//标题字符串
    UINT uType);//显示类型
```

## `5.2 API概念`
application programming interface 应用程序接口.微软为了方便windows的应用开发,提供给开发者的各种函数,这些函数就是windows操作系统提供给应用程序的接口

## `5.3 SDK概念`
软件开发包.包含了API,说明文档,辅助开发工具.

## `5.4 头文件详解`
* windows.h---包含常用的windows的头文件,让开发者方便使用.
* winbase.h---内核API接口的封装,kenel32.dll
* winuser.h---用户界面相关接口的API封装,user32.lib
* socket------ws2_32.lib 涉及到网络编程socket的库文件

## `5.5 代码调试`
错误信息:
- GetLastError();
- 在watch窗口中选择一行,输入$err,hr后显示最后错误;
- 使用断言ASSERT(真),条件一定为真,是异常的高级形式;
- 使用OutputDebugString(“字符串”),输出窗口显示; 
  设置Options选项/Force Carriage Returns 为选择状态;
- TRACE宏: 打印信息和outputdebugstring一样,mfc中的;

# `6. 音乐媒体处理`
## `6.1 PlaySound`

`参考`

MSDN: https://msdn.microsoft.com/en-us/library/dd743680(VS.85).aspx.

百度百科: https://baike.baidu.com/item/PlaySound/5280948?fr=aladdin.

`简述`
PlaySound是Windows用于播放音乐的API函数(方法)。

`原型`

```
BOOL PlaySound( LPCTSTR pszSound, HMODULE hmod, DWORD fdwSound );
```

`参数`

pszSound: 它的含义由 fdwSound 指定;

hmod: 模块句柄;

fdwSound: 播放音乐标志;

- SND_FILENAME
- SND_LOOP | SND_ASYNC

`返回值`

成功为真;否为假;

`注意`

`要求`
|  |  |
| ------------------------ | --------------------------------------------- |
| Minimum supported client | Windows 2000 Professional [desktop apps only] |
| Minimum supported server | Windows 2000 Server [desktop apps only]       |
| Header                   | Mmsystem.h (include Windows.h)                |
| Library                  | Winmm.lib                                     |
| DLL                      | Winmm.dll                                     |
| Unicode and ANSI names   | PlaySoundW (Unicode) and PlaySoundA (ANSI)    |



## `6.2 MCI接口`

### `6.2.0 参考文献`

`MCI` https://msdn.microsoft.com/en-us/library/windows/desktop/dd757151(v=vs.85).aspx

`MCI Reference` https://msdn.microsoft.com/en-us/library/windows/desktop/dd743458(v=vs.85).aspx

`MCI Commands` https://msdn.microsoft.com/en-us/library/windows/desktop/dd743372(v=vs.85).aspx

### `6.2.1 简述`
> MCI ( Media Control Interface ) ，即媒体控制接口，向基于Windows操作系统的应用程序提供了高层次的控制媒体设备接口的能力。

> 使用MCI（媒体控制接口）播放音频文件，MCI为程序员提供了两种方式访问MCI设备或文件：
> 1.一种是消息接口函数方式；
> 2.一种是字符串接口函数方式;

### `6.2.2 消息接口函数方式`
```
MCIERROR  mciSendCommand(MCIDEVICEID IDDevice, UINT uMsg, DWORD fdwCommand, DWORD dwParam);  
```
`IDDevice`
用来表示一个MCI设备。MCI使用MCI_OPEN消息打开一个设备时自动创建一个标识号用以唯一标识要操作的设备，以后的消息操作均使用此标识。  
`uMsg`
表示要发出的消息，取值如下所示。   
- MCI_OPEN        打开一个设备   
- MCI_CLOSE       关闭一个设备   
- MCI_PLAY        播放全部或部分音频，从暂停状态恢复播放   
- MCI_PAUSE       暂停播放   
- MCI_STOP        停止播放   
- MCI_SEEK        改变当前位置   



- MCI_CUE         提示一个设备以最小的延迟开始播放或录制   
- MCI_RECORD      在一个设备上开始录制   
- MCI_SAVE        保存一个文件   
- MCI_INFO        查询设备信息，如产品名称等   
- MCI_GETDEVCAPS  查询产品特征，如设备类型等   
- MCI_STATUS      查询设备当前状态，如播放位置、媒体格式等   
- MCI_SET         设置设备参数，如时间格式、波形数据格式等   

`fdwCommand`
消息指定标志。   
`dwParam`
指定一个指向消息数据结构的指针。  

`返回值`
如果mciSendCommand函数调用成功则返回0，否则返回错误代码消息。所返回的DWORD低位字是错误代码，可以将它发送到mciGetErrorString函数，已获得对错误的文本描述。若错误事设备特有的，高位包含了设备ID,否则高位为0;

### `6.2.3 字符串接口函数方式`

```
MCIERROR  mciSendString(LPCTSTR lpszCommand, LPTSTR lpszReturnString, UINT cchReturn, HANDLE hwndCallback);   
```

```
lpszCommand:一个以NULL结尾的定义MCI控制命令的字符串，格式为：command device_name argument   
  
lpszReturnString:一个远指针，它指向由应用程序返回的字符串缓冲区。   
  
cchReturn:指定了缓冲区大小。   
  
hwndCallback:用来指定接收并处理MCI向应用程序发出的MM_MCINOTIFY消息窗口的句柄。

函数成功调用，则返回0，否则返回错误代码。可以将错误代码传递给mciGetErrorString函数获得对错误的文本描述。
```

# `7. 作业`

音乐播放器.

1. 实现 播放 & 暂停 & 停止; (必做)
2. 实现 下一曲 & 上一曲; (选做)