`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QModelIndex

------

[TOC]

------

# `Brief Introduction`

QModelIndex保存着父QStandardItem及在父中的行列索引,通过行列在父QStandardItem的子QStandardItem列表中得到指向的QStandardItem.

# `Detailed Description`

# `Data Struct`

```
class Q_CORE_EXPORT QModelIndex
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
private:
    int r; //在父中的行索引
    int c; //在父中的列索引
    quintptr i; //父项QStandardItem指针
    const QAbstractItemModel *m; //model
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****
private:
    inline QModelIndex(int arow, int acolumn, void *ptr, const QAbstractItemModel *amodel) Q_DECL_NOTHROW
        : r(arow), c(acolumn), i(reinterpret_cast<quintptr>(ptr)), m(amodel) {}
    Q_DECL_CONSTEXPR inline QModelIndex(int arow, int acolumn, quintptr id, const QAbstractItemModel *amodel) Q_DECL_NOTHROW
        : r(arow), c(acolumn), i(id), m(amodel) {}
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
}
```

```
inline QModelIndex(int arow, int acolumn, void *ptr, const QAbstractItemModel *amodel) Q_DECL_NOTHROW
	: r(arow), c(acolumn), i(reinterpret_cast<quintptr>(ptr)), m(amodel) {}
Q_DECL_CONSTEXPR inline QModelIndex(int arow, int acolumn, quintptr id, const QAbstractItemModel *amodel) Q_DECL_NOTHROW
	: r(arow), c(acolumn), i(id), m(amodel) {}
```

```
[QModelIndex]
    int r;
    int c;
    quintptr i;
    const QAbstractItemModel *m;
```

# `Properties`

# `Public Types`

# `Public Functions`

# `Reimplement Public Functions`

# `Public Slots`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`

# `Reimplement Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`

