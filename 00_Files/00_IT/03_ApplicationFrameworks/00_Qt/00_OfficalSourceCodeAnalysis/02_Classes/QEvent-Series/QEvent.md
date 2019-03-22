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

``` text
class Q_CORE_EXPORT QEvent
{
///> 0. Prepare
public:
enum Type {
        None = 0,                       // invalid event
        Timer = 1,                      // timer event
        MouseButtonPress = 2,           // mouse button pressed
        MouseButtonRelease = 3,         // mouse button released
        MouseButtonDblClick = 4,        // mouse button double click
        MouseMove = 5,                  // mouse move
        KeyPress = 6,                   // key pressed
        KeyRelease = 7,                 // key released

        ...

        Pointer = 218,                  // QQuickPointerEvent;
                                        // ### Qt 6: QPointerEvent

        TabletTrackingChange = 219,     // tablet tracking state has changed

        // 512 reserved for Qt Jambi's MetaCall event
        // 513 reserved for Qt Jambi's DeleteOnMainThread event

        User = 1000,                    // first user event id
        MaxUser = 65535                 // last user event id
    };
    Q_ENUM(Type)

///> 1. Properties
protected:
    QEventPrivate*  d;
    ushort          t;

private:
    ushort          posted : 1;
    ushort          spont : 1;
    ushort          m_accept : 1;
    ushort          reserved : 13;

///> 2. Constructor
public:
    explicit QEvent(Type type);
    QEvent(const QEvent &other);
    virtual ~QEvent();

///> 3. Functions
}
```

## `Constructor`

``` text
```

## `Memory Model`

``` text
__vfptr
d               QEventPrivate*
t               ushort
posted          ushort : 1
spont           ushort : 1
m_accept        ushort : 1
reserved        ushort : 13
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