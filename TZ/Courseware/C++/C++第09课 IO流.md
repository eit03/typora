***
[TOC]
***

# `1. 流`
## `1.1 简述`
> 计算机中的流其实是一种信息的转换。它是一种有序流，因此相对于某一对象，通常我们把对象接收外界的信息输入（Input）称为输入流，相应地从对象向外输出（Output）信息为输出流，合称为输入/输出流（I/O Streams）。对象间进行信息或者数据的交换时总是先将对象或数据转换为某种形式的流，再通过流的传输，到达目的对象后再将流转换为对象数据。所以，可以把流看作是一种数据的载体，通过它可以实现数据交换和传输。

## `1.2 流的总览`

 ![流总览](C:\Users\zzzer000\Documents\Typora\TanZhouEdu\Courseware\C++\流总览.bmp)

按流一般分为三种:

- 输入流
- 输出流
- 输入输出流

按对象分为三种:

- 标准流
- 文件流
- 字符串流

# `2. 标准流`
## `2.1 标准输出流 cout对象`
> cout是ostream类型的对象,对象在std命名空间中;
```
int i = 12345678;
double dbl = 1.2345678;
char str[MAX_PATH] = "aaaaa";
cout << "this is cunt " << i << " " << dbl <<" " << str << endl;
```
## `2.2 标准输入流 cin对象`
> cin是istream类型的对象,对象在std命名空间中;
```
int i = 12345678;
double dbl = 1.2345678;
char str[MAX_PATH] = "aaaaa";
cout << "this is cunt " << i << " " << dbl <<" " << str << endl;
```



# `3. 文件流`
## `3.1 分类`
C++ 通过以下几个类支持文件的输入输出：
- ofstream: 输出的文件流类
- ifstream: 输入的文件流类
- fstream : 可输入输出的文件流类
学会了fstream,其它二个流类也就可以使用了.所以下面只会讲fstream.

## `3.2 输入输出文件流 fstream`
看微软源码可知,fstream是basic_fstream模板类的一个实例类.他有basic_fstream所有的功能.
```
typedef basic_fstream<char, char_traits<char> > fstream;
```

## `3.3 常用函数`

| Funcname | Descriptions   |
| -------- | -------------- |
| open     | 打开文件       |
| is_open  | 文件是否被打开 |
| close    | 关闭文件       |

| Operator | Descriptions |
| -------- | ------------ |
| <<       | 输出到文件   |
| \>\>     | 输入到对象   |

| Funcname | Descriptions                      |
| -------- | --------------------------------- |
| getline  | 读取一行                          |
| read     | 输入(读)到对象                    |
| write    | 输出(写)到文件                    |
| flush    | 将缓冲区的数据写出到文件,再清空它 |
| tellg    | 输入(读)文件指针位置              |
| tellp    | 输出(写)文件指针位置              |
| seekg    | 设置输入(读)文件指针位置          |
| seekp    | 设置输出(写)文件指针位置          |
| eof      | 是否到了流尾部                    |

## `3.4 重要函数详解`

```
void open(const char *_Filename, ios_base::openmode _Mode = ios_base::in | ios_base::out,
    int _Prot = (int)ios_base::_Openprot);
    
_Mode: 打开模式
_Prot: 保护模式
    
open函数的_Mode参数是非常重要的,我们要掌握它.
```

`fstream的打开模式`

|                | 无文件时 | 有文件时                                                     |
| -------------- | -------- | ------------------------------------------------------------ |
| in  out        | 不创建   | 1. 打开<br />2. 位置0<br />3. 替换<br />4. 0补位             |
| in  out  app   | 创建     | 1. 打开<br />2. 位置尾部<br />3. 不替换,尾部添加<br />4. 不0补位,尾部添加 |
| in  out  ate   | 不创建   | 打开成功,其它都不成功                                        |
| in  out  trunc | 创建     | 1. 截断打开<br />2. 位置0<br />3. 替换<br />4. 0补位         |


## `3.5 打开模式`
| ios_base::openmode | Description                                                  |
| ------------------ | ------------------------------------------------------------ |
| app                | to seek to the end of a stream  before each insertion.<br>任何输入附加到文件尾<br />不能与in配合使用<br />与out配合使用 |
| ate                | to seek to the end of a stream  when its controlling object is first created.<br>初始位置在文件尾<br />与in配合使用,定位到文件尾<br />与out配合使用,清空原文件 |
| binary             | to read a file as a binary  stream, rather than as a text stream.<br>以二进制方式读文件流 |
| in                 | to permit extraction from a  stream.<br> 为输入(读)而打开文件 |
| out                | to permit insertion to a  stream.<br> 为输出(写)而打开文件   |
| trunc              | to delete contents of an  existing file when its controlling object is created.<br>如果文件已存在则先删除该文件 |

## `3.5.1 二进制与文本的区别`

一个int型的i = 100,如果以文本的方式写出只有 0x31 0x30 0x30 三个字符,
如果以二进制的方式写出是0x64 0x00 0x00 0x00;

```
#include <fstream>
#include <assert.h>


using namespace std;

int main()
{
	long long llPos = 0;
	bool bRes = 0;
	int i = 100;

	fstream f;
	f.open("1.txt", ios_base::in | ios_base::out | ios_base::ate | ios_base::binary);
	bRes = f.is_open();
	assert(bRes);

	f << i;  //31 30 30
	f.write((char*)&i, sizeof(int));	//64 00 00 00

	f.close();

	return 0;
}
```

## `3.6 >> << read write 的区别`

\>\>是以文本方式写出的,不包含结束符;

建议大家用read write,一切尽在掌握中.

```
#include <fstream>
#include <assert.h>


using namespace std;

int main()
{
	long long llPos = 0;
	bool bRes = 0;
	char str[] = "this is a statement !";
	int i{};

	fstream f;
	f.open("1.txt", ios_base::in | ios_base::out | ios_base::ate);
	bRes = f.is_open();
	assert(bRes);

	f << str;					//到文件中的是什么
	f.write(str, sizeof(str));	    //到文件中的是什么

	//74 68 69 73 20 69 73 20 61 20 73 74 61 74 65 6D
	//65 6E 74 20 21 74 68 69 73 20 69 73 20 61 20 73
	//74 61 74 65 6D 65 6E 74 20 21 00

	f.close();

	return 0;
}
```

## `3.7 保护模式`

| 模式       | 描述              |
| ---------- | ----------------- |
| _SH_DENYRW | 拒绝读写          |
| _SH_DENYWR | 拒绝写            |
| _SH_DENYRD | 拒绝读            |
| _SH_DENYNO | 可读写            |
| _SH_SECURE | 安全模式,向前兼容 |

# `3. 文件打包`

1. 我们文件只要二个内容,就是一个文件,不管是什么文件:
   - 文件名
   - 文件内容
2. 可不可以把10个文件打成一个包呢?
3. 请设计一个格式;

# `4. 文件解包`

怎么把打包的文件解包?

# `5. 作业`

1. 把地图写成文件模式的; (必做)
2. 可以换地图; (选做)