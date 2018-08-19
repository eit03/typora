***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QObjectData
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

```
class Q_CORE_EXPORT QObjectData 
{
public:
    QObject *q_ptr;	//拥有都指针,由QObjectPrivate::q_func()访问;
    QObject *parent; //父对象指针,由QObject::parent()与QObject::setParent()访问;
    QObjectList children; //子对象列表;
    uint isWidget : 1; //是部件与否;
    uint blockSig : 1; //
    uint wasDeleted : 1; //QObject::~QObject()的头部会置为真.析构标志.
    uint isDeletingChildren : 1; //删除子对象前置为真,成功后置为假.
    uint sendChildEvents : 1; //如果是子对象,是否可发送事件给父对象.
    uint receiveChildEvents : 1; //如果是父对象,是否可接收子对象事件.
    uint isWindow : 1; //for QWindow
    uint deleteLaterCalled : 1;
    uint unused : 24; //未使用
    int postedEvents;
    QDynamicMetaObjectData *metaObject; //动态元对象数据指针;
    
public:
    virtual ~QObjectData() = 0;
    QMetaObject *dynamicMetaObject() const;
};
```

```
[QObjectData]
    __vfptr
    QObject *q_ptr;
    QObject *parent;
    QObjectList children;
    uint isWidget : 1;
    uint blockSig : 1;
    uint wasDeleted : 1;
    uint isDeletingChildren : 1;
    uint sendChildEvents : 1;
    uint receiveChildEvents : 1;
    uint isWindow : 1; //for QWindow
    uint deleteLaterCalled : 1;
    uint unused : 24;
    int postedEvents;
    QDynamicMetaObjectData *metaObject;
```



# `Properties`
###### `QObject* q_ptr`
###### `QObject* parent`
###### `QObjectList children`
###### `uint isWidget : 1`
###### `uint blockSig : 1`
###### `uint wasDeleted : 1`
###### `uint isDeletingChildren : 1`
###### `uint sendChildEvents : 1`
###### `uint receiveChildEvents : 1`
###### `uint isWindow : 1 //for QWindow`
###### `uint deleteLaterCalled : 1`
###### `uint unused : 24`
###### `int postedEvents`
###### `QDynamicMetaObjectData* metaObject`




# `Public Types`
# `Public Functions`
###### `virtual ~QObjectData() = 0`

- 纯虚析构函数,不能被实例化;

###### `QMetaObject *dynamicMetaObject() const`

```
QMetaObject *QObjectData::dynamicMetaObject() const
{
    // struct Q_CORE_EXPORT QAbstractDynamicMetaObject : public QDynamicMetaObjectData, public QMetaObject{};
    // QDynamicMetaObjectData::toDynamicMetaObject() = 0;
    // QAbstractDynamicMetaObject::toDynamicMetaObject() {}
    return metaObject->toDynamicMetaObject(q_ptr);
}
```

```
virtual QAbstractDynamicMetaObject* QAbstractDynamicMetaObject::toDynamicMetaObject(QObject *) override { return this; }
```



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

