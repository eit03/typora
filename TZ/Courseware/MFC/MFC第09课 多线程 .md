***
[TOC]
***

# `1. 进程`
>进程（Process）是计算机中的程序关于某数据集合上的一次运行活动，是系统进行资源分配和调度的基本单位，是操作系统结构的基础。在早期面向进程设计的计算机结构中，进程是程序的基本执行实体；在当代面向线程设计的计算机结构中，进程是线程的容器.

## `1.1 相关API`
CreateProcess()
ExitProcess()
OpenProcess()
TerminateProcess()

## `1.2 创建进程例子` 
```
#define _CRT_SECURE_NO_WARNINGS
#include <windows.h>
#include <stdio.h>
#include <assert.h>


int main()
{
	STARTUPINFOW si{};
	si.cb = sizeof(STARTUPINFO);
	PROCESS_INFORMATION pi{};
	BOOL bRst = CreateProcessW(L"..\\Debug\\Project1.exe", 0, 0, 0, 0, CREATE_NEW_CONSOLE, 0, 0, &si, &pi);	//创建进程
	assert(bRst);
	
	getchar();

	TerminateProcess(pi.hProcess, 0);	//结束进程

	return 0;
}
```

# `2. 线程`
>线程是程序中一个单一的顺序控制流程,进程内的一个相对独立的、可调度的执行单元，是系统独立调度和分派CPU的基本单位指令运行时的程序的调度单位。在单个程序中同时运行多个线程完成不同的工作，称为多线程。

```
#define _CRT_SECURE_NO_WARNINGS
#include <windows.h>
#include <stdio.h>
#include <assert.h>
#include <process.h>

unsigned int (__stdcall ThreadCallback0)(void*);

int main()
{
	HANDLE hThread0 = (HANDLE)_beginthreadex(0, 0, ThreadCallback0, 0, 0, 0);
	HANDLE hThread1 = (HANDLE)_beginthreadex(0, 0, ThreadCallback0, 0, 0, 0);

	getchar();

	CloseHandle(hThread0);
	CloseHandle(hThread1);

	return 0;
}

unsigned int __stdcall ThreadCallback0(void *)
{
	return 0;
}
```

# `3. 线程同步机制`
## `1. 原子操作`

| Function                   | Describe                 |
| -------------------------- | ------------------------ |
| InterlockedIncrement       | 给一个整形变量自增1.              |
| InterlockedExchangeAdd     | 为一个整形变量以原子 方式加上一个数.      |
| InterlockedExchange        | 将一个32位数以原子方式赋值给另一个数.     |
| InterlockedExchange64      | 将一个64位数以原子方式赋值给另一个数.     |
| InterlockedCompareExchange | 如果两个数相等,就将另外一个数赋值,不相等无效果 |

在MSDN上是可以找到函数用法的,这里就不写了.

## `2. SRWLock`

| Function                                 | Describe |
| :--------------------------------------- | -------- |
| InitializeCriticalSection                |          |
| DeleteCriticalSection                    |          |
| EnterCriticalSection/TryEnterCriticalSection |          |
| LeaveCriticdSection                      |          |

适用于读多写少的时候.只存在==读==or==一个写==or==Nothint==三种状态.

## `3. CriticalSection`

| Function                                 | Describe |
| ---------------------------------------- | -------- |
| InitializeCriticalSection                |          |
| DeleteCriticalSection                    |          |
| EnterCriticalSection/TryEnterCriticalSection |          |
| LeaveCriticdSection                      |          |

==临界区只是本进程可见的.==

==线程意外死亡,临界出可能得不到释放.==

## `4. Mutex`

| Function            | Describe |
| ------------------- | -------- |
| CreateMutex         |          |
| WaitForSingleObject |          |
| ReleaseMutex        |          |
| CloseHandle         |          |

==互斥体是内核对象.==

## `5. Semaphore`

| Function                      | Describe |
| ----------------------------- | -------- |
| CreateSemahpore/OpenSemaphore |          |
| CloseHandle                   |          |
| WaitForSingleObject           |          |
| ReleaseMutex                  |          |

## `6. Event`

| Function                                 | Describe |
| ---------------------------------------- | -------- |
| CreateEvent/OpenEvent                    |          |
| CloseHandle                              |          |
| WaitForSingleObject/WaitForMultipleObjects |          |
| SetEvent/ResetEvent/PulseEvent           |          |

