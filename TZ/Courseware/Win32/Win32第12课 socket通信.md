***
[TOC]

***

# `1. 网络基础`
## `1.1 What是网络`
> 在计算机领域中，网络是信息传输、接收、共享的虚拟平台，通过它把各个点、面、体的信息联系到一起，从而实现这些资源的共享。网络是人类发展史来最重要的发明，提高了科技和人类社会的发展。

## `1.2 Why要有网络`
实现信息的共享,提高了科技和人类社会的发展.
## `1.3 How实现网络`
计算机中,把实现网络通信技术称为TCP/IP.

# `2. TCP/IP`
## `2.1 What是TCP/IP`
> TCP/IP（Transmission Control Protocol/Internet Protocol）即传输控制协议/网间协议，是一个工业标准的协议集，它是为广域网（WANs）设计的。

## `2.2 Why要有TCP/IP`

实现信息的共享,提高了科技和人类社会的发展.

## `2.3 How实现TCP/IP`

windows中网络通信函数是在#include <WinSock2.h>中声明的.


# `3. Socket`
## `3.1 What是Socket`
socket起源于Unix，而Unix/Linux基本哲学之一就是“一切皆文件”，都可以用“打开open –> 读写write/read –> 关闭close”模式来操作。我的理解就是Socket就是该模式的一个实现，socket即是一种特殊的文件，一些socket函数就是对其进行的操作（读/写IO、打开、关闭）.可以理解socket为网络数据流的指针.
## `3.2 Why要有Socket`

一个网络数据流,总要有一个找到它的对象.

## `3.3 How实现Socket`

类句柄方式 | 流指针首地址.

# `3. TCP`
## `3.1 What是TCP`
> TCP（Transmission Control Protocol 传输控制协议）是一种面向连接的、可靠的、基于字节流的传输层通信协议，由IETF的RFC 793定义。

## `3.2 Why要有TCP`
1. 网络通信
2. 面向连接的、可靠的、基于字节流的传输层通信协议
## `3.3 How实现TCP`
```
int WSAStartup(WORD wVersionRequested, LPWSADATA lpWSAData);    //初始化Winsock DLL
int WSACleanup();                                               //关闭Winsock DLL
int socket(int af, int type, int protocol);                     //创建socket
int bind(SOCKET s, const struct sockaddr *name, int namelen);   //将本地地址与socket关联
int listen(SOCKET s, int backlog);                              //监听即将到来的连接
int connect(SOCKET s, sockaddr* name, int namelen);             //客户端连接服务端
SOCKET accept(SOCKET s, struct sockaddr* addr, int* addrlen);   //接受socket
int send(SOCKET s, const char* buf, int len, int flags);        //发送数据
int recv(SOCKET s, char* buf, int len, int flags)               //接收数据
int closesocket(SOCKET s);                                      //关闭socket

u_short htons(u_short hostshort);                               //host to net short
u_long htonl(u_long hostlong);                                  //host to net long
unsigned long inet_addr(const char* cp);                        //把一个IPv4字符串转换成in_addr成员类型.
char* inet_ntoa(in_addr in);                                    //把一个IPv4 in_addr成员类型转换成字符串.
```

```
typedef struct sockaddr {
    u_short sa_family;			// Address family.
    CHAR    sa_data[14];          // Up to 14 bytes of direct address.
} SOCKADDR, *PSOCKADDR, FAR *LPSOCKADDR;

typedef struct sockaddr_in {
    short   sin_family;           //地址家族
    USHORT  sin_port;             //端口号
    IN_ADDR sin_addr;             //IP地址
    CHAR    sin_zero[8];          //预留,对齐
} SOCKADDR_IN, *PSOCKADDR_IN;

typedef struct in_addr {
        union {
                struct { UCHAR s_b1,s_b2,s_b3,s_b4; } S_un_b;
                struct { USHORT s_w1,s_w2; } S_un_w;
                ULONG S_addr;
        } S_un;
#define s_addr  S_un.S_addr         // can be used for most tcp & ip code
#define s_host  S_un.S_un_b.s_b2    // host on imp
#define s_net   S_un.S_un_b.s_b1    // network
#define s_imp   S_un.S_un_w.s_w2    // imp
#define s_impno S_un.S_un_b.s_b4    // imp #
#define s_lh    S_un.S_un_b.s_b3    // logical host
} IN_ADDR, *PIN_ADDR, FAR *LPIN_ADDR;
```
## `3.4 代码流程`
### `3.4.1 服务器流程`
0. ::WSAStartup
1. ::socket
2. ::bind
2. ::listen
2. ::accept
5. ::recv
   2. ::send
5. ::closesocket
5. ::WSACleanup

```
#include <cassert>
#include <iostream>
#include <WinSock2.h>
#include <WS2tcpip.h>

#pragma comment(lib, "ws2_32.lib")
using namespace std;

#define BACKLOG 5

int main()
{
	int iRes{};

	// ::WSAStartup
	WSADATA wsaData;
	iRes = ::WSAStartup(MAKEWORD(1, 1), &wsaData);
	assert(0 == iRes);

	// ::socket
	SOCKET sockServ = ::socket(AF_INET, SOCK_STREAM, 0);
	assert(INVALID_SOCKET != sockServ);

	// ::bind
	/*如果你的服务器有多个网卡（每个网卡上有不同的IP地址），而你的服务（不管是在udp端口上侦听，还是在tcp端口上侦听），
	出于某种原因：可能是你的服务器操作系统可能随时增减IP地址，也有可能是为了省去确定服务器上有什么网络端口（网卡）
	的麻烦 —— 可以要在调用bind()的时候，告诉操作系统：“我需要在 yyyy 端口上侦听，所有发送到服务器的这个端口，不管是
	哪个网卡 / 哪个IP地址接收到的数据，都是我处理的。”这时候，服务器程序则在0.0.0.0这个地址上进行侦听。例如：*/
	SOCKADDR_IN addrServ;
	addrServ.sin_addr.S_un.S_addr = ::htonl(INADDR_ANY);
	addrServ.sin_family = AF_INET;
	addrServ.sin_port = ::htons(1001);
	iRes = ::bind(sockServ, (SOCKADDR*)&addrServ, sizeof(SOCKADDR));
	assert(0 == iRes);

	// ::listen
	iRes = ::listen(sockServ, BACKLOG);
	assert(0 == iRes);

	//
	SOCKADDR_IN addrClnt;
	int iLen = sizeof(SOCKADDR);
	while (true)
	{
		// ::accept
		SOCKET sockClnt = ::accept(sockServ, (SOCKADDR*)&addrClnt, &iLen);
		assert(INVALID_SOCKET != sockClnt);

		// ::send
		//ip
		char strIP[0x40]{};
		::InetNtopA(AF_INET, &addrClnt.sin_addr, (PSTR)&strIP, sizeof(strIP));
		char strSendMsg[0xff]{};
		::sprintf_s(strSendMsg, sizeof(strSendMsg), "sockClnt--> Welcome you(%s) come here !", strIP);
		int iLen = strlen(strSendMsg) + 1;
		iRes = ::send(sockClnt, strSendMsg, iLen, 0);
		assert(iLen == iRes);

		// ::recv
		char strRecvMsg[0xff]{};
		iRes = ::recv(sockClnt, strRecvMsg, sizeof(strRecvMsg), 0);	//返回 size_byte
		assert(SOCKET_ERROR != iRes);
		//output
		cout << strRecvMsg << endl;

		// ::closesocket
		::closesocket(sockClnt);
	}

	::WSACleanup();

	::system("pause");

	return 0;
}
```

### `3.4.2 客户端流程`
0. ::WSAStartup
1. ::socket
2. ::connect
2. ::send
4. ::recv
   1. ::send
5. ::closesocket
5. ::WSACleanup

```
#include <assert.h>
#include <iostream>
#include <WinSock2.h>
#include <WS2tcpip.h>

#pragma comment(lib, "ws2_32.lib")
using namespace std;

int main()
{
	int iRes{};

	// ::WSAStartup
	WSADATA wsaData;
	iRes = ::WSAStartup(MAKEWORD(1, 1), &wsaData);
	assert(0 == iRes);

	// ::socket
	SOCKET sockClnt = ::socket(AF_INET, SOCK_STREAM, 0);
	assert(INVALID_SOCKET != sockClnt);

	// ::connect
	SOCKADDR_IN addrServ;
	addrServ.sin_family = AF_INET;
	addrServ.sin_port = htons(1001);
	::InetPton(addrServ.sin_family, L"127.0.0.1", &addrServ.sin_addr.S_un.S_addr);
	iRes = ::connect(sockClnt, (SOCKADDR*)&addrServ, sizeof(SOCKADDR));
	assert(0 == iRes);
	// output
	char strIP[0x40]{};
	::InetNtopA(AF_INET, &addrServ.sin_addr, (PSTR)&strIP, sizeof(strIP));
	char strOutput[0xff]{};
	::sprintf_s(strOutput, "sockClnt--> I have connect to (%s) !", strIP);
	cout << strOutput << endl;

	// ::send
	char strSendMsg[0xff] = "sockClnt--> I`m sockClnt !";
	int iLen = strlen(strSendMsg) + 1;
	iRes = ::send(sockClnt, strSendMsg, iLen, 0);
	assert(iRes == iLen);

	// ::recv
	char strRecvMsg[0xff]{};
	iRes = ::recv(sockClnt, strRecvMsg, sizeof(strRecvMsg), 0);
	assert(SOCKET_ERROR != iRes);
	//output
	cout << strRecvMsg << endl;

	//end
	::closesocket(sockClnt);
	::WSACleanup();

	::system("pause");

	return 0;
}
```

# `4. UDP`
## `4.1 What是UDP`
> UDP 是User Datagram Protocol的简称， 中文名是用户数据报协议，是OSI（Open System Interconnection，开放式系统互联） 参考模型中一种无连接的传输层协议，提供面向事务的简单不可靠信息传送服务，IETF RFC 768是UDP的正式规范。UDP在IP报文的协议号是17。

## `4.2 Why要有UDP`
UDP是一种比TCP更快的传输协议.如果把TCP比做组装的电脑,那么UPD就是DIY的电脑.只要我想要的功能.

## `4.3 How实现UDP`
```
int sendto(SOCKET s, const char* buf, int len, int flags, const struct sockaddr* to, int tolen);
int recvfrom(SOCKET s, const char* buf, int len, int flags, const struct sockaddr* from, int fromlen)
```
## `4.4 代码流程`
### `4.4.1 服务器流程`
0. ::WSAStartup
1. ::socket
2. ::bind
3. ::recvfrom
  1. ::sendto
4. ::closesocket
5. ::WSACleanup

```
#include <WinSock2.h>
#include <stdio.h>
#include <assert.h>
#pragma comment(lib, "ws2_32.lib")

int main()
{
	// 0. ::WSAStartup
	// 1. ::socket
	// 2. ::bind
	// 3. ::recvfrom
	// 4. ::sendto
	// 5. closeall

	// 0. ::WSAStartup
	WSADATA wsaData;
	int iRes_WSAStartup = WSAStartup(MAKEWORD(2, 2), &wsaData);
	if (0 != iRes_WSAStartup) { assert(0); }

	// 1. ::socket
	SOCKET sockServ = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (INVALID_SOCKET == sockServ) { assert(0); }

	// 2. ::bind (SOCKET与SOCKADDR的对应关系的建立)
	SOCKADDR_IN addrServ;
	addrServ.sin_addr.S_un.S_addr = inet_addr("127.0.0.1");
	addrServ.sin_family = AF_INET;
	addrServ.sin_port = htons(6667);
	memset(addrServ.sin_zero, 0, sizeof(CHAR[8]));
	int iRes_bind = bind(sockServ, (SOCKADDR*)&addrServ, sizeof(SOCKADDR));
	if (0 != iRes_bind) { assert(0); }
	printf("服务器启动成功! \n");

	while (true)
	{
		// 3. ::recvfrom
		SOCKADDR_IN addrConn;
		int iLen = sizeof(SOCKADDR);
		char strRecv[0x400] = {};
		int iRes_recvfrom = recvfrom(sockServ, strRecv, sizeof(strRecv), 0, (SOCKADDR*)&addrConn, &iLen);
		if (SOCKET_ERROR == iRes_recvfrom) { assert(0); }
		char* strIP = inet_ntoa(addrConn.sin_addr);
		printf("有客户端连接,IP是 : %s ! \n", strIP);
		printf("%s", strRecv);

		// 4. ::sendto
		char strSend[] = ("你好,这是服务器给你发的数据 ! \n");
		sendto(sockServ, strSend, sizeof(strSend), 0, (SOCKADDR*)&addrConn, iLen);
	}


	// 5. closeall
	closesocket(sockServ);
	WSACleanup();
	system("pause");

    return 0;
}
```




### `4.4.2 客户端流程`
0. ::WSAStartup
1. ::socket
2. ::sendto
3. ::recvfrom
   1. ::sendto
4. ::closesocket
5. ::WSACleanup

```
#include <WinSock2.h>
#include <stdio.h>
#include <assert.h>
#pragma comment(lib, "ws2_32.lib")

int main()
{
	// 0. ::WSAStartup
	// 2. ::socket
	// 3. ::bind
	// 4. ::sendto
	// 5. ::recvfrom
	// 6. closeall

	// 0. ::WSAStartup
	WSADATA wsaData;
	int iRes_WSAStartup = WSAStartup(MAKEWORD(2, 2), &wsaData);
	if (0 != iRes_WSAStartup) { assert(0); }

	// 1. ::socket
	SOCKET sockClnt = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (INVALID_SOCKET == sockClnt) { assert(0); }

	// 2. ::bind (SOCKET与SOCKADDR的对应关系的建立)
	SOCKADDR_IN addrServ;
	int iLen = sizeof(SOCKADDR);
	addrServ.sin_addr.S_un.S_addr = inet_addr("127.0.0.1");
	addrServ.sin_family = AF_INET;
	addrServ.sin_port = htons(6667);
	memset(addrServ.sin_zero, 0, sizeof(CHAR[8]));
	//int iRes_bind = bind(sockServ, (SOCKADDR*)&addrServ, sizeof(SOCKADDR));
	//if (0 != iRes_bind) { assert(0); }
	printf("客户端启动成功! \n");

	// 4. ::sendto
	char strSend[] = "你好, 我是客户端 ! \n";
	sendto(sockClnt, strSend, sizeof(strSend), 0, (SOCKADDR*)&addrServ, iLen);

	// 5. ::recvfrom
	SOCKADDR_IN addrFrom;
	int iLenFrom = sizeof(SOCKADDR);
	char strRecv[0x400] = {};
	recvfrom(sockClnt, strRecv, 0x400, 0, (SOCKADDR*)&addrFrom, &iLenFrom);
	printf("%s", strRecv);

	// 6. closeall
	closesocket(sockClnt);
	WSACleanup();
	system("pause");

    return 0;
}
```


# `5. TCP与UDP区别`
1. TCP面向连接（如打电话要先拨号建立连接）;UDP是无连接的，即发送数据之前不需要建立连接
2. TCP提供可靠的服务。也就是说，通过TCP连接传送的数据，无差错，不丢失，不重复，且按序到达;UDP尽最大努力交付，即不保证可靠交付;
  Tcp通过校验和，重传控制，序号标识，滑动窗口、确认应答实现可靠传输。如丢包时的重发控制，还可以对次序乱掉的分包进行顺序控制。
3. UDP具有较好的实时性，工作效率比TCP高，适用于对高速传输和实时性有较高的通信或广播通信。
4. 每一条TCP连接只能是点到点的;UDP支持一对一，一对多，多对一和多对多的交互通信
5. TCP对系统资源要求较多，UDP对系统资源要求较少。

# `6作业`

1. 写一个win32界面版的TCP 或 UDP; (必做)
2. QQ的架构是: 我发消息 --> QQ服务器 --> 你收到消息, 能不能把上面的程序改进成这样? (选做)

