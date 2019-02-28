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
class Q_CORE_EXPORT QObjectData {
///> 0. Prepare
///> 1. Properties
public:
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
    QDynamicMetaObjectData* metaObject;
    
///> 2. Constructor
///> 3. Functions
public:
    virtual ~QObjectData() = 0;
    QMetaObject* dynamicMetaObject() const;
};
```
## `Constructor`
```
__vfptr
q_ptr                        public  QObject*
parent                       public  QObject*
children                     public  QObjectList 
isWidget : 1                 public  uint 
blockSig : 1                 public  uint 
wasDeleted : 1               public  uint 
isDeletingChildren : 1       public  uint 
uint sendChildEvents : 1     public  uint 
uint receiveChildEvents : 1  public  uint 
uint isWindow : 1            public  uint 
uint deleteLaterCalled : 1   public  uint 
uint unused : 24             public  uint 
int postedEvents             public  int 
metaObject                  public  QDynamicMetaObjectData*
```
## `Memory Model`
```

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