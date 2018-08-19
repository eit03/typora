```
#define Q_DECLARE_PUBLIC(Class)                                    \
    inline Class* q_func() { return static_cast<Class *>(q_ptr); } \
    inline const Class* q_func() const { return static_cast<const Class *>(q_ptr); } \
    friend class Class;
```

```
private:
    inline QObject* q_func() { return static_cast<QObject *>(q_ptr); }
    inline const QObject* q_func() const { return static_cast<const QObject *>(q_ptr); }
    friend class QObject;
```

