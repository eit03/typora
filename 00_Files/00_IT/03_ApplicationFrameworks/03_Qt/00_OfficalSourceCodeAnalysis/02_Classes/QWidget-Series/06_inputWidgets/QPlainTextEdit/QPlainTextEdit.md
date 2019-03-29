***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QPlainTextEdit
***
[TOC]
***
# `Brief Introduction`

- QPlainTextEdit是一个提供纯文本编辑与显示的部件.
- QPlainTextEdit中有二种换行:硬换行 & 软换行.
  硬换行:回车导致的换行;内存中它依赖于系统平台,在硬盘中是0xA(Qt平台).
  软换行:由于换行模式导致的换行;如:过长的行,或过长的单词,只能分多行显示(视觉上多行).

# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_WIDGETS_EXPORT QPlainTextEdit : public QAbstractScrollArea
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************

//*****************************************************************************************************************
//Properties ***************************************************************************************************

//*****************************************************************************************************************
//Constructor **************************************************************************************************
public:
    explicit QPlainTextEdit(QWidget *parent = Q_NULLPTR);
    explicit QPlainTextEdit(const QString &text, QWidget *parent = Q_NULLPTR);
protected:
    QPlainTextEdit(QPlainTextEditPrivate &dd, QWidget *parent);
    
//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```
QPlainTextEdit::QPlainTextEdit(QWidget *parent) : QAbstractScrollArea(*new QPlainTextEditPrivate, parent)
{
    Q_D(QPlainTextEdit);
    d->init();
}

QPlainTextEdit::QPlainTextEdit(const QString &text, QWidget *parent) : QAbstractScrollArea(*new QPlainTextEditPrivate, parent)
{
    Q_D(QPlainTextEdit);
    d->init(text);
}

QPlainTextEdit::QPlainTextEdit(QPlainTextEditPrivate &dd, QWidget *parent) : QAbstractScrollArea(dd, parent)
{
    Q_D(QPlainTextEdit);
    d->init();
}
```
## `Memeory Model`
```
[QPlainTextEdit]
    [QAbstractScrollArea]
        ...
           QPlainTextEditPrivate* Object::d_ptr; 
```

# `Properties`
###### `backgroundVisible : bool`

- 中心部件的背景是否可见;真时,背景可见.否,被文档覆盖.
- Default: false.

###### `blockCount : const int`

- 文档中,当前块(段落)的记数.
- Default: 空文档==1.

###### `centerOnScroll : bool`

- 滚动时,光标是否屏幕居中.

###### `cursorWidth : int`

- 设置光标(当前输入光标)的宽度.
- Default: 1.

###### `documentTitle : QString`

- 文档标题,不是窗口标题.
- Default: null.

###### `lineWrapMode : LineWrapMode`

- 换行模式.

  | Constant                      | Value | Description         |
  | ----------------------------- | ----- | ------------------- |
  | `QPlainTextEdit::NoWrap`      | `0`   | 不换行.             |
  | `QPlainTextEdit::WidgetWidth` | `1`   | 到达部件宽度才换行. |
- default: QPlainTextEdit::WidgetWidth.
###### `maximumBlockCount : int`

- 见==blockCount==.
- Default: 0.
- 如果超过,从最前开始的块会不显示.

###### `overwriteMode : bool`

- 用户输入的文本是否重写(替换)存在的文本.
- Default: false.

###### `placeholderText : QString`

- 文档占位符(如帐号框中的UserName提示).
- Default: null.

###### `plainText : QString`

- 文档的内容可以用以下方式访问:
  QString toPlainText() const
  void setPlainText(const QString &text)
- Default: null.

###### `readOnly : bool`

- 只读属性位;只读与写的很多键的响应方式不一样的.
- Default: false.

###### `tabChangesFocus : bool`

- Tap键切换焦点.也就是说不能用于\t.
- Default: false.

###### `tabStopDistance : qreal`

- Tab键\t时,它的距离double值.
- Default: 80pixs.

###### `textInteractionFlags : Qt::TextInteractionFlags`

- 用户输入怎么与文本交互.

  | Constant                        | Value                                                        | Description                                                  |
  | ------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
  | `Qt::NoTextInteraction`         | `0`                                                          | No interaction with the text is possible.<br />用户的任何操作不起作用. |
  | `Qt::TextSelectableByMouse`     | `1`                                                          | Text can be selected with the mouse and copied to the clipboard using a context menu or standard keyboard shortcuts.<br />鼠标选择操作被允许. |
  | `Qt::TextSelectableByKeyboard`  | `2`                                                          | Text can be selected with the cursor keys on the keyboard. A text cursor is shown.<br />键盘选择操作被允许. |
  | `Qt::LinksAccessibleByMouse`    | `4`                                                          | Links can be highlighted and activated with the mouse.<br />链接可以用鼠标操作访问. |
  | `Qt::LinksAccessibleByKeyboard` | `8`                                                          | Links can be focused using tab and activated with enter.<br />链接可以用键盘操作访问. |
  | `Qt::TextEditable`              | `16`                                                         | The text is fully editable.<br />文本写被编辑.               |
  | `Qt::TextEditorInteraction`     | `TextSelectableByMouse | TextSelectableByKeyboard | TextEditable` | The default for a text editor.<br />文本编辑交互方式.        |
  | `Qt::TextBrowserInteraction`    | `TextSelectableByMouse | LinksAccessibleByMouse | LinksAccessibleByKeyboard` | The default for [QTextBrowser](http://doc.qt.io/qt-5/qtextbrowser.html).<br />文本浏览器交互方式. |
- Default: 
  只读:Qt::TextBrowserInteraction.
  可写:Qt::TextEditorInteraction.
###### `undoRedoEnabled : bool`

- 是否允许撤销与重复.
- Default: true.

###### `wordWrapMode : QTextOption::WrapMode`

- 单词软换行模式.

  | Constant                                    | Value | Description                                                  |
  | ------------------------------------------- | ----- | ------------------------------------------------------------ |
  | `QTextOption::NoWrap`                       | `0`   | Text is not wrapped at all.<br />不换行.                     |
  | `QTextOption::WordWrap`                     | `1`   | Text is wrapped at word boundaries.<br />当单词被打散时在视觉上的不同行时,这个单词就是换行. |
  | `QTextOption::ManualWrap`                   | `2`   | Same as QTextOption::NoWrap<br />不换行.                     |
  | `QTextOption::WrapAnywhere`                 | `3`   | Text can be wrapped at any point on a line, even if it occurs in the middle of a word.<br />任何时候可以换行,即使在单词中间. |
  | `QTextOption::WrapAtWordBoundaryOrAnywhere` | `4`   | If possible, wrapping occurs at a word boundary; otherwise it will occur at the appropriate point on the line, even in the middle of a word.<br />这是顺其自然的换行. |
- Default: QTextOption::WrapAtWordBoundaryOrAnywhere.

# `Public Types`
###### `enum LineWrapMode { NoWrap, WidgetWidth }`

| Name        | Value | Description                   |
| ----------- | ----- | ----------------------------- |
| NoWrap      | 0     | 行换行模式为不换行.           |
| WidgetWidth | 1     | 行换行模式为超过部件宽度换行. |

# `Public Functions`
###### `QPlainTextEdit(QWidget *parent = Q_NULLPTR)`
###### `QPlainTextEdit(const QString &text, QWidget *parent = Q_NULLPTR)`
###### `virtual ~QPlainTextEdit()`
###### `QString anchorAt(const QPoint &pos) const`
###### `bool backgroundVisible() const`
###### `int blockCount() const`
###### `bool canPaste() const`
###### `bool centerOnScroll() const`
###### `QMenu * createStandardContextMenu()`
###### `QMenu * createStandardContextMenu(const QPoint &position)`
###### `QTextCharFormat currentCharFormat() const`
###### `QTextCursor cursorForPosition(const QPoint &pos) const`
###### `QRect cursorRect(const QTextCursor &cursor) const`
###### `QRect cursorRect() const`
###### `int cursorWidth() const`
###### `QTextDocument * document() const`
###### `QString documentTitle() const`
###### `void ensureCursorVisible()`
###### `QList<QTextEdit::ExtraSelection> extraSelections() const`
###### `bool find(const QString &exp, QTextDocument::FindFlags options = QTextDocument::FindFlags())`
###### `bool find(const QRegExp &exp, QTextDocument::FindFlags options = QTextDocument::FindFlags())`
###### `bool isReadOnly() const`
###### `bool isUndoRedoEnabled() const`
###### `LineWrapMode lineWrapMode() const`
###### `virtual QVariant loadResource(int type, const QUrl &name)`
###### `int maximumBlockCount() const`
###### `void mergeCurrentCharFormat(const QTextCharFormat &modifier)`
###### `void moveCursor(QTextCursor::MoveOperation operation, QTextCursor::MoveMode mode = QTextCursor::MoveAnchor)`
###### `bool overwriteMode() const`
###### `QString placeholderText() const`
###### `void print(QPagedPaintDevice *printer) const`
###### `void setBackgroundVisible(bool visible)`
###### `void setCenterOnScroll(bool enabled)`
###### `void setCurrentCharFormat(const QTextCharFormat &format)`
###### `void setCursorWidth(int width)`
###### `void setDocument(QTextDocument *document)`
###### `void setDocumentTitle(const QString &title)`
###### `void setExtraSelections(const QList<QTextEdit::ExtraSelection> &selections)`
###### `void setLineWrapMode(LineWrapMode mode)`
###### `void setMaximumBlockCount(int maximum)`
###### `void setOverwriteMode(bool overwrite)`
###### `void setPlaceholderText(const QString &placeholderText)`
###### `void setReadOnly(bool ro)`
###### `void setTabChangesFocus(bool b)`
###### `void setTabStopDistance(qreal distance)`
###### `void setTextCursor(const QTextCursor &cursor)`
###### `void setTextInteractionFlags(Qt::TextInteractionFlags flags)`
###### `void setUndoRedoEnabled(bool enable)`
###### `void setWordWrapMode(QTextOption::WrapMode policy)`
###### `bool tabChangesFocus() const`
###### `qreal tabStopDistance() const`
###### `QTextCursor textCursor() const`
###### `Qt::TextInteractionFlags textInteractionFlags() const`
###### `QString toPlainText() const`
###### `QTextOption::WrapMode wordWrapMode() const`

# `Reimplemented Public Functions`
###### `virtual QVariant inputMethodQuery(Qt::InputMethodQuery property) const`

# `Public Slots`
###### `void appendHtml(const QString &html)`
###### `void appendPlainText(const QString &text)`
###### `void centerCursor()`
###### `void clear()`
###### `void copy()`
###### `void cut()`
###### `void insertPlainText(const QString &text)`
###### `void paste()`
###### `void redo()`
###### `void selectAll()`
###### `void setPlainText(const QString &text)`
###### `void undo()`
###### `void zoomIn(int range = 1)`
###### `void zoomOut(int range = 1)`

# `Signals`
###### `void blockCountChanged(int newBlockCount)`
###### `void copyAvailable(bool yes)`
###### `void cursorPositionChanged()`
###### `void modificationChanged(bool changed)`
###### `void redoAvailable(bool available)`
###### `void selectionChanged()`
###### `void textChanged()`
###### `void undoAvailable(bool available)`
###### `void updateRequest(const QRect &rect, int dy)`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`
###### `QRectF blockBoundingGeometry(const QTextBlock &block) const`
###### `QRectF blockBoundingRect(const QTextBlock &block) const`
###### `virtual bool canInsertFromMimeData(const QMimeData *source) const`
###### `QPointF contentOffset() const`
###### `virtual QMimeData * createMimeDataFromSelection() const`
###### `QTextBlock firstVisibleBlock() const`
###### `QAbstractTextDocumentLayout::PaintContext getPaintContext() const`
###### `virtual void insertFromMimeData(const QMimeData *source)`

# `Reimplemented Protected Functions`
###### `virtual void changeEvent(QEvent *e)`
###### `virtual void contextMenuEvent(QContextMenuEvent *event)`
###### `virtual void dragEnterEvent(QDragEnterEvent *e)`
###### `virtual void dragLeaveEvent(QDragLeaveEvent *e)`
###### `virtual void dragMoveEvent(QDragMoveEvent *e)`
###### `virtual void dropEvent(QDropEvent *e)`
###### `virtual void focusInEvent(QFocusEvent *e)`
###### `virtual bool focusNextPrevChild(bool next)`
###### `virtual void focusOutEvent(QFocusEvent *e)`
###### `virtual void inputMethodEvent(QInputMethodEvent *e)`
###### `virtual void keyPressEvent(QKeyEvent *e)`
###### `virtual void keyReleaseEvent(QKeyEvent *e)`
###### `virtual void mouseDoubleClickEvent(QMouseEvent *e)`
###### `virtual void mouseMoveEvent(QMouseEvent *e)`
###### `virtual void mousePressEvent(QMouseEvent *e)`
###### `virtual void mouseReleaseEvent(QMouseEvent *e)`
###### `virtual void paintEvent(QPaintEvent *e)`
###### `virtual void resizeEvent(QResizeEvent *e)`
###### `virtual void scrollContentsBy(int dx, int dy)`
###### `virtual void showEvent(QShowEvent *)`
###### `virtual void wheelEvent(QWheelEvent *e)`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`
