# `org`
```
/* qmake ignore Q_OBJECT */
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
    
eg:    
public:
    static const QMetaObject staticMetaObject;
    virtual const QMetaObject *metaObject() const;
    virtual void *qt_metacast(const char *);
    virtual int qt_metacall(QMetaObject::Call, int, void **);
    static inline QString tr(const char *s, const char *c = nullptr, int n = -1);
    QT_DEPRECATED static inline QString trUtf8(const char *s, const char *c = nullptr, int n = -1);
private:
	static void qt_static_metacall(QObject *, QMetaObject::Call, int, void **);
	struct QPrivateSignal {};
```

# `preprocess`
```
public:
    static const QMetaObject staticMetaObject;
    virtual const QMetaObject *metaObject() const;
    virtual void *qt_metacast(const char *);
    virtual int qt_metacall(QMetaObject::Call, int, void **);
    static inline QString tr(const char *s,
                             const char *c = nullptr,
                             int n = -1)
    { return staticMetaObject.tr(s, c, n); }
    QT_DEPRECATED static inline QString trUtf8(const char *s,
                                               const char *c = nullptr,
                                               int n = -1)
    { return staticMetaObject.tr(s, c, n); }
    
private:
    Q_DECL_HIDDEN_STATIC_METACALL 
    static void qt_static_metacall(QObject *, 
                                   QMetaObject::Call,
                                   int, void **);
    struct QPrivateSignal {};
```
