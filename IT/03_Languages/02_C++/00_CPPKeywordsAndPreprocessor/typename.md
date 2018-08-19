***

[TOC]

***

`Reference:`http://en.cppreference.com/w/cpp/keyword/typename

***

# `BriefIntroduction:`
> - In a template declaration, typename can be used as an alternative to class to declare type template parameters and template template parameters (since C++17).
> - Inside a declaration or a definition of a template, typename can be used to declare that a dependent name is a type.
> - Inside a requirements for type requirements (since C++20)

`typename`有三种用法:

- 声明模板参数类型时,同class.
- 在模板声明或定义里,可以被用作表明一个名称是类型,可以解歧义.
- ???

# `用法1:`

```
template <class T> struct QTypedArrayData : QArrayData{};

template <typename T> struct QTypedArrayData : QArrayData{};
```

# `用法2:`

```
typename Ops::Type _q_value;

这里的Type可以是类型名|变量名,是有歧义的;但是,typename解释其为类型名.
```



# `用法3:`
