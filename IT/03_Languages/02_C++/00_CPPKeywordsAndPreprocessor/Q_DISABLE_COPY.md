```
#define Q_DISABLE_COPY(Class) \
    Class(const Class &) Q_DECL_EQ_DELETE;\
    Class &operator=(const Class &) Q_DECL_EQ_DELETE;
```

```
    QObject(const QObject &) Q_DECL_EQ_DELETE;
    QObject &operator=(const QObject &) Q_DECL_EQ_DELETE;
```

1. 把拷贝构造与=操作符设为私有的,相当于禁用了.