`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QLayoutItem

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

```
class Q_WIDGETS_EXPORT QLayoutItem
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓↓↓ *****

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓ *****
protected:
    Qt::Alignment align;
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    inline explicit QLayoutItem(Qt::Alignment alignment = Qt::Alignment());
    virtual ~QLayoutItem();
    
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓ *****
public:
    virtual QSize sizeHint() const = 0;
    virtual QSize minimumSize() const = 0;
    virtual QSize maximumSize() const = 0;
    virtual Qt::Orientations expandingDirections() const = 0;
    virtual void setGeometry(const QRect&) = 0;
    virtual QRect geometry() const = 0;
    virtual bool isEmpty() const = 0;
    virtual bool hasHeightForWidth() const;
    virtual int heightForWidth(int) const;
    virtual int minimumHeightForWidth(int) const;
    virtual void invalidate();

    virtual QWidget *widget();
    virtual QLayout *layout();
    virtual QSpacerItem *spacerItem();

    Qt::Alignment alignment() const { return align; }
    void setAlignment(Qt::Alignment a);
    virtual QSizePolicy::ControlTypes controlTypes() const;
};
```

```

```

```
[QLayoutItem]
    __vfptr
    Qt::Alignment align;
```

# `Properties`

# `Public Types`

# `Public Functions`

###### `QLayoutItem(Qt::Alignment alignment = Qt::Alignment())`
###### `virtual ~QLayoutItem()`
###### `Qt::Alignment alignment() const`
###### `virtual QSizePolicy::ControlTypes controlTypes() const`
###### `virtual Qt::Orientations expandingDirections() const = 0`
###### `virtual QRect geometry() const = 0`
###### `virtual bool hasHeightForWidth() const`
###### `virtual int heightForWidth(int w) const`
###### `virtual void invalidate()`
###### `virtual bool isEmpty() const = 0`
###### `virtual QLayout * layout()`
###### `virtual QSize maximumSize() const = 0`
###### `virtual int minimumHeightForWidth(int w) const`
###### `virtual QSize minimumSize() const = 0`
###### `void setAlignment(Qt::Alignment alignment)`
###### `virtual void setGeometry(const QRect &r) = 0`
###### `virtual QSize sizeHint() const = 0`
###### `virtual QSpacerItem * spacerItem()`
###### `virtual QWidget * widget()`

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

