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
struct Q_CORE_EXPORT QArrayData
{
///> 0. Prepare
///> 1. Properties
public:
    QtPrivate::RefCount     ref;
    int                     size;
    uint                    alloc : 31;
    uint                    capacityReserved : 1;
    qptrdiff                offset;

///> 2. Constructor
///> 3. Functions
}
```

`ref : QtPrivate::RefCount`

This is a reference counter class, its functionary is operate a integer of int
type by atomic way.

`size : uint`

counter of elements, the metrics is elements unit. it will not contain null
terminate character when the element is unicode character.

`alloc : uint:31`

capacity counter of elements, the metrics is elements unit.

`capacityReserved : uint:1`

`offset : qptrdiff`

The offset from object pos to real data pos.

Note: It will be 8 bytes in x64 os; then, the memory waste four bytes for memory
alignment.

Note: It was a virtual address when I debug wps that the Qt version is 4.7.4.

## `Constructor`

``` text

```

## `Memory Model`

``` text
QString qs = "sfsfs";

// x86
fd fd fd fd
01 00 00 00 05 00 00 00 06 00 00 00 10 00 00 00
73 00 66 00 73 00 66 00 73 00 00 00
fd fd fd fd

// x64
fd fd fd fd
01 00 00 00 05 00 00 00 06 00 00 00 cd cd cd cd
18 00 00 00 00 00 00 00 73 00 66 00 73 00 66 00
73 00 00 00
fd fd fd fd

// gdb.64
Thread 1 "wps" hit Breakpoint 2, 0x000000000068d520 in QObject::setObjectName(QString const&)@plt ()
(gdb) x/sh *(*$rsi + 0x10)
0x5e580aa:      u"KxDlgPageSetup"

if (*(*$rsi + 0x10)) != u"Document1" && if (*(*$rsi + 0x10)) != u"Document1 - Writer"

if (
    (*(*$rsi + 0x10)) != u"Document1"
    &&
    (*(*$rsi + 0x10)) != u"Document1 - Writer"
   )
u"Document1 - Writer"
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