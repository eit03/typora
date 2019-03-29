***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` \[\]
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
// Prepare *** *** *** *** *** *** *** *** *** *** *** ***

// Properties *** *** *** *** *** *** *** *** *** *** *** ***
public:
    static const QMetaObject staticMetaObject;
protected:
    QScopedPointer<QObjectData> d_ptr;
    static const QMetaObject staticQtMetaObject;
    
// Constructor *** *** *** *** *** *** *** *** *** *** *** ***
public:
    Q_INVOKABLE explicit QObject(QObject *parent=nullptr);
    virtual ~QObject();
protected:
    QObject(QObjectPrivate &dd, QObject *parent = nullptr);
    
// Functions *** *** *** *** *** *** *** *** *** *** *** ***
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
###### `objectName : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`



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
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_CLASSINFO(Name, Value)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_DISABLE_COPY(Class)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_EMIT`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_ENUM( ...)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_ENUM_NS( ...)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_FLAG( ...)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_FLAG_NS( ...)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_GADGET`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_INTERFACES( ...)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_INVOKABLE`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_NAMESPACE`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_OBJECT`

The `Q_OBJECT` macro inside the private section of the class declaration is used to enable meta-object features, such as dynamic properties, signals, and slots.

```
#define Q_OBJECT \
public: \
    QT_WARNING_PUSH \
    Q_OBJECT_NO_OVERRIDE_WARNING \
    static const QMetaObject staticMetaObject; \
    virtual const QMetaObject *metaObject() const; \
    virtual void *qt_metacast(const char *); \
    virtual int qt_metacall(QMetaObject::Call, int, void **); \
    QT_TR_FUNCTIONS \
private: \
    Q_OBJECT_NO_ATTRIBUTES_WARNING \
    Q_DECL_HIDDEN_STATIC_METACALL static void qt_static_metacall(QObject *, QMetaObject::Call, int, void **); \
    QT_WARNING_POP \
    struct QPrivateSignal {}; \
    QT_ANNOTATE_CLASS(qt_qobject, "")
```

```
#define QT_WARNING_PUSH                       __pragma(warning(push))

#define Q_OBJECT_NO_OVERRIDE_WARNING

#  define QT_TR_FUNCTIONS \
    static inline QString tr(const char *s, const char *c = nullptr, int n = -1) { return staticMetaObject.tr(s, c, n); } \
    static inline QString trUtf8(const char *s, const char *c = nullptr, int n = -1) { return staticMetaObject.tr(s, c, n); }
    
#define Q_OBJECT_NO_ATTRIBUTES_WARNING

#define Q_DECL_HIDDEN_STATIC_METACALL Q_DECL_HIDDEN
#define Q_DECL_HIDDEN

#define QT_WARNING_POP                        __pragma(warning(pop))

#define QT_ANNOTATE_CLASS(type, ...)
```

```
public:
    __pragma(warning(push))
    static const QMetaObject staticMetaObject;
    virtual const QMetaObject *metaObject() const;
    virtual void *qt_metacast(const char *);
    virtual int qt_metacall(QMetaObject::Call, int, void **);
    static inline QString tr(const char *s, const char *c = nullptr, int n = -1) { return staticMetaObject.tr(s, c, n); } 
    static inline QString trUtf8(const char *s, const char *c = nullptr, int n = -1) { return staticMetaObject.tr(s, c, n); }
private:  
    static void qt_static_metacall(QObject *, QMetaObject::Call, int, void **);
    __pragma(warning(pop))
    struct QPrivateSignal {};
```
###### `Q_PROPERTY( ...)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_REVISION`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_SET_OBJECT_NAME(Object)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_SIGNAL`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_SIGNALS`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_SLOT`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Q_SLOTS`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`


