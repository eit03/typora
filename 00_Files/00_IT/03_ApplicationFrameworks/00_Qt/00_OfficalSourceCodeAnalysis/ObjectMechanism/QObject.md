***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` \[QObject\]
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
//Prepare *** *** *** *** *** *** *** *** *** *** *** ***

//Properties *** *** *** *** *** *** *** *** *** *** *** ***
public:
    static const QMetaObject staticMetaObject;
protected:
    QScopedPointer<QObjectData> d_ptr;
    static const QMetaObject staticQtMetaObject;
    
//Constructor *** *** *** *** *** *** *** *** *** *** *** ***
public:
    Q_INVOKABLE explicit QObject(QObject *parent=nullptr);
    virtual ~QObject();
protected:
    QObject(QObjectPrivate &dd, QObject *parent = nullptr);
//Functions *** *** *** *** *** *** *** *** *** *** *** ***
}
```



## `Constructor`

```
QObject::QObject(QObject *parent)
    : d_ptr(new QObjectPrivate)
{
    Q_D(QObject);
    d_ptr->q_ptr = this;
    d->threadData = (parent && !parent->thread()) ? parent->d_func()->threadData : QThreadData::current();
    d->threadData->ref();
    if (parent) {
        QT_TRY {
            if (!check_parent_thread(parent, parent ? parent->d_func()->threadData : 0, d->threadData))
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
        reinterpret_cast<QHooks::AddQObjectCallback>(qtHookData[QHooks::AddQObject])(this);
}
```



## `Memory Model`

```
[QObject]
    static const QMetaObject staticMetaObject;
    static const QMetaObject staticQtMetaObject;
    __vfptr;
    QObjectPrivate* d_ptr;
```





# `Properties`
###### `objectName : QString `



# `Public Functions`
###### `QObject(QObject* parent = nullptr)`
###### `virtual `
###### `~QObject()`
###### `bool `
###### `blockSignals(bool block)`
###### `const QObjectList &`
###### `children() const`
###### `QMetaObject::Connection `
###### `connect(const QObject* sender, const char* signal, const char* method, Qt::ConnectionType type = Qt::AutoConnection) const`
###### `bool `
###### `disconnect(const char* signal = nullptr, const QObject* receiver = nullptr, const char* method = nullptr) const`
###### `bool `
###### `disconnect(const QObject* receiver, const char* method = nullptr) const`
###### `void `
###### `dumpObjectInfo() const`
###### `void `
###### `dumpObjectTree() const`
###### `QList<QByteArray> `
###### `dynamicPropertyNames() const`
###### `virtual bool `
###### `event(QEvent* e)`
###### `virtual bool `
###### `eventFilter(QObject* watched, QEvent* event)`
###### `T `
###### `findChild(const QString &name = QString(), Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
###### `QList<T> `
###### `findChildren(const QString &name = QString(), Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
###### `QList<T> `
###### `findChildren(const QRegExp &regExp, Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
###### `QList<T> `
###### `findChildren(const QRegularExpression &re, Qt::FindChildOptions options = Qt::FindChildrenRecursively) const`
###### `bool `
###### `inherits(const char* className) const`
###### `void `
###### `installEventFilter(QObject* filterObj)`
###### `bool `
###### `isWidgetType() const`
###### `bool `
###### `isWindowType() const`
###### `void `
###### `killTimer(int id)`
###### `virtual const QMetaObject* `
###### `metaObject() const`
###### `void `
###### `moveToThread(QThread* targetThread)`
###### `QString `
###### `objectName() const`
###### `QObject* `
###### `parent() const`
###### `QVariant `
###### `property(const char* name) const`
###### `void `
###### `removeEventFilter(QObject* obj)`
###### `void `
###### `setObjectName(const QString &name)`
###### `void `
###### `setParent(QObject* parent)`
###### `bool `
###### `setProperty(const char* name, const QVariant &value)`
###### `bool `
###### `signalsBlocked() const`
###### `int `
###### `startTimer(int interval, Qt::TimerType timerType = Qt::CoarseTimer)`
###### `int `
###### `startTimer(std::chrono::milliseconds time, Qt::TimerType timerType = Qt::CoarseTimer)`
###### `QThread* `
###### `thread() const`



# `Public Slots`
###### `void `
###### `deleteLater()`



# `Static Public Members`
###### `QMetaObject::Connection `
###### `connect(const QObject* sender, const char* signal, const QObject* receiver, const char* method, Qt::ConnectionType type = Qt::AutoConnection)`
###### `QMetaObject::Connection `
###### `connect(const QObject* sender, const QMetaMethod &signal, const QObject* receiver, const QMetaMethod &method, Qt::ConnectionType type = Qt::AutoConnection)`
###### `QMetaObject::Connection `
###### `connect(const QObject* sender, PointerToMemberFunction signal, const QObject* receiver, PointerToMemberFunction method, Qt::ConnectionType type = Qt::AutoConnection)`
###### `QMetaObject::Connection `
###### `connect(const QObject* sender, PointerToMemberFunction signal, Functor functor)`
###### `QMetaObject::Connection `
###### `connect(const QObject* sender, PointerToMemberFunction signal, const QObject* context, Functor functor, Qt::ConnectionType type = Qt::AutoConnection)`
###### `bool `
###### `disconnect(const QObject* sender, const char* signal, const QObject* receiver, const char* method)`
###### `bool `
###### `disconnect(const QObject* sender, const QMetaMethod &signal, const QObject* receiver, const QMetaMethod &method)`
###### `bool `
###### `disconnect(const QMetaObject::Connection &connection)`
###### `bool `
###### `disconnect(const QObject* sender, PointerToMemberFunction signal, const QObject* receiver, PointerToMemberFunction method)`
###### `const QMetaObject `
###### `staticMetaObject`
###### `QString `
###### `tr(const char* sourceText, const char* disambiguation = Q_OBJECT, int n = Q_OBJECT)`



# `Protected Functions`
###### `virtual void `
###### `childEvent(QChildEvent* event)`
###### `virtual void `
###### `connectNotify(const QMetaMethod &signal)`
###### `virtual void `
###### `customEvent(QEvent* event)`
###### `virtual void `
###### `disconnectNotify(const QMetaMethod &signal)`
###### `bool `
###### `isSignalConnected(const QMetaMethod &signal) const`
###### `int `
###### `receivers(const char* signal) const`
###### `QObject* `
###### `sender() const`
###### `int `
###### `senderSignalIndex() const`
###### `virtual void `
###### `timerEvent(QTimerEvent* event)`



# `Signals`
###### `void `
###### `destroyed(QObject* obj = nullptr)`
###### `void `
###### `objectNameChanged(const QString &objectName)`



# `Related Non-Members`
###### `typedef `
###### `QObjectList`
###### `QList<T> `
###### `qFindChildren(const QObject* obj, const QRegExp &regExp)`
###### `T `
###### `qobject_cast(QObject* object)`
###### `T `
###### `qobject_cast(const QObject* object)`



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


