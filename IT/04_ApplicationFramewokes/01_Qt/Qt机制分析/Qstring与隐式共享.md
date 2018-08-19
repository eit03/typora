***

[TOC]

***

`Reference:`QString & Implicit Sharing.

***

# `Syntax`

```
class Q_CORE_EXPORT QString
{
public:
    typedef QStringData Data;
private:	
	Data* d;
}

typedef QTypedArrayData<ushort> QStringData;

template <class T> struct QTypedArrayData : QArrayData{}

struct Q_CORE_EXPORT QArrayData
{
	QtPrivate::RefCount ref;
    int size;
    uint alloc : 31;
    uint capacityReserved : 1;
    qptrdiff offset; // in bytes from beginning of header
};

class RefCount
{
public:
	QBasicAtomicInt atomic;
};

typedef QBasicAtomicInteger<int> QBasicAtomicInt;

template <typename T>
class QBasicAtomicInteger
{
public:
    typedef QAtomicOps<T> Ops;
	typename Ops::Type _q_value;
};

template <typename T>
struct QAtomicOps : QAtomicOpsBySize<sizeof(T)>
{
    typedef T Type;
};

template <int N> struct QAtomicOpsBySize : QGenericAtomicOps<QAtomicOpsBySize<N> > {};

// not really atomic...
template <typename BaseClass> struct QGenericAtomicOps {};
```

# `Analyze`

0. 可以看到,在QString中只有一个成员变量,还是一个指针;这样保证了类的数据结构不会改变:当要添加数据时,在成员变量类里添加就好了;而且,所谓共享,就是指这个指针,这也是为何QString类只有一个成员变量指针.
1. Data* d ==> QStringData* d ==> QTypedArrayData<ushort>* d;不能看类的实现,大概可以知道,字符串中的字符会被转换成ushort类型数组.
2. 分析QArrayData类,可以解析出QString的实现技术:
   0. QArrayData类是数据描述头,用来指向的字符串.如:引用计数 & 尺寸 & 内存尺寸 & VA2OA.
   1. 当字符串创建出来时,引用计数为1;当引用时自加,解引用时自减;delete是解引用;当计数为0时,会释放.
   2. offset是数据相对对象的偏移值.
3. QBasicAtomicInt atomic ==> QBasicAtomicInt atomic ==> QBasicAtomicInteger<int> atomic;  
   typename Ops::Type _q_value ==> QBasicAtomicInteger::QAtomicOps::int _q_value;  
   可以知道,有一个int型成员变量,还是原子操作的;也就是说,引用计数是int型的,还是线程安全的.
4. 不去看具体的实现还是有很多坑的,目前只是了解吧.