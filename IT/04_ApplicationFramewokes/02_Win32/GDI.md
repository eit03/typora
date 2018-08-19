***
`Version:` 
`Declaration:` 
`Defination:` 
`Reference:` https://msdn.microsoft.com/en-us/library/windows/desktop/dd145203(v=vs.85).aspx
`Keyword: ` (Windows GDI)

***
[TOC]
***

# `1. 概述`
> GDI是图形设备接口的英文缩写，主要任务是负责系统与绘图程序之间的信息交换，处理所有Windows程序的图形和图像输出。GDI的出现使程序员无需要关心硬件设备及设备正常驱动，就可以将应用程序的输出转化为硬件设备上的输出和构成，实现了程序开发者与硬件设备的隔离，大大方便了开发工作。

> GDI是Graphics Device Interface的缩写，含义是图形设备接口，它的主要任务是负责系统与绘图程序之间的信息交换，处理所有Windows程序的图形输出。

> 在Windows操作系统下，绝大多数具备图形界面的应用程序都离不开GDI，我们利用GDI所提供的众多函数就可以方便的在屏幕、打印机及其它输出设备上输出图形，文本等操作。

# `2. 特点`
1. 不允许程序直接访问物理显示硬件，通过称为“设备环境”的抽象接口间接访问显示硬件；
2. 程序需要与显示硬件(显示器、打印机等) 进行通讯时,必须首先获得与特定窗口相关联的设备环境；
3. 用户无需关心具体的物理设备类型；
4. Windows参考设备环境的数据结构完成数据的输出。

# `3. 为什么要有GDI`

1. 绘图;
2. 提升绘图效果;
3. 提升开发效率;
4. 提升兼容性;

# `3. GDI的实现`

1. 数据类型在Wingdi.h中声明;
2. 实现在Gdi32.dll中;
3. 链接在Gdi32.lib中;

# `4. 设备环境DC的概念`
> 设备环境DC(Device Context 又称为设备上下文，也称为设备描述表)。他是一个关于如何绘制图形的方法的集合。它即可以绘制各种图形，也可以确定在应用窗口中绘制图形的方式，就是绘图模式和映射模式。

> 在win32编程中，设备环境是用HDC来标识。H的意思Handle句柄的意思。

# `5. DC里的图形对象`

## `5.1 位图Bitmap`
> 位图是可以选择到*设备上下文*（DC）中的GDI对象之一.

> 从开发人员的角度来看，位图由一组指定或包含以下元素的结构组成：
>
> * 描述创建像素矩形的设备的分辨率的标题，矩形的尺寸，位数组的大小等等。
> * 一个逻辑调色板。
> * 位数组，用于定义位图图像中的像素与逻辑调色板中的条目之间的关系。

## `5.2 画刷Brush`
> 在GDI中，用HBRUSH来表示画刷。H是表示句柄的意思。
> 在GDI中，填充矩形，填充圆，填充饼等以及刷窗口背景都是通过画刷来操作的。
> GDI默认的是画刷是白色的画刷。
```
HBRUSH CreateSolidBrush(COLORREF crColor);
HBRUSH CreatePatternBrush(HBITMAP hbmp);
HBRUSH CreateHatchBrush(int fnStyle, COLORREF clrref);
```

## `5.3 字体Font`
> 在GDI中,用HFONT来表示字体。H是表示句柄的意思。
在GDI中，所有的文本绘制，都是要基于具体的字体对象来绘制的。
GDI中默认的字体，是系统等宽字体，比如对话框标题一般就是采用这个字体。

## `5.4 Logical Palette`

## `5.5 Paths`


## `5.6 画笔Pen`
>  在GDI中，用HPEN来表示画笔。H是代表句柄的意思。
>  在GDI中，画线，画边框（如矩形边框，圆边框，饼边框）都是采用画笔来操作的。
>  GDI默认的画笔是黑色，宽度为1，样式为实线的画笔。

```
HPEN CreatePen(int fnPenStyle, int nWidth, COLORREF crColor);
```


## `5.7 区域Region`
> 在GDI中，用HRGN来表示区域。H是表示句柄的意思。
在窗口中，一个区域可以是椭圆形，多边形，或是更常见的矩形。




# `5. 坐标系统`
## `5.1 屏幕坐标系`
> 坐标原点在屏幕左上角, 自左向右x坐标增大 , 自上向下y坐标增大.  通过 GetWindowRect函数获取的窗口区域的坐标就是基于屏幕坐标系的;

## `5.2 窗口坐标系`
> 窗口坐标系又叫非客户区坐标系, 坐标原点在窗口的左上角, X, Y坐标轴方向和屏幕坐标系相同; 通过GetWindowDC返回的设备环境是基于该坐标系的, 该函数只在WM_NCPAINT消息中使用

## `5.3 客户区坐标系`
> 坐标原点在标题栏以下 的客户区左上角, X,Y坐标轴方向与屏幕坐标系相同. 通过BeginPaint函数返回的设置环境是基于客户区坐标系的, 该函数只在WM_PAINT中使用;

> GetDC函数返回的设备环境也是基于客户区坐标系的, 该函数可以在任何消息中使用. GetClientDC函数获取的是客户区矩形,是依据该坐标系计算的, 左上角的坐标一定是(0, 0);

# `6. 坐标系统2`
## `6.1 概述`
> Windows坐标系分为逻辑坐标系和设备坐标系两种，GDI支持这两种坐标系。一般而言，
GDI的文本和图形输出函数使用逻辑坐标，而在客户区移动或按下鼠标的鼠标位置是采用设备坐标。

## `6.2 逻辑坐标系`
> 逻辑坐标系是面向DC的坐标系，这种坐标不考虑具体的设备类型，在绘图时，Windows会根据当前设置的映射模式将逻辑坐标转换为设备坐标。

## `6.3 设备坐标系`
> 设备坐标系是面向物理设备的坐标系，这种坐标以像素或设备所能表示的最小长度单位为单位，X轴方向向右，Y轴方向向下。设备坐标系的原点位置(0, 0)不限定在设备显示区域的左上角。

> 设备坐标系分为屏幕坐标系、窗口坐标系和客户区坐标系三种相互独立的坐标系.

# `7.绘制函数分类`

## `1. 点`

`````
COLORREF SetPixel(HDC hdc, int X, int Y, COLORREF crColor);
COLORREF GetPixel(HDC hdc, int nXPos, int nYPos);
`````

## `2. 线`

## `3. 面`



# `9. 重要函数`
| 设备上下文相关        |     |
| ------------------ | ---- |
| GetDC              |      |
| CreateDC           |      |
| BeginPaint         |      |
| CreateCompatibleDC |      |
| DeleteDC           |      |

| 对象相关         |     |
| ------------------ | ---- |
| SelectObject       |      |
| GetObject | |


| 画线相关 |      |
| -------- | ---- |
| LineTo   |      |
| Polyline |      |
| Arc      |      |

| 填充画图函数 |      |
| ------------ | ---- |
| Ellipse      |      |
| FillRect     |      |
| Pie          |      |

| 画图属性相关 |      |
| ------------ | ---- |
| SetBkColor   |      |
| SetBkMode    |      |
| SetTextColor |      |

| 文本&字体相关 |      |
| ------------- | ---- |
| TextOut       |      |
| GetFontData   |      |

| 位图相关   |      |
| ---------- | ---- |
| SetPixel   |      |
| BitBlt     |      |
| StretchBlt |      |

| 坐标相关       |                                      |
| -------------- | ------------------------------------ |
| DPtoLP         | 用于设备坐标与逻辑坐标之间的相互转换 |
| LPtoDP         | 用于设备坐标与逻辑坐标之间的相互转换 |
| ScreenToClient | 用于屏幕坐标与客户区坐标的相互转换   |
| ClientToScreen | 用于屏幕坐标与客户区坐标的相互转换   |

| 映射相关         |      |
| ---------------- | ---- |
| SetMapMode       |      |
| SetWindowExtEx   |      |
| SetViewportExtEx |      |

| 元文件相关         |      |
| ------------------ | ---- |
| PlayMetaFile       |      |
| SetWinMetaFileBits |      |

| 区域相关  |      |
| --------- | ---- |
| FillRgn   |      |
| FrameRgn  |      |
| InvertRgn |      |

| 路径相关          |      |
| ----------------- | ---- |
| BeginPath         |      |
| EndPath           |      |
| StrokeAndFillPath |      |






| 裁剪相关       |      |
| -------------- | ---- |
| SelectClipRgn  |      |
| SelectClipPath |      |

# `10. 代码`

## `1. 捕获整个桌面图像的应用程序，将其缩小到当前窗口大小，然后将其保存到文件中`

```
// GDI_CapturingAnImage.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "GDI_CapturingAnImage.h"

#define MAX_LOADSTRING 100

// Global Variables:
HINSTANCE hInst;                        // current instance
TCHAR szTitle[MAX_LOADSTRING];          // The title bar text
TCHAR szWindowClass[MAX_LOADSTRING];    // the main window class name

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY _tWinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPTSTR    lpCmdLine,
                     int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    MSG msg;
    HACCEL hAccelTable;

    // Initialize global strings
    LoadString(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadString(hInstance, IDC_GDI_CAPTURINGANIMAGE, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    if (!InitInstance (hInstance, nCmdShow))
    {
        return FALSE;
    }

    hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_GDI_CAPTURINGANIMAGE));

    // Main message loop:
    while (GetMessage(&msg, NULL, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int) msg.wParam;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
//  COMMENTS:
//
//    This function and its usage are only necessary if you want this code
//    to be compatible with Win32 systems prior to the 'RegisterClassEx'
//    function that was added to Windows 95. It is important to call this function
//    so that the application will get 'well formed' small icons associated
//    with it.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEX wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style            = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndProc;
    wcex.cbClsExtra        = 0;
    wcex.cbWndExtra        = 0;
    wcex.hInstance        = hInstance;
    wcex.hIcon            = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_GDI_CAPTURINGANIMAGE));
    wcex.hCursor        = LoadCursor(NULL, IDC_ARROW);
    wcex.hbrBackground    = (HBRUSH)(COLOR_WINDOW+1);
    wcex.lpszMenuName    = MAKEINTRESOURCE(IDC_GDI_CAPTURINGANIMAGE);
    wcex.lpszClassName    = szWindowClass;
    wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassEx(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   HWND hWnd;

   hInst = hInstance; // Store instance handle in our global variable

   hWnd = CreateWindow(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
// Copyright (c) Microsoft Corporation. All rights reserved

//
//   FUNCTION: CaptureAnImage(HWND hWnd)
//
//   PURPOSE: Captures a screenshot into a window and then saves it in a .bmp file.
//
//   COMMENTS: 
//
//      Note: This sample will attempt to create a file called captureqwsx.bmp 
//        



int CaptureAnImage(HWND hWnd)
{
    HDC hdcScreen;
    HDC hdcWindow;
    HDC hdcMemDC = NULL;
    HBITMAP hbmScreen = NULL;
    BITMAP bmpScreen;

    // Retrieve the handle to a display device context for the client 
    // area of the window. 
    hdcScreen = GetDC(NULL);
    hdcWindow = GetDC(hWnd);

    // Create a compatible DC which is used in a BitBlt from the window DC
    hdcMemDC = CreateCompatibleDC(hdcWindow); 

    if(!hdcMemDC)
    {
        MessageBox(hWnd, L"CreateCompatibleDC has failed",L"Failed", MB_OK);
        goto done;
    }

    // Get the client area for size calculation
    RECT rcClient;
    GetClientRect(hWnd, &rcClient);

    //This is the best stretch mode
    SetStretchBltMode(hdcWindow,HALFTONE);

    //The source DC is the entire screen and the destination DC is the current window (HWND)
    if(!StretchBlt(hdcWindow, 
               0,0, 
               rcClient.right, rcClient.bottom, 
               hdcScreen, 
               0,0,
               GetSystemMetrics (SM_CXSCREEN),
               GetSystemMetrics (SM_CYSCREEN),
               SRCCOPY))
    {
        MessageBox(hWnd, L"StretchBlt has failed",L"Failed", MB_OK);
        goto done;
    }
    
    // Create a compatible bitmap from the Window DC
    hbmScreen = CreateCompatibleBitmap(hdcWindow, rcClient.right-rcClient.left, rcClient.bottom-rcClient.top);
    
    if(!hbmScreen)
    {
        MessageBox(hWnd, L"CreateCompatibleBitmap Failed",L"Failed", MB_OK);
        goto done;
    }

    // Select the compatible bitmap into the compatible memory DC.
    SelectObject(hdcMemDC,hbmScreen);
    
    // Bit block transfer into our compatible memory DC.
    if(!BitBlt(hdcMemDC, 
               0,0, 
               rcClient.right-rcClient.left, rcClient.bottom-rcClient.top, 
               hdcWindow, 
               0,0,
               SRCCOPY))
    {
        MessageBox(hWnd, L"BitBlt has failed", L"Failed", MB_OK);
        goto done;
    }

    // Get the BITMAP from the HBITMAP
    GetObject(hbmScreen,sizeof(BITMAP),&bmpScreen);
     
    BITMAPFILEHEADER   bmfHeader;    
    BITMAPINFOHEADER   bi;
     
    bi.biSize = sizeof(BITMAPINFOHEADER);    
    bi.biWidth = bmpScreen.bmWidth;    
    bi.biHeight = bmpScreen.bmHeight;  
    bi.biPlanes = 1;    
    bi.biBitCount = 32;    
    bi.biCompression = BI_RGB;    
    bi.biSizeImage = 0;  
    bi.biXPelsPerMeter = 0;    
    bi.biYPelsPerMeter = 0;    
    bi.biClrUsed = 0;    
    bi.biClrImportant = 0;

    DWORD dwBmpSize = ((bmpScreen.bmWidth * bi.biBitCount + 31) / 32) * 4 * bmpScreen.bmHeight;

    // Starting with 32-bit Windows, GlobalAlloc and LocalAlloc are implemented as wrapper functions that 
    // call HeapAlloc using a handle to the process's default heap. Therefore, GlobalAlloc and LocalAlloc 
    // have greater overhead than HeapAlloc.
    HANDLE hDIB = GlobalAlloc(GHND,dwBmpSize); 
    char *lpbitmap = (char *)GlobalLock(hDIB);    

    // Gets the "bits" from the bitmap and copies them into a buffer 
    // which is pointed to by lpbitmap.
    GetDIBits(hdcWindow, hbmScreen, 0,
        (UINT)bmpScreen.bmHeight,
        lpbitmap,
        (BITMAPINFO *)&bi, DIB_RGB_COLORS);

    // A file is created, this is where we will save the screen capture.
    HANDLE hFile = CreateFile(L"captureqwsx.bmp",
        GENERIC_WRITE,
        0,
        NULL,
        CREATE_ALWAYS,
        FILE_ATTRIBUTE_NORMAL, NULL);   
    
    // Add the size of the headers to the size of the bitmap to get the total file size
    DWORD dwSizeofDIB = dwBmpSize + sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);
 
    //Offset to where the actual bitmap bits start.
    bmfHeader.bfOffBits = (DWORD)sizeof(BITMAPFILEHEADER) + (DWORD)sizeof(BITMAPINFOHEADER); 
    
    //Size of the file
    bmfHeader.bfSize = dwSizeofDIB; 
    
    //bfType must always be BM for Bitmaps
    bmfHeader.bfType = 0x4D42; //BM   
 
    DWORD dwBytesWritten = 0;
    WriteFile(hFile, (LPSTR)&bmfHeader, sizeof(BITMAPFILEHEADER), &dwBytesWritten, NULL);
    WriteFile(hFile, (LPSTR)&bi, sizeof(BITMAPINFOHEADER), &dwBytesWritten, NULL);
    WriteFile(hFile, (LPSTR)lpbitmap, dwBmpSize, &dwBytesWritten, NULL);
    
    //Unlock and Free the DIB from the heap
    GlobalUnlock(hDIB);    
    GlobalFree(hDIB);

    //Close the handle for the file that was created
    CloseHandle(hFile);
       
    //Clean up
done:
    DeleteObject(hbmScreen);
    DeleteObject(hdcMemDC);
    ReleaseDC(NULL,hdcScreen);
    ReleaseDC(hWnd,hdcWindow);

    return 0;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE:  Processes messages for the main window.
//
//  WM_COMMAND    - process the application menu
//  WM_PAINT    - Paint the main window
//  WM_DESTROY    - post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    int wmId, wmEvent;
    PAINTSTRUCT ps;
    HDC hdc;
   
    switch (message)
    {
    case WM_CREATE:
        {
        break;
        }
    case WM_COMMAND:
        wmId    = LOWORD(wParam);
        wmEvent = HIWORD(wParam);
        // Parse the menu selections:
        switch (wmId)
        {
        case IDM_ABOUT:
            DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
            break;
        case IDM_EXIT:
            DestroyWindow(hWnd);
            break;
        default:
            return DefWindowProc(hWnd, message, wParam, lParam);
        }
        break;
        
    case WM_MOVE:
        
    case WM_PAINT:
        hdc = BeginPaint(hWnd, &ps);
        CaptureAnImage(hWnd);
        EndPaint(hWnd, &ps);
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}
```

