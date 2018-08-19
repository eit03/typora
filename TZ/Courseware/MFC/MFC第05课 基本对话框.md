***
[TOC]
***

# `1. 模态与非模态对话框`

## `1.1 模态对话框`
> 模态对话框垄断了用户的输入。当一个模态对话框打开时，用户只能与该对话框进行交互，而其他用户界面对象收不到输入信息。模态对话框下，用户需要操作目标对话框就必须先操作模态对话框。用户对模态对话框的处理如图所示。

### `1.1.1 代码`

### `1.1.2 流程分析`

1. 从==CModalessApp theApp==全局变量开始运行.
2. WinMain().
3. CWinApp::InitInstance().
   1. 设计窗口类
   2. 注册窗口类
   3. 创建窗口
   4. 显示&更新
4. 消息循环. 

## `1.2 非态式对话框`
>模态对话框垄断了用户的输入。当一个模态对话框打开时，用户只能与该对话框进行交互，而其他用户界面对象收不到输入信息。模态对话框下，用户需要操作目标对话框就必须先操作模态对话框。用户对模态对话框的处理如图所示。

### `1.2.1 代码`

1. CWinApp::InitInstance() 
   1. 设计窗口类
   2. 注册窗口类
   3. 创建窗口
   4. 显示&更新
   5. return true         -->消息循环
		 OnOk()		    -->DestroyWindow()
3. OnCancel()              -->DestroyWindow()
4. PostNcDestory()         -->delete this

### `1.2.2 流程分析`



# `2. 标准文件对话框` 

1. 封装在CFileDialog中.
2. 重要函数
   1. 构造函数
   2. DoModal()
   3. GetPathName()

```
TCHAR strFilter[] = _T(".cpp|*.cpp|.h|*.h|所有文件(*.*)|*.*||");
CFileDialog oFileDlg(true, L"txt", L"new 1.txt", 0, strFilter);		
if (IDOK == oFileDlg.DoModal())
{
	CString strFilePath = oFileDlg.GetPathName();
	AfxMessageBox(strFilePath);
}
```
# `3. 标准颜色对话框`

1. 封装在CColorDialog中.
2. 重要函数
   1. DoModal()
   2. GetColor()

```
CColorDialog oClrDlg;			 
if (IDOK == oClrDlg.DoModal())    
{
COLORREF clr = oClrDlg.GetColor();   
CString wcsTmp;
wcsTmp.Format(L"%08x", clr);
AfxMessageBox(wcsTmp);
}
```

# `4. 标准字体对话框`

1. 封装在CFileDialog中.
2. 重要函数
   1. 构造函数
   2. DoModal()
   3. GetPathName()

```
CFontDialog dlg;
if (IDOK == dlg.DoModal())
{
// Create the font using the selected font from CFontDialog.
LOGFONT lf;
memcpy(&lf, dlg.m_cf.lpLogFont, sizeof(LOGFONT));

CFont font;
assert(font.CreateFontIndirect(&lf));

// Do something with the font just created...
CClientDC dc(this);
CFont* def_font = dc.SelectObject(&font);
dc.TextOut(5, 5, _T("Hello"), 5);
dc.SelectObject(def_font);

// Done with the font. Delete the font object.
font.DeleteObject();
}
```

