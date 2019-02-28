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
struct Q_CORE_EXPORT QMetaObject
{
///> 0. Prepare
public:
    enum Call {
        InvokeMetaMethod,
        ReadProperty,
        WriteProperty,
        ResetProperty,
        QueryPropertyDesignable,
        QueryPropertyScriptable,
        QueryPropertyStored,
        QueryPropertyEditable,
        QueryPropertyUser,
        CreateInstance,
        IndexOfMethod,
        RegisterPropertyMetaType,
        RegisterMethodArgumentMetaType
    };
    
    class Connection;
    
///> 1. Properties
public:
    struct { // private data
        typedef void (*StaticMetacallFunction)(QObject *, QMetaObject::Call, int, void **);
        const QMetaObject *         superdata;
        const QByteArrayData *      stringdata;
        const uint *                data;
        StaticMetacallFunction      static_metacall;
        const QMetaObject *const*   relatedMetaObjects;
        void *                      extradata;
          //reserved for future use
    } d;
    
///> 2. Constructor
///> 3. Functions
}
```
`superdata`
&\<SupperName\>::staticMetaObject; meta data object of supper class; 
analyze from moc_xxx.cpp(moc_xxx.i).

`stringdata`
qt_meta_stringdata_\<ClassName\>.data; strings that include singles name and slots name and that strings Q_PROPERTY macro used; analyze from moc_xxx.cpp(moc_xxx.i).

`data`
qt_meta_data_\<ClassName\>; analyze from moc_xxx.cpp(moc_xxx.i).

`static_metacall`
\<ClassName\>::qt_static_metacall; this is dispatch function; analyze from moc_xxx.cpp(moc_xxx.i).

```
void Object::qt_static_metacall(
    QObject *_o, // receiver objcet.
    QMetaObject::Call _c, // QMetaObject::Call.
    int _id, // switch id.
    void **_a) //args
{ 
    ...
    switch (_id) {
    case 0: _t->ageChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
    case 1: _t->nameChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
    case 2: _t->telNumberChanged((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
    case 3: _t->onAgeChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
    case 4: _t->onNameChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
    default: ;
    }
    ...
}
```
```
moc_xxx.i
static const qt_meta_stringdata_Object_t qt_meta_stringdata_Object = {
    {
{ { { -1 } }, 6, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 0 - 0 * sizeof(QByteArrayData)) }, 
{ { { -1 } }, 10, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 7 - 1 * sizeof(QByteArrayData)) }, 
{ { { -1 } }, 0, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 18 - 2 * sizeof(QByteArrayData)) }, 
{ { { -1 } }, 3, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 19 - 3 * sizeof(QByteArrayData)) }, 
{ { { -1 } }, 11, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 23 - 4 * sizeof(QByteArrayData)) }, 
{ { { -1 } }, 4, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 35 - 5 * sizeof(QByteArrayData)) }, 
{ { { -1 } }, 16, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 40 - 6 * sizeof(QByteArrayData)) }, 
{ { { -1 } }, 12, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 57 - 7 * sizeof(QByteArrayData)) }, 
{ { { -1 } }, 13, 0, 0, qptrdiff(__builtin_offsetof(qt_meta_stringdata_Object_t,stringdata0) + 70 - 8 * sizeof(QByteArrayData)) } 

    },
    "Object\0ageChanged\0\0age\0nameChanged\0"
    "name\0telNumberChanged\0onAgeChanged\0"
    "onNameChanged"
};
```
```
moc_xxx.i
static const uint qt_meta_data_Object[] = {
       8,       
       0,       
       0,    0, 
       5,   14, 
       2,   56, 
       0,    0, 
       0,    0, 
       0,       
       3,       
       
       1,    1,   39,    2, 0x06 ,
       4,    1,   42,    2, 0x06 ,
       6,    2,   45,    2, 0x06 ,

       7,    1,   50,    2, 0x09 ,
       8,    1,   53,    2, 0x09 ,

    // qmetatype.h
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    2,    2,
 
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::QString,    5,
 
       3, QMetaType::Int, 0x00495103,
       5, QMetaType::QString, 0x00495103,

       0,
       1,

       0        
};
```

`relatedMetaObjects` 
nullptr; analyze from moc_xxx.cpp.

`extradata`
nullptr; analyze from moc_xxx.cpp.

```
superdata : meta data object of supper class, &<Supper>::staticMetaObject,     
stringdata : 
data                       
static_metacall           
relatedMetaObjects 
extradata
```
## `Constructor`
```

```
## `Memory Model`
```
d                              public  struct{}
    superdata                  public  const QMetaObject*
    stringdata                 public  const QByteArrayData *
    data                       public  const uint *
    static_metacall            public  StaticMetacallFunction
    relatedMetaObjects         public  const QMetaObject *const* 
    extradata                  public  void *
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