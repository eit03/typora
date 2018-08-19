`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QStandardItemModel

------

[TOC]

------

# `Brief Introduction`

QStandardItemModel管理着行列标头项,根项,这些数据在d类中.

## `数据在哪里?`

1. QStandardItemModel中的QStandardItemModelPrivate储存着:

   0. 行标头项
   2. 列标头项
   3. 根项

   以一个表来论,可以看的出数据全在这个model中了.

2. 索引(QModelIndex)有四个数据:row & clm & parrentItem & model; row & clm 是自己指定的;parrentItem也是自指定的,如果为0,内部则指向根项;model是自动填充的.

2. 项(item)才是真正的数据所在,它的数据可以分为:

   0. model信息
   1. 本项信息
   2. 父项信息
   3. 子项信息

   同时它可以是:

   0. 根项(无父项)
   1. 父项(有子项)
   2. 项(没有子项)

   它的数据结构支持这些.

   通过index可以在父项的子项集中找到指定的子项;定位项也就简单了.

## `索引是什么?`

上面已经给出了答案.

## `选择标志在哪里?`

QItemSelectionRange是包含左上与右下QModelIndex;只与项范围有关;

QItemSelection是QItemSelectionRange类型QList;是项范围的集合;

QItemSelectionModel可以指定项范围或集合项是当前的&选择的等,d类中有如下关键数据:

0. QItemSelection ranges;	//先前被选择的项选择范围集合
0. QItemSelection currentSelection; //当前项选择范围集合
0. QItemSelectionModel::SelectionFlags currentCommand; //currentSelection的操作方式

由此可知,它是可以得到最终的被选择项(或索引),是选择与否的最终管理者.

组合后的QItemSelection内的项全是被选择的.

# `Detailed Description`

# `Data Struct`

```
class Q_GUI_EXPORT QStandardItemModel : public QAbstractItemModel
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓↓↓ *****

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓ *****

//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    explicit QStandardItemModel(QObject *parent = Q_NULLPTR);
    QStandardItemModel(int rows, int columns, QObject *parent = Q_NULLPTR);  
protected:
    QStandardItemModel(QStandardItemModelPrivate &dd, QObject *parent = Q_NULLPTR);
    
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓ *****
}
```



```
QStandardItemModel::QStandardItemModel(QObject *parent) : QAbstractItemModel(*new QStandardItemModelPrivate, parent)
{
    Q_D(QStandardItemModel);
    d->init();
    d->root->d_func()->setModel(this);
}

QStandardItemModel::QStandardItemModel(int rows, int columns, QObject *parent) : QAbstractItemModel(*new QStandardItemModelPrivate, parent)
{
    Q_D(QStandardItemModel);
    d->init();
    d->root->insertColumns(0, columns);
    d->columnHeaderItems.insert(0, columns, 0);
    d->root->insertRows(0, rows);
    d->rowHeaderItems.insert(0, rows, 0);
    d->root->d_func()->setModel(this);
}

QStandardItemModel::QStandardItemModel(QStandardItemModelPrivate &dd, QObject *parent) : QAbstractItemModel(dd, parent)
{
    Q_D(QStandardItemModel);
    d->init();
}
```

```
[QStandardItemModel]
	[QAbstractItemModel]
	...
		[QObject]
			QStandardItemModelPrivate* d_ptr;
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

