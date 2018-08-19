***
`Version:` 5.10
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
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
private:
    //在QWidgetPrivate::init()中赋值:QWidget::data = &QWidgetPrivate::data;
    QWidgetData *data; 	
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****
public:
    QWidget::QWidget(QWidget *parent, Qt::WindowFlags f) : QObject(*new QWidgetPrivate, 0), QPaintDevice();
    QWidget::QWidget(QWidgetPrivate &dd, QWidget* parent, Qt::WindowFlags f) : QObject(dd, 0), QPaintDevice();

//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
}
```
## `Constructor`
```
QWidget::QWidget(QWidget *parent, Qt::WindowFlags f) : QObject(*new QWidgetPrivate, 0), QPaintDevice();
QWidget::QWidget(QWidgetPrivate &dd, QWidget* parent, Qt::WindowFlags f) : QObject(dd, 0), QPaintDevice();
```
## `Memory Model`
```
[QWidget]
	[QObject]
	[QPaintDevice]
	QWidgetData* data;
```

# `Properties`
`Interpretation:` 
`StorePos:`
`Defualt:`

`Access:`

`Remark:`

###### `acceptDrops : bool`
`Interpretation:` 

部件是否允许接受拖拽事件.
`StorePos:  ` 

与==QWidgetPrivate::high_attributes==有关,详见代码.

```
void QWidget::setAcceptDrops(bool on) {setAttribute(Qt::WA_AcceptDrops, on);}
```
`Defualt:` 

false;

`Access:`

`Remark:`

`Eg 0:内部拖放事件`

```
// main.cpp
#include <QApplication>
#include <QHBoxLayout>

#include "dragwidget.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QWidget w;
    QHBoxLayout *hrztlLayout = new QHBoxLayout(&w);
    hrztlLayout->addWidget(new DragWidget);
    hrztlLayout->addWidget(new DragWidget);
    
    w.setWindowTitle(QObject::tr("Draggable Icons"));
    w.show();
    
    return a.exec();
}
```

```
// DragWidget.h
#ifndef DRAGWIDGET_H
#define DRAGWIDGET_H

#include <QFrame>

class QDropEvent;
class QDragEnterEvent;

class DragWidget : public QFrame
{
public:
    explicit DragWidget(QWidget *parent = nullptr);

    QPoint pt;
    QByteArray data;

protected:
    void dragEnterEvent(QDragEnterEvent *event) override;
    void dragMoveEvent(QDragMoveEvent *event) override;
    void dropEvent(QDropEvent *event) override;
    void mousePressEvent(QMouseEvent *event) override;
};

#endif // DRAGWIDGET_H
```

```
// DragWidget.cpp
#include <QLabel>
#include <QMimeData>
#include <QPainter>
#include <qdrag.h>
#include <qevent.h>

#include "dragwidget.h"


DragWidget::DragWidget(QWidget *parent)
{
    setMinimumSize(200, 200);
    setFrameStyle(QFrame::Sunken | QFrame::StyledPanel);
    setAcceptDrops(1);
    
    QLabel *boatLabel = new QLabel(this);
    boatLabel->move(10, 10);
    boatLabel->setPixmap(QPixmap(":/png/boat.png"));
    boatLabel->setAttribute(Qt::WA_DeleteOnClose);
    
    QLabel *houseLabel = new QLabel(this);
    houseLabel->move(100, 10);
    houseLabel->setPixmap(QPixmap(":/png/house.png"));
    houseLabel->setAttribute(Qt::WA_DeleteOnClose);
    
    QLabel *carLabel = new QLabel(this);
    carLabel->move(10, 80);
    carLabel->setPixmap(QPixmap(":/png/car.png"));
    carLabel->setAttribute(Qt::WA_DeleteOnClose);
}

void DragWidget::dragEnterEvent(QDragEnterEvent *event)
{
        if (event->source() == this) {
            event->setDropAction(Qt::MoveAction);
            event->accept();
        } else {
            event->acceptProposedAction();
        }
}

void DragWidget::dragMoveEvent(QDragMoveEvent *event)
{
        if (event->source() == this) {
            pt = event->pos();
            event->setDropAction(Qt::MoveAction);
            event->accept();
        } else {
            event->acceptProposedAction();
        }
}

void DragWidget::dropEvent(QDropEvent *event)
{
        if (event->source() == this) {
            pt = event->pos();
            event->setDropAction(Qt::MoveAction);
            event->accept();
        } else {
            event->acceptProposedAction();
        }
}

void DragWidget::mousePressEvent(QMouseEvent *event)
{
    QLabel *child = static_cast<QLabel*>(childAt(event->pos()));
    if (!child)
        return;
    
    QPixmap orgMap = *child->pixmap();
    QPixmap tmpMap = orgMap;
    
    QPoint ptOff = event->pos() - child->pos();
    
    QPainter painter;
    painter.begin(&tmpMap);
    painter.fillRect(tmpMap.rect(), QColor(0xff, 0, 0, 0x80));
    painter.end();
    child->setPixmap(tmpMap);


    QDrag *drag = new QDrag(this);
    drag->setMimeData(new QMimeData());
    drag->setPixmap(orgMap);
    drag->setHotSpot(event->pos() - child->pos());
    if (drag->exec(Qt::MoveAction, Qt::MoveAction) == Qt::MoveAction) {
        child->setPixmap(orgMap);
        child->move(pt - ptOff);
    } else {
        child->setPixmap(orgMap);
    }
}
```
`Eg 1:外部拖放事件`

```
#include "mainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}
```

```
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <qevent.h>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

protected:
    void dragEnterEvent(QDragEnterEvent *event) override;
    void dropEvent(QDropEvent *event) override;

private:
    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
```



```
#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QMessageBox>
#include <QMimeData>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    setAcceptDrops(1);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::dragEnterEvent(QDragEnterEvent *event)
{
    if (event->mimeData()->hasText())
        event->acceptProposedAction();
    else
        event->ignore();
}

void MainWindow::dropEvent(QDropEvent *event)
{
    const QMimeData *mimeData = event->mimeData();
    if (mimeData->hasText()) {
        QString str= mimeData->text();
        QMessageBox::information(this, 0, str);
    }
}
```

###### `accessibleDescription : QString`

`Interpretation:`
`StorePos:`
`Defualt:`
`Remark:`

- 部件的辅助描述.
- Defualt: null.

###### `accessibleName : QString`

- 部件的辅助名.
- Defualt: null.

###### `autoFillBackground : bool`

- 部件是否自动填充背景.
  如果为真,在每次调用绘制事件前,会先填充背景,背景由QPalette::Window指定.
- Defual: false.

###### `baseSize : QSize`
###### `childrenRect : const QRect`

- 所有子部件组合所霸占的矩形(相对客户区),隐藏子不计.
- Defualt: 没有子时,为0.

###### `childrenRegion : const QRegion`

- 所有子部件组合所霸占的范围(相对客户区),隐藏子不计.
- Defualt: 没有子时,为0.

###### `contextMenuPolicy : Qt::ContextMenuPolicy`

- 部件的环境菜单策略.
- Defualt: Qt::DefaultContextMenu.
- 三种显示菜单方式:
  - `Qt::DefaultContextMenu` --> `QWidget::contextMenuEvent()`;
  - `Qt::ActionsContextMenu` --> `QWidget::actions()里的动作会被作为菜单内容`.
  - `Qt::CustomContextMenu` --> `QWidget::customContextMenuRequested() 这是信号`

| Constant                 | Value | Description                                                  |
| ------------------------ | ----- | ------------------------------------------------------------ |
| `Qt::NoContextMenu`      | `0`   | the widget does not feature a context menu, context menu handling is deferred to the widget's parent. |
| `Qt::PreventContextMenu` | `4`   | the widget does not feature a context menu, and in contrast to `NoContextMenu`, the handling is *not* deferred to the widget's parent. This means that all right mouse button events are guaranteed to be delivered to the widget itself through [QWidget::mousePressEvent](http://doc.qt.io/qt-5/qwidget.html#mousePressEvent)(), and [QWidget::mouseReleaseEvent](http://doc.qt.io/qt-5/qwidget.html#mouseReleaseEvent)(). |
| `Qt::DefaultContextMenu` | `1`   | the widget's [QWidget::contextMenuEvent](http://doc.qt.io/qt-5/qwidget.html#contextMenuEvent)() handler is called. |
| `Qt::ActionsContextMenu` | `2`   | the widget displays its [QWidget::actions](http://doc.qt.io/qt-5/qwidget.html#actions)() as context menu. |
| `Qt::CustomContextMenu`  | `3`   | the widget emits the [QWidget::customContextMenuRequested](http://doc.qt.io/qt-5/qwidget.html#customContextMenuRequested)() signal. |

`eg: --> Qt::DefaultContextMenu`

```
void MyWidget::contextMenuEvent(QContextMenuEvent *event)
{
    QMenu menu;
    menu.addAction(QString("1"));
    menu.addAction(QString("2"));
    menu.exec(QCursor::pos() + QPoint(10, 10));
}
```
`eg: --> Qt::ActionsContextMenu`

```
MyWidget::MyWidget(QWidget *parent) : QWidget(parent)
{
    addAction(new QAction("0", this));
    addAction(new QAction("1", this));
    setContextMenuPolicy(Qt::ActionsContextMenu);
}
```

`eg: --> Qt::CustomContextMenu`

```
MyWidget::MyWidget(QWidget *parent) : QWidget(parent)
{
    setContextMenuPolicy(Qt::CustomContextMenu);
    //connect(this, &MyWidget::customContextMenuRequested, this, &MyWidget::slotCustomContextMenuRequested);
    connect(this, SIGNAL(customContextMenuRequested(const QPoint &)), this, SLOT(slotCustomContextMenuRequested(const QPoint &)));
}

void MyWidget::slotCustomContextMenuRequested(const QPoint &pos)
{
    QMenu menu;
    menu.addAction(QString("1"));
    menu.addAction(QString("2"));
    menu.exec(QCursor::pos() + QPoint(2, 2));
}
```
###### `cursor : QCursor`

- 部件的鼠标形状.
- Defualt: Qt::ArrowCursor.

###### `enabled : bool`

- 部件是否可用.
- defualt: true.

###### `focus : const bool`

- 部件是否有键盘焦点.
- defualt: false.

###### `focusPolicy : Qt::FocusPolicy`

- 部件接受键盘焦点的策略.
- defualt:

| Constant          | Value                         | Description                                                  |
| ----------------- | ----------------------------- | ------------------------------------------------------------ |
| `Qt::TabFocus`    | `0x1`                         | the widget accepts focus by tabbing.                         |
| `Qt::ClickFocus`  | `0x2`                         | the widget accepts focus by clicking.                        |
| `Qt::StrongFocus` | `TabFocus | ClickFocus | 0x8` | the widget accepts focus by both tabbing and clicking. On macOS this will also be indicate that the widget accepts tab focus when in 'Text/List focus mode'. |
| `Qt::WheelFocus`  | `StrongFocus | 0x4`           | like Qt::StrongFocus plus the widget accepts focus by using the mouse wheel. |
| `Qt::NoFocus`     | `0`                           | the widget does not accept focus.                            |

###### `font : QFont`

- 部件字体.
- defualt:

###### `frameGeometry : const QRect`
`Interpretation:`部件的矩形(相对于父客户区);
如果没有父,则相对于桌面.
`StorePos:`
`Defualt:`
`Remark:`

- 部件的矩形(相对于父客户区);
  如果没有父,则相对于桌面.

- Defualt: 依赖平台与显示器.

###### `frameSize : const QSize`

- 框架QSize.
- Defualt: 依赖平台与显示器.

###### `fullScreen : const bool`

- 部件是否全屏显赫.
- Defualt: false.

###### `geometry : QRect`

- 部件客户区QRect(相对于父客户区).

###### `height : const int`

- 部件客户区高度.

###### `inputMethodHints : Qt::InputMethodHints`
###### `isActiveWindow : const bool`

- 是否是活动窗口.

###### `layoutDirection : Qt::LayoutDirection`

- 布局方向.
- Defualt: Qt::LeftToRight.

###### `locale : QLocale`

- 区域设置,本地化用.

###### `maximized : const bool`
- 是否是最大化的.
###### `maximumHeight : int`
- 客户区最大高度.
###### `maximumSize : QSize`
- 客户区最大Qsize.
###### `maximumWidth : int`
- 客户区最大宽度.
###### `minimized : const bool`
- 是否是最小化的.
###### `minimumHeight : int`
- 客户区最小高度.
###### `minimumSize : QSize`
- 客户区最小Qsize.
###### `minimumSizeHint : const QSize`
- 客户区最小尺寸暗示.
###### `minimumWidth : int`
- 客户区最小宽度.
###### `modal : const bool`

- 是否是模态的.
- Defualt: false.

###### `mouseTracking : bool`

- 是否允许接收鼠标跟踪.
  If mouse tracking is disabled (the default), the widget only receives mouse move events when at least one mouse button is pressed while the mouse is being moved.

  If mouse tracking is enabled, the widget receives mouse move events even if no buttons are pressed.

- Defualt: false.

###### `normalGeometry : const QRect`

###### `palette : QPalette`

- 调色板.

###### `pos : QPoint`

- 部件位置(相对于父客户区).

###### `rect : const QRect`

- 客户区QRect.

###### `size : QSize`
###### `sizeHint : const QSize`
###### `sizeIncrement : QSize`
###### `sizePolicy : QSizePolicy`
###### `statusTip : QString`

- 客户区(排除可见子部件区域)悬停时显示的工具提醒.

###### `styleSheet : QString`

- 样式表.

###### `tabletTracking : bool`
###### `toolTip : QString`

- 客户区(排除可见子部件区域)悬停时显示的工具提醒.

###### `toolTipDuration : int`

- 工具提醒持续许毫秒数.
- defualt: -1,时间取决于字符串长度.

###### `updatesEnabled : bool`

- 是否允许更新.
  如果有一个大量的密集的更新,可以先禁用,再允许.

###### `visible : bool`

- 是否可见.

###### `whatsThis : QString`

###### `width : const int`

- 客户区宽度.

###### `windowFilePath : QString`
###### `windowFlags : Qt::WindowFlags`

- 设置部件标志.指定部件的类型与显示方式.


- ==enum Qt::WindowType==类型的组合.

The main types are

| Constant            | Value                 | Description                                                  |
| ------------------- | --------------------- | ------------------------------------------------------------ |
| `Qt::Widget`        | `0x00000000`          | `QWidget`的默认类型.如果该类型的部件有父部件,它就是子部件,否是一个窗口. |
| `Qt::Window`        | `0x00000001`          | 表明该部件是一个窗口,通常有一个系统框架,一个标题栏,与是否有父部件无关.注意,如果该部件没有父,是不可能取消这个标志. |
| `Qt::Dialog`        | `0x00000002 | Window` | 表明该部件是一个对话框窗口(在标题栏没有最大化最小按钮),是`QDialog`的默认类型.如果把它作为模态对话框,应该从另一窗口中被启动,或者,有一父且使用`QWidget::windowModality`属性.如果使它为模态的,它将阻止程序的其它顶层窗口获得任何输入. |
| `Qt::Sheet`         | `0x00000004 | Window` | Indicates that the window is a sheet on macOS. Since using a sheet implies window modality, the recommended way is to use [QWidget::setWindowModality](http://doc.qt.io/qt-5/qwidget.html#windowModality-prop)(), or [QDialog::open](http://doc.qt.io/qt-5/qdialog.html#open)(), instead. |
| `Qt::Drawer`        | `Sheet | Dialog`      | Indicates that the widget is a drawer on macOS.              |
| `Qt::Popup`         | `0x00000008 | Window` | 表明该部件是一个弹出式的顶层窗口,比如它是模式的,但是供弹出菜单使用的窗口系统框架. |
| `Qt::Tool`          | `Popup | Dialog`      | 表明该部件是一个工具窗口.工具窗口经常是小的窗口,比通常的标题栏各装饰更小.典型用于工具按钮集.如果它有父部件,它将总是保持在最上面.否,使用`Qt::WindowStaysOnTopHint`更好.如果系统支持,工具窗口可以被轻微的框架装饰. |
| `Qt::ToolTip`       | `Popup | Sheet`       | Indicates that the widget is a tooltip. This is used internally to implement [tooltips](http://doc.qt.io/qt-5/qwidget.html#toolTip-prop). |
| `Qt::SplashScreen`  | `ToolTip | Dialog`    | Indicates that the window is a splash screen. This is the default type for [QSplashScreen](http://doc.qt.io/qt-5/qsplashscreen.html). |
| `Qt::Desktop`       | `0x00000010 | Window` | Indicates that this widget is the desktop. This is the type for [QDesktopWidget](http://doc.qt.io/qt-5/qdesktopwidget.html). |
| `Qt::SubWindow`     | `0x00000012`          | Indicates that this widget is a sub-window, such as a [QMdiSubWindow](http://doc.qt.io/qt-5/qmdisubwindow.html) widget. |
| `Qt::ForeignWindow` | `0x00000020 | Window` | Indicates that this window object is a handle representing a native platform window created by another process or by manually using native code. |
| `Qt::CoverWindow`   | `0x00000040 | Window` | Indicates that the window represents a cover window, which is shown when the application is minimized on some platforms. |

There are also a number of flags which you can use to customize the appearance of top-level windows. These have no effect on other windows:

| Constant                           | Value                     | Description                                                  |
| ---------------------------------- | ------------------------- | ------------------------------------------------------------ |
| `Qt::MSWindowsFixedSizeDialogHint` | `0x00000100`              | Gives the window a thin dialog border on Windows. This style is traditionally used for fixed-size dialogs. |
| `Qt::MSWindowsOwnDC`               | `0x00000200`              | Gives the window its own display context on Windows.         |
| `Qt::BypassWindowManagerHint`      | `0x00000400`              | This flag can be used to indicate to the platform plugin that "all" window manager protocols should be disabled. This flag will behave different depending on what operating system the application is running on and what window manager is running. The flag can be used to get a native window with no configuration set. |
| `Qt::X11BypassWindowManagerHint`   | `BypassWindowManagerHint` | Bypass the window manager completely. This results in a borderless window that is not managed at all (i.e., no keyboard input unless you call [QWidget::activateWindow](http://doc.qt.io/qt-5/qwidget.html#activateWindow)() manually). |
| `Qt::FramelessWindowHint`          | `0x00000800`              | Produces a borderless window. The user cannot move or resize a borderless window via the window system. On X11, the result of the flag is dependent on the window manager and its ability to understand Motif and/or NETWM hints. Most existing modern window managers can handle this. |
| `Qt::NoDropShadowWindowHint`       | `0x40000000`              | Disables window drop shadow on supporting platforms.         |

The `CustomizeWindowHint` flag is used to enable customization of the window controls. This flag must be set to allow the `WindowTitleHint`, `WindowSystemMenuHint`, `WindowMinimizeButtonHint`, `WindowMaximizeButtonHint` and `WindowCloseButtonHint` flags to be changed.

| Constant                                  | Value                                                 | Description                                                  |
| ----------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------ |
| `Qt::CustomizeWindowHint`                 | `0x02000000`                                          | Turns off the default window title hints.                    |
| `Qt::WindowTitleHint`                     | `0x00001000`                                          | Gives the window a title bar.                                |
| `Qt::WindowSystemMenuHint`                | `0x00002000`                                          | Adds a window system menu, and possibly a close button (for example on Mac). If you need to hide or show a close button, it is more portable to use `WindowCloseButtonHint`. |
| `Qt::WindowMinimizeButtonHint`            | `0x00004000`                                          | Adds a minimize button. On some platforms this implies Qt::WindowSystemMenuHint for it to work. |
| `Qt::WindowMaximizeButtonHint`            | `0x00008000`                                          | Adds a maximize button. On some platforms this implies Qt::WindowSystemMenuHint for it to work. |
| `Qt::WindowMinMaxButtonsHint`             | `WindowMinimizeButtonHint | WindowMaximizeButtonHint` | Adds a minimize and a maximize button. On some platforms this implies Qt::WindowSystemMenuHint for it to work. |
| `Qt::WindowCloseButtonHint`               | `0x08000000`                                          | Adds a close button. On some platforms this implies Qt::WindowSystemMenuHint for it to work. |
| `Qt::WindowContextHelpButtonHint`         | `0x00010000`                                          | Adds a context help button to dialogs. On some platforms this implies Qt::WindowSystemMenuHint for it to work. |
| `Qt::MacWindowToolBarButtonHint`          | `0x10000000`                                          | On macOS adds a tool bar button (i.e., the oblong button that is on the top right of windows that have toolbars). |
| `Qt::WindowFullscreenButtonHint`          | `0x80000000`                                          | On macOS adds a fullscreen button.                           |
| `Qt::BypassGraphicsProxyWidget`           | `0x20000000`                                          | Prevents the window and its children from automatically embedding themselves into a [QGraphicsProxyWidget](http://doc.qt.io/qt-5/qgraphicsproxywidget.html) if the parent widget is already embedded. You can set this flag if you want your widget to always be a toplevel widget on the desktop, regardless of whether the parent widget is embedded in a scene or not. |
| `Qt::WindowShadeButtonHint`               | `0x00020000`                                          | Adds a shade button in place of the minimize button if the underlying window manager supports it. |
| `Qt::WindowStaysOnTopHint`                | `0x00040000`                                          | Informs the window system that the window should stay on top of all other windows. Note that on some window managers on X11 you also have to pass Qt::X11BypassWindowManagerHint for this flag to work correctly. |
| `Qt::WindowStaysOnBottomHint`             | `0x04000000`                                          | Informs the window system that the window should stay on bottom of all other windows. Note that on X11 this hint will work only in window managers that support _NET_WM_STATE_BELOW atom. If a window always on the bottom has a parent, the parent will also be left on the bottom. This window hint is currently not implemented for macOS. |
| `Qt::WindowTransparentForInput`           | `0x00080000`                                          | Informs the window system that this window is used only for output (displaying something) and does not take input. Therefore input events should pass through as if it wasn't there. |
| `Qt::WindowOverridesSystemGestures`       | `0x00100000`                                          | Informs the window system that this window implements its own set of gestures and that system level gestures, like for instance three-finger desktop switching, should be disabled. |
| `Qt::WindowDoesNotAcceptFocus`            | `0x00200000`                                          | Informs the window system that this window should not receive the input focus. |
| `Qt::MaximizeUsingFullscreenGeometryHint` | `0x00400000`                                          | Informs the window system that when maximizing the window it should use as much of the available screen geometry as possible, including areas that may be covered by system UI such as status bars or application launchers. This may result in the window being placed under these system UIs, but does not guarantee it, depending on whether or not the platform supports it. When the flag is enabled the user is responsible for taking [QScreen::availableGeometry](http://doc.qt.io/qt-5/qscreen.html#availableGeometry-prop)() into account, so that any UI elements in the application that require user interaction are not covered by system UI. |
| `Qt::WindowType_Mask`                     | `0x000000ff`                                          | A mask for extracting the window type part of the window flags. |

###### `windowIcon : QIcon`

- 部件图标.

###### `windowModality : Qt::WindowModality`

- 部件模态方式.

==enum Qt::WindowModality==:

| Constant               | Value | Description                                                  |
| ---------------------- | ----- | ------------------------------------------------------------ |
| `Qt::NonModal`         | `0`   | The window is not modal and does not block input to other windows. |
| `Qt::WindowModal`      | `1`   | The window is modal to a single window hierarchy and blocks input to its parent window, all grandparent windows, and all siblings of its parent and grandparent windows. |
| `Qt::ApplicationModal` | `2`   | The window is modal to the application and blocks input to all windows. |

###### `windowModified : bool`

- 部件的显示文档是否有未保存的修改.

###### `windowOpacity : double`

- 设置整个部件的不透明度,0~1.0.

###### `windowTitle : QString`

- 窗口标题.

###### `x : const int`

- 部件框架左上x坐标.

###### `y : const int`

- 部件框架左上y坐标.

# `Public Types`
###### `enum RenderFlag { DrawWindowBackground, DrawChildren, IgnoreMask }`
###### `flags RenderFlags`


# `Public Functions`
###### `QWidget(QWidget *parent = Q_NULLPTR, Qt::WindowFlags f = Qt::WindowFlags())`
###### `~QWidget()`
###### `bool acceptDrops() const`
###### `QString accessibleDescription() const`
###### `QString accessibleName() const`
###### `QList<QAction *> actions() const`
###### `void activateWindow()`
###### `void addAction(QAction *action)`
###### `void addActions(QList<QAction *> actions)`
###### `void adjustSize()`
###### `bool autoFillBackground() const`
###### `QPalette::ColorRole backgroundRole() const`
###### `QBackingStore * backingStore() const`
###### `QSize baseSize() const`
###### `QWidget * childAt(int x, int y) const`
###### `QWidget * childAt(const QPoint &p) const`
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
###### `QWidget * focusProxy() const`
###### `QWidget * focusWidget() const`
###### `const QFont & font() const`
###### `QFontInfo fontInfo() const`
###### `QFontMetrics fontMetrics() const`
###### `QPalette::ColorRole foregroundRole() const`
###### `QRect frameGeometry() const`
###### `QSize frameSize() const`
###### `const QRect & geometry() const`
###### `void getContentsMargins(int *left, int *top, int *right, int *bottom) const`
###### `QPixmap grab(const QRect &rectangle = QRect( QPoint( 0, 0 ), QSize( -1, -1 ) ))`
###### `void grabGesture(Qt::GestureType gesture, Qt::GestureFlags flags = Qt::GestureFlags())`
###### `void grabKeyboard()`
###### `void grabMouse()`
###### `void grabMouse(const QCursor &cursor)`
###### `int grabShortcut(const QKeySequence &key, Qt::ShortcutContext context = Qt::WindowShortcut)`
###### `QGraphicsEffect * graphicsEffect() const`
###### `QGraphicsProxyWidget * graphicsProxyWidget() const`
###### `bool hasEditFocus() const`
###### `bool hasFocus() const`
###### `virtual bool hasHeightForWidth() const`
###### `bool hasMouseTracking() const`
###### `bool hasTabletTracking() const`
###### `int height() const`
###### `virtual int heightForWidth(int w) const`
###### `Qt::InputMethodHints inputMethodHints() const`
###### `virtual QVariant inputMethodQuery(Qt::InputMethodQuery query) const`
###### `void insertAction(QAction *before, QAction *action)`
###### `void insertActions(QAction *before, QList<QAction *> actions)`
###### `bool isActiveWindow() const`
###### `bool isAncestorOf(const QWidget *child) const`
###### `bool isEnabled() const`
###### `bool isEnabledTo(const QWidget *ancestor) const`
###### `bool isFullScreen() const`
###### `bool isHidden() const`
###### `bool isMaximized() const`
###### `bool isMinimized() const`
###### `bool isModal() const`
###### `bool isVisible() const`
###### `bool isVisibleTo(const QWidget *ancestor) const`
###### `bool isWindow() const`
###### `bool isWindowModified() const`
###### `QLayout * layout() const`
###### `Qt::LayoutDirection layoutDirection() const`
###### `QLocale locale() const`
###### `QPoint mapFrom(const QWidget *parent, const QPoint &pos) const`
###### `QPoint mapFromGlobal(const QPoint &pos) const`
###### `QPoint mapFromParent(const QPoint &pos) const`
###### `QPoint mapTo(const QWidget *parent, const QPoint &pos) const`
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
###### `QWidget * nativeParentWidget() const`
###### `QWidget * nextInFocusChain() const`
###### `QRect normalGeometry() const`
###### `void overrideWindowFlags(Qt::WindowFlags flags)`
###### `const QPalette & palette() const`
###### `QWidget * parentWidget() const`
###### `QPoint pos() const`
###### `QWidget * previousInFocusChain() const`
###### `QRect rect() const`
###### `void releaseKeyboard()`
###### `void releaseMouse()`
###### `void releaseShortcut(int id)`
###### `void removeAction(QAction *action)`
###### `void render(QPaintDevice *target, const QPoint &targetOffset = QPoint(), const QRegion &sourceRegion = QRegion(), RenderFlags renderFlags = RenderFlags( DrawWindowBackground | DrawChildren ))`
###### `void render(QPainter *painter, const QPoint &targetOffset = QPoint(), const QRegion &sourceRegion = QRegion(), RenderFlags renderFlags = RenderFlags( DrawWindowBackground | DrawChildren ))`
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
###### `void setFocusProxy(QWidget *w)`
###### `void setFont(const QFont &)`
###### `void setForegroundRole(QPalette::ColorRole role)`
###### `void setGeometry(const QRect &)`
###### `void setGeometry(int x, int y, int w, int h)`
###### `void setGraphicsEffect(QGraphicsEffect *effect)`
###### `void setInputMethodHints(Qt::InputMethodHints hints)`
###### `void setLayout(QLayout *layout)`
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
###### `void setParent(QWidget *parent)`
###### `void setParent(QWidget *parent, Qt::WindowFlags f)`
###### `void setShortcutAutoRepeat(int id, bool enable = true)`
###### `void setShortcutEnabled(int id, bool enable = true)`
###### `void setSizeIncrement(const QSize &)`
###### `void setSizeIncrement(int w, int h)`
###### `void setSizePolicy(QSizePolicy)`
###### `void setSizePolicy(QSizePolicy::Policy horizontal, QSizePolicy::Policy vertical)`
###### `void setStatusTip(const QString &)`
###### `void setStyle(QStyle *style)`
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
###### `void setupUi(QWidget *widget)`
###### `QSize size() const`
###### `virtual QSize sizeHint() const`
###### `QSize sizeIncrement() const`
###### `QSizePolicy sizePolicy() const`
###### `void stackUnder(QWidget *w)`
###### `QString statusTip() const`
###### `QStyle * style() const`
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
###### `QWidget * window() const`

- 返回部件的窗口,如果本身是窗口,返回自身.

###### `QString windowFilePath() const`

- 如果没有设置窗口标题名,这个全路径的文件名被使用.

###### `Qt::WindowFlags windowFlags() const`
###### `QWindow * windowHandle() const`
###### `QIcon windowIcon() const`
###### `Qt::WindowModality windowModality() const`
###### `qreal windowOpacity() const`
###### `QString windowRole() const`
###### `Qt::WindowStates windowState() const`

| Constant               | Value        | Description                                                  |
| ---------------------- | ------------ | ------------------------------------------------------------ |
| `Qt::WindowNoState`    | `0x00000000` | The window has no state set (in normal state).               |
| `Qt::WindowMinimized`  | `0x00000001` | The window is minimized (i.e. iconified).                    |
| `Qt::WindowMaximized`  | `0x00000002` | The window is maximized with a frame around it.              |
| `Qt::WindowFullScreen` | `0x00000004` | The window fills the entire screen without any frame around it. |
| `Qt::WindowActive`     | `0x00000008` | The window is the active window, i.e. it has keyboard focus. |

###### `QString windowTitle() const`
###### `Qt::WindowType windowType() const`

- enum Qt::WindowType
  flags Qt::WindowFlags

###### `int x() const`
###### `int y() const`



# `Reimplemented Public Functions`
###### `virtual QPaintEngine * paintEngine() const`



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



# `Signals`
###### `void customContextMenuRequested(const QPoint &pos)`
###### `void windowIconChanged(const QIcon &icon)`
###### `void windowTitleChanged(const QString &title)`



# `Static Public Members`
###### `QWidget * createWindowContainer(QWindow *window, QWidget *parent = Q_NULLPTR, Qt::WindowFlags flags = Qt::WindowFlags())`
###### `QWidget * find(WId id)`
###### `QWidget * keyboardGrabber()`
###### `QWidget * mouseGrabber()`
###### `void setTabOrder(QWidget *first, QWidget *second)`



# `Protected Functions`
###### `virtual void actionEvent(QActionEvent *event)`
###### `virtual void changeEvent(QEvent *event)`
###### `virtual void closeEvent(QCloseEvent *event)`
###### `virtual void contextMenuEvent(QContextMenuEvent *event)`
###### `void create(WId window = 0, bool initializeWindow = true, bool destroyOldWindow = true)`
###### `void destroy(bool destroyWindow = true, bool destroySubWindows = true)`
###### `virtual void dragEnterEvent(QDragEnterEvent *event)`
###### `virtual void dragLeaveEvent(QDragLeaveEvent *event)`
###### `virtual void dragMoveEvent(QDragMoveEvent *event)`
###### `virtual void dropEvent(QDropEvent *event)`
###### `virtual void enterEvent(QEvent *event)`
###### `virtual void focusInEvent(QFocusEvent *event)`
###### `bool focusNextChild()`
###### `virtual bool focusNextPrevChild(bool next)`
###### `virtual void focusOutEvent(QFocusEvent *event)`
###### `bool focusPreviousChild()`
###### `virtual void hideEvent(QHideEvent *event)`
###### `virtual void inputMethodEvent(QInputMethodEvent *event)`
###### `virtual void keyPressEvent(QKeyEvent *event)`
###### `virtual void keyReleaseEvent(QKeyEvent *event)`
###### `virtual void leaveEvent(QEvent *event)`
###### `virtual void mouseDoubleClickEvent(QMouseEvent *event)`
###### `virtual void mouseMoveEvent(QMouseEvent *event)`
###### `virtual void mousePressEvent(QMouseEvent *event)`
###### `virtual void mouseReleaseEvent(QMouseEvent *event)`
###### `virtual void moveEvent(QMoveEvent *event)`
###### `virtual bool nativeEvent(const QByteArray &eventType, void *message, long *result)`
###### `virtual void paintEvent(QPaintEvent *event)`
###### `virtual void resizeEvent(QResizeEvent *event)`
###### `virtual void showEvent(QShowEvent *event)`
###### `virtual void tabletEvent(QTabletEvent *event)`
###### `virtual void wheelEvent(QWheelEvent *event)`



# `Reimplemented Protected Functions`
###### `virtual bool event(QEvent *event)`
###### `virtual void initPainter(QPainter *painter) const`
###### `virtual int metric(PaintDeviceMetric m) const`



# `Protected Slots`
###### `void updateMicroFocus()`



# `Macros`
###### `QWIDGETSIZE_MAX`
```

```