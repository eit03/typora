***
`Version:` 5.10
`Declaration:` qobject.h
`Defination:` 
`Reference:` http://doc.qt.io/qt-5/qobject.html
`Keyword:` QObject
***
[TOC]
***

# `Brief Introduction`
# `Detailed Description`

# `DataStruct`
```
class QObject 
{
public:
    static const QMetaObject staticMetaObject;	// Q_OBJECT宏中;
protected:
    QScopedPointer<QObjectData> d_ptr;	// 这里QObjectData是基类,其实分配的是QObjectPrivate;
    static const QMetaObject staticQtMetaObject;
};
//只有一个成员变量;还是一个智能指针;有利二进制兼容;
```



```
[QObject]
    static const QMetaObject staticMetaObject;
    static const QMetaObject staticQtMetaObject;
    int* __vfptr
    QObjectPrivate* d_ptr
```

# `Properties`
###### `objectName : QString`

- QObject::d_ptr->extraData->objectName;
- By default, this property contains an empty string.
- Access functions:
	QString objectName() const;
	void setObjectName(const QString &name);


# `Public Functions`
###### `QObject(QObject *parent = Q_NULLPTR)`
###### `virtual ~QObject()`
###### `bool blockSignals(bool block)`
###### `const QObjectList & children() const`
###### `QMetaObject::Connection connect(const QObject *sender, const char *signal, const char *method, Qt::ConnectionType type = Qt::AutoConnection) const`
###### `bool disconnect(const char *signal = Q_NULLPTR, const QObject *receiver = Q_NULLPTR, const char *method = Q_NULLPTR) const`
###### `bool disconnect(const QObject *receiver, const char *method = Q_NULLPTR) const`
###### `void dumpObjectInfo() const`
###### `void dumpObjectTree() const`
###### `QList<QByteArray> dynamicPropertyNames() const`
###### `virtual bool event(QEvent *e)`
###### `virtual bool eventFilter(QObject *watched, QEvent *event)`
###### `T findChild(const QString &name = QString(), Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
###### `QList<T> findChildren(const QString &name = QString(), Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
###### `QList<T> findChildren(const QRegExp &regExp, Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
###### `QList<T> findChildren(const QRegularExpression &re, Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
###### `bool inherits(const char *className) const`
###### `void installEventFilter(QObject *filterObj)`
###### `bool isWidgetType() const`
###### `bool isWindowType() const`
###### `void killTimer(int id)`
###### `virtual const QMetaObject * metaObject() const`

```
663EF140  push        ebp  
663EF141  mov         ebp,esp  
663EF143  sub         esp,8  
663EF146  mov         dword ptr [this],ecx  
663EF149  mov         ecx,dword ptr [this]  
663EF14C  add         ecx,4		//ecx==>QObjectPrivate*
663EF14F  call        QScopedPointer<QObjectData,QScopedPointerDeleter<QObjectData> >::operator-> (6609174Dh)  
663EF154  cmp         dword ptr [eax+18h],0  	// eax==>QObjectData*	[eax+18h]==>QDynamicMetaObjectData* QObjectData::metaObject;
663EF158  je          QObject::metaObject+31h (663EF171h)  // 如果为0,返回QObject::staticMetaObject;否返回动态元对象.
663EF15A  mov         ecx,dword ptr [this]  
663EF15D  add         ecx,4  
663EF160  call        QScopedPointer<QObjectData,QScopedPointerDeleter<QObjectData> >::operator-> (6609174Dh)  
663EF165  mov         ecx,eax  
663EF167  call        QObjectData::dynamicMetaObject (6609CECCh)  	
663EF16C  mov         dword ptr [ebp-8],eax  	// eax==>QDynamicMetaObjectData* QObjectData::metaObject;
663EF16F  jmp         QObject::metaObject+38h (663EF178h)  
663EF171  mov         dword ptr [ebp-8],offset QObject::staticMetaObject (667C3704h)  
663EF178  mov         eax,dword ptr [ebp-8]  
663EF17B  mov         esp,ebp  
663EF17D  pop         ebp  
663EF17E  ret  
```

```
const QMetaObject *QObject::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}
```



###### `void moveToThread(QThread *targetThread)`
###### `QString objectName() const`

```
QString QObject::objectName() const
{
    Q_D(const QObject);
    return d->extraData ? d->extraData->objectName : QString();
}
```

###### `QObject * parent() const`
###### `QVariant property(const char *name) const`

```
QVariant QObject::property(const char *name) const
{
    Q_D(const QObject);
    const QMetaObject* meta = metaObject();
    if (!name || !meta)
        return QVariant();

    int id = meta->indexOfProperty(name);
    if (id < 0) {
        if (!d->extraData)
            return QVariant();
        const int i = d->extraData->propertyNames.indexOf(name);
        return d->extraData->propertyValues.value(i);
    }
    QMetaProperty p = meta->property(id);
#ifndef QT_NO_DEBUG
    if (!p.isReadable())
        qWarning("%s::property: Property \"%s\" invalid or does not exist",
                 metaObject()->className(), name);
#endif
    return p.read(this);
}
```



###### `void removeEventFilter(QObject *obj)`
###### `void setObjectName(const QString &name)`

```
void QObject::setObjectName(const QString &name)
{
    Q_D(QObject);
    if (!d->extraData)
        d->extraData = new QObjectPrivate::ExtraData;

    if (d->extraData->objectName != name) {
        d->extraData->objectName = name;
        emit objectNameChanged(d->extraData->objectName, QPrivateSignal());
    }
}
```

###### `void setParent(QObject *parent)`

- 设置对象的父对象.
- QWidget::setParent()与它参数是不同的.

```
void QObject::setParent(QObject *parent)
{
    Q_D(QObject);
    Q_ASSERT(!d->isWidget);
    d->setParent_helper(parent);
}
```



###### `bool setProperty(const char *name, const QVariant &value)`

```
bool QObject::setProperty(const char *name, const QVariant &value)
{
    Q_D(QObject);
    const QMetaObject* meta = metaObject();
    if (!name || !meta)
        return false;

    int id = meta->indexOfProperty(name);
    if (id < 0) {
        if (!d->extraData)
            d->extraData = new QObjectPrivate::ExtraData;

        const int idx = d->extraData->propertyNames.indexOf(name);

        if (!value.isValid()) {
            if (idx == -1)
                return false;
            d->extraData->propertyNames.removeAt(idx);
            d->extraData->propertyValues.removeAt(idx);
        } else {
            if (idx == -1) {
                d->extraData->propertyNames.append(name);
                d->extraData->propertyValues.append(value);
            } else {
                if (value == d->extraData->propertyValues.at(idx))
                    return false;
                d->extraData->propertyValues[idx] = value;
            }
        }

        QDynamicPropertyChangeEvent ev(name);
        QCoreApplication::sendEvent(this, &ev);

        return false;
    }
    QMetaProperty p = meta->property(id);
#ifndef QT_NO_DEBUG
    if (!p.isWritable())
        qWarning("%s::setProperty: Property \"%s\" invalid,"
                 " read-only or does not exist", metaObject()->className(), name);
#endif
    return p.write(this, value);
}
```

```
int QMetaObject::indexOfProperty(const char *name) const
{
    const QMetaObject *m = this;
    while (m) {
        const QMetaObjectPrivate *d = priv(m->d.data);
        for (int i = d->propertyCount-1; i >= 0; --i) {
            const char *prop = rawStringData(m, m->d.data[d->propertyData + 3*i]);
            if (name[0] == prop[0] && strcmp(name + 1, prop + 1) == 0) {
                i += m->propertyOffset();
                return i;
            }
        }
        m = m->d.superdata;
    }

    Q_ASSERT(priv(this->d.data)->revision >= 3);
    if (priv(this->d.data)->flags & DynamicMetaObject) {
        QAbstractDynamicMetaObject *me =
            const_cast<QAbstractDynamicMetaObject *>(static_cast<const QAbstractDynamicMetaObject *>(this));

        return me->createProperty(name, 0);
    }

    return -1;
}
```

###### `bool signalsBlocked() const`
###### `int startTimer(int interval, Qt::TimerType timerType = Qt::CoarseTimer)`
###### `int startTimer(std::chrono::milliseconds time, Qt::TimerType timerType = Qt::CoarseTimer)`
###### `QThread * thread() const`


# `Public Slots`
###### `void deleteLater()`


# `Signals`
###### `void destroyed(QObject *obj = Q_NULLPTR)`
###### `void objectNameChanged(const QString &objectName)`


# `Static Public Members`
###### `QMetaObject::Connection connect(const QObject *sender, const char *signal, const QObject *receiver, const char *method, Qt::ConnectionType type = Qt::AutoConnection)`
###### `QMetaObject::Connection connect(const QObject *sender, const QMetaMethod &signal, const QObject *receiver, const QMetaMethod &method, Qt::ConnectionType type = Qt::AutoConnection)`
###### `QMetaObject::Connection connect(const QObject *sender, PointerToMemberFunction signal, const QObject *receiver, PointerToMemberFunction method, Qt::ConnectionType type = Qt::AutoConnection)`
###### `QMetaObject::Connection connect(const QObject *sender, PointerToMemberFunction signal, Functor functor)`
###### `QMetaObject::Connection connect(const QObject *sender, PointerToMemberFunction signal, const QObject *context, Functor functor, Qt::ConnectionType type = Qt::AutoConnection)`
###### `bool disconnect(const QObject *sender, const char *signal, const QObject *receiver, const char *method)`
###### `bool disconnect(const QObject *sender, const QMetaMethod &signal, const QObject *receiver, const QMetaMethod &method)`
###### `bool disconnect(const QMetaObject::Connection &connection)`
###### `bool disconnect(const QObject *sender, PointerToMemberFunction signal, const QObject *receiver, PointerToMemberFunction method)`
###### `const QMetaObject staticMetaObject`
###### `QString tr(const char *sourceText, const char *disambiguation = Q_NULLPTR, int n = -1)`


# `Protected Functions`
###### `virtual void childEvent(QChildEvent *event)`
###### `virtual void connectNotify(const QMetaMethod &signal)`
###### `virtual void customEvent(QEvent *event)`
###### `virtual void disconnectNotify(const QMetaMethod &signal)`
###### `bool isSignalConnected(const QMetaMethod &signal) const`
###### `int receivers(const char *signal) const`
###### `QObject * sender() const`
###### `int senderSignalIndex() const`
###### `virtual void timerEvent(QTimerEvent *event)`


# `Related Non-Members`
###### `typedef QObjectList`
###### `QList<T> qFindChildren(const QObject *obj, const QRegExp &regExp)`
###### `T qobject_cast(QObject *object)`


# `Macros`
###### `QT_NO_NARROWING_CONVERSIONS_IN_CONNECT`
###### `Q_CLASSINFO(Name, Value)`
###### `Q_DISABLE_COPY(Class)`
###### `Q_EMIT`
###### `Q_ENUM(...)`
###### `Q_ENUM_NS(...)`
###### `Q_FLAG(...)`
###### `Q_FLAG_NS(...)`
###### `Q_GADGET`
###### `Q_INTERFACES(...)`
###### `Q_INVOKABLE`
###### `Q_OBJECT`
###### `Q_PROPERTY(...)`
###### `Q_REVISION`
###### `Q_SET_OBJECT_NAME(Object)`
###### `Q_SIGNAL`
###### `Q_SIGNALS`
###### `Q_SLOT`
###### `Q_SLOTS`