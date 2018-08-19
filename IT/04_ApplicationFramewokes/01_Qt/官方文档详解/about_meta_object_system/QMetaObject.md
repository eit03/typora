***
`Version:` 5.10
`Declaration:` qobject.h
`Defination:` 
`Reference:` 
`Keyword:` 
***


[TOC]
***

# `BriefIntroduction`




# `DataStruct`
```
//qobjectdefs.h
struct Q_CORE_EXPORT QMetaObject
{
	struct {
        typedef void (*StaticMetacallFunction)(QObject *, QMetaObject::Call, int, void **);
        
        const QMetaObject *superdata;
        const QByteArrayData *stringdata;
        const uint *data;	//data==>QMetaObjectPrivate*
        StaticMetacallFunction static_metacall;
        const QMetaObject * const *relatedMetaObjects;
        void *extradata; //reserved for future use
    } d;
}
```
```
[QMetaObject]
    const QMetaObject *superdata;                    //父类信息;
    const QByteArrayData *stringdata;                //类名;
    const uint *data;                                //data==>QMetaObjectPrivate*;
    StaticMetacallFunction static_metacall;
    const QMetaObject * const *relatedMetaObjects;   //其它关联类信息;
    void *extradata;                                 //reserved for future use;
```


# `Public Types`
###### `class Connection`


# `Public Functions`
###### `QMetaClassInfo classInfo(int index) const`
###### `int classInfoCount() const`
###### `int classInfoOffset() const`
###### `const char * className() const`
###### `QMetaMethod constructor(int index) const`
###### `int constructorCount() const`
###### `QMetaEnum enumerator(int index) const`
###### `int enumeratorCount() const`
###### `int enumeratorOffset() const`
###### `int indexOfClassInfo(const char *name) const`
###### `int indexOfConstructor(const char *constructor) const`
###### `int indexOfEnumerator(const char *name) const`
###### `int indexOfMethod(const char *method) const`
###### `int indexOfProperty(const char *name) const`

```
int QMetaObject::indexOfProperty(const char *name) const
{
    const QMetaObject *m = this;
    while (m) {
        const QMetaObjectPrivate *d = priv(m->d.data);	//QMetaObject::data==>QMetaObjectPrivate*;
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



###### `int indexOfSignal(const char *signal) const`
###### `int indexOfSlot(const char *slot) const`
###### `bool inherits(const QMetaObject *metaObject) const`
###### `QMetaMethod method(int index) const`
###### `int methodCount() const`
###### `int methodOffset() const`
###### `QObject * newInstance(QGenericArgument val0 = QGenericArgument( Q_NULLPTR ), QGenericArgument val1 = QGenericArgument(), QGenericArgument val2 = QGenericArgument(), QGenericArgument val3 = QGenericArgument(), QGenericArgument val4 = QGenericArgument(), QGenericArgument val5 = QGenericArgument(), QGenericArgument val6 = QGenericArgument(), QGenericArgument val7 = QGenericArgument(), QGenericArgument val8 = QGenericArgument(), QGenericArgument val9 = QGenericArgument()) const`
###### `QMetaProperty property(int index) const`
###### `int propertyCount() const`
###### `int propertyOffset() const`
###### `const QMetaObject * superClass() const`
###### `QMetaProperty userProperty() const`


# `Static Public Members`
###### `bool checkConnectArgs(const char *signal, const char *method)`
###### `bool checkConnectArgs(const QMetaMethod &signal, const QMetaMethod &method)`
###### `void connectSlotsByName(QObject *object)`
###### `bool invokeMethod(QObject *obj, const char *member, Qt::ConnectionType type, QGenericReturnArgument ret, QGenericArgument val0 = QGenericArgument( Q_NULLPTR ), QGenericArgument val1 = QGenericArgument(), QGenericArgument val2 = QGenericArgument(), QGenericArgument val3 = QGenericArgument(), QGenericArgument val4 = QGenericArgument(), QGenericArgument val5 = QGenericArgument(), QGenericArgument val6 = QGenericArgument(), QGenericArgument val7 = QGenericArgument(), QGenericArgument val8 = QGenericArgument(), QGenericArgument val9 = QGenericArgument())`
###### `bool invokeMethod(QObject *obj, const char *member, QGenericReturnArgument ret, QGenericArgument val0 = QGenericArgument( Q_NULLPTR ), QGenericArgument val1 = QGenericArgument(), QGenericArgument val2 = QGenericArgument(), QGenericArgument val3 = QGenericArgument(), QGenericArgument val4 = QGenericArgument(), QGenericArgument val5 = QGenericArgument(), QGenericArgument val6 = QGenericArgument(), QGenericArgument val7 = QGenericArgument(), QGenericArgument val8 = QGenericArgument(), QGenericArgument val9 = QGenericArgument())`
###### `bool invokeMethod(QObject *obj, const char *member, Qt::ConnectionType type, QGenericArgument val0 = QGenericArgument( Q_NULLPTR ), QGenericArgument val1 = QGenericArgument(), QGenericArgument val2 = QGenericArgument(), QGenericArgument val3 = QGenericArgument(), QGenericArgument val4 = QGenericArgument(), QGenericArgument val5 = QGenericArgument(), QGenericArgument val6 = QGenericArgument(), QGenericArgument val7 = QGenericArgument(), QGenericArgument val8 = QGenericArgument(), QGenericArgument val9 = QGenericArgument())`
###### `bool invokeMethod(QObject *obj, const char *member, QGenericArgument val0 = QGenericArgument( Q_NULLPTR ), QGenericArgument val1 = QGenericArgument(), QGenericArgument val2 = QGenericArgument(), QGenericArgument val3 = QGenericArgument(), QGenericArgument val4 = QGenericArgument(), QGenericArgument val5 = QGenericArgument(), QGenericArgument val6 = QGenericArgument(), QGenericArgument val7 = QGenericArgument(), QGenericArgument val8 = QGenericArgument(), QGenericArgument val9 = QGenericArgument())`
###### `bool invokeMethod(QObject *receiver, PointerToMemberFunction function, Qt::ConnectionType type = Qt::AutoConnection, MemberFunctionReturnType *ret = nullptr)`
###### `bool invokeMethod(QObject *receiver, PointerToMemberFunction function, MemberFunctionReturnType *ret)`
###### `bool invokeMethod(QObject *context, Functor function, Qt::ConnectionType type = Qt::AutoConnection, FunctorReturnType *ret = nullptr)`
###### `bool invokeMethod(QObject *context, Functor function, FunctorReturnType *ret)`
###### `QByteArray normalizedSignature(const char *method)`
###### `QByteArray normalizedType(const char *type)`


# `Macros`
###### `QGenericArgument Q_ARG(Type, const Type &value)`
###### `QGenericReturnArgument Q_RETURN_ARG(Type, Type &value)`