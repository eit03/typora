***


[TOC]

***

# `引入`

```
从C到C++有很多的改变,今天我们就要学习某些重要的特性.
```

# `1. 缺省参数`

1. 默认形参值要写在函数声明里;

2. 默认形参要与在参数后面,中间不能有非默认形参;

   ```
   int Add(int a, int b = 2);
   int Add(int a = 1, int b);
   int Add(int a, int b = 2, int c);
   int Add(int a, int b = 2, int c = 3, int d = 4);
   ```

   ​

# `2. 重载函数`
## `2.1 引入`
```
请写一个函数,计算两个数的和,(整数,浮点数,或者他们的组合).

int Add(int iArg0, int iArg1);          //int加法
double Add(double fArg0, double fArg1);    //double加法
float Add(float fArg0, float fArg1);    //float加法

int Add(int iArg0, char iArg1);          //加法 类型顺序不同
int Add(char iArg0, char iArg1);         //加法 类型顺序不同

解决:在c语言部分,可能写不同的函数名进行实现,坏处就是调用麻烦.
```

## `2.2 规则`
```
重载函数是函数的一种特殊情况，为方便使用，C++允许在同一范围中声明几个功能类似的同名函数，但是这些同名函数的形式参数（指参数的个数、类型或者顺序）必须不同，也就是说用同一个运算符完成不同的运算功能。这就是重载函数。重载函数常用来实现功能类似而所处理的数据类型不同的问题。

同一范围中   同名函数   形式参数必须不同    实现功能类似而所处理的数据类型不同的问题    与返回值类型一毛钱关系没有.
```

## `2.3 怎么确定是重载函数`
```
1. 函数名相同 (必须)
2. 作用域相同 (必须)
3. 参数列表:  (之一)
       参数个数不同
       类型不同
       类型顺序不同
4. const参数不构成重载 (反面)                     
   int Add(int iArg0, int iArg1);          //int加法   ?Add@@YAHHH@Z
   int Add(const int iArg0, int iArg1);    //int加法   ?Add@@YAHHH@Z
5. 返回值不同不构成重载 (反面)
6. 引用和非引用 <不?> 构成重载 (反面)
   int Add(int iArg0, int iArg1);          //int加法   ?Add@@YAHHH@Z
   int Add(int& iArg0, int iArg1);         //int加法   ?Add@@YAHAAHH@Z
   error C2668: 'Add': ambiguous call to overloaded function
7. const函数和非const函数构成重载(在成员函数中) 
   int Add(int iArg0, int iArg1);          //int加法   ?Add@@YAHHH@Z
   int Add(int iArg0, int iArg1) const;    //error C2270: 'Add': modifiers not allowed on nonmember functions
```

## `2.4 函数重载冲突`
```
int fun(int x,int y);  
int fun(int x,int y,int z = 10); 
//error C2668: 'fun': ambiguous call to overloaded function
```

## `2.5 重载实现方式`

编译器看的函数名与我们看的不一样,会加入一些内容.

要把编译器认为的函数名的返回值类型标识符删掉,这才是函数重载时,看的函数名.

`C编译器的函数名修饰规则`
```
void (__cdecl Add)(int x, int y); 
void (__stdcall Add)(int x, int y); 
__cdecl: 在输出函数名前加上一个下划线前缀。比如: _Add
__stdcall: 编译器和链接器会在输出函数名前加上一个下划线前缀，函数名后面加上一个“@”符号和其參数的字节数。比如: _Add@8
__fastcall: 在输出函数名前加上一个“@”符号。后面也是一个“@”符号和其參数的字节数，比如: @Add@8
```

`C++编译器的函数名修饰规则`

```
1. 无论 __cdecl，__stdcall还是__fastcall调用方式，函数修饰都是以一个“?”开始，
2. 后面紧跟函数的名字。
3. 再后面是參数表的开始标识符.对于__stdcall方式，参数表的开始标识是“@@YG”，对于__cdecl方式则是“@@YA”。对于 __fastcall方式则是“@@YI”。
4. 返回类型: 与函数參数规则一样。
5. 函数参数: 函数参数类型是有对应的规则.
6. 结束标识: 參数表后以“@Z”标识整个名字的结束。假设该函数无參数，则以“Z”标识结束。


參数表的拼写代号例如以下所看到的
X--void    
D--char    
E--unsigned char    
F--short    
H--int    
I--unsigned int    
J--long    
K--unsigned long（DWORD） 
M--float    
N--double    
_N--bool 
U--struct 
.... 
用PA表示指针
用PB表示const类型的指针
假设同样类型的指针连续出现，以“0”取代,一 个“0”代表一次反复。
U表示结构类型。通常后跟结构体的类型名，用“@@”表示结构类型名的结束。


"int __stdcall Add0(int,int)" (?Add0@@YGHHH@Z)
"void __stdcall Add1(int,int)" (?Add1@@YGXHH@Z)
"double __stdcall Add2(int,int)" (?Add2@@YGNHH@Z)
"double __stdcall Add3(void)" (?Add3@@YGNXZ)

"int __stdcall Add4(int *,int *)" (?Add4@@YGHPAH0@Z)
```

# `3. 内联函数`
## `3.1 定义`
```
用函数编译好的二进制代码，替换对该函数的调用指令的方法。
内联牺牲代码空间的方法，避免了函 数调用的开销，赢得了运行时间
```

## `3.2 关键字:inline`
```
编译过程:执行到函数调用指令时，程序将在函数调用后立刻执行存储该指令的内存地址，并将函数参数复制到堆栈中，跳到标记的函数起点的内存空间，执行函数代码，执行完成之后跳回地址被保存的指令处，跳跃是需要时间消耗和内存消耗的，所以用到内联。
```

## `3.3 内联函数要求`
```
1. 递归函数不能定义为内联函数
2. 只有1~5条语句的小函数上适用否则编译系统将该函数视为普通函数。
3. 内联函数只能先定义后使用，否则编译系统也会把它认为是普通函数。
4. 声明定义都需要加上inline关键字
5. 内联分为显示内联和隐式内联，结构体和类中是隐式，不需要加inline
```

# `4. C++动态内存分配`
## `4.1 申请方式`
```
void* __CRTDECL operator new[](size_t const size)
```
```
指针变量名=new类型标识符； //申请不会主动初始化
指针变量名=new类型标识符（初始值）；//申请后初始化一个值
指针变量名=new类型标识符[内存单元个数]；//申请数组
指针变量名=new类型标识符[内存单元个数]{初始化值}；//数组赋值
返回值:如果分配内存成功，则返回其起始地址，否则返回0 

//new一个类型出来
int* pI1 = new int[10]{1, 2, 3, 4, 5};  //new 10个int
//int* pI2 = new int(10); //*pI2 = 10;
//int* pI3 = new int{ 10 }; //*pI3 = 10;
/* ... */
delete pI1;
```

## `4.2 释放内存`
```
delete 指针变量名；   //单个内存
delete[]指针变量名； //数组必须是delete[] 指针名;进行删除
注意: 
1.只可以释放new申请的内存空间，不可以是malloc申请的空间
2.不可以delete已经释放的空间否则发送意外事故,先判断NULL
```

## `4.3 显示类中转换`
```
dynamic_cast<目标类型> (源类型发量)   多态父子类指针或引用之间的转换(不要求)
const_cast<目标类型> (源类型发量)     去除指针或者引用前面的const属性
static_cast<目标类型> (源类型发量)    基本都可以用到
```

# `5. 引用类型`

## `5.1 引入`

```
1. 形参不能修改实参.
2. 指针变量不好使用.
3. 怎么返回变量本身.
```

## `5.2 定义`
```
“引用”（reference）是c++的一种新的变量类型，是对C的一个重要补充。它的作用是为变量起一个别名。
```

## `5.3 引用规则`
```
1. 引用被创建的同时必须被初始化（指针则可以在任何时候被初始化）。
2. 不能有NULL引用，引用必须与合法的存储单元关联（指针则可以是NULL）。
3. 一旦引用被初始化，就不能改变引用的关系。
```

## `5.4 引用的使用`

###### `实参 形参`

```
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>


void Swap(int& a, int& b);

int main()
{
    int x = 10;
    int y = 20;
    //x与a绑定了.
    Swap(x, y);
    printf("x: %d, y: %d", x, y);


    return 0;
}

void Swap(int& a, int& b)
{
    int iTmp;
    iTmp = a;
    a = b;
    b = iTmp;
}

```



###### `指针变量作形参`

以前都有学过.

###### `引用`

    int i = 0;
    int j = 20;
    
    //error C2530: 'ri': references must be initialized
    //引用 
    int& ri = i;
    ri = 10;
    printf("ri: %d, i = %d, j = %d \n", ri, i, j);
    //指针
    int* p = &i;
    *p = 40;
    printf("ri: %d, i = %d, j = %d \n", ri, i, j);
    
    ri = j;  
    printf("ri: %d, i = %d, j = %d \n", ri, i, j);
## `5.5 引用的主要作用`
```
传递函数的参数和返回值。
```



# `6. 作业`

1. 写出一个int类型的加法函数Add,写出一个unsigned int 类型的加法函数Add,写出一个float类型的加法函数Add;
   把编译器认为的函数名,重载规则的函数名写出来 (必做)
2. 写二个交换变量内容的函数,一个用指针,一个用引用; (必做)

