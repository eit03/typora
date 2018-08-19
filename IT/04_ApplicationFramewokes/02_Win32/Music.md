```
#include <Windows.h>
#include <assert.h>

#pragma comment(lib, "Winmm.lib")

#define IDBTN_OPEN			10000
#define IDBTN_PLAY			10001
#define IDBTN_PAUSE			10002
#define IDBTN_STOP			10003
#define IDBTN_PREV			10004
#define IDBTN_NEXT			10005
#define IDLB_LIST			10006


HINSTANCE g_hInst = 0;
HWND g_hLBWnd = 0, g_hPauseBtn = 0;
int g_iPlayStatu = 0;		// 0: 没有设备  1: 播放中  2: 暂停中
MCIDEVICEID g_id = 0;

int g_iCurSel = -1;
int g_iMaxCount = -1;

LRESULT CALLBACK MyWndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
void OnOpen(HWND hWnd);
void OnPlay();
void OnPause(HWND hWnd, MCIDEVICEID id);
void OnResume(HWND hWnd, MCIDEVICEID id);
void OnStop(MCIDEVICEID id);
void OnPrev();
void OnNext();

MCIDEVICEID mciOpen(const LPWSTR wcsFileName);
DWORD_PTR mciLenth(MCIDEVICEID id);
void mciPlay(MCIDEVICEID id);
void mciPause(MCIDEVICEID id);
void mciResume(MCIDEVICEID id);
void mciStop(MCIDEVICEID id);


int WINAPI WinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPSTR lpCmdLine, _In_ int nShowCmd)
{
	g_hInst = hInstance;

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
	RECT rtMainWnd = { 0, 0, 444, 720 };
	AdjustWindowRect(&rtMainWnd, dwStyle, 0);
	HWND hWnd = CreateWindow(L"CN_CLASSNAME", L"WN_WINDOWNAEM", dwStyle, 600, 100,
		rtMainWnd.right - rtMainWnd.left, rtMainWnd.bottom - rtMainWnd.top, 0, 0, hInstance, 0);
	assert(INVALID_HANDLE_VALUE != hWnd);

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
	switch (uMsg)
	{
	case WM_COMMAND:
		switch (LOWORD(wParam))
		{
		case IDBTN_OPEN:
			OnOpen(hWnd);
			break;
		case IDBTN_PLAY:
			OnPlay();
			break;
		case IDBTN_PAUSE:
			if (1 == g_iPlayStatu)
				OnPause(g_hPauseBtn, g_id);
			else if (2 == g_iPlayStatu)
				OnResume(g_hPauseBtn, g_id);
			break;
		case IDBTN_STOP:
			OnStop(g_id);
			break;
		case IDBTN_PREV:
			OnPrev(hWnd);
			break;
		case IDBTN_NEXT:
			OnNext(hWnd);
			break;
		default:
			break;
		}break;
	case WM_CREATE:
		{
			CreateWindowW(L"BUTTON", L"打开", WS_CHILD | WS_VISIBLE, 10, 688, 60, 30, hWnd, (HMENU)IDBTN_OPEN, g_hInst, 0);
			CreateWindowW(L"BUTTON", L"播放", WS_CHILD | WS_VISIBLE, 80, 688, 60, 30, hWnd, (HMENU)IDBTN_PLAY, g_hInst, 0);
			g_hPauseBtn = CreateWindowW(L"BUTTON", L"暂停", WS_CHILD | WS_VISIBLE, 150, 688, 60, 30, hWnd, (HMENU)IDBTN_PAUSE, g_hInst, 0);
			CreateWindowW(L"BUTTON", L"停止", WS_CHILD | WS_VISIBLE, 220, 688, 60, 30, hWnd, (HMENU)IDBTN_STOP, g_hInst, 0);
			CreateWindowW(L"BUTTON", L"下曲", WS_CHILD | WS_VISIBLE, 290, 688, 60, 30, hWnd, (HMENU)IDBTN_NEXT, g_hInst, 0);
			CreateWindowW(L"BUTTON", L"上曲", WS_CHILD | WS_VISIBLE, 360, 688, 60, 30, hWnd, (HMENU)IDBTN_PREV, g_hInst, 0);

			g_hLBWnd = CreateWindowW(L"LISTBOX", L"", WS_CHILD | WS_VISIBLE | WS_BORDER, 0, 0, 444, 690, hWnd, (HMENU)IDLB_LIST, g_hInst, 0);
		}break;
	case WM_DESTROY:
		{
			PostQuitMessage(0);
			return 0;
		}break;
	}

	return DefWindowProc(hWnd, uMsg, wParam, lParam);
}

void OnOpen(HWND hWnd)
{
	LPTSTR lpszCurDir;
	static TCHAR szFilter[] = TEXT("MP3 Files (*.mp3)\0*.mp3\0")\
		TEXT("All Files (*.*)\0*.*\0\0");
	static TCHAR  szFileName[MAX_PATH], szTitleName[MAX_PATH];
	OPENFILENAME ofn;

	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hWnd;
	ofn.hInstance = NULL;
	ofn.lpstrFilter = szFilter;
	ofn.lpstrCustomFilter = NULL;
	ofn.nMaxCustFilter = 0;
	ofn.nFilterIndex = 0;
	ofn.lpstrFile = szFileName;
	ofn.nMaxFile = MAX_PATH;
	ofn.lpstrFileTitle = NULL;
	ofn.nMaxFileTitle = MAX_PATH;
	ofn.lpstrInitialDir = NULL;
	ofn.lpstrTitle = NULL;
	ofn.Flags = OFN_EXTENSIONDIFFERENT;
	ofn.nFileOffset = 0;
	ofn.nFileExtension = 0;
	ofn.lpstrDefExt = TEXT(".mp3");
	ofn.lCustData = 0;
	ofn.lpfnHook = NULL;
	ofn.lpTemplateName = NULL;
	ofn.hwndOwner = hWnd;
	ofn.lpstrFileTitle = szTitleName;
	ofn.Flags = 0;

	GetOpenFileName(&ofn);     //显示打开对话框
	lpszCurDir = ofn.lpstrFile;
	GetCurrentDirectory(MAX_PATH, lpszCurDir);
	//将歌曲列表添加到ListBox中
	DlgDirList(hWnd, lpszCurDir, IDLB_LIST, 0, DDL_ARCHIVE);

	g_iMaxCount = 0;
	g_iCurSel = 0;
}

void OnPlay()
{
	if (LB_ERR == g_iCurSel)
		return;

	WCHAR wcsTmp[MAX_PATH] = {0};
	SendMessage(g_hLBWnd, LB_GETTEXT, g_iCurSel, (LPARAM)wcsTmp);
	int iLen = wcslen(wcsTmp);
	if (0 != wcscmp(wcsTmp + iLen - 4, L".mp3"))
		return;

	g_id = mciOpen(wcsTmp);
	mciPlay(g_id);

	g_iMaxCount = SendMessage(g_hLBWnd, LB_GETCOUNT, 0, 0);
	g_iCurSel = SendMessage(g_hLBWnd, LB_GETCURSEL, 0, 0);

	g_iPlayStatu = 1;
}

void OnPause(HWND hWnd, MCIDEVICEID id)
{
	mciPause(id);

	g_iPlayStatu = 2;
	SetWindowTextW(hWnd, L"继续");
}

void OnResume(HWND hWnd, MCIDEVICEID id)
{
	mciResume(id);

	g_iPlayStatu = 1;
	SetWindowTextW(hWnd, L"暂停");
}

void OnStop(MCIDEVICEID id)
{
	if (0 == g_iPlayStatu)
		return;
	else if (2 == g_iPlayStatu)
		SetWindowTextW(g_hPauseBtn, L"暂停");

	g_iPlayStatu = 0;

	mciStop(id);
}

void OnPrev()
{
	g_iMaxCount = SendMessage(g_hLBWnd, LB_GETCOUNT, 0, 0);
	g_iCurSel = SendMessage(g_hLBWnd, LB_GETCURSEL, 0, 0);
	if (g_iCurSel < 0)
		return;

	if (0 == g_iCurSel)
		g_iCurSel = g_iMaxCount -1;
	else
		--g_iCurSel;

	SendMessage(g_hLBWnd, LB_SETCURSEL, g_iCurSel, 0);

	OnPlay();
}

void OnNext()
{
	g_iMaxCount = SendMessage(g_hLBWnd, LB_GETCOUNT, 0, 0);
	g_iCurSel = SendMessage(g_hLBWnd, LB_GETCURSEL, 0, 0);
	if (g_iCurSel < 0)
		return;

	if (g_iMaxCount -1 == g_iCurSel)
		g_iCurSel = 0;
	else
		++g_iCurSel;

	SendMessage(g_hLBWnd, LB_SETCURSEL, g_iCurSel, 0);

	OnPlay();
}

MCIDEVICEID mciOpen(const LPWSTR wcsFileName)
{
	mciSendCommandW(MCI_ALL_DEVICE_ID, MCI_CLOSE, MCI_WAIT, 0);

	MCI_OPEN_PARMS mop = { 0 };
	mop.lpstrElementName = wcsFileName;
	mciSendCommandW(0, MCI_OPEN, MCI_OPEN_ELEMENT, (DWORD_PTR)&mop);

	return mop.wDeviceID;
}

DWORD_PTR mciLenth(MCIDEVICEID id)
{
	MCI_STATUS_PARMS msp = { 0 };
	mciSendCommandW(id, MCI_SEEK, MCI_SEEK_TO_END, 0);
	msp.dwItem = MCI_STATUS_POSITION;
	mciSendCommandW(id, MCI_STATUS, MCI_STATUS_ITEM, (DWORD_PTR)&msp);
	mciSendCommandW(id, MCI_SEEK, MCI_SEEK_TO_START, 0);

	return msp.dwReturn;
}

void mciPlay(MCIDEVICEID id)
{
	MCI_PLAY_PARMS mpp = { 0 };
	mpp.dwFrom = 0;
	mpp.dwTo = -1;
	mciSendCommandW(id, MCI_PLAY, MCI_NOTIFY, &mpp);
}

void mciPause(MCIDEVICEID id)
{
	MCI_GENERIC_PARMS mgr = { 0 };
	mciSendCommandW(id, MCI_PAUSE, MCI_NOTIFY, &mgr);
}

void mciResume(MCIDEVICEID id)
{
	MCI_GENERIC_PARMS mgp = { 0 };
	mciSendCommandW(id, MCI_RESUME, MCI_NOTIFY, &mgp);
}

void mciStop(MCIDEVICEID id)
{
	MCI_GENERIC_PARMS mgp = { 0 };
	mciSendCommandW(id, MCI_STOP, MCI_NOTIFY, &mgp);
}

```

