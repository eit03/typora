

***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QFrame
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_WIDGETS_EXPORT QFrame : public QWidget
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************
public:
    enum Shape {
        NoFrame     = 0, // no frame
        Box         = 0x0001, // rectangular box
        Panel       = 0x0002, // rectangular panel
        WinPanel    = 0x0003, // rectangular panel (Windows)
        HLine       = 0x0004, // horizontal line
        VLine       = 0x0005, // vertical line
        StyledPanel = 0x0006 // rectangular panel depending on the GUI style
    };
    Q_ENUM(Shape)
    
    enum Shadow {
        Plain  = 0x0010, // plain line
        Raised = 0x0020, // raised shadow effect
        Sunken = 0x0030 // sunken shadow effect
    };
    Q_ENUM(Shadow)

    enum StyleMask {
        Shadow_Mask = 0x00f0, // mask for the shadow
        Shape_Mask  = 0x000f // mask for the shape
    };
    
//*****************************************************************************************************************
//Properties ***************************************************************************************************

//*****************************************************************************************************************
//Constructor **************************************************************************************************
public:
    explicit QFrame(QWidget* parent = Q_NULLPTR, Qt::WindowFlags f = Qt::WindowFlags());
protected:
    QFrame(QFramePrivate &dd, QWidget* parent = Q_NULLPTR, Qt::WindowFlags f = Qt::WindowFlags());
    
//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```
QFrame::QFrame(QWidget* parent, Qt::WindowFlags f) : QWidget(*new QFramePrivate, parent, f) { Q_D(QFrame); d->init(); }
QFrame::QFrame(QFramePrivate &dd, QWidget* parent, Qt::WindowFlags f) : QWidget(dd, parent, f) { Q_D(QFrame); d->init(); }
```
## `Memeory Model`
```
[QFrame]
    [QWidget]
    	...
    	    QFramePrivate* QOjbect::d_ptr;
```

# `Properties`
###### `frameRect : QRect`
###### `frameShadow : Shadow`
###### `frameShape : Shape`
###### `frameWidth : const int`
###### `lineWidth : int`
###### `midLineWidth : int`

# `Public Types`
###### `enum Shadow { Plain, Raised, Sunken }`
###### `enum Shape { NoFrame, Box, Panel, StyledPanel, ..., WinPanel }`
###### `enum StyleMask { Shadow_Mask, Shape_Mask }`

# `Public Functions`
###### `QFrame(QWidget *parent = Q_NULLPTR, Qt::WindowFlags f = Qt::WindowFlags())`
###### `~QFrame()`
###### `QRect frameRect() const`
###### `Shadow frameShadow() const`
###### `Shape frameShape() const`
###### `int frameStyle() const`
###### `int frameWidth() const`
###### `int lineWidth() const`
###### `int midLineWidth() const`
###### `void setFrameRect(const QRect &)`
###### `void setFrameShadow(Shadow)`
###### `void setFrameShape(Shape)`
###### `void setFrameStyle(int style)`
###### `void setLineWidth(int)`
###### `void setMidLineWidth(int)`

# `Reimplemented Public Functions`
###### `virtual QSize sizeHint() const`

# `Public Slots`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`
###### `void initStyleOption(QStyleOptionFrame *option) const`

# `Reimplemented Protected Functions`
###### `virtual void changeEvent(QEvent *ev)`
###### `virtual bool event(QEvent *e)`
###### `virtual void paintEvent(QPaintEvent *)`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`
