```
#define Q_DECLARE_PRIVATE(Class) \
    inline Class##Private* d_func() { return reinterpret_cast<Class##Private *>(qGetPtrHelper(d_ptr)); } \
    inline const Class##Private* d_func() const { return reinterpret_cast<const Class##Private *>(qGetPtrHelper(d_ptr)); } \
    friend class Class##Private;
    
    
eg: Q_DECLARE_PRIVATE(QObject)
    // get data pointer
    inline QObjectPrivate* d_func() { return reinterpret_cast<QObjectPrivate *>(qGetPtrHelper(d_ptr)); }
    inline const QObjectPrivate* d_func() const { return reinterpret_cast<const QObjectPrivate *>(qGetPtrHelper(d_ptr)); }
    // declare friend
    friend class QObjectPrivate;
```

