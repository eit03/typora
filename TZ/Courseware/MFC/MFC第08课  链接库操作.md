***

[TOC]

***



# `1. 链接库`
## `1.1 简介`
## `1.2 分类`
1. 静态链接库
2. 动态链接库

# `2. 静态链接库`
## `2.1 简介`
## `2.2 例子`

1. 在工程面板中选择创建==Static Library==类型工程.

2. 添加Main.h文件,内容如下:
   ```
   #pragma once
   extern "C" int Add(int x, int y);
   ```

3. 添加Main.cpp文件,内容如果下:

   ```
   #include "Main.h"

   int Add(int x, int y) { return x + y; }
   ```

4. 添加工程,选择win32控制台类型工程.

5. 添加Main.cpp,内容如下:

   ```
   #include <stdio.h>
   #include "C:\\Users\\???????\\source\\repos\\StaticLib0\\StaticLib0\\Main.h"				//指出了Add函数.
   #pragma comment(lib, "C:\\Users\\???????\\source\\repos\\StaticLib0\\Debug\\StaticLib0.lib")   //.obj链接.lib

   int main()
   {
   	int i = Add(3, 4);
   	printf("%d", i);

   	return 0;
   }
   ```
# `3. 动态链接库`
## `3.1 简介`



## `3.2 显示动态链接库例子`

1. 在工程面板中选择创建==Dynamic-Link Library (DLL)==类型工程.

2. 添加Main.h文件,内容如下:
   ```
   #pragma once
   extern "C" int _declspec(dllexport)Add(int x, int y);
   ```

3. 添加Main.cpp文件,内容如果下:

```
#include "stdafx.h"
#include "Main.h"

int Add(int x, int y) { return x + y; }
```

4. 添加工程,选择win32控制台类型工程.

5. 添加Main.cpp,内容如下:
```
#include <stdio.h>
#include <windows.h>


typedef int(*PFUN)(int, int);

int main()
{
	HINSTANCE hDll = 0;
	PFUN pAdd = 0;
	hDll = LoadLibrary("C:\\Users\\zzzer000\\source\\repos\\DynamicLinkLib0\\Debug\\DynamicLinkLib0.dll");
	if (!hDll)
	{
		printf("LoadLibrary() Err");
		return 0;
	}

	pAdd = (PFUN)GetProcAddress(hDll, "Add");
	if (!pAdd)
	{
		printf("GetProcAddress() Err");
		return 0;
	}
	
	int i = pAdd(4, 5);
	printf("%d \n", i);

	return 0;
}
```


## `3.3 隐式动态链接库例子`

把.h .dll .lib放大使用目录下,再包含.h就可以了.

# `4. 三种方式的区别`

| 静态链接库 | 显示动态链接库 | 隐式动态链接库 |             |
| ---------- | -------------- | -------------- | ----------- |
| Y          | N              | N              | 代码在exe中 |
| -          | -              | Y              | .lib在exe中 |

