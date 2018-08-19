```
#pragma once
#include <atlstr.h>
#include <WinSock2.h>
#pragma comment (lib,"ws2_32.lib")

#define BACKLOG 0xff

class CTcpSocket
{
	//*****************************************************************************************************************
	//Prepare ******************************************************************************************************

	//*****************************************************************************************************************
	//Properties ***************************************************************************************************
public:
	SOCKET m_sockSrv{};
	SOCKADDR_IN m_addrSrv{};

	SOCKET m_sockClnt{};
	SOCKADDR_IN m_addrClnt{};

	BOOL m_bIsSrv{};

protected:
private:

	//*****************************************************************************************************************
	//Constructor **************************************************************************************************
public:
	CTcpSocket();
	~CTcpSocket();

protected:
private:

	//*****************************************************************************************************************
	//Functions ****************************************************************************************************
public:
	VOID Startup(const CString& wcsIP, const SHORT usPort, const BOOL bStartupSrv = FALSE);
	VOID StartupSrv(const CString& wcsIP, const SHORT usPort);
	VOID StartupClnt(const CString& wcsIP, const SHORT usPort);
	VOID Close();

	SOCKET Accept();

	int Recv(SOCKET socket, CString& wcsMsg);
	VOID Send(SOCKET socket, CString& wcsMsg);

protected:
private:
};
```



```
#include <assert.h>
#include <WS2tcpip.h>
#include "TcpSocket.h"

CTcpSocket::CTcpSocket()
{
}

CTcpSocket::~CTcpSocket()
{
}

VOID CTcpSocket::Startup(const CString & wcsIP, const SHORT usPort, const BOOL bStartupSrv)
{
	m_bIsSrv = bStartupSrv;

	if (bStartupSrv)
		StartupSrv(wcsIP, usPort);
	else
		StartupClnt(wcsIP, usPort);
}

VOID CTcpSocket::StartupSrv(const CString & wcsIP, const SHORT usPort)
{
	// 0.go
	assert(!m_sockSrv);
	int iRes{};

	// 1.WSAStartup
	WSADATA wsaData{};
	iRes = WSAStartup(MAKEWORD(2, 2), &wsaData);
	assert(!iRes);

	// 2.socket
	m_sockSrv = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	assert(INVALID_SOCKET != m_sockSrv);

	// 3.bind
	m_addrSrv.sin_family = AF_INET;
	iRes = InetPton(AF_INET, wcsIP, &m_addrSrv.sin_addr);
	assert(1 == iRes);
	m_addrSrv.sin_port = htons(usPort);
	memset(m_addrSrv.sin_zero, 0, sizeof(m_addrSrv.sin_zero));

	iRes = bind(m_sockSrv, (SOCKADDR*)&m_addrSrv, sizeof(SOCKADDR));
	assert(!iRes);

	// 4.listen
	iRes = listen(m_sockSrv, BACKLOG);
	assert(!iRes);

	// end
}

VOID CTcpSocket::StartupClnt(const CString & wcsIP, const SHORT usPort)
{
	// 0.go
	assert(!m_sockClnt);
	int iRes{};

	// 1.WSAStartup
	WSADATA wsaData{};
	iRes = WSAStartup(MAKEWORD(2, 2), &wsaData);
	assert(!iRes);

	// 2.socket
	m_sockClnt = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	assert(INVALID_SOCKET == m_sockClnt);

	// 3.connect
	m_addrClnt.sin_family = AF_INET;
	iRes = InetPton(AF_INET, wcsIP, &m_addrClnt.sin_addr);
	assert(1 == iRes);
	m_addrClnt.sin_port = htons(usPort);
	memset(m_addrClnt.sin_zero, 0, sizeof(m_addrClnt.sin_zero));

	iRes = connect(m_sockClnt, (SOCKADDR*)&m_addrClnt, sizeof(SOCKADDR));
	assert(!iRes);

	// end
}

VOID CTcpSocket::Close()
{
	int iRes{};

	if (m_bIsSrv)
		iRes = closesocket(m_sockSrv);
	else
		iRes = closesocket(m_sockClnt);

	assert(!iRes);
}

SOCKET CTcpSocket::Accept()
{
	int iLen = sizeof(SOCKADDR);
	SOCKET sockConn = accept(m_sockSrv, (SOCKADDR*)&m_addrClnt, &iLen);
	assert(INVALID_SOCKET != sockConn);

	return sockConn;
}

int CTcpSocket::Recv(SOCKET socket, CString & wcsMsg)
{
	wcsMsg.Preallocate(0x400);
	return recv(socket, (CHAR*)wcsMsg.GetBuffer(), 0x400, 0);
}

VOID CTcpSocket::Send(SOCKET socket, CString & wcsMsg)
{
	int iLenToSend = (wcsMsg.GetLength() + 1) * sizeof(TCHAR);
	int iRes = send(socket, (CHAR*)wcsMsg.GetBuffer(), iLenToSend, 0);
	assert(SOCKET_ERROR != iRes);
	assert(iRes == iLenToSend);
}
```



