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
private:
    struct QPrivateSignal {};

public:
    static const QMetaObject staticMetaObject;
    
public:
    virtual const QMetaObject *metaObject() const; 
    virtual void *qt_metacast(const char *); 
    virtual int qt_metacall(QMetaObject::Call, int, void **); 
    static inline QString tr(const char *s, const char *c = Q_NULLPTR, int n = -1) { return staticMetaObject.tr(s, c, n); }
    static inline QString trUtf8(const char *s, const char *c = Q_NULLPTR, int n = -1) { return staticMetaObject.tr(s, c, n); }
private:
    static void qt_static_metacall(QObject *, QMetaObject::Call, int, void **);
```

拥有Q_OBJECT宏的类,它会有上面的成员;成员函数的实现在moc_##ClassName.cpp中,是Qt元对象编辑器做的最先预处理.