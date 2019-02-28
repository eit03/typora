***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` \[QWidget\]

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
//Prepare *** *** *** *** *** *** *** *** *** *** *** *** **

//Properties *** *** *** *** *** *** *** *** *** *** *** ***
private:
    QWidgetData *data; //指向QWidgetPrivate类的data成员.

//Constructor *** *** *** *** *** *** *** *** *** *** *** **
public:
    explicit QWidget(QWidget* parent = nullptr, Qt::WindowFlags f = Qt::WindowFlags());
    ~QWidget();
protected:
    QWidget(QWidgetPrivate &d, QWidget* parent, Qt::WindowFlags f);
    
//Functions *** *** *** *** *** *** *** *** *** *** ***  ***

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

QWidget::~QWidget()
{
    Q_D(QWidget);
    d->data.in_destructor = true;

#if defined (QT_CHECK_STATE)
    if (Q_UNLIKELY(paintingActive()))
        qWarning("QWidget: %s (%s) deleted while being painted", className(), name());
#endif

#ifndef QT_NO_GESTURES
    if (QGestureManager *manager = QGestureManager::instance()) {
        // \forall Qt::GestureType type : ungrabGesture(type) (inlined)
        for (auto it = d->gestureContext.keyBegin(), end = d->gestureContext.keyEnd(); it != end; ++it)
            manager->cleanupCachedGestures(this, *it);
    }
    d->gestureContext.clear();
#endif

    // force acceptDrops false before winId is destroyed.
    d->registerDropSite(false);

#ifndef QT_NO_ACTION
    // remove all actions from this widget
    for (int i = 0; i < d->actions.size(); ++i) {
        QActionPrivate *apriv = d->actions.at(i)->d_func();
        apriv->widgets.removeAll(this);
    }
    d->actions.clear();
#endif

#ifndef QT_NO_SHORTCUT
    // Remove all shortcuts grabbed by this
    // widget, unless application is closing
    if (!QApplicationPrivate::is_app_closing && testAttribute(Qt::WA_GrabbedShortcut))
        qApp->d_func()->shortcutMap.removeShortcut(0, this, QKeySequence());
#endif

    // delete layout while we still are a valid widget
    delete d->layout;
    d->layout = 0;
    // Remove myself from focus list

    Q_ASSERT(d->focus_next->d_func()->focus_prev == this);
    Q_ASSERT(d->focus_prev->d_func()->focus_next == this);

    if (d->focus_next != this) {
        d->focus_next->d_func()->focus_prev = d->focus_prev;
        d->focus_prev->d_func()->focus_next = d->focus_next;
        d->focus_next = d->focus_prev = 0;
    }


    QT_TRY {
#if QT_CONFIG(graphicsview)
        const QWidget* w = this;
        while (w->d_func()->extra && w->d_func()->extra->focus_proxy)
            w = w->d_func()->extra->focus_proxy;
        QWidget *window = w->window();
        QWExtra *e = window ? window->d_func()->extra : 0;
        if (!e || !e->proxyWidget || (w->parentWidget() && w->parentWidget()->d_func()->focus_child == this))
#endif
        clearFocus();
    } QT_CATCH(...) {
        // swallow this problem because we are in a destructor
    }

    d->setDirtyOpaqueRegion();

    if (isWindow() && isVisible() && internalWinId()) {
        QT_TRY {
            d->close_helper(QWidgetPrivate::CloseNoEvent);
        } QT_CATCH(...) {
            // if we're out of memory, at least hide the window.
            QT_TRY {
                hide();
            } QT_CATCH(...) {
                // and if that also doesn't work, then give up
            }
        }
    }

#if 0 /* Used to be included in Qt4 for Q_WS_WIN */ || 0 /* Used to be included in Qt4 for Q_WS_X11 */|| 0 /* Used to be included in Qt4 for Q_WS_MAC */
    else if (!internalWinId() && isVisible()) {
        qApp->d_func()->sendSyntheticEnterLeave(this);
    }
#endif
    else if (isVisible()) {
        qApp->d_func()->sendSyntheticEnterLeave(this);
    }

    if (QWidgetBackingStore *bs = d->maybeBackingStore()) {
        bs->removeDirtyWidget(this);
        if (testAttribute(Qt::WA_StaticContents))
            bs->removeStaticWidget(this);
    }

    delete d->needsFlush;
    d->needsFlush = 0;

    // The next 20 lines are duplicated from QObject, but required here
    // since QWidget deletes is children itself
    bool blocked = d->blockSig;
    d->blockSig = 0; // unblock signals so we always emit destroyed()

    if (d->isSignalConnected(0)) {
        QT_TRY {
            emit destroyed(this);
        } QT_CATCH(...) {
            // all the signal/slots connections are still in place - if we don't
            // quit now, we will crash pretty soon.
            qWarning("Detected an unexpected exception in ~QWidget while emitting destroyed().");
            QT_RETHROW;
        }
    }

    if (d->declarativeData) {
        d->wasDeleted = true; // needed, so that destroying the declarative data does the right thing
        if (static_cast<QAbstractDeclarativeDataImpl*>(d->declarativeData)->ownedByQml1) {
            if (QAbstractDeclarativeData::destroyed_qml1)
                QAbstractDeclarativeData::destroyed_qml1(d->declarativeData, this);
        } else {
            if (QAbstractDeclarativeData::destroyed)
                QAbstractDeclarativeData::destroyed(d->declarativeData, this);
        }
        d->declarativeData = 0;                 // don't activate again in ~QObject
        d->wasDeleted = false;
    }

    d->blockSig = blocked;

#if 0 // Used to be included in Qt4 for Q_WS_MAC
    // QCocoaView holds a pointer back to this widget. Clear it now
    // to make sure it's not followed later on. The lifetime of the
    // QCocoaView might exceed the lifetime of this widget in cases
    // where Cocoa itself holds references to it.
    extern void qt_mac_clearCocoaViewQWidgetPointers(QWidget *);
    qt_mac_clearCocoaViewQWidgetPointers(this);
#endif

    if (!d->children.isEmpty())
        d->deleteChildren();

    QApplication::removePostedEvents(this);

    QT_TRY {
        destroy();                                        // platform-dependent cleanup
    } QT_CATCH(...) {
        // if this fails we can't do anything about it but at least we are not allowed to throw.
    }
    --QWidgetPrivate::instanceCounter;

    if (QWidgetPrivate::allWidgets) // might have been deleted by ~QApplication
        QWidgetPrivate::allWidgets->remove(this);

    QT_TRY {
        QEvent e(QEvent::Destroy);
        QCoreApplication::sendEvent(this, &e);
    } QT_CATCH(const std::exception&) {
        // if this fails we can't do anything about it but at least we are not allowed to throw.
    }

#if QT_CONFIG(graphicseffect)
    delete d->graphicsEffect;
#endif
}
```
## `Memory Model`
```
[QWidget]
    static const QMetaObject staticMetaObject;
    [QObject]
    [QPaintDevice]
    QWidgetData *data;
```



# `Properties`
###### ` acceptDrops : bool`
- Interpretation:
  部件是否允许接受拖拽事件.
- StorePosition:
  与*QWidgetPrivate::high_attributes*有关,详见代码.

  ```
  void QWidget::setAcceptDrops(bool on) {setAttribute(Qt::WA_AcceptDrops, on);}
  ```
- Defualt:
  false
- Access:
- Remark:
- Eg 0:内部拖放事件
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

- Eg 1:外部拖放事件

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
###### ` accessibleDescription : QString`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` accessibleName : QString`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` autoFillBackground : bool`
- Interpretation:
  是否自动填充部件的背景色;
  如果真,那么在调用paint事件前,背景会被填充,*QPalette::Winddow*指定的颜色会被使用;
  此外,窗口总是被填充使用*QPalette::Winddow*,除非*WA_OpaquePaintEvent*或*WA_NoSystemBackground*属性被设置;
  如果部件的父有一个静态梯度的背景,那么这个属性不能被关闭;
  与风格切片一起使用时,要相当小心.当部件有有效的背景切片或**border-image**时,这个属性被自动禁用;
- StorePosition:
- Defualt:
  false
- Access:
  bool autoFillBackground() const
  void setAutoFillBackground(bool enabled)
- Remark:
- Eg 0:
###### ` baseSize : QSize`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` childrenRect : const QRect`

- Interpretation:
  所有子部件组合所占用的矩形(相对客户区),隐藏子不计.
- StorePosition:
- Defualt:
  对于一个没有子部件的部件,是一个0宽0高的矩形.
- Access:
- Remark:
- Eg 0:
###### ` childrenRegion : const QRegion`
- Interpretation:
  所有子部件组合所占用的矩形(相对客户区),隐藏子不计.
- StorePosition:
- Defualt:
  By default, for a widget with no children, this property contains an empty region.
- Access:
- Remark:
- Eg 0:
###### ` contextMenuPolicy : Qt::ContextMenuPolicy`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` cursor : QCursor`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` enabled : bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` focus : const bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` focusPolicy : Qt::FocusPolicy`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` font : QFont`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` frameGeometry : const QRect`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` frameSize : const QSize`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` fullScreen : const bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` geometry : QRect`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` height : const int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` inputMethodHints : Qt::InputMethodHints`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` isActiveWindow : const bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` layoutDirection : Qt::LayoutDirection`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` locale : QLocale`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` maximized : const bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` maximumHeight : int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` maximumSize : QSize`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` maximumWidth : int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` minimized : const bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` minimumHeight : int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` minimumSize : QSize`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` minimumSizeHint : const QSize`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` `

- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` minimumWidth : int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` modal : const bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` mouseTracking : bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` normalGeometry : const QRect`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` palette : QPalette`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` pos : QPoint`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` rect : const QRect`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` size : QSize`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` sizeHint : const QSize`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` sizeIncrement : QSize`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` sizePolicy : QSizePolicy`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` statusTip : QString`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` styleSheet : QString`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` tabletTracking : bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` toolTip : QString`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` toolTipDuration : int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` updatesEnabled : bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` visible : bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` whatsThis : QString`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` width : const int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` windowFilePath : QString`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` windowFlags : Qt::WindowFlags`

- Interpretation:
  部件标志集;
  部件的一种分类是**窗口**与**子窗口**:**窗口**是没有父部件的部件,*parentWidget()*返回零,可以有标志*Qt::Window*或*Qt::Dialog*,**子窗口**是有父部件;
  设置部件标志时,会调用*setParrent()*,会导致部件被隐藏,你需要调用*show()*再次显示它;

- StorePosition:

- Defualt:

- Access:

- Remark:
  要了解这个属性,必须看*enum Qt::WindowType*与*flags Qt::WindowFlags*二个类型.

  - Main type
    | Constant            | Value                 | Description                                                  |
    | ------------------- | --------------------- | ------------------------------------------------------------ |
    | `Qt::Widget`        | `0x00000000`          | This is the default type for [QWidget](http://doc.qt.io/qt-5/qwidget.html). Widgets of this type are child widgets if they have a parent, and independent windows if they have no parent. See also Qt::Window and Qt::SubWindow.<br /><br />*QWidget*类默认使用这个类型.如果它有父,这个部件是个子部件;如果它没有父,这个部件是个独立的窗口.详见*Qt::Window*与*Qt::SubWindow*. |
    | `Qt::Window`        | `0x00000001`          | Indicates that the widget is a window, usually with a window system frame and a title bar, irrespective of whether the widget has a parent or not. Note that it is not possible to unset this flag if the widget does not have a parent.<br /><br />表明部件是一个窗口,它通常带有系统框架窗口与标题栏,不管是否有父.注意,如果该部件没有父,没有设置这个枚举是不可能的. |
    | `Qt::Dialog`        | `0x00000002 | Window` | Indicates that the widget is a window that should be decorated as a dialog (i.e., typically no maximize or minimize buttons in the title bar). This is the default type for [QDialog](http://doc.qt.io/qt-5/qdialog.html). If you want to use it as a modal dialog, it should be launched from another window, or have a parent and used with the [QWidget::windowModality](http://doc.qt.io/qt-5/qwidget.html#windowModality-prop) property. If you make it modal, the dialog will prevent other top-level windows in the application from getting any input. We refer to a top-level window that has a parent as a *secondary* window.<br /><br />表明部件是一个窗口,应该被装饰为一个对话框(通常标题栏里没有最大化&最小化按钮).它是*QDialog*类的默认类型.如果想使用一个模态对话框,它应该被另一个窗口启动,或有一个父且有*QWidget::windowModality*属性.如果你使它模态的,它将阻止应用的其它顶层窗口得到任何输入.它被成为一个顶层窗口,父被成为一个辅助窗口. |
    | `Qt::Sheet`         | `0x00000004 | Window` | Indicates that the window is a sheet on [macOS](http://doc.qt.io/qt-5/internationalization.html#macos). Since using a sheet implies window modality, the recommended way is to use [QWidget::setWindowModality](http://doc.qt.io/qt-5/qwidget.html#windowModality-prop)(), or [QDialog::open](http://doc.qt.io/qt-5/qdialog.html#open)(), instead. |
    | `Qt::Drawer`        | `Sheet | Dialog`      | Indicates that the widget is a drawer on [macOS](http://doc.qt.io/qt-5/internationalization.html#macos). |
    | `Qt::Popup`         | `0x00000008 | Window` | Indicates that the widget is a pop-up top-level window, i.e. that it is modal, but has a window system frame appropriate for pop-up menus.<br /><br />表明部件是一个弹出式的顶层窗口,即,它是模态的,但是是一个有恰当的窗口系统框架的弹出式菜单. |
    | `Qt::Tool`          | `Popup | Dialog`      | Indicates that the widget is a tool window. A tool window is often a small window with a smaller than usual title bar and decoration, typically used for collections of tool buttons. If there is a parent, the tool window will always be kept on top of it. If there isn't a parent, you may consider using Qt::WindowStaysOnTopHint as well. If the window system supports it, a tool window can be decorated with a somewhat lighter frame. It can also be combined with Qt::FramelessWindowHint. On [macOS](http://doc.qt.io/qt-5/internationalization.html#macos), tool windows correspond to the [NSPanel](https://developer.apple.com/documentation/appkit/nspanel) class of windows. This means that the window lives on a level above normal windows making it impossible to put a normal window on top of it. By default, tool windows will disappear when the application is inactive. This can be controlled by the [Qt::WA_MacAlwaysShowToolWindow](http://doc.qt.io/qt-5/qt.html#WidgetAttribute-enum) attribute.<br /><br />表明部件是工具窗口.一个工具窗口通常是小窗口,比标题栏和装饰还小,典型的被用作工具按钮的集合.如果它有一个父,它总是保持在父之上,否,用*Qt::FramelessWindowHint*为好. |
    | `Qt::ToolTip`       | `Popup | Sheet`       | Indicates that the widget is a tooltip. This is used internally to implement [tooltips](http://doc.qt.io/qt-5/qwidget.html#toolTip-prop). |
    | `Qt::SplashScreen`  | `ToolTip | Dialog`    | Indicates that the window is a splash screen. This is the default type for [QSplashScreen](http://doc.qt.io/qt-5/qsplashscreen.html). |
    | `Qt::Desktop`       | `0x00000010 | Window` | Indicates that this widget is the desktop. This is the type for QDesktopWidget. |
    | `Qt::SubWindow`     | `0x00000012`          | Indicates that this widget is a sub-window, such as a [QMdiSubWindow](http://doc.qt.io/qt-5/qmdisubwindow.html) widget. |
    | `Qt::ForeignWindow` | `0x00000020 | Window` | Indicates that this window object is a handle representing a native platform window created by another process or by manually using native code. |
    | `Qt::CoverWindow`   | `0x00000040 | Window` | Indicates that the window represents a cover window, which is shown when the application is minimized on some platforms. |
- Eg 0:
###### ` windowIcon : QIcon`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` windowModality : Qt::WindowModality`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` windowModified : bool`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` windowOpacity : double`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` windowTitle : QString`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` x : const int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:
###### ` y : const int`
- Interpretation:
- StorePosition:
- Defualt:
- Access:
- Remark:
- Eg 0:



# `Public Types`
###### `enum RenderFlag { DrawWindowBackground, DrawChildren, IgnoreMask }`
###### `flags RenderFlags`



# `Public Functions`
###### ` QWidget(QWidget* parent = nullptr, Qt::WindowFlags f = ...)`
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
###### ` QWIDGETSIZE_MAX`


