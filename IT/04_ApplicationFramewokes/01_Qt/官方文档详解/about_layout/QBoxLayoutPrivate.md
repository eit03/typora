`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` 

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

```
class QBoxLayoutPrivate : public QLayoutPrivate
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓↓↓ *****

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓ *****
public:
    QList<QBoxLayoutItem *> list; //布局中布局项列表
    QVector<QLayoutStruct> geomArray;
    int hfwWidth;
    int hfwHeight;
    int hfwMinHeight;
    QSize sizeHint;
    QSize minSize;
    QSize maxSize;
    int leftMargin, topMargin, rightMargin, bottomMargin;
    Qt::Orientations expanding;
    uint hasHfw : 1;
    uint dirty : 1;
    QBoxLayout::Direction dir;
    int spacing;
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    QBoxLayoutPrivate() : hfwWidth(-1), dirty(true), spacing(-1) {}
    ~QBoxLayoutPrivate();
    
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓ *****
    Q_DECLARE_PUBLIC(QBoxLayout)
public:
    void setDirty() { geomArray.clear(); hfwWidth = -1; hfwHeight = -1; dirty = true; 

    inline void deleteAll() { while (!list.isEmpty()) delete list.takeFirst(); }

    void setupGeom();
    void calcHfw(int);

    void effectiveMargins(int *left, int *top, int *right, int *bottom) const;
    QLayoutItem* replaceAt(int index, QLayoutItem*) Q_DECL_OVERRIDE;
};
```

```
QBoxLayoutPrivate() : hfwWidth(-1), dirty(true), spacing(-1) {}
```

```
[QBoxLayoutPrivate]
    [QLayoutPrivate] 
    QList<QBoxLayoutItem *> list;
    QVector<QLayoutStruct> geomArray;
    int hfwWidth;
    int hfwHeight;
    int hfwMinHeight;
    QSize sizeHint;
    QSize minSize;
    QSize maxSize;
    int leftMargin, topMargin, rightMargin, bottomMargin;
    Qt::Orientations expanding;
    uint hasHfw : 1;
    uint dirty : 1;
    QBoxLayout::Direction dir;
    int spacing;
```



# `Properties`

# `Public Types`

# `Public Functions`

# `Public Slots`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`

