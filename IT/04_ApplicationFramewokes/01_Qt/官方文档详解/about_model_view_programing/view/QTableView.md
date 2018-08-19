`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QTableView

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

```
class Q_WIDGETS_EXPORT QTableView : public QAbstractItemView
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓↓↓ *****

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓ *****

//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    explicit QTableView(QWidget *parent = Q_NULLPTR);
    
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓ *****
}
```

```
QTableView::QTableView(QWidget *parent) : QAbstractItemView(*new QTableViewPrivate, parent)
{
    Q_D(QTableView);
    d->init();
}
```

```
[QTableView]
	[QAbstractItemView]
```

# `Properties`

###### `cornerButtonEnabled : bool`
###### `gridStyle : Qt::PenStyle`
###### `showGrid : bool`
###### `sortingEnabled : bool`
###### `wordWrap : bool`

# `Public Types`

# `Public Functions`

###### `QTableView(QWidget *parent = Q_NULLPTR)`
###### `~QTableView()`
###### `void clearSpans()`
###### `int columnAt(int x) const`
###### `int columnSpan(int row, int column) const`
###### `int columnViewportPosition(int column) const`
###### `int columnWidth(int column) const`
###### `Qt::PenStyle gridStyle() const`
###### `QHeaderView * horizontalHeader() const`
###### `bool isColumnHidden(int column) const`
###### `bool isCornerButtonEnabled() const`
###### `bool isRowHidden(int row) const`
###### `bool isSortingEnabled() const`
###### `int rowAt(int y) const`
###### `int rowHeight(int row) const`
###### `int rowSpan(int row, int column) const`
###### `int rowViewportPosition(int row) const`
###### `void setColumnHidden(int column, bool hide)`
###### `void setColumnWidth(int column, int width)`
###### `void setCornerButtonEnabled(bool enable)`
###### `void setGridStyle(Qt::PenStyle style)`
###### `void setHorizontalHeader(QHeaderView *header)`
###### `void setRowHeight(int row, int height)`
###### `void setRowHidden(int row, bool hide)`
###### `void setSortingEnabled(bool enable)`
###### `void setSpan(int row, int column, int rowSpanCount, int columnSpanCount)`
###### `void setVerticalHeader(QHeaderView *header)`
###### `void setWordWrap(bool on)`
###### `bool showGrid() const`
###### `void sortByColumn(int column, Qt::SortOrder order)`
###### `QHeaderView * verticalHeader() const`
###### `bool wordWrap() const`

# `Reimplement Public Functions`

###### `virtual QModelIndex indexAt(const QPoint &pos) const`
###### `virtual void setModel(QAbstractItemModel *model)`
###### `virtual void setRootIndex(const QModelIndex &index)`
###### `virtual void setSelectionModel(QItemSelectionModel *selectionModel)`

# `Public Slots`

###### `void hideColumn(int column)`
###### `void hideRow(int row)`
###### `void resizeColumnToContents(int column)`
###### `void resizeColumnsToContents()`
###### `void resizeRowToContents(int row)`
###### `void resizeRowsToContents()`
###### `void selectColumn(int column)`
###### `void selectRow(int row)`
###### `void setShowGrid(bool show)`
###### `void showColumn(int column)`
###### `void showRow(int row)`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`

# `Reimplement Protected Functions`

###### `virtual void currentChanged(const QModelIndex &current, const QModelIndex &previous)`
###### `virtual int horizontalOffset() const`
###### `virtual bool isIndexHidden(const QModelIndex &index) const`
###### `virtual QModelIndex moveCursor(CursorAction cursorAction, Qt::KeyboardModifiers modifiers)`
###### `virtual void paintEvent(QPaintEvent *event)`
###### `virtual QModelIndexList selectedIndexes() const`
###### `virtual void selectionChanged(const QItemSelection &selected, const QItemSelection &deselected)`
###### `virtual void setSelection(const QRect &rect, QItemSelectionModel::SelectionFlags flags)`
###### `virtual int sizeHintForColumn(int column) const`
###### `virtual int sizeHintForRow(int row) const`
###### `virtual void timerEvent(QTimerEvent *event)`
###### `virtual void updateGeometries()`
###### `virtual int verticalOffset() const`
###### `virtual QStyleOptionViewItem viewOptions() const`
###### `virtual QSize viewportSizeHint() const`

# `Protected Slots`

###### `void columnCountChanged(int oldCount, int newCount)`
###### `void columnMoved(int column, int oldIndex, int newIndex)`
###### `void columnResized(int column, int oldWidth, int newWidth)`
###### `void rowCountChanged(int oldCount, int newCount)`
###### `void rowMoved(int row, int oldIndex, int newIndex)`
###### `void rowResized(int row, int oldHeight, int newHeight)`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`

