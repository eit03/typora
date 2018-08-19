`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QStandardItem

------

[TOC]

------

# `Brief Introduction`

看QStandardItem的d类可知,QStandardItem可以是:根项&父项&子项;而且只要给出一个项,就可以找到父项&子项;这样Table&Tree就能很好的支持了.d类中还有role对应的数据向量表.

总之,QStandardItem可以找到父与子,它的数据也在d类中.

# `Detailed Description`

# `Data Struct`

```
class Q_GUI_EXPORT QStandardItem
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
protected:
    QScopedPointer<QStandardItemPrivate> d_ptr;

//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****
public:
    QStandardItem();
    explicit QStandardItem(const QString &text);
    QStandardItem(const QIcon &icon, const QString &text);
    explicit QStandardItem(int rows, int columns = 1);
protected:
    QStandardItem(const QStandardItem &other);
    QStandardItem(QStandardItemPrivate &dd);
    QStandardItem &operator=(const QStandardItem &other)
	
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
}
```



```
QStandardItem::QStandardItem() : QStandardItem(*new QStandardItemPrivate) {}
QStandardItem::QStandardItem(const QString &text) : QStandardItem(*new QStandardItemPrivate) { setText(text); }
QStandardItem::QStandardItem(const QIcon &icon, const QString &text) : QStandardItem(text) { setIcon(icon); }
QStandardItem::QStandardItem(int rows, int columns) : QStandardItem(*new QStandardItemPrivate) { setRowCount(rows); setColumnCount(columns); }
QStandardItem::QStandardItem(QStandardItemPrivate &dd) : d_ptr(&dd) { Q_D(QStandardItem); d->q_ptr = this; }
QStandardItem::QStandardItem(const QStandardItem &other) : d_ptr(new QStandardItemPrivate)
{
    Q_D(QStandardItem);
    d->q_ptr = this;
    operator=(other);
}
QStandardItem &QStandardItem::operator=(const QStandardItem &other)
{
    Q_D(QStandardItem);
    d->values = other.d_func()->values;
    return *this;
}
```

```
[QStandardItem]
	__vfptr
	QScopedPointer<QStandardItemPrivate> d_ptr;
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

