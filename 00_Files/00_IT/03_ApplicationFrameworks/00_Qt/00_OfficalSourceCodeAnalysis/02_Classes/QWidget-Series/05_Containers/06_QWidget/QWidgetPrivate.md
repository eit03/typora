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
class Q_WIDGETS_EXPORT QWidgetPrivate : public QObjectPrivate
{
///> 0. Prepare
public:
    enum DrawWidgetFlags {
        DrawAsRoot = 0x01,
        DrawPaintOnScreen = 0x02,
        DrawRecursive = 0x04,
        DrawInvisible = 0x08,
        DontSubtractOpaqueChildren = 0x10,
        DontDrawOpaqueChildren = 0x20,
        DontDrawNativeChildren = 0x40,
        DontSetCompositionMode = 0x80
    };

    enum CloseMode {
        CloseNoEvent,
        CloseWithEvent,
        CloseWithSpontaneousEvent
    };

    enum Direction {
        DirectionNorth = 0x01,
        DirectionEast = 0x10,
        DirectionSouth = 0x02,
        DirectionWest = 0x20
    };

///> 1. Properties
public:
    // Regular pointers (keep them together to avoid gaps
    // on 64 bit architectures).
    QWExtra*                                    extra;
    QWidget*                                    focus_next;
    QWidget*                                    focus_prev;
    QWidget*                                    focus_child;
    QLayout*                                    layout;
    QRegion*                                    needsFlush;
    QPaintDevice*                               redirectDev;
    QWidgetItemV2*                              widgetItem;
    QPaintEngine*                               extraPaintEngine;
    mutable const QMetaObject*                  polished;
    QGraphicsEffect*                            graphicsEffect;
    // All widgets are added into the allWidgets set. Once
    // they receive a window id they are also added to the mapper.
    // This should just ensure that all widgets are deleted by QApplication
    static QWidgetMapper*                       mapper;
    static QWidgetSet*                          allWidgets;
#if !defined(QT_NO_IM)
    Qt::InputMethodHints                        imHints;
#endif
#ifdef QT_KEYPAD_NAVIGATION
    static QPointer<QWidget>                    editingWidget;
#endif

    // Implicit pointers (shared_null/shared_empty).
    QRegion                                     opaqueChildren;
    QRegion                                     dirty;
#ifndef QT_NO_TOOLTIP
    QString                                     toolTip;
    int                                         toolTipDuration;
#endif
#if QT_CONFIG(statustip)
    QString                                     statusTip;
#endif
#if QT_CONFIG(whatsthis)
    QString                                     whatsThis;
#endif
#ifndef QT_NO_ACCESSIBILITY
    QString                                     accessibleName;
    QString                                     accessibleDescription;
#endif

    // Other variables.
    uint                                        inheritedFontResolveMask;
    uint                                        inheritedPaletteResolveMask;
    short                                       leftmargin;
    short                                       topmargin;
    short                                       rightmargin;
    short                                       bottommargin;
    signed char                                 leftLayoutItemMargin;
    signed char                                 topLayoutItemMargin;
    signed char                                 rightLayoutItemMargin;
    signed char                                 bottomLayoutItemMargin;
    // Current number of widget instances
    static int                                  instanceCounter;
    // Maximum number of widget instances
    static int                                  maxInstances;
    Qt::HANDLE                                  hd;
    QWidgetData                                 data;
    QSizePolicy                                 size_policy;
    QLocale                                     locale;
    QPoint                                      redirectOffset;
#ifndef QT_NO_ACTION
    QList<QAction*>                             actions;
#endif
#ifndef QT_NO_GESTURES
    QMap<Qt::GestureType, Qt::GestureFlags>     gestureContext;
#endif

    // Bit fields.
    // the low ones are in w->data->widget_attributes
    uint                                        high_attributes[4];
    QPalette::ColorRole                         fg_role : 8;
    QPalette::ColorRole                         bg_role : 8;
    uint                                        dirtyOpaqueChildren : 1;
    uint                                        isOpaque : 1;
    uint                                        retainSizeWhenHiddenChanged : 1;
    uint                                        inDirtyList : 1;
    uint                                        isScrolled : 1;
    uint                                        isMoved : 1;
    uint                                        usesDoubleBufferedGLContext : 1;
    uint                                        mustHaveWindowHandle : 1;
    uint                                        renderToTexture : 1;
    uint                                        textureChildSeen : 1;
#ifndef QT_NO_IM
    uint                                        inheritsInputMethodHints : 1;
#endif
#ifndef QT_NO_OPENGL
    uint                                        renderToTextureReallyDirty : 1;
    uint                                        renderToTextureComposeActive : 1;
#endif
    uint                                        childrenHiddenByWState : 1;
    uint                                        childrenShownByExpose : 1;

    // *************************** Platform specific **************************
#if defined(Q_OS_WIN)
    // see qwidget.cpp ::paintEngine()
    uint                                        noPaintOnScreen : 1;
#endif

///> 2. Constructor
public:
    explicit QWidgetPrivate(int version = QObjectPrivateVersion);
    ~QWidgetPrivate();

///> 3. Functions
}
```
## `Constructor`
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
{
    if (Q_UNLIKELY(!qApp)) {
        qFatal("QWidget: Must construct a QApplication before a QWidget");
        return;
    }

#ifdef QT_BUILD_INTERNAL
    // Don't check the version parameter in internal builds.
    // This allows incompatible versions to be loaded, possibly for testing.
    Q_UNUSED(version);
#else
    if (Q_UNLIKELY(version != QObjectPrivateVersion))
        qFatal("Cannot mix incompatible Qt library "
               "(version 0x%x) with this library (version 0x%x)",
                version, QObjectPrivateVersion);
#endif

    isWidget = true;
    memset(high_attributes, 0, sizeof(high_attributes));
#if 0 // Used to be included in Qt4 for Q_WS_MAC
    drawRectOriginalAdded = false;
    originalDrawMethod = true;
    changeMethods = false;
    isInUnifiedToolbar = false;
    unifiedSurface = 0;
    toolbar_ancestor = 0;
    flushRequested = false;
    touchEventsEnabled = false;
#endif
#ifdef QWIDGET_EXTRA_DEBUG
    static int count = 0;
    qDebug() << "widgets" << ++count;
#endif
}
```
```
QWidgetPrivate::~QWidgetPrivate()
{
    if (widgetItem)
        widgetItem->wid = 0;

    if (extra)
        deleteExtra();
}
```
## `Memory Model`

```
[QObjectPrivate]              QObjectPrivate
extra                         QWExtra *
focus_next                    QWidget *
focus_prev                    QWidget *
focus_child                   QWidget *
layout                        QLayout *
needsFlush                    QRegion *
redirectDev                   QPaintDevice *
widgetItem                    QWidgetItemV2 *
extraPaintEngine              QPaintEngine *
polished                      const QMetaObject *
graphicsEffect                QGraphicsEffect *
imHints                       QFlags<enum Qt::InputMethodHint>
opaqueChildren                QRegion
dirty                         QRegion
toolTip                       QString
toolTipDuration               int
statusTip                     QString
whatsThis                     QString
accessibleName                QString
accessibleDescription         QString
inheritedFontResolveMask      unsigned int
inheritedPaletteResolveMask   unsigned int
leftmargin                    short
topmargin                     short
rightmargin                   short
bottommargin                  short
leftLayoutItemMargin          char
topLayoutItemMargin           char
rightLayoutItemMargin         char
bottomLayoutItemMargin        char
hd                            void *
data                          QWidgetData
size_policy                   QSizePolicy
locale                        QLocale
redirectOffset                QPoint
actions                       QList<QAction *>
gestureContext        QMap<enum Qt::GestureType,QFlags<enum Qt::GestureFlag> >
high_attributes               unsigned int[4]
fg_role                       QPalette::ColorRole
bg_role                       QPalette::ColorRole
dirtyOpaqueChildren           unsigned int
isOpaque                      unsigned int
retainSizeWhenHiddenChanged   unsigned int
inDirtyList                   unsigned int
isScrolled                    unsigned int
isMoved                       unsigned int
usesDoubleBufferedGLContext   unsigned int
mustHaveWindowHandle          unsigned int
renderToTexture               unsigned int
textureChildSeen              unsigned int
inheritsInputMethodHints      unsigned int
renderToTextureReallyDirty    unsigned int
renderToTextureComposeActive  unsigned int
childrenHiddenByWState        unsigned int
childrenShownByExpose         unsigned int
noPaintOnScreen               unsigned int
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