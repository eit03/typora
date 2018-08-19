***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QTextDocument

***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_GUI_EXPORT QTextDocument : public QObject
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************

//*****************************************************************************************************************
//Properties ***************************************************************************************************

//*****************************************************************************************************************
//Constructor **************************************************************************************************
public:
    explicit QTextDocument(QObject *parent = Q_NULLPTR);
    explicit QTextDocument(const QString &text, QObject *parent = Q_NULLPTR);
protected:
    QTextDocument(QTextDocumentPrivate &dd, QObject *parent);
    
//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```
QTextDocument::QTextDocument(QObject *parent) : QObject(*new QTextDocumentPrivate, parent)
{
    Q_D(QTextDocument);
    d->init();
}

QTextDocument::QTextDocument(const QString &text, QObject *parent) : QObject(*new QTextDocumentPrivate, parent)
{
    Q_D(QTextDocument);
    d->init();
    QTextCursor(this).insertText(text);
}

QTextDocument::QTextDocument(QTextDocumentPrivate &dd, QObject *parent) : QObject(dd, parent)
{
    Q_D(QTextDocument);
    d->init();
}
```
## `Memeory Model`
```
[QTextDocument]
    [QObject]
        __vfptr;
        QTextDocumentPrivate* QObject::d_ptr;
```

# `Properties`
###### `baseUrl : QUrl`
###### `blockCount : const int`
###### `defaultFont : QFont`
###### `defaultStyleSheet : QString`
###### `defaultTextOption : QTextOption`
###### `documentMargin : qreal`
###### `indentWidth : qreal`
###### `maximumBlockCount : int`
###### `modified : bool`
###### `pageSize : QSizeF`
###### `size : const QSizeF`
###### `textWidth : qreal`
###### `undoRedoEnabled : bool`
###### `useDesignMetrics : bool`

# `Public Types`
###### `enum FindFlag { FindBackward, FindCaseSensitively, FindWholeWords }`
###### `flags FindFlags`
###### `enum MetaInformation { DocumentTitle, DocumentUrl }`
###### `enum ResourceType { HtmlResource, ImageResource, StyleSheetResource, UserResource }`
###### `enum Stacks { UndoStack, RedoStack, UndoAndRedoStacks }`

# `Public Functions`
###### `QTextDocument(QObject *parent = Q_NULLPTR)`
###### `QTextDocument(const QString &text, QObject *parent = Q_NULLPTR)`
###### `~QTextDocument()`
###### `void addResource(int type, const QUrl &name, const QVariant &resource)`
###### `void adjustSize()`
###### `QVector<QTextFormat> allFormats() const`
###### `int availableRedoSteps() const`
###### `int availableUndoSteps() const`
###### `QUrl baseUrl() const`
###### `QTextBlock begin() const`
###### `int blockCount() const`
###### `QChar characterAt(int pos) const`
###### `int characterCount() const`
###### `virtual void clear()`
###### `void clearUndoRedoStacks(Stacks stacksToClear = UndoAndRedoStacks)`
###### `QTextDocument * clone(QObject *parent = Q_NULLPTR) const`
###### `Qt::CursorMoveStyle defaultCursorMoveStyle() const`
###### `QFont defaultFont() const`
###### `QString defaultStyleSheet() const`
###### `QTextOption defaultTextOption() const`
###### `QAbstractTextDocumentLayout * documentLayout() const`
###### `qreal documentMargin() const`
###### `void drawContents(QPainter *p, const QRectF &rect = QRectF())`
###### `QTextBlock end() const`
###### `QTextCursor find(const QString &subString, const QTextCursor &cursor, FindFlags options = FindFlags()) const`
###### `QTextCursor find(const QString &subString, int position = 0, FindFlags options = FindFlags()) const`
###### `QTextCursor find(const QRegExp &expr, int from = 0, FindFlags options = FindFlags()) const`
###### `QTextCursor find(const QRegExp &expr, const QTextCursor &cursor, FindFlags options = FindFlags()) const`
###### `QTextCursor find(const QRegularExpression &expr, int from = 0, FindFlags options = FindFlags()) const`
###### `QTextCursor find(const QRegularExpression &expr, const QTextCursor &cursor, FindFlags options = FindFlags()) const`
###### `QTextBlock findBlock(int pos) const`
###### `QTextBlock findBlockByLineNumber(int lineNumber) const`
###### `QTextBlock findBlockByNumber(int blockNumber) const`
###### `QTextBlock firstBlock() const`
###### `qreal idealWidth() const`
###### `qreal indentWidth() const`
###### `bool isEmpty() const`
###### `bool isModified() const`
###### `bool isRedoAvailable() const`
###### `bool isUndoAvailable() const`
###### `bool isUndoRedoEnabled() const`
###### `QTextBlock lastBlock() const`
###### `int lineCount() const`
###### `void markContentsDirty(int position, int length)`
###### `int maximumBlockCount() const`
###### `QString metaInformation(MetaInformation info) const`
###### `QTextObject * object(int objectIndex) const`
###### `QTextObject * objectForFormat(const QTextFormat &f) const`
###### `int pageCount() const`
###### `QSizeF pageSize() const`
###### `void print(QPagedPaintDevice *printer) const`
###### `void redo(QTextCursor *cursor)`
###### `QVariant resource(int type, const QUrl &name) const`
###### `int revision() const`
###### `QTextFrame * rootFrame() const`
###### `void setBaseUrl(const QUrl &url)`
###### `void setDefaultCursorMoveStyle(Qt::CursorMoveStyle style)`
###### `void setDefaultFont(const QFont &font)`
###### `void setDefaultStyleSheet(const QString &sheet)`
###### `void setDefaultTextOption(const QTextOption &option)`
###### `void setDocumentLayout(QAbstractTextDocumentLayout *layout)`
###### `void setDocumentMargin(qreal margin)`
###### `void setHtml(const QString &html)`
###### `void setIndentWidth(qreal width)`
###### `void setMaximumBlockCount(int maximum)`
###### `void setMetaInformation(MetaInformation info, const QString &string)`
###### `void setPageSize(const QSizeF &size)`
###### `void setPlainText(const QString &text)`
###### `void setTextWidth(qreal width)`
###### `void setUndoRedoEnabled(bool enable)`
###### `void setUseDesignMetrics(bool b)`
###### `QSizeF size() const`
###### `qreal textWidth() const`
###### `QString toHtml(const QByteArray &encoding = QByteArray()) const`
###### `QString toPlainText() const`
###### `QString toRawText() const`
###### `void undo(QTextCursor *cursor)`
###### `bool useDesignMetrics() const`

# `Reimplemented Public Functions`

# `Public Slots`
###### `void redo()`
###### `void setModified(bool m = true)`
###### `void undo()`

# `Signals`
###### `void baseUrlChanged(const QUrl &url)`
###### `void blockCountChanged(int newBlockCount)`
###### `void contentsChange(int position, int charsRemoved, int charsAdded)`
###### `void contentsChanged()`
###### `void cursorPositionChanged(const QTextCursor &cursor)`
###### `void documentLayoutChanged()`
###### `void modificationChanged(bool changed)`
###### `void redoAvailable(bool available)`
###### `void undoAvailable(bool available)`
###### `void undoCommandAdded()`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`
###### `virtual QTextObject * createObject(const QTextFormat &format)`
###### `virtual QVariant loadResource(int type, const QUrl &name)`

# `Reimplemented Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`
