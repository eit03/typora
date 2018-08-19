***
`Version:` 
`Declaration:` 
`Defination:` 
`Reference:` https://msdn.microsoft.com/en-us/library/windows/desktop/dd145203(v=vs.85).aspx
`Keyword:` GDI && Windows GDI

***
[TOC]
***



# `1. 简述`
图形设备接口:Graphics Device Interface,是微软设计的一套API，GDI是windows图形显示程序与实际物理设备之间的一个桥梁。使用者不需要关心硬件设备，只管调用API就好.

`GDI的特点:`
- 不直接访问物理显示硬件，通过”设备环境”的抽象接口访问
- 程序与硬件(显示器等)交互时，必须获得与相对应设备环境
- 使用者不用关心物理设备类型

`设备环境 Device Context:`
简称DC,也叫做设备上下文，设备描叙表。DC就是程序可以进行绘图的地方：例如我们要在平屏幕绘图，设备就屏幕吧，而dc就是屏幕上的绘图层.

`设备句柄:`
设备上下文句柄，设备环境句柄，简称HDC.如果需要绘图，首先得得到句柄，绘图完成之后必须释放句柄.

`位图:`
位的矩形数据，这些位对应显示设备上的像素，简称BMP(bitmap)，可以分为设备相关位图(DDB)和设备无关位图(DIB) ，我们一般使用的是DIB.

`文字:`
GDI支持TrueType字体，这种字体是在填充轮廓线基础上建立的。实际上就是TTF后缀的字体.

`颜色:`
RGB R=0~255,G = 0~255, R = 0~255;红绿蓝,例如RGB(123,234,123).

# `2. 设备句柄`

## `2.1 BeginPaint & EndPaint`

| Funs         | Descrption             |
| ------------ | ---------------------- |
| BeginPaint() | 开始绘制,返回设备句柄. |
| EndPaint()   | 结束绘制,释放资源.     |

- BeginPaint-EndPaint会结束WM_PAINT消息
- BeginPaint-EndPaint会结束无效区域
- BeginPaint-EndPaint只能在WM_PAINT中使用


## `2.2 GetDC & ReleaseDC`

| Funs        | Description                    |
| ----------- | ------------------------------ |
| GetDC()     | 开始绘制,得到指定窗口设备句柄. |
| ReleaseDC() | 结束绘制,释放资源.             |

- GetDC-ReleaseDC是在WM_PAINT消息外绘制
- 注意,它只绘制一次,也就是说,WM_ERASEBKGND重绘背景会覆盖它

## `2.3 CreateCompatibleDC & DeleteDC`

| Funs        | Description                    |
| ----------- | ------------------------------ |
| CreateCompatibleDC()     | 创建与设备兼容的内存设备句柄 |
| DeleteDC() | 释放资源.             |

- CreateCompatibleDC()是在内存中画图(做数据),不会画在显示器上;成型之后,我们可以把图画出来,这样只用画一次就可以了


# `3. 图形绘制`

## `3.1 画笔 HPEN`

CreatePen  		创建画笔

GetStockPen		得到系统内置的画笔

## `3.2 画刷 HBRUSH`

| Funs                      | Description                      |
| ------------------------- | -------------------------------- |
| CreateSolidBrush()        | 使用纯色创建画笔                 |
| CreatePatternBrush()      | 使用位图模式创建画笔             |
| CreateDIBPatternBrushPt() | 使用DIB模式创建画笔              |
| CreateBrushIndirect()     | 用指定的样式，颜色和图案创建画笔 |
| GetStockBrush()           | 得到系统内置的画刷               |

## `3.3 字体 HFONT`

```
HFONT CreateFont(
  _In_ int     nHeight,               //高度
  _In_ int     nWidth,                //宽度
  _In_ int     nEscapement,           //矢量斜度
  _In_ int     nOrientation,          //斜度,水平上字体的斜角度
  _In_ int     fnWeight,              //字体粗细
  _In_ DWORD   fdwItalic,             //是否斜体
  _In_ DWORD   fdwUnderline,          //是否下划线
  _In_ DWORD   fdwStrikeOut,          //如果设置为TRUE，则删除字体。
  _In_ DWORD   fdwCharSet,            //字符集
  _In_ DWORD   fdwOutputPrecision,    //输出精度
  _In_ DWORD   fdwClipPrecision,      //剪切精度
  _In_ DWORD   fdwQuality,            //质量
  _In_ DWORD   fdwPitchAndFamily,     //字体的音调和家庭
  _In_ LPCTSTR lpszFace               //字体名
);
```

- 创建字体的成员有点多
- 第一个成员控制字体尺寸,也可以为0
- 最后一个成员控件字体类型
- 其它成员0就好

## `3.4 画点`

SetPixel()

GetPixel()

## `3.5 画线`

MoveToEx()

LineTo()

## `3.6 画圆`

Ellipse()

## `3.7 画矩形`

Rectangle()

## `3.8 画图`

1. 创建兼容DC
2. 创建位图
3. 选择位图到内存DC
4. 画内存DC到DC

```
HBITMAP hbm {};

case WM_INITDIALOG:
	{
          hbm = LoadBitmap(g_hInst, MAKEINTRESOURCE(IDBM_BRUSH));
		assert(hbm);
	}break;
case WM_PAINT:
	{
		PAINTSTRUCT ps{};
		HDC hdc = BeginPaint(hDlg, &ps);
		assert(hdc);
		HDC hdcMem = CreateCompatibleDC(hdc);
		assert(hdcMem);
	
		SelectObject(hdcMem, hbm);
	
		BITMAP bm{};
		GetObject(hbm, sizeof(BITMAP), &bm);
		RECT rtClnt{};
		GetClientRect(hDlg, &rtClnt);
		StretchBlt(hdc, 0, 0, rtClnt.right, rtClnt.bottom, hdcMem, 0, 0, bm.bmWidth, bm.bmHeight, SRCCOPY);
	
		DeleteDC(hdcMem);
		EndPaint(hDlg, &ps);
	}break;
case WM_SIZE:
	InvalidateRect(hDlg, 0, 0);
	break;
```



## `3.9 画字`

TextOut()
DrawText()

## `3.10 操作GDI对象操作`

| Funs           | Description                     |
| -------------- | ------------------------------- |
| SelectObject() | 选择一个GDI对象,返回旧的GDI对象 |
| DeleteObject() | 释放对象                        |
|                |                                 |
| GetObject()    | 通过句柄得到GDI对象             |
|                |                                 |
| SelectBrush()  |                                 |
| SelectFont()   |                                 |
| SelectPen()    |                                 |

# `4. 作业`
浏览器的按钮一般有三种状态: 正常 & 悬停 & 按下,用本课的知识给按钮加上三态. (必做)