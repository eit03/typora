see moc_xxx.cpp

see moc_xxx.i

see qt_meta_stringdata_Object_t qt_meta_stringdata_Object;

see static const uint qt_meta_data_Object[];

see void xxx::qt_static_metacall(QObject \*\_o, QMetaObject::Call \_c, int \_id, void \*\*\_a);

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
struct qt_meta_stringdata_Object_t {
    QByteArrayData data[9];
    char stringdata0[84];
};

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
    8,  // revision;
    0,  // classname; index in qt_meta_stringdata_Object_t::QByteArrayData  
    0,    0,  // classinfo;
    5,   14,  // methods; 5: count of signals and slots in class.
    2,   56,  // properties; 2: count of properties.
    0,    0,  // enums/sets;
    0,    0,  // constructors;
    0,  // flags;
    3,  // signalCount;      

    // signals: name, argc, parameters, tag, flags
      // first column: name index in qt_meta_stringdata_Object_t::QByteArrayData
      // second column: number of args
      // third clumn:
    1,    1,   39,    2, 0x06 ,
    4,    1,   42,    2, 0x06 ,
    6,    2,   45,    2, 0x06 ,

    // slots: name, argc, parameters, tag, flags
    7,    1,   50,    2, 0x09 ,
    8,    1,   53,    2, 0x09 ,

    // signals: parameters
      // define in qmetatype.h
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    2,    2,
    
    // slots: parameters
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::QString,    5,
 
    // properties: name, type, flags
      // first column: name index in qt_meta_stringdata_Object_t::QByteArrayData
      // second column: enum constant of type that is defined in qmetatype.h
      // third clumn:
    3, QMetaType::Int, 0x00495103,
    5, QMetaType::QString, 0x00495103,

    // properties: notify_signal_id
    0,
    1,

    // eod
    0        
};
```