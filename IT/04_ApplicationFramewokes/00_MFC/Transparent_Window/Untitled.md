```
BOOL Cmain_window_transparentDlg::OnInitDialog()
{
	...
	// TODO: Add extra initialization here
	DWORD dwExStyle = GetWindowLong(m_hWnd, GWL_EXSTYLE);
	SetWindowLong(m_hWnd, GWL_EXSTYLE, dwExStyle | WS_EX_LAYERED);
	SetLayeredWindowAttributes(0, 150, LWA_ALPHA);
	...
}
```

