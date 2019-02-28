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
///> 2. Constructor
///> 3. Functions
}
```
## `Constructor`
```

```
## `Memory Model`
```

```
# `Properties`
###### `acceptDrops : bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `accessibleDescription : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `accessibleName : QString`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `autoFillBackground : bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `baseSize : QSize`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `childrenRect : const QRect`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `childrenRegion : const QRegion`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `contextMenuPolicy : Qt::ContextMenuPolicy`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `cursor : QCursor`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `enabled : bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `focus : const bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `focusPolicy : Qt::FocusPolicy`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `font : QFont`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `frameGeometry : const QRect`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `frameSize : const QSize`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `fullScreen : const bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `geometry : QRect`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
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
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `isActiveWindow : const bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `layoutDirection : Qt::LayoutDirection`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `locale : QLocale`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
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
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `mouseTracking : bool`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
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
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
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
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
`Eg 0:`
###### `windowOpacity : double`
`Interpretation:`
`StorePosition:`
`Defualt:`
`Access:`
`Remark:`
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