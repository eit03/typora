***
`Version:` 5.10
`Declaration:` qobject_p.h
`Defination:` 
`Reference:` 
`Keyword:` QObjectPrivate

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

```
class Q_CORE_EXPORT QObjectPrivate : public QObjectData
{
// Prepare ******************************************************************
public:
    struct ExtraData
    {
        ExtraData() {}
        #ifndef QT_NO_USERDATA
        QVector<QObjectUserData *> userData;
        #endif
        QList<QByteArray> propertyNames;
        QVector<QVariant> propertyValues;
        QVector<int> runningTimers;
        QList<QPointer<QObject> > eventFilters;
        QString objectName; //QObject的objectName属性,可用QObject::property(),QObject::setProperty()访问;
    };

    typedef void (*StaticMetaCallFunction)(QObject *, QMetaObject::Call, int, void **);
    struct Connection
    {
        QObject *sender;
        QObject *receiver;
        union { StaticMetaCallFunction callFunction; QtPrivate::QSlotObjectBase *slotObj; };
        // The next pointer for the singly-linked ConnectionList
        Connection *nextConnectionList;
        //senders linked list
        Connection *next;
        Connection **prev;
        QAtomicPointer<const int> argumentTypes;
        QAtomicInt ref_;
        ushort method_offset;
        ushort method_relative;
        uint signal_index : 27; // In signal range (see QObjectPrivate::signalIndex())
        ushort connectionType : 3; // 0 == auto, 1 == direct, 2 == queued, 4 == blocking
        ushort isSlotObject : 1;
        ushort ownArgumentTypes : 1;
        Connection() : nextConnectionList(0), ref_(2), ownArgumentTypes(true) {
            //ref_ is 2 for the use in the internal lists, and for the use in QMetaObject::Connection
        }
        ~Connection();
        int method() const { Q_ASSERT(!isSlotObject); return method_offset + method_relative; }
        void ref() { ref_.ref(); }
        void deref() {
            if (!ref_.deref()) {
                Q_ASSERT(!receiver);
                delete this;
            }
        }
    };
    
    // ConnectionList is a singly-linked list
    struct ConnectionList {
        ConnectionList() : first(0), last(0) {}
        Connection *first;
        Connection *last;
    };

    struct Sender
    {
        QObject *sender;
        int signal;
        int ref;
    };
    
// Properties ******************************************************************
public:
    ExtraData *extraData;    // extra data set by the user
    QThreadData *threadData; // id of the thread that owns the object

    QObjectConnectionListVector *connectionLists;

    Connection *senders;     // linked list of connections connected to this object
    Sender *currentSender;   // object currently activating the object
    mutable quint32 connectedSignals[2];

    union {
        QObject* currentChildBeingDeleted; //should only be used when QObjectData::isDeletingChildren is set,
        						    //如果一个子对象在调用QObjectData::isDeletingChildren()时,这个对象会被填充入字段中.
        QAbstractDeclarativeData *declarativeData; //extra data used by the declarative module
    };

    // these objects are all used to indicate that a QObject was deleted plus QPointer, which keeps a separate list
    QAtomicPointer<QtSharedPointer::ExternalRefCountData> sharedRefcount;
};

// fonctions ******************************************************************
public:
    QObjectPrivate(int version = QObjectPrivateVersion);
    virtual ~QObjectPrivate();
    void deleteChildren();

    void setParent_helper(QObject *);
    void moveToThread_helper();
    void setThreadData_helper(QThreadData *currentData, QThreadData *targetData);
    void _q_reregisterTimers(void *pointer);

    bool isSender(const QObject *receiver, const char *signal) const;
    QObjectList receiverList(const char *signal) const;
    QObjectList senderList() const;

    void addConnection(int signal, Connection *c);
    void cleanConnectionLists();

    static inline Sender *setCurrentSender(QObject *receiver, Sender *sender);
    static inline void resetCurrentSender(QObject *receiver, Sender *currentSender, Sender *previousSender);

    static QObjectPrivate *get(QObject *o) { return o->d_func(); }
    static const QObjectPrivate *get(const QObject *o) { return o->d_func(); }

    int signalIndex(const char *signalName, const QMetaObject **meta = 0) const;
    inline bool isSignalConnected(uint signalIdx, bool checkDeclarative = true) const;
    inline bool isDeclarativeSignalConnected(uint signalIdx) const;

    // To allow abitrary objects to call connectNotify()/disconnectNotify() without making
    // the API public in QObject. This is used by QQmlNotifierEndpoint.
    inline void connectNotify(const QMetaMethod &signal);
    inline void disconnectNotify(const QMetaMethod &signal);

    template <typename Func1, typename Func2>
    static inline QMetaObject::Connection connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal, const typename QtPrivate::FunctionPointer<Func2>::Object *receiverPrivate, Func2 slot, Qt::ConnectionType type = Qt::AutoConnection);

    template <typename Func1, typename Func2>
    static inline bool disconnect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal, const typename QtPrivate::FunctionPointer<Func2>::Object *receiverPrivate, Func2 slot);

    static QMetaObject::Connection connectImpl(const QObject *sender, int signal_index, const QObject *receiver, void **slot, QtPrivate::QSlotObjectBase *slotObj, Qt::ConnectionType type, const int *types, const QMetaObject *senderMetaObject);
    static QMetaObject::Connection connect(const QObject *sender, int signal_index, QtPrivate::QSlotObjectBase *slotObj, Qt::ConnectionType type);
    static bool disconnect(const QObject *sender, int signal_index, void **slot);
    
private:
    inline QObject* q_func() { return static_cast<QObject *>(q_ptr); }
    inline const QObject* q_func() const { return static_cast<const QObject *>(q_ptr); }
    friend class QObject;
```



```
[QObjectPrivate]
    [QObjectData]
    ExtraData *extraData;    // extra data set by the user
    QThreadData *threadData; // id of the thread that owns the object
    QObjectConnectionListVector *connectionLists;
    Connection *senders;     // linked list of connections connected to this object
    Sender *currentSender;   // object currently activating the object
    mutable quint32 connectedSignals[2];
    union 
    {
        QObject *currentChildBeingDeleted;
        QAbstractDeclarativeData *declarativeData; //extra data used by the declarative module
    };
    QAtomicPointer<QtSharedPointer::ExternalRefCountData> sharedRefcount;
```



# `Properties`

# `Public Types`

# `Public Functions`

###### `QObjectPrivate(int version = QObjectPrivateVersion)`
###### `virtual ~QObjectPrivate()`
###### `void deleteChildren()`

- 释放对象的子对象.

```
void QObjectPrivate::deleteChildren()
{
    Q_ASSERT_X(!isDeletingChildren, "QObjectPrivate::deleteChildren()", "isDeletingChildren already set, did this function recurse?");
    isDeletingChildren = true;
    // delete children objects, don't use qDeleteAll as the destructor of the child might delete siblings.
    for (int i = 0; i < children.count(); ++i) {
        currentChildBeingDeleted = children.at(i);
        children[i] = 0;
        delete currentChildBeingDeleted;
    }
    children.clear();
    currentChildBeingDeleted = 0;
    isDeletingChildren = false;
}
```



###### `void setParent_helper(QObject *)`

- 通过代码分析,这个函数不会被重载,不同线程的QObject对象不能成为父子.
- 通过传参0,可以取消父对象.

```
void QObjectPrivate::setParent_helper(QObject *o)
{
    Q_Q(QObject);
    if (o == parent)
        return;
    if (parent) 
    {
        QObjectPrivate *parentD = parent->d_func();
        if (parentD->isDeletingChildren && wasDeleted && parentD->currentChildBeingDeleted == q) {
            // don't do anything since QObjectPrivate::deleteChildren() already cleared our entry in parentD->children.
        } else {
            const int index = parentD->children.indexOf(q);
            if (parentD->isDeletingChildren)
                parentD->children[index] = 0;
            else {
                parentD->children.removeAt(index);
                if (sendChildEvents && parentD->receiveChildEvents) {
                    QChildEvent e(QEvent::ChildRemoved, q);
                    QCoreApplication::sendEvent(parent, &e);
                }
            }
        }
    } 
    parent = o;
    if (parent) {
        // object hierarchies are constrained to a single thread
        if (threadData != parent->d_func()->threadData) {
            qWarning("QObject::setParent: Cannot set parent, new parent is in a different thread");
            parent = 0;
            return;
        }
        parent->d_func()->children.append(q);
        if(sendChildEvents && parent->d_func()->receiveChildEvents) {
            if (!isWidget) {
                QChildEvent e(QEvent::ChildAdded, q);
                QCoreApplication::sendEvent(parent, &e);
            }
        }
    }
    if (!wasDeleted && !isDeletingChildren && declarativeData && QAbstractDeclarativeData::parentChanged)
        QAbstractDeclarativeData::parentChanged(declarativeData, q, o);
}
```



###### `void moveToThread_helper()`
###### `void setThreadData_helper(QThreadData *currentData, QThreadData *targetData)`
###### `void _q_reregisterTimers(void *pointer)`
###### `bool isSender(const QObject *receiver, const char *signal) const`
###### `QObjectList receiverList(const char *signal) const`
###### `QObjectList senderList() const`
###### `void addConnection(int signal, Connection *c)`
###### `void cleanConnectionLists()`
###### `static inline Sender *setCurrentSender(QObject *receiver, Sender *sender)`
###### `static inline void resetCurrentSender(QObject *receiver, Sender *currentSender, Sender *previousSender)`
###### `static QObjectPrivate *get(QObject *o) { return o->d_func()` }
###### `static const QObjectPrivate *get(const QObject *o) { return o->d_func()` }
###### `int signalIndex(const char *signalName, const QMetaObject **meta = 0) const`
###### `inline bool isSignalConnected(uint signalIdx, bool checkDeclarative = true) const`
###### `inline bool isDeclarativeSignalConnected(uint signalIdx) const`
###### `inline void connectNotify(const QMetaMethod &signal)`
###### `inline void disconnectNotify(const QMetaMethod &signal)`
###### `template <typename Func1, typename Func2> static inline QMetaObject::Connection connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal, const typename QtPrivate::FunctionPointer<Func2>::Object *receiverPrivate, Func2 slot, Qt::ConnectionType type = Qt::AutoConnection)`
###### `template <typename Func1, typename Func2> static inline bool disconnect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal, const typename QtPrivate::FunctionPointer<Func2>::Object *receiverPrivate, Func2 slot)`
###### `static QMetaObject::Connection connectImpl(const QObject *sender, int signal_index, const QObject *receiver, void **slot, QtPrivate::QSlotObjectBase *slotObj, Qt::ConnectionType type, const int *types, const QMetaObject *senderMetaObject)`
###### `static QMetaObject::Connection connect(const QObject *sender, int signal_index, QtPrivate::QSlotObjectBase *slotObj, Qt::ConnectionType type)`
###### `static bool disconnect(const QObject *sender, int signal_index, void **slot)`

# `Public Slots`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`
###### `inline QObject* q_func()`
```
inline QObject* q_func() { return static_cast<QObject *>(q_ptr); }
```
###### `inline const QObject* q_func() const`
```
inline const QObject* q_func() const { return static_cast<const QObject*>(q_ptr); }
```

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`

