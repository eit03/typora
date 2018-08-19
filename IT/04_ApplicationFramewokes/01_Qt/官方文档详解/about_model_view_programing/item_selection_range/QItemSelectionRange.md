`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QItemSelectionRange

------

[TOC]

------

# `Brief Introduction`

QItemSelectionRange保存了项选择范围.它只有二个变量,左上&右下索引.以一个表,选择模型为默认为例:可以通过这二个索引知道被选择项的范围了,可以返回被选择项的列表.但是QItemSelectionRange只是给了个项选择范围你了,并没有给这个范围内的项标上选择与否标志,那是QItemSelectionModel的事.

总而言之,QItemSelectionRange给定了多项的集合,表达方式为左上索引&左下索引,组成的矩形内的所有项.

# `Detailed Description`

# `Data Struct`

```
class Q_CORE_EXPORT QItemSelectionRange
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
private:
    QPersistentModelIndex tl; //左上永续索引
    QPersistentModelIndex br; //右下永续索引
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****
public:
    inline QItemSelectionRange() : tl(), br() {}
    inline QItemSelectionRange(const QItemSelectionRange &other) : tl(other.tl), br(other.br) {}
    QItemSelectionRange(QItemSelectionRange &&other) Q_DECL_NOTHROW : tl(std::move(other.tl)), br(std::move(other.br)) {}
    QItemSelectionRange& operator=(QItemSelectionRange &&other) Q_DECL_NOTHROW { tl=std::move(other.tl); br = std::move(other.br); return *this; }
    QItemSelectionRange &operator=(const QItemSelectionRange &other) { tl = other.tl; br = other.br; return *this; }
    QItemSelectionRange(const QModelIndex &topL, const QModelIndex &bottomR) : tl(topL), br(bottomR) {}
    explicit QItemSelectionRange(const QModelIndex &index) : tl(index), br(tl) {}
    
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
}
```

```
全是内联的.
```

```
[QItemSelectionRange]
    QPersistentModelIndex tl;
    QPersistentModelIndex br;
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

