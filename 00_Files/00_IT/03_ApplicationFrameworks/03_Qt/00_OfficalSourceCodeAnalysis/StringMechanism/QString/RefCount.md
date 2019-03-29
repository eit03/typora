***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` \[RefCount\] \[namespace QtPrivate\]

***
[TOC]
***



# `Brief Introduction`



# `Detailed Description`



# `Data Struct`
## `Type Declaration`

```
class RefCount
{

//Prepare *** *** *** *** *** *** *** *** *** *** *** ***

//Properties *** *** *** *** *** *** *** *** *** *** *** ***
public:
	//  0    ==> 不可共享
	//  1    ==> 自拥有(目前独享,可共享)
	// -1    ==> 静态共享(可静态共享,不可共享)    //Persistent object, never deleted
	// other ==> 共享计数
	QBasicAtomicInt atomic; //引用计数

//Constructor *** *** *** *** *** *** *** *** *** *** *** ***

//Functions ***
public:
	inline bool ref() Q_DECL_NOTHROW;                 //加计数          // (0 != atomic)
	inline bool deref() Q_DECL_NOTHROW;               //减计数          // (0 != atomic)
	bool setSharable(bool sharable) Q_DECL_NOTHROW;   //设置可共享属性  // (0 == atomic) || (1 == atomic) 才可以设置
	bool isSharable() const Q_DECL_NOTHROW;           //是否可共享      // (0 != atomic)
	bool isStatic() const Q_DECL_NOTHROW;             //是否静态共享    // (-1 == atomic)
	bool isShared() const Q_DECL_NOTHROW;             //是否被共享      // (0 != atomic) && (1 != atomic) 表示已经被共享
	void initializeOwned() Q_DECL_NOTHROW;			//自拥有
	void initializeUnsharable() Q_DECL_NOTHROW;       //不可共享
}
```



## `Constructor`

## `Memory Model`

```
[RefCount]
    QBasicAtomicInt atomic; ==> QBasicAtomicInteger<int> QBasicAtomicInt;
        [QBasicAtomicInteger : template <typename T>]
            typename Ops::Type _q_value; ==> typedef T Type; typedef QAtomicOps<T> Ops; ==> QAtomicOps<T>::Type _q_value;
                [QAtomicOps : template <typename X>] ==> typedef std::atomic<X> Type;
                
QAtomicOps中是没有数据的,它只是泛类型的操作集合.
template <typename T> class QBasicAtomicInteger 里保存模板类型数据.
```



# `Public Types`


# `Public Functions`

# `Static Public Members`

# `Related Non-Members`

# `Macros`

# `说人话`