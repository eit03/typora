***
[TOC]
***

# `1. Orange`
```
#include <Windows.h>
#include <assert.h>


LRESULT CALLBACK MyWndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

int WINAPI WinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPSTR lpCmdLine, _In_ int nShowCmd)
{
	//0.Design window class
	WNDCLASSW wc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	wc.hbrBackground = (HBRUSH)GetStockObject(LTGRAY_BRUSH);
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	wc.hInstance = hInstance;
	wc.lpfnWndProc = (WNDPROC)MyWndProc;
	wc.lpszClassName = L"CN_CLASSNAME";
	wc.lpszMenuName = 0;
	wc.style = 0;

	//1.Register window class
	BOOL bRes = GetClassInfoW(hInstance, wc.lpszClassName, &wc);
	if (!bRes)
	{
		bRes = RegisterClass(&wc);
		assert(bRes);
	}

	//2.create window
	DWORD dwStyle = WS_OVERLAPPEDWINDOW;
	RECT rtMainWnd{ 0,0, 720, (int)(720 * 0.618) };
	AdjustWindowRect(&rtMainWnd, dwStyle, 0);
	HWND hWnd = CreateWindow(wc.lpszClassName, L"WN_WINDOWNAEM", dwStyle, 300, 300,
		rtMainWnd.right - rtMainWnd.left, rtMainWnd.bottom - rtMainWnd.top, 0, 0, hInstance, 0);
	assert(hWnd);

	//3.show update
	ShowWindow(hWnd, nShowCmd);
	UpdateWindow(hWnd);

	//4.Msg loop
	MSG msg;
	while (GetMessage(&msg, 0, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	//5.return
	return msg.wParam;
}

LRESULT CALLBACK MyWndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	PAINTSTRUCT ps;
	HDC hdc;

	switch (uMsg)
	{
	case WM_PAINT:
		{
			hdc = BeginPaint(hWnd, &ps);
			Ellipse(hdc, 0, 0, 200, 100);
			EndPaint(hWnd, &ps);
		}break;
	case WM_DESTROY:
		{
			PostQuitMessage(0);
		}break;
	}

	return DefWindowProc(hWnd, uMsg, wParam, lParam);
}
```

# `命名空间版`

```
//MainWnd.h
#pragma once
#include <windows.h>


namespace NSMainWnd
{
	LRESULT CALLBACK WndMsgProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam); //窗口消息处理中心
	void DesignWndClass(WNDCLASS& wc, HINSTANCE hInst, WNDPROC wsp); //设计窗口类
	void RegisterWndClass(WNDCLASS& wc, HINSTANCE hInst); //注册窗口
	//CreateWindow()
	void AdjustAndCenterWnd(DWORD dwStyle, RECT& rt); //校正与居中窗口
	int MsgLoop(); //消息循环
	//return
};
```

```

```



```
//Main.cpp
#include <Windows.h>
#include <assert.h>
#include "MainWnd.h"


int WINAPI WinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPSTR lpCmdLine, _In_ int nShowCmd)
{
	{
		using namespace NSMainWnd;
		WNDCLASS wc{};
		DesignWndClass(wc, hInstance, WndMsgProc);
		RegisterWndClass(wc, hInstance);
		
		RECT rtMainFrame{ 0, 0, 720, (int)(720 * 0.618) };
		DWORD dwStyle = WS_OVERLAPPEDWINDOW;
		AdjustAndCenterWnd(dwStyle, rtMainFrame);
		HWND hWnd = CreateWindow(wc.lpszClassName, L"WN_WINDOWNAEM", dwStyle, rtMainFrame.left, rtMainFrame.top, 
			rtMainFrame.right - rtMainFrame.left, rtMainFrame.bottom - rtMainFrame.top, 0, 0, hInstance, 0);
		assert(hWnd);

		ShowWindow(hWnd, nShowCmd);
		UpdateWindow(hWnd);

		return MsgLoop();
	}
}
```

# `Dlg`

```
#include <windows.h>
#include <Windowsx.h>
#include <Commctrl.h>
#include <assert.h>
#include "resource.h"


INT_PTR CALLBACK MainDlgProc(HWND hDlg, UINT uMsg, WPARAM wParam, LPARAM lParam);

int __stdcall WinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPSTR lpCmdLine, _In_ int nShowCmd)
{
	DialogBox(hInstance, MAKEINTRESOURCE(IDDLG_MAIN), 0, MainDlgProc);
	return 0;
}

INT_PTR CALLBACK MainDlgProc(HWND hDlg, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	switch (uMsg)
	{
	case WM_CLOSE:
		EndDialog(hDlg, 0);
		break;
	}

	return FALSE;
}
```


# `MFC`
```
BOOL CMainWnd::PreCreateWindow(CREATESTRUCT& cs)
{
    // TODO: Add your specialized code here and/or call the base class
    //0.Design window class
    HINSTANCE hInstance = AfxGetInstanceHandle();
    assert(hInstance);

    WNDCLASSEXW wc{};
    wc.cbSize = sizeof(WNDCLASSEXW);

    BOOL bRet = GetClassInfoExW(hInstance, cs.lpszClass, &wc);
    if (bRet)
        return true;


    wc.hbrBackground = (HBRUSH)GetStockObject(LTGRAY_BRUSH);
    wc.hCursor = LoadCursor(NULL, IDC_ARROW);
    wc.hIcon = wc.hIconSm = LoadIcon(NULL, IDI_APPLICATION);
    wc.hInstance = hInstance;
    wc.lpfnWndProc = AfxWndProc;
    wc.lpszClassName = cs.lpszClass;
    wc.style = CS_VREDRAW | CS_HREDRAW | CS_DBLCLKS;

    //1.Register window class
    bRet = (BOOL)RegisterClassExW(&wc);
    assert(bRet);

    return true;
}
```

