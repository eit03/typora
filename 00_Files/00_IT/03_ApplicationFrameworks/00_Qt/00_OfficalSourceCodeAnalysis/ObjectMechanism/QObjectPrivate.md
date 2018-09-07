***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` \[QObjectPrivate\]

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
//Prepare *** *** *** *** *** *** *** *** *** *** *** ***

//Properties *** *** *** *** *** *** *** *** *** *** *** ***
public:
    ExtraData *extraData;    // extra data set by the user
    QThreadData *threadData; // id of the thread that owns the object
    QObjectConnectionListVector *connectionLists;
    Connection *senders;     // linked list of connections connected to this object
    Sender *currentSender;   // object currently activating the object
    mutable quint32 connectedSignals[2];
    union {
        QObject *currentChildBeingDeleted; // should only be used when QObjectData::isDeletingChildren is set
        QAbstractDeclarativeData *declarativeData; //extra data used by the declarative module
    };
    // these objects are all used to indicate that a QObject was deleted
    // plus QPointer, which keeps a separate list
    QAtomicPointer<QtSharedPointer::ExternalRefCountData> sharedRefcount;
    
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
[QObjectPrivate]
    [QObjectData]
    ExtraData *extraData;
    QThreadData *threadData;
    QObjectConnectionListVector *connectionLists;
    Connection *senders;
    Sender *currentSender;
    mutable quint32 connectedSignals[2];
    union {
        QObject *currentChildBeingDeleted;
        QAbstractDeclarativeData *declarativeData; //extra data used by the declarative module
    };
    QAtomicPointer<QtSharedPointer::ExternalRefCountData> sharedRefcount;
```




