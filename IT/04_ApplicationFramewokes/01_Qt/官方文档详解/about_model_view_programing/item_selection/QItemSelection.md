`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QItemSelection

------

[TOC]

------

# `Brief Introduction`

QItemSelection是一个QList<QItemSelectionRange>,可以说它管理着QItemSelectionRange集合.

# `Detailed Description`

# `Data Struct`

```
class Q_CORE_EXPORT QItemSelection : public QList<QItemSelectionRange>
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****

//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****
public:
    QItemSelection() Q_DECL_NOTHROW : QList<QItemSelectionRange>() {}
    QItemSelection(const QModelIndex &topLeft, const QModelIndex &bottomRight);


//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
public:
    // reusing QList::swap() here is OK!

    void select(const QModelIndex &topLeft, const QModelIndex &bottomRight);
    bool contains(const QModelIndex &index) const;
    QModelIndexList indexes() const;
    void merge(const QItemSelection &other, QItemSelectionModel::SelectionFlags command);
    static void split(const QItemSelectionRange &range, const QItemSelectionRange &other, QItemSelection *result);
};
```



```
QItemSelection::QItemSelection() Q_DECL_NOTHROW : QList<QItemSelectionRange>() {}
QItemSelection::QItemSelection(const QModelIndex &topLeft, const QModelIndex &bottomRight) { select(topLeft, bottomRight); }
```

```
[QItemSelection]
	[QList<QItemSelectionRange>]
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

