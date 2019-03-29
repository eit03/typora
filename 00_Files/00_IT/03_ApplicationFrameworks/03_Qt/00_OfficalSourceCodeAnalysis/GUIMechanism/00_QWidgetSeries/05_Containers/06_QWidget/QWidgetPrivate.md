***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QObjectPrivate
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

```
class Q_WIDGETS_EXPORT QWidgetPrivate : public QObjectPrivate
{
    // Regular pointers (keep them together to avoid gaps on 64 bit architectures).
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
    QWidgetData data; //=================================================================
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
#endif
}
```

```
QWidgetPrivate::QWidgetPrivate(int version)
    : QObjectPrivate(version)
      , extra(0)
      , focus_next(0)
      , focus_prev(0)
      , focus_child(0)
      , layout(0)
      , needsFlush(0)
      , redirectDev(0)
      , widgetItem(0)
      , extraPaintEngine(0)
      , polished(0)
      , graphicsEffect(0)
#if !defined(QT_NO_IM)
      , imHints(Qt::ImhNone)
#endif
#ifndef QT_NO_TOOLTIP
      , toolTipDuration(-1)
#endif
      , inheritedFontResolveMask(0)
      , inheritedPaletteResolveMask(0)
      , leftmargin(0)
      , topmargin(0)
      , rightmargin(0)
      , bottommargin(0)
      , leftLayoutItemMargin(0)
      , topLayoutItemMargin(0)
      , rightLayoutItemMargin(0)
      , bottomLayoutItemMargin(0)
      , hd(0)
      , size_policy(QSizePolicy::Preferred, QSizePolicy::Preferred)
      , fg_role(QPalette::NoRole)
      , bg_role(QPalette::NoRole)
      , dirtyOpaqueChildren(1)
      , isOpaque(0)
      , retainSizeWhenHiddenChanged(0)
      , inDirtyList(0)
      , isScrolled(0)
      , isMoved(0)
      , usesDoubleBufferedGLContext(0)
      , mustHaveWindowHandle(0)
      , renderToTexture(0)
      , textureChildSeen(0)
#ifndef QT_NO_IM
      , inheritsInputMethodHints(0)
#endif
#ifndef QT_NO_OPENGL
      , renderToTextureReallyDirty(1)
      , renderToTextureComposeActive(0)
#endif
      , childrenHiddenByWState(0)
      , childrenShownByExpose(0)
#if defined(Q_OS_WIN)
      , noPaintOnScreen(0)
#endif
#if 0 // Used to be included in Qt4 for Q_WS_X11
      , picture(0)
#elif 0 // Used to be included in Qt4 for Q_WS_WIN
  #ifndef QT_NO_GESTURES
      , nativeGesturePanEnabled(0)
  #endif
#elif 0 // Used to be included in Qt4 for Q_WS_MAC
      , needWindowChange(0)
      , window_event(0)
      , qd_hd(0)
#endif
{}
```

```
[QWidgetPrivate]
    [QObjectPrivate]
    // Regular pointers (keep them together to avoid gaps on 64 bit architectures).
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
    QWidgetData data; //=================================================================
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
#endif
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
