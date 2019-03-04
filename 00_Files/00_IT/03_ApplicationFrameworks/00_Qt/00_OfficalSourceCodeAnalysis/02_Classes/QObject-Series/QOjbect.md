***
`Version:` Qt 5.12.1, QtCreate 4.8.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:`
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`
# `Data Struct`
## `Type Declaration`
```
class Q_CORE_EXPORT QObject
{
///> 0. Prepare
///> 1. Properties
public:
    // form Q_OBJECT macro.
    static const QMetaObject staticMetaObject;
protected:
    // type is QObjectPrivate.
    QScopedPointer<QObjectData> d_ptr;
    static const QMetaObject staticQtMetaObject;
    
///> 2. Constructors
public:
    Q_INVOKABLE explicit QObject(QObject *parent=nullptr);
    virtual ~QObject();
protected:
    QScopedPointer<QObjectData> d_ptr;
private:
    Q_DISABLE_COPY(QObject)
    
///> 3. Functions
}
```
## `Constructor`
```
QObject::QObject(QObject *parent)
    : d_ptr(new QObjectPrivate)
{
    Q_D(QObject);
    d_ptr->q_ptr = this;
    d->threadData = (parent && !parent->thread()) ?
    	parent->d_func()->threadData : 
    	QThreadData::current();
    d->threadData->ref();
    if (parent) {
        QT_TRY {
            if (!check_parent_thread(parent, 
                parent ? parent->d_func()->threadData : 0, 
                d->threadData))
                parent = 0;
            setParent(parent);
        } QT_CATCH(...) {
            d->threadData->deref();
            QT_RETHROW;
        }
    }
#if QT_VERSION < 0x60000
    qt_addObject(this);
#endif
    if (Q_UNLIKELY(qtHookData[QHooks::AddQObject]))
        reinterpret_cast<QHooks::AddQObjectCallback>			
            (qtHookData[QHooks::AddQObject])(this);
    Q_TRACE(QObject_ctor, this);
}
```
## `Memory Model`
```
__vfptr
d_ptr               protected  QScopedPointer<QObjectData>(QObjectPrivate)
staticMetaObject    public     static const QMetaObject
staticQtMetaObject  protected  static const QMetaObject
```



# `Properties`
###### `objectName : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`

```
QString QObject::objectName() const
{
    Q_D(const QObject);
    return d->extraData ? d->extraData->objectName : QString();
}

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

# `Public Functions`
###### `QObject(QObject* parent = nullptr)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`

###### `virtual ~QObject()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool blockSignals(bool block)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `const QObjectList & children() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QMetaObject::Connection connect(const QObject* sender, const char* signal, const char* method, Qt::ConnectionType type = Qt::AutoConnection) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool disconnect(const char* signal = nullptr, const QObject* receiver = nullptr, const char* method = nullptr) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool disconnect(const QObject* receiver, const char* method = nullptr) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void dumpObjectInfo() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void dumpObjectTree() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QList<QByteArray> dynamicPropertyNames() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual bool event(QEvent* e)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual bool eventFilter(QObject* watched, QEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `T findChild(const QString &name = QString(), Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QList<T> findChildren(const QString &name = QString(), Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QList<T> findChildren(const QRegExp &regExp, Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QList<T> findChildren(const QRegularExpression &re, Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool inherits(const char* className) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void installEventFilter(QObject* filterObj)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isWidgetType() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isWindowType() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void killTimer(int id)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual const QMetaObject* metaObject() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void moveToThread(QThread* targetThread)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString objectName() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QObject* parent() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QVariant property(const char* name) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void removeEventFilter(QObject* obj)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setObjectName(const QString &name)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setParent(QObject* parent)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool setProperty(const char* name, const QVariant &value)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool signalsBlocked() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int startTimer(int interval, Qt::TimerType timerType = Qt::CoarseTimer)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int startTimer(std::chrono::milliseconds time, Qt::TimerType timerType = Qt::CoarseTimer)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QThread* thread() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`



# `Public Slots`
###### `void deleteLater()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`



# `Static Public Members`
###### `QMetaObject::Connection connect(const QObject* sender, const char* signal, const QObject* receiver, const char* method, Qt::ConnectionType type = Qt::AutoConnection)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QMetaObject::Connection connect(const QObject* sender, const QMetaMethod &signal, const QObject* receiver, const QMetaMethod &method, Qt::ConnectionType type = Qt::AutoConnection)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QMetaObject::Connection connect(const QObject* sender, PointerToMemberFunction signal, const QObject* receiver, PointerToMemberFunction method, Qt::ConnectionType type = Qt::AutoConnection)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QMetaObject::Connection connect(const QObject* sender, PointerToMemberFunction signal, Functor functor)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QMetaObject::Connection connect(const QObject* sender, PointerToMemberFunction signal, const QObject* context, Functor functor, Qt::ConnectionType type = Qt::AutoConnection)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool disconnect(const QObject* sender, const char* signal, const QObject* receiver, const char* method)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool disconnect(const QObject* sender, const QMetaMethod &signal, const QObject* receiver, const QMetaMethod &method)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool disconnect(const QMetaObject::Connection &connection)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool disconnect(const QObject* sender, PointerToMemberFunction signal, const QObject* receiver, PointerToMemberFunction method)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `const QMetaObject staticMetaObject`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString tr(const char* sourceText, const char* disambiguation = Q_OBJECT, int n = Q_OBJECT)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`



# `Protected Functions`
###### `virtual void childEvent(QChildEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void connectNotify(const QMetaMethod &signal)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void customEvent(QEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void disconnectNotify(const QMetaMethod &signal)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isSignalConnected(const QMetaMethod &signal) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int receivers(const char* signal) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QObject* sender() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int senderSignalIndex() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void timerEvent(QTimerEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Protected Variables`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QScopedPointer<QObjectData> d_ptr`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Static Protected Members`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `const QMetaObject staticQtMetaObject`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`



# `Signals`
###### `void destroyed(QObject* obj = nullptr)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void objectNameChanged(const QString &objectName)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`



# `Related Non-Members`
###### `typedef QObjectList`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QList<T> qFindChildren(const QObject* obj, const QRegExp &regExp)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `T qobject_cast(QObject* object)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `T qobject_cast(const QObject* object)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`

# `Macros`
###### `QT_NO_NARROWING_CONVERSIONS_IN_CONNECT`
###### `Q_CLASSINFO(Name, Value)`
###### `Q_DISABLE_COPY(Class)`
###### `Q_EMIT`
###### `Q_ENUM( ...)`
###### `Q_ENUM_NS( ...)`
###### `Q_FLAG( ...)`
###### `Q_FLAG_NS( ...)`
###### `Q_GADGET`
###### `Q_INTERFACES( ...)`
###### `Q_INVOKABLE`
###### `Q_NAMESPACE`
###### `Q_OBJECT`
###### `Q_PROPERTY( ...)`
###### `Q_REVISION`
###### `Q_SET_OBJECT_NAME(Object)`
###### `Q_SIGNAL`
###### `Q_SIGNALS`
###### `Q_SLOT`
###### `Q_SLOTS`


