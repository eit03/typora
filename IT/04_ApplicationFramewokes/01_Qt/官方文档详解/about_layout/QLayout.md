`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QLayout

------

[TOC]

------

# `Brief Introduction`

0. QLayout是用来管理布局项QLayoutItem的.
1. 通常一个QWidget生成QWidgetItem;
   QWidgetItem is derived from QLayoutItem; 
   QLayoutItem被添加到QLayout中,具体在QxxxLayout:list属性中
   可以见QBoxLayout::insertWidget()代码.
2. QLayout是一个抽象类.

# `Detailed Description`

# `Data Struct`

```
class Q_WIDGETS_EXPORT QLayout : public QObject, public QLayoutItem
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓↓↓ *****

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓ *****

//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
    QLayout(QWidget *parent);
    QLayout();
    
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓ *****
}
```

```
QLayout::QLayout() : QObject(*new QLayoutPrivate, 0) {}

QLayout::QLayout(QLayoutPrivate &dd, QLayout *lay, QWidget *w) : QObject(dd, lay ? static_cast<QObject*>(lay) : static_cast<QObject*>(w))
{
    Q_D(QLayout);
    if (lay) {
        lay->addItem(this);
    } else if (w) {
        if (Q_UNLIKELY(w->layout())) {
            qWarning("QLayout: Attempting to add QLayout \"%ls\" to %s \"%ls\", which already has a layout",
                     qUtf16Printable(QObject::objectName()), w->metaObject()->className(), qUtf16Printable(w->objectName()));
            setParent(0);
        } else {
            d->topLevel = true;
            w->d_func()->layout = this;
            QT_TRY {
                invalidate();
            } QT_CATCH(...) {
                w->d_func()->layout = 0;
                QT_RETHROW;
            }
        }
    }
}
```



```
[QLayout]
	[QObject]
	[QLayoutItem]
```



# `Properties`

###### `sizeConstraint : SizeConstraint`
###### `spacing : int`

# `Public Types`
###### `enum SizeConstraint { SetDefaultConstraint, SetFixedSize, SetMinimumSize, SetMaximumSize, SetMinAndMaxSize, SetNoConstraint }`

# `Public Functions`

###### `QLayout(QWidget *parent)`
###### `QLayout()`
###### `bool activate()`
###### `virtual void addItem(QLayoutItem *item) = 0`
###### `void addWidget(QWidget *w)`

0. to add the QWidget to the QLayout`s parrent.
1. to add QLayoutItem that associate with the QWidget to the QLayout.

```
void QLayout::addWidget(QWidget *w)
{
    addChildWidget(w);
    addItem(QLayoutPrivate::createWidgetItem(this, w));
}
```

- QLayout是抽象类,addItem()是纯虚函数,所以这个函数是不会被调用.

###### `QMargins contentsMargins() const`
###### `QRect contentsRect() const`
###### `virtual int count() const = 0`
###### `void getContentsMargins(int *left, int *top, int *right, int *bottom) const`
###### `virtual int indexOf(QWidget *widget) const`
###### `bool isEnabled() const`
###### `virtual QLayoutItem * itemAt(int index) const = 0`
###### `QWidget * menuBar() const`
###### `QWidget * parentWidget() const`
###### `void removeItem(QLayoutItem *item)`
###### `void removeWidget(QWidget *widget)`
###### `QLayoutItem * replaceWidget(QWidget *from, QWidget *to, Qt::FindChildOptions options = Qt::FindChildrenRecursively)`
###### `bool setAlignment(QWidget *w, Qt::Alignment alignment)`
###### `bool setAlignment(QLayout *l, Qt::Alignment alignment)`
###### `void setContentsMargins(int left, int top, int right, int bottom)`
###### `void setContentsMargins(const QMargins &margins)`
###### `void setEnabled(bool enable)`
###### `void setMenuBar(QWidget *widget)`
###### `void setSizeConstraint(SizeConstraint)`
###### `void setSpacing(int)`
###### `SizeConstraint sizeConstraint() const`
###### `int spacing() const`
###### `virtual QLayoutItem * takeAt(int index) = 0`
###### `void update()`

# `Reimplemented Public Functions`

###### `virtual QSizePolicy::ControlTypes controlTypes() const`
###### `virtual Qt::Orientations expandingDirections() const`
###### `virtual QRect geometry() const`
###### `virtual void invalidate()`
###### `virtual bool isEmpty() const`
###### `virtual QLayout * layout()`
###### `virtual QSize maximumSize() const`
###### `virtual QSize minimumSize() const`
###### `virtual void setGeometry(const QRect &r)`

# `Public Slots`

# `Signals`

# `Static Public Members`

###### `QSize closestAcceptableSize(const QWidget *widget, const QSize &size)`

# `Protected Types`

# `Protected Functions`

###### `void addChildLayout(QLayout *l)`
###### `void addChildWidget(QWidget *w)`

- 把部件w作为子部件添加到布局的父中.
- 是否显示w部件.

```
void QLayout::addChildWidget(QWidget *w)
{
    QWidget *mw = parentWidget(); //mw-->布局的父
    QWidget *pw = w->parentWidget(); //pw-->部件的父

    //Qt::WA_LaidOut is never reset. It only means that the widget at some point has
    //been in a layout.
    if (pw && w->testAttribute(Qt::WA_LaidOut)) {
        QLayout *l = pw->layout();
        if (l && removeWidgetRecursively(l, w)) {
#ifdef QT_DEBUG
            if (Q_UNLIKELY(layoutDebug()))
                qWarning("QLayout::addChildWidget: %s \"%ls\" is already in a layout; moved to new layout",
                         w->metaObject()->className(), qUtf16Printable(w->objectName()));
#endif
        }
    }
    if (pw && mw && pw != mw) {
#ifdef QT_DEBUG
            if (Q_UNLIKELY(layoutDebug()))
                qWarning("QLayout::addChildWidget: %s \"%ls\" in wrong parent; moved to correct parent",
                         w->metaObject()->className(), qUtf16Printable(w->objectName()));
#endif
        pw = 0;
    }
    bool needShow = mw && mw->isVisible() && !(w->isHidden() && w->testAttribute(Qt::WA_WState_ExplicitShowHide));
    if (!pw && mw) //布局与部件它们的父是同一个.
        w->setParent(mw);
    w->setAttribute(Qt::WA_LaidOut); //设置部件Qt::WA_LaidOut属性
    if (needShow)
        QMetaObject::invokeMethod(w, "_q_showIfNotHidden", Qt::QueuedConnection); //show later
}
```



###### `QRect alignmentRect(const QRect &r) const`

# `Reimplemented Protected Functions`

###### `virtual void childEvent(QChildEvent *e)`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`

