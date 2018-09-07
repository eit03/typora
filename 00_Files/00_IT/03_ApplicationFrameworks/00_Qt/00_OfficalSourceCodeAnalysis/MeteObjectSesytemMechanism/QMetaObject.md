***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` [QMetaObject]

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
//Prepare *** *** *** *** *** *** *** *** *** *** *** ***

//Properties *** *** *** *** *** *** *** *** *** *** *** ***
public:
    struct { // private data
        const QMetaObject *superdata;
        const QByteArrayData *stringdata;
        const uint *data;
        typedef void (*StaticMetacallFunction)(QObject *, QMetaObject::Call, int, void **);
        StaticMetacallFunction static_metacall;
        const QMetaObject * const *relatedMetaObjects;
        void *extradata; //reserved for future use
    } d;

//Constructor *** *** *** *** *** *** *** *** *** *** *** ***

//Functions *** *** *** *** *** *** *** *** *** *** *** ***
}
```

## `Construtor`
```

```
## `Memeory Model`
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
