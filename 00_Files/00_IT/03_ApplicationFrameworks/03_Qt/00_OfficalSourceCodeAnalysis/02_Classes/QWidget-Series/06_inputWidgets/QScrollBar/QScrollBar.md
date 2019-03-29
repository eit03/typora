***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QScrollBar
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_WIDGETS_EXPORT QScrollBar : public QAbstractSlider
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************

//*****************************************************************************************************************
//Properties ***************************************************************************************************
    
//*****************************************************************************************************************
//Constructor **************************************************************************************************
public:
    explicit QScrollBar(QWidget *parent = Q_NULLPTR);
    explicit QScrollBar(Qt::Orientation, QWidget *parent = Q_NULLPTR);
private:
    Q_DISABLE_COPY(QScrollBar)
    
//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```
QScrollBar::QScrollBar(QWidget *parent) : QScrollBar(Qt::Vertical, parent) {}

QScrollBar::QScrollBar(Qt::Orientation orientation, QWidget *parent) : QAbstractSlider(*new QScrollBarPrivate, parent)
{
    d_func()->orientation = orientation;
    d_func()->init();
}
```
## `Memeory Model`
```
[QScrollBar]
    [QAbstractSlider]
```

# `Properties`

# `Public Types`

# `Public Functions`
###### `QScrollBar(QWidget *parent = Q_NULLPTR)`
###### `QScrollBar(Qt::Orientation orientation, QWidget *parent = Q_NULLPTR)`
###### `~QScrollBar()`
###### `Reimplemented Public Functions`
###### `virtual bool event(QEvent *event)`
###### `virtual QSize sizeHint() const`

# `Reimplement Public Functions`

# `Public Slots`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`
###### `void initStyleOption(QStyleOptionSlider *option) const`
###### `Reimplemented Protected Functions`
###### `virtual void contextMenuEvent(QContextMenuEvent *event)`
###### `virtual void hideEvent(QHideEvent *)`
###### `virtual void mouseMoveEvent(QMouseEvent *e)`
###### `virtual void mousePressEvent(QMouseEvent *e)`
###### `virtual void mouseReleaseEvent(QMouseEvent *e)`
###### `virtual void paintEvent(QPaintEvent *)`
###### `virtual void sliderChange(SliderChange change)`
###### `virtual void wheelEvent(QWheelEvent *event)`

# `Reimplement Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`
