***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` []

***
[TOC]
***


# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_WIDGETS_EXPORT QWidgetPrivate : public QObjectPrivate
{
//Prepare *** *** *** *** *** *** *** *** *** *** *** ***

//Properties *** *** *** *** *** *** *** *** *** *** *** ***
public:
    QWExtra *extra;
    QWidget *focus_next;
    QWidget *focus_prev;
    QWidget *focus_child;
    QLayout *layout;
    QRegion *needsFlush;
    QPaintDevice *redirectDev;
    QWidgetItemV2 *widgetItem;
    QPaintEngine *extraPaintEngine;
    mutable const QMetaObject *polished;
    QGraphicsEffect *graphicsEffect;
    // All widgets are added into the allWidgets set. Once
    // they receive a window id they are also added to the mapper.
    // This should just ensure that all widgets are deleted by QApplication
    static QWidgetMapper *mapper;
    static QWidgetSet *allWidgets;
#if !defined(QT_NO_IM)
    Qt::InputMethodHints imHints;
#endif
#ifdef QT_KEYPAD_NAVIGATION
    static QPointer<QWidget> editingWidget;
#endif

    // Implicit pointers (shared_null/shared_empty).
    QRegion opaqueChildren;
    QRegion dirty;
#ifndef QT_NO_TOOLTIP
    QString toolTip;
    int toolTipDuration;
#endif
#if QT_CONFIG(statustip)
    QString statusTip;
#endif
#if QT_CONFIG(whatsthis)
    QString whatsThis;
#endif
#ifndef QT_NO_ACCESSIBILITY
    QString accessibleName;
    QString accessibleDescription;
#endif

    // Other variables.
    uint inheritedFontResolveMask;
    uint inheritedPaletteResolveMask;
    short leftmargin;
    short topmargin;
    short rightmargin;
    short bottommargin;
    signed char leftLayoutItemMargin;
    signed char topLayoutItemMargin;
    signed char rightLayoutItemMargin;
    signed char bottomLayoutItemMargin;
    static int instanceCounter; // Current number of widget instances
    static int maxInstances; // Maximum number of widget instances
    Qt::HANDLE hd;
    QWidgetData data;
    QSizePolicy size_policy;
    QLocale locale;
    QPoint redirectOffset;
#ifndef QT_NO_ACTION
    QList<QAction*> actions;
#endif
#ifndef QT_NO_GESTURES
    QMap<Qt::GestureType, Qt::GestureFlags> gestureContext;
#endif

    // Bit fields.
    uint high_attributes[4]; // the low ones are in QWidget::widget_attributes
    QPalette::ColorRole fg_role : 8;
    QPalette::ColorRole bg_role : 8;
    uint dirtyOpaqueChildren : 1;
    uint isOpaque : 1;
    uint retainSizeWhenHiddenChanged : 1;
    uint inDirtyList : 1;
    uint isScrolled : 1;
    uint isMoved : 1;
    uint usesDoubleBufferedGLContext : 1;
    uint mustHaveWindowHandle : 1;
    uint renderToTexture : 1;
    uint textureChildSeen : 1;
#ifndef QT_NO_IM
    uint inheritsInputMethodHints : 1;
#endif
#ifndef QT_NO_OPENGL
    uint renderToTextureReallyDirty : 1;
    uint renderToTextureComposeActive : 1;
#endif
    uint childrenHiddenByWState : 1;
    uint childrenShownByExpose : 1;

    // *************************** Platform specific ************************************
#if defined(Q_OS_WIN)
    uint noPaintOnScreen : 1; // see qwidget.cpp ::paintEngine()
    
    
//Constructor *** *** *** *** *** *** *** *** *** *** *** ***
public:
    explicit QWidgetPrivate(int version = QObjectPrivateVersion);
    ~QWidgetPrivate();
    
    
//Functions *** *** *** *** *** *** *** *** *** *** *** ***
}
```

## `Construtor`
```

```
## `Memeory Model`
```
[QWidgetPrivate]
    [QObjectPrivate]
    QWExtra *extra;
    QWidget *focus_next;
    QWidget *focus_prev;
    QWidget *focus_child;
    QLayout *layout;
    QRegion *needsFlush;
    QPaintDevice *redirectDev;
    QWidgetItemV2 *widgetItem;
    QPaintEngine *extraPaintEngine;
    mutable const QMetaObject *polished;
    QGraphicsEffect *graphicsEffect;
    // All widgets are added into the allWidgets set. Once
    // they receive a window id they are also added to the mapper.
    // This should just ensure that all widgets are deleted by QApplication
    static QWidgetMapper *mapper;
    static QWidgetSet *allWidgets;
#if !defined(QT_NO_IM)
    Qt::InputMethodHints imHints;
#endif
#ifdef QT_KEYPAD_NAVIGATION
    static QPointer<QWidget> editingWidget;
#endif

    // Implicit pointers (shared_null/shared_empty).
    QRegion opaqueChildren;
    QRegion dirty;
#ifndef QT_NO_TOOLTIP
    QString toolTip;
    int toolTipDuration;
#endif
#if QT_CONFIG(statustip)
    QString statusTip;
#endif
#if QT_CONFIG(whatsthis)
    QString whatsThis;
#endif
#ifndef QT_NO_ACCESSIBILITY
    QString accessibleName;
    QString accessibleDescription;
#endif

    // Other variables.
    uint inheritedFontResolveMask;
    uint inheritedPaletteResolveMask;
    short leftmargin;
    short topmargin;
    short rightmargin;
    short bottommargin;
    signed char leftLayoutItemMargin;
    signed char topLayoutItemMargin;
    signed char rightLayoutItemMargin;
    signed char bottomLayoutItemMargin;
    static int instanceCounter; // Current number of widget instances
    static int maxInstances; // Maximum number of widget instances
    Qt::HANDLE hd;
    QWidgetData data;
    QSizePolicy size_policy;
    QLocale locale;
    QPoint redirectOffset;
#ifndef QT_NO_ACTION
    QList<QAction*> actions;
#endif
#ifndef QT_NO_GESTURES
    QMap<Qt::GestureType, Qt::GestureFlags> gestureContext;
#endif

    // Bit fields.
    uint high_attributes[4]; // the low ones are in QWidget::widget_attributes
    QPalette::ColorRole fg_role : 8;
    QPalette::ColorRole bg_role : 8;
    uint dirtyOpaqueChildren : 1;
    uint isOpaque : 1;
    uint retainSizeWhenHiddenChanged : 1;
    uint inDirtyList : 1;
    uint isScrolled : 1;
    uint isMoved : 1;
    uint usesDoubleBufferedGLContext : 1;
    uint mustHaveWindowHandle : 1;
    uint renderToTexture : 1;
    uint textureChildSeen : 1;
#ifndef QT_NO_IM
    uint inheritsInputMethodHints : 1;
#endif
#ifndef QT_NO_OPENGL
    uint renderToTextureReallyDirty : 1;
    uint renderToTextureComposeActive : 1;
#endif
    uint childrenHiddenByWState : 1;
    uint childrenShownByExpose : 1;

    // *************************** Platform specific ************************************
#if defined(Q_OS_WIN)
    uint noPaintOnScreen : 1; // see qwidget.cpp ::paintEngine()
```

# `Properties`

# `Public Types`
# `Public Functions`
# `Reimplemented Public Functions`
# `Public Slots`

# `Static Public Members`

# `Protected Types`
# `Protected Functions`
# `Reimplemented Protected Functions`
# `Protected Slots`
# `staitc Protected Members`

# `Private Types`
# `Private Functions`
# `Private Slots`
# `Static Private Members`

# `Signals`
# `Related Non-Members`
# `Macros`
