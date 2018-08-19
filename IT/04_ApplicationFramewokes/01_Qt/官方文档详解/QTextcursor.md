***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QTextCursor

***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************

//*****************************************************************************************************************
//Properties ***************************************************************************************************

//*****************************************************************************************************************
//Constructor **************************************************************************************************

//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```

```
## `Memeory Model`
```

```

# `Properties`

# `Public Types`
###### `enum MoveMode { MoveAnchor, KeepAnchor }`
###### `enum MoveOperation { NoMove, Start, StartOfLine, StartOfBlock, ..., PreviousRow }`
###### `enum SelectionType { Document, BlockUnderCursor, LineUnderCursor, WordUnderCursor }`

# `Public Functions`
###### `QTextCursor()`
###### `QTextCursor(QTextDocument *document)`
###### `QTextCursor(QTextFrame *frame)`
###### `QTextCursor(const QTextBlock &block)`
###### `QTextCursor(const QTextCursor &cursor)`
###### `~QTextCursor()`
###### `int anchor() const`
###### `bool atBlockEnd() const`
###### `bool atBlockStart() const`
###### `bool atEnd() const`
###### `bool atStart() const`
###### `void beginEditBlock()`
###### `QTextBlock block() const`
###### `QTextCharFormat blockCharFormat() const`
###### `QTextBlockFormat blockFormat() const`
###### `int blockNumber() const`
###### `QTextCharFormat charFormat() const`
###### `void clearSelection()`
###### `int columnNumber() const`
###### `QTextList * createList(const QTextListFormat &format)`
###### `QTextList * createList(QTextListFormat::Style style)`
###### `QTextFrame * currentFrame() const`
###### `QTextList * currentList() const`
###### `QTextTable * currentTable() const`
###### `void deleteChar()`
###### `void deletePreviousChar()`
###### `QTextDocument * document() const`
###### `void endEditBlock()`
###### `bool hasComplexSelection() const`
###### `bool hasSelection() const`
###### `void insertBlock()`
###### `void insertBlock(const QTextBlockFormat &format)`
###### `void insertBlock(const QTextBlockFormat &format, const QTextCharFormat &charFormat)`
###### `void insertFragment(const QTextDocumentFragment &fragment)`
###### `QTextFrame * insertFrame(const QTextFrameFormat &format)`
###### `void insertHtml(const QString &html)`
###### `void insertImage(const QTextImageFormat &format)`
###### `void insertImage(const QTextImageFormat &format, QTextFrameFormat::Position alignment)`
###### `void insertImage(const QString &name)`
###### `void insertImage(const QImage &image, const QString &name = QString())`
###### `QTextList * insertList(const QTextListFormat &format)`
###### `QTextList * insertList(QTextListFormat::Style style)`
###### `QTextTable * insertTable(int rows, int columns, const QTextTableFormat &format)`
###### `QTextTable * insertTable(int rows, int columns)`
###### `void insertText(const QString &text)`
###### `void insertText(const QString &text, const QTextCharFormat &format)`
###### `bool isCopyOf(const QTextCursor &other) const`
###### `bool isNull() const`
###### `void joinPreviousEditBlock()`
###### `bool keepPositionOnInsert() const`
###### `void mergeBlockCharFormat(const QTextCharFormat &modifier)`
###### `void mergeBlockFormat(const QTextBlockFormat &modifier)`
###### `void mergeCharFormat(const QTextCharFormat &modifier)`
###### `bool movePosition(MoveOperation operation, MoveMode mode = MoveAnchor, int n = 1)`
###### `int position() const`
###### `int positionInBlock() const`
###### `void removeSelectedText()`
###### `void select(SelectionType selection)`
###### `void selectedTableCells(int *firstRow, int *numRows, int *firstColumn, int *numColumns) const`
###### `QString selectedText() const`
###### `QTextDocumentFragment selection() const`
###### `int selectionEnd() const`
###### `int selectionStart() const`
###### `void setBlockCharFormat(const QTextCharFormat &format)`
###### `void setBlockFormat(const QTextBlockFormat &format)`
###### `void setCharFormat(const QTextCharFormat &format)`
###### `void setKeepPositionOnInsert(bool b)`
###### `void setPosition(int pos, MoveMode m = MoveAnchor)`
###### `void setVerticalMovementX(int x)`
###### `void setVisualNavigation(bool b)`
###### `void swap(QTextCursor &other)`
###### `int verticalMovementX() const`
###### `bool visualNavigation() const`
###### `bool operator!=(const QTextCursor &other) const`
###### `bool operator<(const QTextCursor &other) const`
###### `bool operator<=(const QTextCursor &other) const`
###### `QTextCursor & operator=(QTextCursor &&other)`
###### `QTextCursor & operator=(const QTextCursor &cursor)`
###### `bool operator==(const QTextCursor &other) const`
###### `bool operator>(const QTextCursor &other) const`
###### `bool operator>=(const QTextCursor &other) const`

# `Reimplemented Public Functions`

# `Public Slots`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`

# `Reimplemented Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`
