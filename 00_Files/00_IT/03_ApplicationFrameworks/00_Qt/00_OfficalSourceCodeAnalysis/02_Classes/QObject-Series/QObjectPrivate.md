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
class Q_CORE_EXPORT QObjectPrivate : public QObjectData
{
///> 0. Prepare
public:
    struct ExtraData
    {
        ExtraData() {}
    #ifndef QT_NO_USERDATA
        QVector<QObjectUserData *> userData;
    #endif // QT_NO_USERDATA
        QList<QByteArray> propertyNames;
        QVector<QVariant> propertyValues;
        QVector<int> runningTimers;
        QList<QPointer<QObject> > eventFilters;
        // QOjbect::objectName() QOjbect::setObjectName()
        QString objectName;
    };

    typedef void (*StaticMetaCallFunction)(QObject *,
        QMetaObject::Call, int, void **);
        
    struct Connection
    {
        QObject *sender;
        QObject *receiver;
        union {
            StaticMetaCallFunction callFunction;
            QtPrivate::QSlotObjectBase *slotObj;
        };
        // The next pointer for the singly-linked ConnectionList
        Connection *nextConnectionList;
        //senders linked list
        Connection *next;
        Connection **prev;
        QAtomicPointer<const int> argumentTypes;
        QAtomicInt ref_;
        ushort method_offset;
        ushort method_relative;
        // In signal range (see QObjectPrivate::signalIndex())
        uint signal_index : 27; 
        // 0 == auto, 1 == direct, 2 == queued, 4 == blocking
        ushort connectionType : 3; 
        ushort isSlotObject : 1;
        ushort ownArgumentTypes : 1;
        Connection() 
            : nextConnectionList(nullptr), ref_(2), ownArgumentTypes(true) 
        {
            // ref_ is 2 for the use in the internal lists, and for the use in 
            // QMetaObject::Connection
        }
        ~Connection();
        int method() const 
        { Q_ASSERT(!isSlotObject); return method_offset + method_relative; }
        void ref() { ref_.ref(); }
        void deref()
        {
            if (!ref_.deref())
            {
                Q_ASSERT(!receiver);
                delete this;
            }
        }
    };
    
    // ConnectionList is a singly-linked list
    struct ConnectionList {
        ConnectionList() : first(nullptr), last(nullptr) {}
        Connection *first;
        Connection *last;
    };

    struct Sender
    {
        QObject *sender;
        int signal;
        int ref;
    };
    
///> 1. Properties
public:
    ExtraData *extraData;    // extra data set by the user
    QThreadData *threadData; // id of the thread that owns the object

    QObjectConnectionListVector *connectionLists;

    // linked list of connections connected to this object
    Connection *senders;
    // object currently activating the object
    Sender *currentSender;
    mutable quint32 connectedSignals[2];

    union {
        // should only be used when QObjectData::isDeletingChildren is set
        QObject *currentChildBeingDeleted;
        //extra data used by the declarative module
        QAbstractDeclarativeData *declarativeData;
    };

    // these objects are all used to indicate that a QObject was deleted
    // plus QPointer, which keeps a separate list
    QAtomicPointer<QtSharedPointer::ExternalRefCountData> sharedRefcount;
    
///> 2. Constructor
public:
    QObjectPrivate(int version = QObjectPrivateVersion);
    virtual ~QObjectPrivate();
    
///> 3. Functions
}
```
## `Constructor`
```

```
## `Memory Model`
```
[QObjectData]
extraData                 public  ExtraData*
threadData                public  QThreadData*
connectionLists           public  QObjectConnectionListVector*
senders                   public  Connection*
currentSender             public  Sender*
connectedSignals          public  mutable quint32[2]
sharedRefcount            public  QObject*
currentChildBeingDeleted  public  QAtomicPointer
                                      <QtSharedPointer::ExternalRefCountData>
```
# `Properties`
# `Public Types`
# `Public Functions`
# `Reimplemented Public Functions`
# `Public Slots`
# `Static Public Members`
# `Protected Types`
# `Protected Functions`
# `Reimplemented Protected Functions`
# `Protected Slots`
# `staitc Protected Members`
# `Private Types`
# `Private Functions`
# `Private Slots`
# `Static Private Members`
# `Signals`
# `Related Non-Members`
# `Macros`