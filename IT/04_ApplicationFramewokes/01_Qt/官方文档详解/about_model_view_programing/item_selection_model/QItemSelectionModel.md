`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QItemSelectionModel

------

[TOC]

------

# `Brief Introduction`

QItemSelectionModel给QItemSelection加上了SelectionFlag(选择|反选|取消|清除...).所以只有它才知道哪些QStandardItem被选择.

d类中有二个QItemSelection:一是先前的,它代表QStandardItem被选择的;二是当前的,配合当前SelectionFlag使用.二者合并,才是真正的QItemSelection.

# `Detailed Description`

# `Data Struct`

```
class Q_CORE_EXPORT QItemSelectionModel : public QObject
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********
public:
    enum SelectionFlag {
        NoUpdate       = 0x0000, //相当于没有调用QItemSelectionModel::select()
        Clear          = 0x0001, //清除所有itemsltn
        Select         = 0x0002, //选择当前itemsltn
        Deselect       = 0x0004, //取消选择当前itemsltn
        Toggle         = 0x0008, //itemsltn中,如果项被选择,则取消选择;反之,选择;只影响itemsltn范围内
        Current        = 0x0010, //当前itemsltn被更新
        Rows           = 0x0020, //所有index被扩展到满行
        Columns        = 0x0040, //所有index被扩展到满行
        SelectCurrent  = Select | Current,
        ToggleCurrent  = Toggle | Current,
        ClearAndSelect = Clear | Select
    };
    
//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    explicit QItemSelectionModel(QAbstractItemModel *model = Q_NULLPTR);
    explicit QItemSelectionModel(QAbstractItemModel *model, QObject *parent);
protected:
    QItemSelectionModel(QItemSelectionModelPrivate &dd, QAbstractItemModel *model);
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****

//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
}
```

```
QItemSelectionModel::QItemSelectionModel(QAbstractItemModel *model) : QObject(*new QItemSelectionModelPrivate, model)
{
    d_func()->initModel(model);
}

QItemSelectionModel::QItemSelectionModel(QAbstractItemModel *model, QObject *parent) : QObject(*new QItemSelectionModelPrivate, parent)
{
    d_func()->initModel(model);
}

QItemSelectionModel::QItemSelectionModel(QItemSelectionModelPrivate &dd, QAbstractItemModel *model) : QObject(dd, model)
{
    dd.initModel(model);
}
```

```
[QItemSelectionModel]
	[QObject]
		QItemSelectionModelPrivate* QObject::d_ptr;
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

