`Version:` 5.10
`Declaration:` qobject_p.h
`Defination:` 
`Reference:` 
`Keyword:` QAbstractDynamicMetaObject

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

```
struct Q_CORE_EXPORT QAbstractDynamicMetaObject : public QDynamicMetaObjectData, public QMetaObject
{
    ~QAbstractDynamicMetaObject();

    virtual QAbstractDynamicMetaObject *toDynamicMetaObject(QObject *) Q_DECL_OVERRIDE { return this; }
    virtual int createProperty(const char *, const char *) { return -1; }
    virtual int metaCall(QObject *, QMetaObject::Call c, int _id, void **a) Q_DECL_OVERRIDE { return metaCall(c, _id, a); }
    virtual int metaCall(QMetaObject::Call, int _id, void **) { return _id; } // Compat overload
};
```

```
[QAbstractDynamicMetaObject]
    [QDynamicMetaObjectData]
    [QMetaObject]
```



# `Properties`

# `Public Types`

# `Public Functions`
###### `virtual QAbstractDynamicMetaObject *toDynamicMetaObject(QObject *) Q_DECL_OVERRIDE`
###### `virtual int createProperty(const char *, const char *)`
###### `virtual int metaCall(QObject *, QMetaObject::Call c, int _id, void **a) Q_DECL_OVERRIDE`
###### `virtual int metaCall(QMetaObject::Call, int _id, void **)`

# `Public Slots`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`

