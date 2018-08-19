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

### `3.4.2 客户端流程`
0. ::WSAStartup
1. ::socket
2. ::connect
2. ::send
4. ::recv
   1. ::send
5. ::closesocket
5. ::WSACleanup

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
5. ::closesocket
5. ::WSACleanup
### `4.4.2 客户端流程`
0. ::WSAStartup
1. ::socket
2. ::connect
2. ::sendto
4. ::recvfrom
   1. ::sendto
5. ::closesocket
5. ::WSACleanup

# `5. TCP与UDP区别`
1. TCP面向连接（如打电话要先拨号建立连接）;UDP是无连接的，即发送数据之前不需要建立连接
2. TCP提供可靠的服务。也就是说，通过TCP连接传送的数据，无差错，不丢失，不重复，且按序到达;UDP尽最大努力交付，即不保证可靠交付;
Tcp通过校验和，重传控制，序号标识，滑动窗口、确认应答实现可靠传输。如丢包时的重发控制，还可以对次序乱掉的分包进行顺序控制。
3. UDP具有较好的实时性，工作效率比TCP高，适用于对高速传输和实时性有较高的通信或广播通信。
4. 每一条TCP连接只能是点到点的;UDP支持一对一，一对多，多对一和多对多的交互通信
5. TCP对系统资源要求较多，UDP对系统资源要求较少。

# `6. TCP/IP协议三次握手与四次分手`

