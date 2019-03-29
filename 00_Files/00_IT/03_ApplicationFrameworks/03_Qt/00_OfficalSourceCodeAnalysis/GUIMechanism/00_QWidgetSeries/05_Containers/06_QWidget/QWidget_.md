***
`Version:` 5.11
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
## `Constructor`
## `Memory Model`



# `Properties`

###### `acceptDrops : bool`

`Describe:`

该属性保存着该部件是否启用拖拽事件.

如果为真,则向系统宣布:部件可能可以接受拖拽事件.

`Default:` 

false.

`Access:`

bool acceptDrops() const;

void setAcceptDrops(bool on);

`Warning:` 

在拖拽事件处理器中,不要修改这个属性.

如果部件是桌面(WindowType()==Qt::Desktop),当某个程序在使用桌面,拖拽可能会失败;如果发生这种情况,你可以调用acceptDrops()函数去测试.

`Remark:`

`Usage:`





###### `accessibleDescription : QString`

`Describe:`

该属性保存着辅助技术所看到的部件描述.

部件的辅助描述应该传达小部件的功能描述.

`Default:`

`Access:`

`Warning:` 

`Remark:`

`Usage:`

###### `accessibleName : QString`

###### `autoFillBackground : bool`
###### `baseSize : QSize`

###### `childrenRect : const QRect`

`Describe:`

该属性保存着子部件在父部件中的组合矩形(相对于客户区).

隐藏的子部件排除在外.

`Default:` 

0.

`Access:`

QRect childrenRect() const;

`Warning:` 

`Remark:`

`Usage:`

###### `childrenRegion : const QRegion`

`Describe:`

该属性保存着子部件在父部件中的组合矩形(相对于客户区).

隐藏的子部件排除在外.

`Default:` 

0.

`Access:`

QRegion childrenRegion() const;

`Warning:` 

`Remark:`

`Usage:`

###### `contextMenuPolicy : Qt::ContextMenuPolicy`
###### `cursor : QCursor`

`Describe:`

该属性保存着部件的鼠标形状.

当鼠标光标在该部件上,它会设置光标为这个形状.

如果没有设置光标,或取消光标,父部件光标被使用.

`Default:` 

Qt::ArrowCursor.

`Access:`

QCursor cursor() const;
void setCursor(const QCursor &);
void unsetCursor();

`Warning:` 

设置光标不一定能成功;比如,设置非输入部件的光标为工字形光标.

`Remark:`

`Usage:`

```
setCursor(Qt::CrossCursor);
```

###### `enabled : bool`

`Describe:`

此属性保存小部件是否启用。.

通常,启用的小部件处理键盘和鼠标事件;禁用的小部件不会.

有些小部件在禁用时的显示方式不同.例如,一个按钮可能会把标签涂成灰色.如果您的小部件需要知道何时启用或禁用它,您可以使用changeEvent().类型为QEvent:EnabledChange. 

禁用部件将隐式禁用所有其子部件.启用部件将分别启用所有非禁用子部件.

`Default:` 

true.

`Access:`

bool isEnabled() const;
void setEnabled(bool);

`Warning:` 

`Remark:`

`Usage:`

###### `focus : const bool`

`Describe:`

此属性包含此小部件(或其焦点代理)是否具有键盘输入焦点.

获取部件该属性的值,实际上相当于检查QApplication::focusWidget()是否指该部件.

`Default:` 

false.

`Access:`

bool hasFocus() const;

`Warning:` 

`Remark:`

`Usage:`

###### `focusPolicy : Qt::FocusPolicy`

`Describe:`

此属性保存小部件接受键盘焦点的方式.

详见enum Qt::FocusPolicy.

`Default:` 

false.

`Access:`

Qt::FocusPolicy focusPolicy() const;
void setFocusPolicy(Qt::FocusPolicy policy);

`Warning:` 

如果小部件处理键盘事件,则必须启用键盘焦点.

`Remark:`

`Usage:`

###### `font : QFont`

###### `frameGeometry : const QRect`
###### `frameSize : const QSize`
###### `fullScreen : const bool`
###### `geometry : QRect`
###### `height : const int`

###### `inputMethodHints : Qt::InputMethodHints`
###### `isActiveWindow : const bool`
###### `layoutDirection : Qt::LayoutDirection`
###### `locale : QLocale`
###### `maximized : const bool`
###### `maximumHeight : int`
###### `maximumSize : QSize`
###### `maximumWidth : int`
###### `minimized : const bool`
###### `minimumHeight : int`
###### `minimumSize : QSize`
###### `minimumSizeHint : const QSize`
###### `minimumWidth : int`
###### `modal : const bool`
###### `mouseTracking : bool`
###### `normalGeometry : const QRect`
###### `palette : QPalette`
###### `pos : QPoint`
###### `rect : const QRect`
###### `size : QSize`
###### `sizeHint : const QSize`
###### `sizeIncrement : QSize`
###### `sizePolicy : QSizePolicy`
###### `statusTip : QString`
###### `styleSheet : QString`
###### `tabletTracking : bool`
###### `toolTip : QString`
###### `toolTipDuration : int`
###### `updatesEnabled : bool`
###### `visible : bool`
###### `whatsThis : QString`
###### `width : const int`
###### `windowFilePath : QString`



###### `windowFlags : Qt::WindowFlags`

`Describe:`

该属性保存部件的显示属性.

它是==enum Qt::WindowType==的任意组合.

==Qt::Window==与==Qt::Dialog==指明是窗口(window),它的父部件是桌面.

`Default:` 

`Access:`
Qt::WindowFlags	windowFlags() const;
void setWindowFlags(Qt::WindowFlags type);

`Warning:` 

如果是一个窗口(window),你调用函数setParent()函数,让其父为非桌面后,它会被隐藏,应该调用show()函数显示.

`Remark:`

Main Type:

| Constant            | Value                 | Description                                                  |
| ------------------- | --------------------- | ------------------------------------------------------------ |
| `Qt::Widget`        | `0x00000000`          | This is the default type for [QWidget](http://doc.qt.io/qt-5/qwidget.html). Widgets of this type are child widgets if they have a parent, and independent windows if they have no parent. See also Qt::Window and Qt::SubWindow.<br /><br />QWidget类默认使用这个类型.如果它有父,这个部件是个子部件;如果它没有父,这个部件是个独立的窗口.详见==Qt::Window==与==Qt::SubWindow==. |
| `Qt::Window`        | `0x00000001`          | Indicates that the widget is a window, usually with a window system frame and a title bar, irrespective of whether the widget has a parent or not. Note that it is not possible to unset this flag if the widget does not have a parent.<br /><br />表明部件是一个窗口,它通常带有系统框架窗口与标题栏,不管是否有父.注意,如果该部件没有父, |
| `Qt::Dialog`        | `0x00000002 | Window` | Indicates that the widget is a window that should be decorated as a dialog (i.e., typically no maximize or minimize buttons in the title bar). This is the default type for [QDialog](http://doc.qt.io/qt-5/qdialog.html). If you want to use it as a modal dialog, it should be launched from another window, or have a parent and used with the [QWidget::windowModality](http://doc.qt.io/qt-5/qwidget.html#windowModality-prop) property. If you make it modal, the dialog will prevent other top-level windows in the application from getting any input. We refer to a top-level window that has a parent as a *secondary* window. |
| `Qt::Sheet`         | `0x00000004 | Window` | Indicates that the window is a sheet on [macOS](http://doc.qt.io/qt-5/internationalization.html#macos). Since using a sheet implies window modality, the recommended way is to use [QWidget::setWindowModality](http://doc.qt.io/qt-5/qwidget.html#windowModality-prop)(), or [QDialog::open](http://doc.qt.io/qt-5/qdialog.html#open)(), instead. |
| `Qt::Drawer`        | `Sheet | Dialog`      | Indicates that the widget is a drawer on [macOS](http://doc.qt.io/qt-5/internationalization.html#macos). |
| `Qt::Popup`         | `0x00000008 | Window` | Indicates that the widget is a pop-up top-level window, i.e. that it is modal, but has a window system frame appropriate for pop-up menus. |
| `Qt::Tool`          | `Popup | Dialog`      | Indicates that the widget is a tool window. A tool window is often a small window with a smaller than usual title bar and decoration, typically used for collections of tool buttons. If there is a parent, the tool window will always be kept on top of it. If there isn't a parent, you may consider using Qt::WindowStaysOnTopHint as well. If the window system supports it, a tool window can be decorated with a somewhat lighter frame. It can also be combined with Qt::FramelessWindowHint. On [macOS](http://doc.qt.io/qt-5/internationalization.html#macos), tool windows correspond to the [NSPanel](https://developer.apple.com/documentation/appkit/nspanel) class of windows. This means that the window lives on a level above normal windows making it impossible to put a normal window on top of it. By default, tool windows will disappear when the application is inactive. This can be controlled by the [Qt::WA_MacAlwaysShowToolWindow](http://doc.qt.io/qt-5/qt.html#WidgetAttribute-enum) attribute. |
| `Qt::ToolTip`       | `Popup | Sheet`       | Indicates that the widget is a tooltip. This is used internally to implement [tooltips](http://doc.qt.io/qt-5/qwidget.html#toolTip-prop). |
| `Qt::SplashScreen`  | `ToolTip | Dialog`    | Indicates that the window is a splash screen. This is the default type for [QSplashScreen](http://doc.qt.io/qt-5/qsplashscreen.html). |
| `Qt::Desktop`       | `0x00000010 | Window` | Indicates that this widget is the desktop. This is the type for QDesktopWidget. |
| `Qt::SubWindow`     | `0x00000012`          | Indicates that this widget is a sub-window, such as a [QMdiSubWindow](http://doc.qt.io/qt-5/qmdisubwindow.html) widget. |
| `Qt::ForeignWindow` | `0x00000020 | Window` | Indicates that this window object is a handle representing a native platform window created by another process or by manually using native code. |
| `Qt::CoverWindow`   | `0x00000040 | Window` | Indicates that the window represents a cover window, which is shown when the application is minimized on some platforms. |

`Usage:`



###### `windowIcon : QIcon`

###### `windowModality : Qt::WindowModality`
###### `windowModified : bool`
###### `windowOpacity : double`
###### `windowTitle : QString`
###### `x : const int`
###### `y : const int`



# `Public Types`
###### `enum RenderFlag { DrawWindowBackground, DrawChildren, IgnoreMask }`
###### `flags RenderFlags`



# `Public Functions`
###### `QWidget(QWidget* parent = nullptr, Qt::WindowFlags f = ...)`
###### `virtual ~QWidget()`
###### `bool acceptDrops() const`
###### `QString accessibleDescription() const`
###### `QString accessibleName() const`
###### `QList<QAction*> actions() const`
###### `void activateWindow()`
###### `void addAction(QAction* action)`
###### `void addActions(QList<QAction*> actions)`
###### `void adjustSize()`
###### `bool autoFillBackground() const`
###### `QPalette::ColorRole backgroundRole() const`
###### `QBackingStore* backingStore() const`
###### `QSize baseSize() const`
###### `QWidget* childAt(int x, int y) const`
###### `QWidget* childAt(const QPoint &p) const`
###### `QRect childrenRect() const`
###### `QRegion childrenRegion() const`
###### `void clearFocus()`
###### `void clearMask()`
###### `QMargins contentsMargins() const`
###### `QRect contentsRect() const`
###### `Qt::ContextMenuPolicy contextMenuPolicy() const`
###### `QCursor cursor() const`
###### `WId effectiveWinId() const`
###### `void ensurePolished() const`
###### `Qt::FocusPolicy focusPolicy() const`
###### `QWidget* focusProxy() const`
###### `QWidget* focusWidget() const`
###### `const QFont & font() const`
###### `QFontInfo fontInfo() const`
###### `QFontMetrics fontMetrics() const`
###### `QPalette::ColorRole foregroundRole() const`
###### `QRect frameGeometry() const`
###### `QSize frameSize() const`
###### `const QRect & geometry() const`
###### `void getContentsMargins(int* left, int* top, int* right, int* bottom) const`
###### `QPixmap grab(const QRect &rectangle = QRect(QPoint(0, 0), QSize(-1, -1)))`
###### `void grabGesture(Qt::GestureType gesture, Qt::GestureFlags flags = ...)`
###### `void grabKeyboard()`
###### `void grabMouse()`
###### `void grabMouse(const QCursor &cursor)`
###### `int grabShortcut(const QKeySequence &key, Qt::ShortcutContext context = Qt::WindowShortcut)`
###### `QGraphicsEffect* graphicsEffect() const`
###### `QGraphicsProxyWidget* graphicsProxyWidget() const`
###### `bool hasEditFocus() const`
###### `bool hasFocus() const`
###### `virtual bool hasHeightForWidth() const`
###### `bool hasMouseTracking() const`
###### `bool hasTabletTracking() const`
###### `int height() const`
###### `virtual int heightForWidth(int w) const`
###### `Qt::InputMethodHints inputMethodHints() const`
###### `virtual QVariant inputMethodQuery(Qt::InputMethodQuery query) const`
###### `void insertAction(QAction* before, QAction* action)`
###### `void insertActions(QAction* before, QList<QAction*> actions)`
###### `bool isActiveWindow() const`
###### `bool isAncestorOf(const QWidget* child) const`
###### `bool isEnabled() const`
###### `bool isEnabledTo(const QWidget* ancestor) const`
###### `bool isFullScreen() const`
###### `bool isHidden() const`
###### `bool isMaximized() const`
###### `bool isMinimized() const`
###### `bool isModal() const`
###### `bool isVisible() const`
###### `bool isVisibleTo(const QWidget* ancestor) const`
###### `bool isWindow() const`
###### `bool isWindowModified() const`
###### `QLayout* layout() const`
###### `Qt::LayoutDirection layoutDirection() const`
###### `QLocale locale() const`
###### `QPoint mapFrom(const QWidget* parent, const QPoint &pos) const`
###### `QPoint mapFromGlobal(const QPoint &pos) const`
###### `QPoint mapFromParent(const QPoint &pos) const`
###### `QPoint mapTo(const QWidget* parent, const QPoint &pos) const`
###### `QPoint mapToGlobal(const QPoint &pos) const`
###### `QPoint mapToParent(const QPoint &pos) const`
###### `QRegion mask() const`
###### `int maximumHeight() const`
###### `QSize maximumSize() const`
###### `int maximumWidth() const`
###### `int minimumHeight() const`
###### `QSize minimumSize() const`
###### `virtual QSize minimumSizeHint() const`
###### `int minimumWidth() const`
###### `void move(const QPoint &)`
###### `void move(int x, int y)`
###### `QWidget* nativeParentWidget() const`
###### `QWidget* nextInFocusChain() const`
###### `QRect normalGeometry() const`
###### `void overrideWindowFlags(Qt::WindowFlags flags)`
###### `const QPalette & palette() const`
###### `QWidget* parentWidget() const`
###### `QPoint pos() const`
###### `QWidget* previousInFocusChain() const`
###### `QRect rect() const`
###### `void releaseKeyboard()`
###### `void releaseMouse()`
###### `void releaseShortcut(int id)`
###### `void removeAction(QAction* action)`
###### `void render(QPaintDevice* target, const QPoint &targetOffset = QPoint(), const QRegion &sourceRegion = QRegion(), QWidget::RenderFlags renderFlags = ...)`
###### `void render(QPainter* painter, const QPoint &targetOffset = QPoint(), const QRegion &sourceRegion = QRegion(), QWidget::RenderFlags renderFlags = ...)`
###### `void repaint(int x, int y, int w, int h)`
###### `void repaint(const QRect &rect)`
###### `void repaint(const QRegion &rgn)`
###### `void resize(const QSize &)`
###### `void resize(int w, int h)`
###### `bool restoreGeometry(const QByteArray &geometry)`
###### `QByteArray saveGeometry() const`
###### `void scroll(int dx, int dy)`
###### `void scroll(int dx, int dy, const QRect &r)`
###### `void setAcceptDrops(bool on)`
###### `void setAccessibleDescription(const QString &description)`
###### `void setAccessibleName(const QString &name)`
###### `void setAttribute(Qt::WidgetAttribute attribute, bool on = true)`
###### `void setAutoFillBackground(bool enabled)`
###### `void setBackgroundRole(QPalette::ColorRole role)`
###### `void setBaseSize(const QSize &)`
###### `void setBaseSize(int basew, int baseh)`
###### `void setContentsMargins(int left, int top, int right, int bottom)`
###### `void setContentsMargins(const QMargins &margins)`
###### `void setContextMenuPolicy(Qt::ContextMenuPolicy policy)`
###### `void setCursor(const QCursor &)`
###### `void setEditFocus(bool enable)`
###### `void setFixedHeight(int h)`
###### `void setFixedSize(const QSize &s)`
###### `void setFixedSize(int w, int h)`
###### `void setFixedWidth(int w)`
###### `void setFocus(Qt::FocusReason reason)`
###### `void setFocusPolicy(Qt::FocusPolicy policy)`
###### `void setFocusProxy(QWidget* w)`
###### `void setFont(const QFont &)`
###### `void setForegroundRole(QPalette::ColorRole role)`
###### `void setGeometry(const QRect &)`
###### `void setGeometry(int x, int y, int w, int h)`
###### `void setGraphicsEffect(QGraphicsEffect* effect)`
###### `void setInputMethodHints(Qt::InputMethodHints hints)`
###### `void setLayout(QLayout* layout)`
###### `void setLayoutDirection(Qt::LayoutDirection direction)`
###### `void setLocale(const QLocale &locale)`
###### `void setMask(const QBitmap &bitmap)`
###### `void setMask(const QRegion &region)`
###### `void setMaximumHeight(int maxh)`
###### `void setMaximumSize(const QSize &)`
###### `void setMaximumSize(int maxw, int maxh)`
###### `void setMaximumWidth(int maxw)`
###### `void setMinimumHeight(int minh)`
###### `void setMinimumSize(const QSize &)`
###### `void setMinimumSize(int minw, int minh)`
###### `void setMinimumWidth(int minw)`
###### `void setMouseTracking(bool enable)`
###### `void setPalette(const QPalette &)`
###### `void setParent(QWidget* parent)`
###### `void setParent(QWidget* parent, Qt::WindowFlags f)`
###### `void setShortcutAutoRepeat(int id, bool enable = true)`
###### `void setShortcutEnabled(int id, bool enable = true)`
###### `void setSizeIncrement(const QSize &)`
###### `void setSizeIncrement(int w, int h)`
###### `void setSizePolicy(QSizePolicy)`
###### `void setSizePolicy(QSizePolicy::Policy horizontal, QSizePolicy::Policy vertical)`
###### `void setStatusTip(const QString &)`
###### `void setStyle(QStyle* style)`
###### `void setTabletTracking(bool enable)`
###### `void setToolTip(const QString &)`
###### `void setToolTipDuration(int msec)`
###### `void setUpdatesEnabled(bool enable)`
###### `void setWhatsThis(const QString &)`
###### `void setWindowFilePath(const QString &filePath)`
###### `void setWindowFlag(Qt::WindowType flag, bool on = true)`
###### `void setWindowFlags(Qt::WindowFlags type)`
###### `void setWindowIcon(const QIcon &icon)`
###### `void setWindowModality(Qt::WindowModality windowModality)`
###### `void setWindowOpacity(qreal level)`
###### `void setWindowRole(const QString &role)`
###### `void setWindowState(Qt::WindowStates windowState)`
###### `void setupUi(QWidget* widget)`
###### `QSize size() const`
###### `virtual QSize sizeHint() const`
###### `QSize sizeIncrement() const`
###### `QSizePolicy sizePolicy() const`
###### `void stackUnder(QWidget* w)`
###### `QString statusTip() const`
###### `QStyle* style() const`
###### `QString styleSheet() const`
###### `bool testAttribute(Qt::WidgetAttribute attribute) const`
###### `QString toolTip() const`
###### `int toolTipDuration() const`
###### `bool underMouse() const`
###### `void ungrabGesture(Qt::GestureType gesture)`
###### `void unsetCursor()`
###### `void unsetLayoutDirection()`
###### `void unsetLocale()`
###### `void update(int x, int y, int w, int h)`
###### `void update(const QRect &rect)`
###### `void update(const QRegion &rgn)`
###### `void updateGeometry()`
###### `bool updatesEnabled() const`
###### `QRegion visibleRegion() const`
###### `QString whatsThis() const`
###### `int width() const`
###### `WId winId() const`
###### `QWidget* window() const`
###### `QString windowFilePath() const`
###### `Qt::WindowFlags windowFlags() const`
###### `QWindow* windowHandle() const`
###### `QIcon windowIcon() const`
###### `Qt::WindowModality windowModality() const`
###### `qreal windowOpacity() const`
###### `QString windowRole() const`
###### `Qt::WindowStates windowState() const`
###### `QString windowTitle() const`
###### `Qt::WindowType windowType() const`
###### `int x() const`
###### `int y() const`



# `Reimplemented Public Functions`
###### `virtual QPaintEngine* paintEngine() const override`



# `Public Slots`
###### `bool close()`
###### `void hide()`
###### `void lower()`
###### `void raise()`
###### `void repaint()`
###### `void setDisabled(bool disable)`
###### `void setEnabled(bool)`
###### `void setFocus()`
###### `void setHidden(bool hidden)`
###### `void setStyleSheet(const QString &styleSheet)`
###### `virtual void setVisible(bool visible)`
###### `void setWindowModified(bool)`
###### `void setWindowTitle(const QString &)`
###### `void show()`
###### `void showFullScreen()`
###### `void showMaximized()`
###### `void showMinimized()`
###### `void showNormal()`
###### `void update()`



# `Static Public Members`
###### `QWidget* createWindowContainer(QWindow* window, QWidget* parent = nullptr, Qt::WindowFlags flags = ...)`
###### `QWidget* find(WId id)`
###### `QWidget* keyboardGrabber()`
###### `QWidget* mouseGrabber()`
###### `void setTabOrder(QWidget* first, QWidget* second)`



# `Protected Functions`
###### `virtual void actionEvent(QActionEvent* event)`
###### `virtual void changeEvent(QEvent* event)`
###### `virtual void closeEvent(QCloseEvent* event)`
###### `virtual void contextMenuEvent(QContextMenuEvent* event)`
###### `void create(WId window = 0, bool initializeWindow = true, bool destroyOldWindow = true)`
###### `void destroy(bool destroyWindow = true, bool destroySubWindows = true)`
###### `virtual void dragEnterEvent(QDragEnterEvent* event)`
###### `virtual void dragLeaveEvent(QDragLeaveEvent* event)`
###### `virtual void dragMoveEvent(QDragMoveEvent* event)`
###### `virtual void dropEvent(QDropEvent* event)`
###### `virtual void enterEvent(QEvent* event)`
###### `virtual void focusInEvent(QFocusEvent* event)`
###### `bool focusNextChild()`
###### `virtual bool focusNextPrevChild(bool next)`
###### `virtual void focusOutEvent(QFocusEvent* event)`
###### `bool focusPreviousChild()`
###### `virtual void hideEvent(QHideEvent* event)`
###### `virtual void inputMethodEvent(QInputMethodEvent* event)`
###### `virtual void keyPressEvent(QKeyEvent* event)`
###### `virtual void keyReleaseEvent(QKeyEvent* event)`
###### `virtual void leaveEvent(QEvent* event)`
###### `virtual void mouseDoubleClickEvent(QMouseEvent* event)`
###### `virtual void mouseMoveEvent(QMouseEvent* event)`
###### `virtual void mousePressEvent(QMouseEvent* event)`
###### `virtual void mouseReleaseEvent(QMouseEvent* event)`
###### `virtual void moveEvent(QMoveEvent* event)`
###### `virtual bool nativeEvent(const QByteArray &eventType, void* message, long* result)`
###### `virtual void paintEvent(QPaintEvent* event)`
###### `virtual void resizeEvent(QResizeEvent* event)`
###### `virtual void showEvent(QShowEvent* event)`
###### `virtual void tabletEvent(QTabletEvent* event)`
###### `virtual void wheelEvent(QWheelEvent* event)`



# `Reimplemented Protected Functions`
###### `virtual bool event(QEvent* event) override`
###### `virtual void initPainter(QPainter* painter) const override`
###### `virtual int metric(QPaintDevice::PaintDeviceMetric m) const override`



# `Protected Slots`
###### `void updateMicroFocus()`



# `Signals`
###### `void customContextMenuRequested(const QPoint &pos)`
###### `void windowIconChanged(const QIcon &icon)`
###### `void windowTitleChanged(const QString &title)`



# `Macros`
###### `QWIDGETSIZE_MAX`


