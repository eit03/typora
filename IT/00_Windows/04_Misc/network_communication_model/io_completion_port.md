***
`reference:` 
`reference:`
`reference:`
***
[TOC]
***



# `Srv`

```
#pragma once
#include <Windows.h>


typedef struct _COMPLETION_KEY
{
	SOCKET sock{};
	sockaddr_in addr{};
	WCHAR buf[0x400]{};
	int iOperatorType{}; //类型没有使用
}COMPLETION_KEY, *PCOMPLETION_KEY;

void __cdecl IOCPProc(void* lpParam);
```

```
#include <WinSock2.h>
#include <Windows.h>
#include <assert.h>
#include <iostream>
#include "_global.h"


void __cdecl IOCPProc(void * lpParam)
{
	BOOL bRes{};
	DWORD dwTransferred{};
	PCOMPLETION_KEY pck{};
	LPOVERLAPPED pOL{};

	while (true)
	{
		 bRes = GetQueuedCompletionStatus(lpParam, &dwTransferred, (PULONG_PTR)&pck, &pOL, INFINITE);

		 if (FALSE == bRes && 0 == pOL && ERROR_ABANDONED_WAIT_0 == GetLastError())
		 {
			 // completion port has been closed;
			 closesocket(pck->sock);
			 delete pck;
			 pck = 0;
			 assert(0);
		 }
		 else if (0 == bRes && 0 == dwTransferred)
		 {
			 // socket has been closed;
			 closesocket(pck->sock);
			 delete pck;
			 pck = 0;
			 continue;
		 }
		 else if (!dwTransferred)
		 {
			 // socket has been closed;
			 closesocket(pck->sock);
			 delete pck;
			 pck = 0;
			 continue;
		 }
		 else if (!bRes)
		 {
			 // unknow error occurs;
			 std::cout << "GetQueuedCompletionStatus: unknow error occurs!" << std::endl;
			 assert(0);
		 }

		 // output content;
		 std::cout << (char*)pck->buf << std::endl;

		 // recv msg
		 //memset(pck->buf, 0, sizeof(COMPLETION_KEY::buf));
		 WSABUF wsaBuf{ sizeof(COMPLETION_KEY::buf), (char*)pck->buf };
		 DWORD dwRetCounter{};
		 WSAOVERLAPPED wsaOL{};
		 WSARecv(pck->sock, &wsaBuf, 1, 0, &dwRetCounter, &wsaOL, 0);
	}
}
```

```
#include <WinSock2.h>
#include <Windows.h>
#include <assert.h>
#include <iostream>
#include <process.h>
#include "_global.h"
#pragma comment(lib, "Ws2_32.lib")

/**
* 1. create iocp
* 2. create threads
* 3. wsastartup
* 4. socket
* 5. bind
* 6. listen
*		7. accept 
*		8. bind iocp
*		9. recv
* 10. closesocket
*/
int main()
{
	// go
	int iRes{};

	// 1. create iocp
	HANDLE hIOCP = CreateIoCompletionPort(INVALID_HANDLE_VALUE, 0, 0, 0);
	assert(hIOCP);

	// 2. create threads
	for (int i = 0; i < 4 ; i++)
	{
		HANDLE hThread = (HANDLE)_beginthread(IOCPProc, 0, hIOCP);
		assert(-1 != (int)hThread);
		CloseHandle(hThread);
	}

	// 3. wsastartup
	WSADATA wsaData{};
	iRes = WSAStartup(0x202, &wsaData);
	assert(!iRes);

	// 4. socket
	SOCKET sockLsn = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	assert(INVALID_SOCKET != sockLsn);

	// 5. bind
	sockaddr_in addrSrv{};
	addrSrv.sin_family = AF_INET;
	addrSrv.sin_addr.S_un.S_addr = htonl(INADDR_ANY);
	addrSrv.sin_port = htons(6666);
	iRes = bind(sockLsn, (sockaddr*)&addrSrv, sizeof(sockaddr));
	assert(!iRes);

	// 6. listen
	iRes = listen(sockLsn, 200);
	assert(!iRes);

	while (true)
	{
		//7. accpet
		sockaddr_in addrCln{};
		int iSize = sizeof(sockaddr_in);
		SOCKET sockCln = accept(sockLsn, (sockaddr*)&addrCln, &iSize);
		assert(INVALID_SOCKET != sockCln);

		// 8. bind iocp
		PCOMPLETION_KEY pck = new COMPLETION_KEY;
		pck->sock = sockCln;
		pck->addr = addrCln;
		CreateIoCompletionPort((HANDLE)sockCln, hIOCP, (ULONG_PTR)pck, 0);

		// 9. recv
		WSABUF wsaBuf{sizeof(COMPLETION_KEY::buf), (char*)pck->buf};
		DWORD dwRetCounter{};
		WSAOVERLAPPED wsaOL{};
		WSARecv(sockCln, &wsaBuf, 1, 0, &dwRetCounter, &wsaOL, 0);
	}

	// 10. closesocket
	closesocket(sockLsn);
	WSACleanup();

	//end
	return 0;
}
```

# `Cln`

```
#define _WINSOCK_DEPRECATED_NO_WARNINGS
#include <WinSock2.h>
#include <Windows.h>
#include <assert.h>
#include <iostream>
#include <process.h>
#pragma comment(lib, "Ws2_32.lib")

/**
* 1. wsastartup
* 2. socket
* 3. connect
*		4. send
* 5. closesocket
*/
int main()
{
	// go
	int iRes{};

	// 1. wsastartup
	WSADATA wsaData{};
	iRes = WSAStartup(0x202, &wsaData);
	assert(!iRes);

	// 2. socket
	SOCKET sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	assert(INVALID_SOCKET != sock);

	// 3. connect
	sockaddr_in addrCln{};
	addrCln.sin_family = AF_INET;
	addrCln.sin_addr.S_un.S_addr = inet_addr("127.0.0.1");
	addrCln.sin_port = htons(6666);
	iRes = connect(sock, (sockaddr*)&addrCln, sizeof(sockaddr));
	assert(!iRes);

	char szStr[0x400]{};
	while (true)
	{
		std::cout << "please input msg to send (exit to quit): ";
		std::cin.getline(szStr, 0x400);
		if (!strcmp("exit", szStr)) break;

		// 4. send
		iRes = send(sock, szStr, strlen(szStr) + 1, 0);
		assert(iRes);
		assert(SOCKET_ERROR != iRes);
		assert(iRes == strlen(szStr) + 1);
	}

	// 5. closesocket
	closesocket(sock);
	WSACleanup();

	//end
	return 0;
}
```

