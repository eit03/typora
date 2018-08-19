`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QItemSelectionModelPrivate

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

```
class QItemSelectionModelPrivate: public QObjectPrivate
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    QPointer<QAbstractItemModel> model;	//model
    //最终面向界面的QItemSelection是由ranges与currentSelection组合而成;
    //ranges是除当前项范围操作外的被选择项范围的集合;注意,ranges中的项范围中的项是被选择的,被选择的,被选择的;
    //currentSelection是当前项范围,与当前currentCommand配合使用;注意它的操作由currentCommand指定,不一定是选择操作;
    //最终,所有被选择项是由ranges `+` currentSelection操作后的项选择指出.
    QItemSelection ranges; //先前被选择的项选择范围集合
    QItemSelection currentSelection; //当前项选择范围集合
    QPersistentModelIndex currentIndex; //当前index,好像没有使用
    QItemSelectionModel::SelectionFlags currentCommand; //currentSelection的操作方式
    QVector<QPersistentModelIndex> savedPersistentIndexes; //保存的index列表
    QVector<QPersistentModelIndex> savedPersistentCurrentIndexes; //保存的当前index列表
    QVector<QPair<QPersistentModelIndex, uint> > savedPersistentRowLengths;
    QVector<QPair<QPersistentModelIndex, uint> > savedPersistentCurrentRowLengths;
    // optimization when all indexes are selected
    bool tableSelected; //全表被选择
    QPersistentModelIndex tableParent; //表的父index
    int tableColCount; //表的列数
    int tableRowCount; //表的行数
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****
public:
    QItemSelectionModelPrivate() : model(0), currentCommand(QItemSelectionModel::NoUpdate), tableSelected(false),
    	tableColCount(0), tableRowCount(0) {}
    	     
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
}
```

```
头中实现
```



```
[QItemSelectionModelPrivate]
    [QObjectPrivate]
    QPointer<QAbstractItemModel> model;
    QItemSelection ranges;
    QItemSelection currentSelection;
    QPersistentModelIndex currentIndex;
    QItemSelectionModel::SelectionFlags currentCommand;
    QVector<QPersistentModelIndex> savedPersistentIndexes;
    QVector<QPersistentModelIndex> savedPersistentCurrentIndexes;
    QVector<QPair<QPersistentModelIndex, uint> > savedPersistentRowLengths;
    QVector<QPair<QPersistentModelIndex, uint> > savedPersistentCurrentRowLengths;
    // optimization when all indexes are selected
    bool tableSelected;
    QPersistentModelIndex tableParent;
    int tableColCount;
    int tableRowCount;
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

