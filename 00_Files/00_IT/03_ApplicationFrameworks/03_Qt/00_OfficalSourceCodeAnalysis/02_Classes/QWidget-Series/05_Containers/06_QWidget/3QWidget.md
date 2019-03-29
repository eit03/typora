***
`Version:` Qt 5.12.1, QtCreate 4.8.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:`
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`
# `Data Struct`
## `Type Declaration`
```
class Q_WIDGETS_EXPORT QWidget : public QObject, public QPaintDevice
{
///> 0. Prepare
public:
    enum RenderFlag {
        DrawWindowBackground = 0x1,
        DrawChildren = 0x2,
        IgnoreMask = 0x4
    };
    Q_DECLARE_FLAGS(RenderFlags, RenderFlag)

///> 1. Properties
private:
    QWidgetData *data;

///> 2. Constructor
public:
    explicit QWidget(QWidget* parent = nullptr, Qt::WindowFlags f =
        Qt::WindowFlags());
    ~QWidget();
protected:
    QWidget(QWidgetPrivate &d, QWidget* parent, Qt::WindowFlags f);
private:
    Q_DISABLE_COPY(QWidget)

///> 3. Functions
}
```
## `Constructor`

```
QWidget::QWidget(QWidget *parent, Qt::WindowFlags f)
    : QObject(*new QWidgetPrivate, 0), QPaintDevice()
{
    QT_TRY {
        d_func()->init(parent, f);
    } QT_CATCH(...) {
        QWidgetExceptionCleaner::cleanup(this, d_func());
        QT_RETHROW;
    }
}
```

```
QWidget::QWidget(QWidgetPrivate &dd, QWidget* parent, Qt::WindowFlags f)
    : QObject(dd, 0), QPaintDevice()
{
    Q_D(QWidget);
    QT_TRY {
        d->init(parent, f);
    } QT_CATCH(...) {
        QWidgetExceptionCleaner::cleanup(this, d_func());
        QT_RETHROW;
    }
}
```

## `Memory Model`

```
[QObject]
[QPaintDevice]
data                    QWidgetData*
```

# `Properties`
###### `acceptDrops : bool`
`Interpretation:`

This property holds whether drop events are enabled for this widget.
Setting this property to true announces to the system that
this widget may be able to accept drop events.

`StorePosition:`

d->high_attributes : ?;

`Defualt:`

`Access:`

bool acceptDrops() const;
void setAcceptDrops(bool on);

```
QWidget wgt;
wgt.acceptDrops();
wgt.setAcceptDrops(true);
wgt.show();

bool QWidget::acceptDrops() const { return testAttribute(Qt::WA_AcceptDrops); }

inline bool QWidget::testAttribute(Qt::WidgetAttribute attribute) const
{
    if (attribute < int(8*sizeof(uint)))
        return data->widget_attributes & (1<<attribute);
    return testAttribute_helper(attribute);
}

bool QWidget::testAttribute_helper(Qt::WidgetAttribute attribute) const
{
    Q_D(const QWidget);
    const int x = attribute - 8*sizeof(uint);
    const int int_off = x / (8*sizeof(uint));
    return (d->high_attributes[int_off] & (1<<(x-(int_off*8*sizeof(uint)))));
}
```

`Remark:`
`Eg 0:`
###### `accessibleDescription : QString`

`Interpretation:`

This property holds the widget's description as seen by assistive technologies;

The accessible description of a widget should convey what a widget does. While
the accessibleName should be a short and consise string (e.g. Save), the
description should give more context, such as Saves the current document.

`StorePosition:`

d->accessibleDescription;

`Defualt:`

`Access:`

QString accessibleDescription() const;
void setAccessibleDescription(const QString &description);

`Remark:`

`Eg 0:`
###### `accessibleName : QString`
`Interpretation:`

see previours property.
see Qt documentation.

`StorePosition:`

d->accessibleName;

`Defualt:`

`Access:`

QString accessibleName() const;
void setAccessibleName(const QString &name);

`Remark:`
`Eg 0:`
###### `autoFillBackground : bool`

`Interpretation:`

This property holds whether the widget background is filled automatically;

If enabled, this property will cause Qt to fill the background of the widget
before invoking the paint event. The color used is defined by the
**QPalette::Window** color role from the widget's palette.

In addition, Windows are always filled with **QPalette::Window**, unless the
**WA_OpaquePaintEvent** or **WA_NoSystemBackground** attributes are set.

`StorePosition:`

d->extra->autoFillBackground;

`Defualt:`

By default, this property is false.

`Access:`

bool autoFillBackground() const;
void setAutoFillBackground(bool enabled);

`Remark:`

This property cannot be turned off (i.e., set to false) if a widget's parent
has a static gradient for its background.

Use this property with caution in conjunction with Qt Style Sheets. When a
widget has a style sheet with a valid background or a border-image,
this property is automatically disabled.

`Eg 0:`
###### `baseSize : QSize`
`Interpretation:`

This property holds the base size of the widget;

The base size is used to calculate a proper widget size
if the widget defines sizeIncrement().

`StorePosition:`

d->extra->topextra->basew;
d->extra->topextra->baseh;

`Defualt:`

By default, for a newly-created widget, this property contains a size with zero
width and height.

`Access:`

QSize baseSize() const;
void setBaseSize(const QSize &);
void setBaseSize(int basew, int baseh);

`Remark:`
`Eg 0:`
###### `childrenRect : const QRect`
`Interpretation:`

This property holds the bounding rectangle of the widget's children;

Hidden children are excluded;

`StorePosition:`

```
QRect QWidget::childrenRect() const
{
    Q_D(const QWidget);
    QRect r(0, 0, 0, 0);
    for (int i = 0; i < d->children.size(); ++i) {
        QWidget *w = qobject_cast<QWidget *>(d->children.at(i));
        if (w && !w->isWindow() && !w->isHidden())
            r |= w->geometry();
    }
    return r;
}
```

`Defualt:`

By default, for a widget with no children, this property contains a rectangle
with zero width and height located at the origin.

`Access:`

QRect childrenRect() const;

`Remark:`
`Eg 0:`
###### `childrenRegion : const QRegion`
`Interpretation:`

This property holds the combined region occupied by the widget's children
Hidden children are excluded.

`StorePosition:`
```
QRegion QWidget::childrenRegion() const
{
    Q_D(const QWidget);
    QRegion r;
    for (int i = 0; i < d->children.size(); ++i) {
        QWidget *w = qobject_cast<QWidget *>(d->children.at(i));
        if (w && !w->isWindow() && !w->isHidden()) {
            QRegion mask = w->mask();
            if (mask.isEmpty())
                r |= w->geometry();
            else
                r |= mask.translated(w->pos());
        }
    }
    return r;
}
```

`Defualt:`

By default, for a widget with no children, this property contains an empty region.

`Access:`

QRegion childrenRegion() const;

`Remark:`
`Eg 0:`
###### `contextMenuPolicy : Qt::ContextMenuPolicy`
`Interpretation:`

how the widget shows a context menu;

The default value of this property is **Qt::DefaultContextMenu**, which means
the contextMenuEvent() handler is called. Other values are **Qt::NoContextMenu**,
**Qt::PreventContextMenu**, **Qt::ActionsContextMenu**, and **Qt::CustomContextMenu**.
With **Qt::CustomContextMenu**, the signal customContextMenuRequested() is emitted.

`StorePosition:`

data->context_menu_policy;

```
Qt::ContextMenuPolicy QWidget::contextMenuPolicy() const
{
    return (Qt::ContextMenuPolicy)data->context_menu_policy;
}
```
`Defualt:`
`Access:`

Qt::ContextMenuPolicy contextMenuPolicy() const;
void setContextMenuPolicy(Qt::ContextMenuPolicy policy);

`Remark:`
`Eg 0:`
###### `cursor : QCursor`
`Interpretation:`

This property holds the cursor shape for this widget;

`StorePosition:`

d->extra->curs;

```
QCursor QWidget::cursor() const
{
    Q_D(const QWidget);
    if (testAttribute(Qt::WA_SetCursor))
        return (d->extra && d->extra->curs)
            ? *d->extra->curs
            : QCursor(Qt::ArrowCursor);
    if (isWindow() || !parentWidget())
        return QCursor(Qt::ArrowCursor);
    return parentWidget()->cursor();
}
```

`Defualt:`

By default, this property contains a cursor with the **Qt::ArrowCursor** shape.

`Access:`

QCursor cursor() const;
void setCursor(const QCursor &);
void unsetCursor();

`Remark:`

If no cursor has been set, or after a call to unsetCursor(), the parent's cursor
is used.

Some underlying window implementations will reset the cursor if it leaves a
widget even if the mouse is grabbed. If you want to have a cursor set for
all widgets, even when outside the window, consider
QApplication::setOverrideCursor().

Some widgets display themselves differently when they are disabled. For example
a button might draw its label grayed out. If your widget needs to know when it
becomes enabled or disabled, you can use the changeEvent()
with type QEvent::EnabledChange.

`Eg 0:`
###### `enabled : bool`
`Interpretation:`

This property holds whether the widget is enabled;

In general an enabled widget handles keyboard and mouse events; a disabled
widget does not. An exception is made with QAbstractButton.

`StorePosition:`

data->widget_attributes;

```
inline bool QWidget::isEnabled() const
{ return !testAttribute(Qt::WA_Disabled); }

inline bool QWidget::testAttribute(Qt::WidgetAttribute attribute) const
{
    if (attribute < int(8*sizeof(uint)))
        return data->widget_attributes & (1<<attribute);
    return testAttribute_helper(attribute);
}
```

`Defualt:`

By default, this property is true.

`Access:`

bool isEnabled() const;
void setEnabled(bool);


`Remark:`

Disabling a widget implicitly disables all its children. Enabling respectively
enables all child widgets unless they have been explicitly disabled. It it not
possible to explicitly enable a child widget which is not a window while its
parent widget remains disabled.

`Eg 0:`

###### `focus : const bool`
`Interpretation:`

This property holds whether this widget (or its focus proxy) has the keyboard
input focus;

`StorePosition:`

d->extra->focus_proxy;

```
bool QWidget::hasFocus() const
{
    const QWidget* w = this;
    while (w->d_func()->extra && w->d_func()->extra->focus_proxy)
        w = w->d_func()->extra->focus_proxy;
#if QT_CONFIG(graphicsview)
    if (QWidget *window = w->window()) {
        QWExtra *e = window->d_func()->extra;
        if (e && e->proxyWidget && e->proxyWidget->hasFocus() && window->focusWidget() == w)
            return true;
    }
#endif // QT_CONFIG(graphicsview)
    return (QApplication::focusWidget() == w);
}
```

`Defualt:`

By default, this property is false;

`Access:`

bool hasFocus() const;

`Remark:`

Obtaining the value of this property for a widget is effectively equivalent to
checking whether QApplication::focusWidget() refers to the widget.

`Eg 0:`

###### `focusPolicy : Qt::FocusPolicy`

`Interpretation:`

This property holds the way the widget accepts keyboard focus;

The policy is Qt::TabFocus if the widget accepts keyboard focus by tabbing,
**Qt::ClickFocus** if the widget accepts focus by clicking, **Qt::StrongFocus**
if it accepts both, and **Qt::NoFocus** if it does not accept focus at all.

`StorePosition:`

data->focus_policy;

```
Qt::FocusPolicy QWidget::focusPolicy() const
{
    return (Qt::FocusPolicy)data->focus_policy;
}
```

`Defualt:`
`Access:`

Qt::FocusPolicy focusPolicy() const;
void setFocusPolicy(Qt::FocusPolicy policy);

`Remark:`

You must enable keyboard focus for a widget if it processes keyboard events.
This is normally done from the widget's constructor. For instance, the QLineEdit
constructor calls setFocusPolicy(Qt::StrongFocus).

If the widget has a focus proxy, then the focus policy will be propagated to it.

`Eg 0:`

###### `font : QFont`

`Interpretation:`

This property holds the font currently set for the widget;

This property describes the widget's requested font. The font is used by the
widget's style when rendering standard components, and is available as a means
to ensure that custom widgets can maintain consistency with the native
platform's look and feel. It's common that different platforms, or different
styles, define different fonts for an application.

When you assign a new font to a widget, the properties from this font are
combined with the widget's default font to form the widget's final font.
You can call fontInfo() to get a copy of the widget's final font. The final
font is also used to initialize QPainter's font.

The default depends on the system environment. QApplication maintains a
system/theme font which serves as a default for all widgets. There may also
be special font defaults for certain types of widgets. You can also define
default fonts for widgets yourself by passing a custom font and the name of a
widget to QApplication::setFont(). Finally, the font is matched against Qt's
font database to find the best match.

QWidget propagates explicit font properties from parent to child. If you change
a specific property on a font and assign that font to a widget, that property
will propagate to all the widget's children, overriding any system defaults for
that property. Note that fonts by default don't propagate to windows
(see isWindow()) unless the Qt::WA_WindowPropagation attribute is enabled.

QWidget's font propagation is similar to its palette propagation.

The current style, which is used to render the content of all standard Qt
widgets, is free to choose to use the widget font, or in some cases, to ignore
it (partially, or completely). In particular, certain styles like GTK style,
Mac style, and Windows Vista style, apply special modifications to the widget
font to match the platform's native look and feel. Because of this, assigning
properties to a widget's font is not guaranteed to change the appearance of the
widget. Instead, you may choose to apply a styleSheet.

`StorePosition:`

data->fnt;

`Defualt:`
`Access:`

const QFont& font() const;
void setFont(const QFont &);

`Remark:`

If Qt Style Sheets are used on the same widget as setFont(), style sheets will
take precedence if the settings conflict.

`Eg 0:`

###### `frameGeometry : const QRect`
`Interpretation:`

Geometry of the widget relative to its parent including any window frame.

`StorePosition:`

data->crect;

```
QRect QWidget::frameGeometry() const
{
    Q_D(const QWidget);
    if (isWindow() && ! (windowType() == Qt::Popup)) {
        QRect fs = d->frameStrut();
        return QRect(data->crect.x() - fs.left(),
                     data->crect.y() - fs.top(),
                     data->crect.width() + fs.left() + fs.right(),
                     data->crect.height() + fs.top() + fs.bottom());
    }
    return data->crect;
}
```

`Defualt:`

By default, this property contains a value that depends on the user's platform
and screen geometry.

`Access:`

QRect frameGeometry() const;

`Remark:`
`Eg 0:`

###### `frameSize : const QSize`
`Interpretation:`

This property holds the size of the widget including any window frame;

`StorePosition:`

```
QSize QWidget::frameSize() const
{
    Q_D(const QWidget);
    if (isWindow() && !(windowType() == Qt::Popup)) {
        QRect fs = d->frameStrut();
        return QSize(data->crect.width() + fs.left() + fs.right(),
                      data->crect.height() + fs.top() + fs.bottom());
    }
    return data->crect.size();
}
```

`Defualt:`

By default, this property contains a value that depends on the user's platform
and screen geometry;

`Access:`

QSize frameSize() const;

`Remark:`
`Eg 0:`

###### `fullScreen : const bool`
`Interpretation:`

This property holds whether the widget is shown in full screen mode;

A widget in full screen mode occupies the whole screen area and does not display
window decorations, such as a title bar.

`StorePosition:`

```
bool QWidget::isFullScreen() const
{ return data->window_state & Qt::WindowFullScreen; }
```

`Defualt:`

By default, this property is false.

`Access:`

bool isFullScreen() const;

`Remark:`
`Eg 0:`

###### `geometry : QRect`
`Interpretation:`

This property holds the geometry of the widget relative to its parent and
excluding the window frame

`StorePosition:`

data->crect;

```
inline const QRect &QWidget::geometry() const
{ return data->crect; }
```

`Defualt:`

By default, this property contains a value that depends on the user's platform
and screen geometry.

`Access:`

const QRect & geometry() const;
void setGeometry(int x, int y, int w, int h);
void setGeometry(const QRect &);

`Remark:`

When changing the geometry, the widget, if visible, receives a move event
(moveEvent()) and/or a resize event (resizeEvent()) immediately. If the widget
is not currently visible, it is guaranteed to receive appropriate events before
it is shown.

The size component is adjusted if it lies outside the range defined by
minimumSize() and maximumSize().

Warning: Calling setGeometry() inside resizeEvent() or moveEvent() can lead to
infinite recursion.

`Eg 0:`

###### `height : const int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `inputMethodHints : Qt::InputMethodHints`
`Interpretation:`

???

`StorePosition:`
`Defualt:`

By default, this property contains a value that depends on the user's platform
and screen geometry.

`Access:`

int height() const;

`Remark:`

Note: Do not use this function to find the height of a screen on a multiple
screen desktop. Read this note for details.

`Eg 0:`

###### `isActiveWindow : const bool`
`Interpretation:`

This property holds whether this widget's window is the active window;

The active window is the window that contains the widget that has keyboard focus
(The window may still have focus if it has no widgets or none of its widgets
accepts keyboard focus).

When popup windows are visible, this property is true for both the active window
and for the popup.

`StorePosition:`
`Defualt:`

By default, this property is false.

`Access:`

bool isActiveWindow() const;

`Remark:`
`Eg 0:`

###### `layoutDirection : Qt::LayoutDirection`
`Interpretation:`

This property holds the layout direction for this widget;

| Constant                | Value | Description           |
| ----------------------- | ----- | --------------------- |
| Qt::LeftToRight         | 0     | Left-to-right layout. |
| Qt::RightToLeft         | 1     | Right-to-left layout. |
| Qt::LayoutDirectionAuto | 2     | Automatic layout.     |

`StorePosition:`

d->high_attributes[??];

`Defualt:`

By default, this property is set to Qt::LeftToRight.;

`Access:`

Qt::LayoutDirection layoutDirection() const;
void setLayoutDirection(Qt::LayoutDirection direction);
void unsetLayoutDirection();

`Remark:`

When the layout direction is set on a widget, it will propagate to the widget's
children, but not to a child that is a window and not to a child for which
setLayoutDirection() has been explicitly called. Also, child widgets added after
setLayoutDirection() has been called for the parent do not inherit the parent's
layout direction.

This method no longer affects text layout direction since Qt 4.7.;

`Eg 0:`

###### `locale : QLocale`
`Interpretation:`

This property holds the widget's locale

As long as no special locale has been set, this is either the parent's locale or (if this widget is a top level widget), the default locale.

If the widget displays dates or numbers, these should be formatted using the widget's locale.

This property was introduced in Qt 4.3.

`StorePosition:`
`Defualt:`
`Access:`

QLocale locale() const;
void setLocale(const QLocale &locale);
void unsetLocale();

`Remark:`
`Eg 0:`

###### `maximized : const bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `maximumHeight : int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `maximumSize : QSize`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `maximumWidth : int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `minimized : const bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `minimumHeight : int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `minimumSize : QSize`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `minimumSizeHint : const QSize`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `minimumWidth : int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `modal : const bool`
`Interpretation:`

This property holds whether the widget is a modal widget

This property only makes sense for windows. A modal widget prevents widgets in all other windows from getting any input.

`StorePosition:`

data->window_modality;

```
inline bool QWidget::isModal() const
{ return data->window_modality != Qt::NonModal; }
```

`Defualt:`

By default, this property is false.

`Access:`

bool isModal() const;

`Remark:`
`Eg 0:`
###### `mouseTracking : bool`
`Interpretation:`

This property holds whether mouse tracking is enabled for the widget

If mouse tracking is disabled (the default), the widget only receives mouse move events when at least one mouse button is pressed while the mouse is being moved.

If mouse tracking is enabled, the widget receives mouse move events even if no buttons are pressed.

`StorePosition:`

`Defualt:`

By default, mouse tracking is disabled;

`Access:`

bool hasMouseTracking() const;
void setMouseTracking(bool enable);

`Remark:`
`Eg 0:`

###### `normalGeometry : const QRect`
`Interpretation:`


`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`

###### `palette : QPalette`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `pos : QPoint`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `rect : const QRect`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `size : QSize`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `sizeHint : const QSize`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `sizeIncrement : QSize`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `sizePolicy : QSizePolicy`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `statusTip : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `styleSheet : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `tabletTracking : bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `toolTip : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `toolTipDuration : int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `updatesEnabled : bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `visible : bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `whatsThis : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `width : const int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `windowFilePath : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `windowFlags : Qt::WindowFlags`
`Interpretation:`

Window flags are a combination of a type and zero or more hints to the window
system.

If the widget had type Qt::Widget or Qt::SubWindow and becomes a window
(Qt::Window, Qt::Dialog, etc.), it is put at position (0, 0) on the desktop. If
the widget is a window and becomes a Qt::Widget or Qt::SubWindow, it is put at
position (0, 0) relative to its parent widget.


`StorePosition:`
`Defualt:`
`Access:`

Qt::WindowFlags windowFlags() const;
void setWindowFlags(Qt::WindowFlags type);

`Remark:`

Note: This function calls setParent() when changing the flags for a window,
causing the widget to be hidden. You must call show() to make the widget visible
again.

`Eg 0:`

###### `windowIcon : QIcon`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `windowModality : Qt::WindowModality`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `windowModified : bool`
`Interpretation:`

This property holds whether the document shown in the window has unsaved changes;

A modified window is a window whose content has changed but has not been saved
to disk. This flag will have different effects varied by the platform. On macOS
the close button will have a modified look; on other platforms, the window title
will have an '*' (asterisk).

The window title must contain a "[\*]" placeholder, which indicates where the
'\*' should appear. Normally, it should appear right after the file name
(e.g., "document1.txt[\*] - Text Editor"). If the window isn't modified, the
placeholder is simply removed.

`StorePosition:`

d->high_attributes[???];

`Defualt:`
`Access:`

bool isWindowModified() const;
void setWindowModified(bool);

`Remark:`

ote that if a widget is set as modified, all its ancestors will also be set as
modified. However, if you call setWindowModified(false) on a widget, this will
not propagate to its parent because other children of the parent might have been
modified.

`Eg 0:`

###### `windowOpacity : double`
`Interpretation:`

This property holds the level of opacity for the window.

The valid range of opacity is from 1.0 (completely opaque) to 0.0 (completely
transparent).

`StorePosition:`
`Defualt:`

By default the value of this property is 1.0.

`Access:`

qreal windowOpacity() const;
void setWindowOpacity(qreal level);

`Remark:`

This feature is available on Embedded Linux, macOS, Windows, and X11 platforms
that support the Composite extension.

Note: On X11 you need to have a composite manager running, and the X11 specific
_NET_WM_WINDOW_OPACITY atom needs to be supported by the window manager you are
using.

Warning: Changing this property from opaque to transparent might issue a paint
event that needs to be processed before the window is displayed correctly. This
affects mainly the use of QPixmap::grabWindow(). Also note that semi-transparent
windows update and resize significantly slower than opaque windows.

`Eg 0:`

###### `windowTitle : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `x : const int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `y : const int`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
# `Public Functions`
###### `QWidget(QWidget* parent = nullptr, Qt::WindowFlags f = Qt::WindowFlags())`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual ~QWidget()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool acceptDrops() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString accessibleDescription() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString accessibleName() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QList<QAction*> actions() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void activateWindow()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void addAction(QAction* action)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void addActions(QList<QAction*> actions)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void adjustSize()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool autoFillBackground() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPalette::ColorRole backgroundRole() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QBackingStore* backingStore() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QSize baseSize() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* childAt(int x, int y) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* childAt(const QPoint &p) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QRect childrenRect() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QRegion childrenRegion() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void clearFocus()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void clearMask()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QMargins contentsMargins() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QRect contentsRect() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Qt::ContextMenuPolicy contextMenuPolicy() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QCursor cursor() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `WId effectiveWinId() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void ensurePolished() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Qt::FocusPolicy focusPolicy() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* focusProxy() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* focusWidget() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `const QFont & font() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QFontInfo fontInfo() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QFontMetrics fontMetrics() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPalette::ColorRole foregroundRole() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QRect frameGeometry() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QSize frameSize() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `const QRect & geometry() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void getContentsMargins(int* left, int* top, int* right, int* bottom) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPixmap grab(const QRect &rectangle = QRect(QPoint(0, 0), QSize(-1, -1)))`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void grabGesture(Qt::GestureType gesture, Qt::GestureFlags flags = Qt::GestureFlags())`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void grabKeyboard()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void grabMouse()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void grabMouse(const QCursor &cursor)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int grabShortcut(const QKeySequence &key, Qt::ShortcutContext context = Qt::WindowShortcut)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QGraphicsEffect* graphicsEffect() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QGraphicsProxyWidget* graphicsProxyWidget() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool hasEditFocus() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool hasFocus() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual bool hasHeightForWidth() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool hasMouseTracking() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool hasTabletTracking() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int height() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual int heightForWidth(int w) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Qt::InputMethodHints inputMethodHints() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual QVariant inputMethodQuery(Qt::InputMethodQuery query) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void insertAction(QAction* before, QAction* action)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void insertActions(QAction* before, QList<QAction*> actions)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isActiveWindow() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isAncestorOf(const QWidget* child) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isEnabled() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isEnabledTo(const QWidget* ancestor) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isFullScreen() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isHidden() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isMaximized() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isMinimized() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isModal() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isVisible() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isVisibleTo(const QWidget* ancestor) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isWindow() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool isWindowModified() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QLayout* layout() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Qt::LayoutDirection layoutDirection() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QLocale locale() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPoint mapFrom(const QWidget* parent, const QPoint &pos) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPoint mapFromGlobal(const QPoint &pos) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPoint mapFromParent(const QPoint &pos) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPoint mapTo(const QWidget* parent, const QPoint &pos) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPoint mapToGlobal(const QPoint &pos) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPoint mapToParent(const QPoint &pos) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QRegion mask() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int maximumHeight() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QSize maximumSize() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int maximumWidth() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int minimumHeight() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QSize minimumSize() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual QSize minimumSizeHint() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int minimumWidth() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void move(const QPoint &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void move(int x, int y)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* nativeParentWidget() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* nextInFocusChain() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QRect normalGeometry() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void overrideWindowFlags(Qt::WindowFlags flags)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `const QPalette & palette() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* parentWidget() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QPoint pos() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* previousInFocusChain() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QRect rect() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void releaseKeyboard()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void releaseMouse()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void releaseShortcut(int id)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void removeAction(QAction* action)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void render(QPaintDevice* target, const QPoint &targetOffset = QPoint(), const QRegion &sourceRegion = QRegion(), RenderFlags renderFlags = RenderFlags(DrawWindowBackground | DrawChildren))`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void render(QPainter* painter, const QPoint &targetOffset = QPoint(), const QRegion &sourceRegion = QRegion(), RenderFlags renderFlags = RenderFlags(DrawWindowBackground | DrawChildren))`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void repaint(int x, int y, int w, int h)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void repaint(const QRect &rect)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void repaint(const QRegion &rgn)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void resize(const QSize &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void resize(int w, int h)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool restoreGeometry(const QByteArray &geometry)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QByteArray saveGeometry() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void scroll(int dx, int dy)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void scroll(int dx, int dy, const QRect &r)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setAcceptDrops(bool on)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setAccessibleDescription(const QString &description)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setAccessibleName(const QString &name)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setAttribute(Qt::WidgetAttribute attribute, bool on = true)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setAutoFillBackground(bool enabled)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setBackgroundRole(QPalette::ColorRole role)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setBaseSize(const QSize &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setBaseSize(int basew, int baseh)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setContentsMargins(int left, int top, int right, int bottom)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setContentsMargins(const QMargins &margins)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setContextMenuPolicy(Qt::ContextMenuPolicy policy)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setCursor(const QCursor &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setEditFocus(bool enable)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFixedHeight(int h)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFixedSize(const QSize &s)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFixedSize(int w, int h)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFixedWidth(int w)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFocus(Qt::FocusReason reason)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFocusPolicy(Qt::FocusPolicy policy)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFocusProxy(QWidget* w)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFont(const QFont &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setForegroundRole(QPalette::ColorRole role)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setGeometry(const QRect &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setGeometry(int x, int y, int w, int h)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setGraphicsEffect(QGraphicsEffect* effect)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setInputMethodHints(Qt::InputMethodHints hints)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setLayout(QLayout* layout)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setLayoutDirection(Qt::LayoutDirection direction)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setLocale(const QLocale &locale)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMask(const QBitmap &bitmap)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMask(const QRegion &region)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMaximumHeight(int maxh)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMaximumSize(const QSize &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMaximumSize(int maxw, int maxh)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMaximumWidth(int maxw)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMinimumHeight(int minh)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMinimumSize(const QSize &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMinimumSize(int minw, int minh)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMinimumWidth(int minw)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setMouseTracking(bool enable)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setPalette(const QPalette &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setParent(QWidget* parent)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setParent(QWidget* parent, Qt::WindowFlags f)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setShortcutAutoRepeat(int id, bool enable = true)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setShortcutEnabled(int id, bool enable = true)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setSizeIncrement(const QSize &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setSizeIncrement(int w, int h)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setSizePolicy(QSizePolicy)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setSizePolicy(QSizePolicy::Policy horizontal, QSizePolicy::Policy vertical)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setStatusTip(const QString &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setStyle(QStyle* style)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setTabletTracking(bool enable)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setToolTip(const QString &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setToolTipDuration(int msec)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setUpdatesEnabled(bool enable)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWhatsThis(const QString &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowFilePath(const QString &filePath)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowFlag(Qt::WindowType flag, bool on = true)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowFlags(Qt::WindowFlags type)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowIcon(const QIcon &icon)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowModality(Qt::WindowModality windowModality)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowOpacity(qreal level)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowRole(const QString &role)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowState(Qt::WindowStates windowState)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setupUi(QWidget* widget)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QSize size() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual QSize sizeHint() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QSize sizeIncrement() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QSizePolicy sizePolicy() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void stackUnder(QWidget* w)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString statusTip() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QStyle* style() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString styleSheet() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool testAttribute(Qt::WidgetAttribute attribute) const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString toolTip() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int toolTipDuration() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool underMouse() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void ungrabGesture(Qt::GestureType gesture)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void unsetCursor()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void unsetLayoutDirection()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void unsetLocale()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void update(int x, int y, int w, int h)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void update(const QRect &rect)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void update(const QRegion &rgn)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void updateGeometry()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool updatesEnabled() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QRegion visibleRegion() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString whatsThis() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int width() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `WId winId() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* window() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString windowFilePath() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Qt::WindowFlags windowFlags() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWindow* windowHandle() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QIcon windowIcon() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Qt::WindowModality windowModality() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `qreal windowOpacity() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString windowRole() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Qt::WindowStates windowState() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QString windowTitle() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `Qt::WindowType windowType() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int x() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `int y() const`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
# `Reimplemented Public Functions`
###### `virtual QPaintEngine* paintEngine() const override`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
# `Public Slots`
###### `bool close()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void hide()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void lower()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void raise()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void repaint()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setDisabled(bool disable)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setEnabled(bool)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setFocus()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setHidden(bool hidden)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setStyleSheet(const QString &styleSheet)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void setVisible(bool visible)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowModified(bool)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setWindowTitle(const QString &)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void show()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void showFullScreen()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void showMaximized()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void showMinimized()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void showNormal()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void update()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
# `Static Public Members`
###### `QWidget* createWindowContainer(QWindow* window, QWidget* parent = nullptr, Qt::WindowFlags flags = Qt::WindowFlags())`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* find(WId id)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* keyboardGrabber()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `QWidget* mouseGrabber()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void setTabOrder(QWidget* first, QWidget* second)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `const QMetaObject staticMetaObject`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
# `Protected Functions`
###### `virtual void actionEvent(QActionEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void changeEvent(QEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void closeEvent(QCloseEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void contextMenuEvent(QContextMenuEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void create(WId window = 0, bool initializeWindow = true, bool destroyOldWindow = true)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void destroy(bool destroyWindow = true, bool destroySubWindows = true)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void dragEnterEvent(QDragEnterEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void dragLeaveEvent(QDragLeaveEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void dragMoveEvent(QDragMoveEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void dropEvent(QDropEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void enterEvent(QEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void focusInEvent(QFocusEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool focusNextChild()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual bool focusNextPrevChild(bool next)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void focusOutEvent(QFocusEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `bool focusPreviousChild()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void hideEvent(QHideEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void inputMethodEvent(QInputMethodEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void keyPressEvent(QKeyEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void keyReleaseEvent(QKeyEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void leaveEvent(QEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void mouseDoubleClickEvent(QMouseEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void mouseMoveEvent(QMouseEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void mousePressEvent(QMouseEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void mouseReleaseEvent(QMouseEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void moveEvent(QMoveEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual bool nativeEvent(const QByteArray &eventType, void* message, long* result)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void paintEvent(QPaintEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void resizeEvent(QResizeEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void showEvent(QShowEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void tabletEvent(QTabletEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void wheelEvent(QWheelEvent* event)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
# `Reimplemented Protected Functions`
###### `virtual bool event(QEvent* event) override`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual void initPainter(QPainter* painter) const override`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `virtual int metric(QPaintDevice::PaintDeviceMetric m) const override`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
# `Protected Slots`
###### `void updateMicroFocus()`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
# `Signals`
###### `void customContextMenuRequested(const QPoint &pos)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void windowIconChanged(const QIcon &icon)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `void windowTitleChanged(const QString &title)`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`

# `Macros`
###### `QWIDGETSIZE_MAX`