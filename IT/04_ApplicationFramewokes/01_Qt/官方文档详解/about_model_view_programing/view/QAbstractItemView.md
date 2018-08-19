`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QAbstractItemView

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

```
class Q_WIDGETS_EXPORT QAbstractItemView : public QAbstractScrollArea
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓↓↓ *****

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓ *****
	//数据全在QAbstractItemViewPrivate* QObject::d_ptr中.
	
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
	explicit QAbstractItemView(QWidget *parent = Q_NULLPTR);
protected:
	QAbstractItemView(QAbstractItemViewPrivate &, QWidget *parent = nullptr);

//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓ *****
}
```

```
QAbstractItemView::QAbstractItemView(QWidget *parent) : QAbstractScrollArea(*(new QAbstractItemViewPrivate), parent) { d_func()->init(); }
QAbstractItemView::QAbstractItemView(QAbstractItemViewPrivate &dd, QWidget *parent) : QAbstractScrollArea(dd, parent) { d_func()->init(); }
```



```
[QAbstractItemView]
	[QAbstractScrollArea]
		...
		[QObject]
			QAbstractItemViewPrivate* d_prt;	//数据全在这里面
```

# `Properties`

###### `alternatingRowColors : bool`
###### `autoScroll : bool`
###### `autoScrollMargin : int`
###### `defaultDropAction : Qt::DropAction`
###### `dragDropMode : DragDropMode`
###### `dragDropOverwriteMode : bool`
###### `dragEnabled : bool`
###### `editTriggers : EditTriggers`
###### `horizontalScrollMode : ScrollMode`
###### `iconSize : QSize`
###### `selectionBehavior : SelectionBehavior`
###### `selectionMode : SelectionMode`
###### `showDropIndicator : bool`
###### `tabKeyNavigation : bool`
###### `textElideMode : Qt::TextElideMode`
###### `verticalScrollMode : ScrollMode`

# `Public Types`

###### `enum DragDropMode { NoDragDrop, DragOnly, DropOnly, DragDrop, InternalMove }`

| Constant                          | Value | Description                                                  |
| --------------------------------- | ----- | ------------------------------------------------------------ |
| `QAbstractItemView::NoDragDrop`   | `0`   | Does not support dragging or dropping.                       |
| `QAbstractItemView::DragOnly`     | `1`   | The view supports dragging of its own items                  |
| `QAbstractItemView::DropOnly`     | `2`   | The view accepts drops                                       |
| `QAbstractItemView::DragDrop`     | `3`   | The view supports both dragging and dropping                 |
| `QAbstractItemView::InternalMove` | `4`   | The view accepts move (**not copy**) operations only from itself. |

###### `enum EditTrigger { NoEditTriggers, CurrentChanged, DoubleClicked, SelectedClicked, ..., AllEditTriggers }`

| Constant                             | Value | Description                                                  |
| ------------------------------------ | ----- | ------------------------------------------------------------ |
| `QAbstractItemView::NoEditTriggers`  | `0`   | No editing possible.                                         |
| `QAbstractItemView::CurrentChanged`  | `1`   | Editing start whenever current item changes.                 |
| `QAbstractItemView::DoubleClicked`   | `2`   | Editing starts when an item is double clicked.               |
| `QAbstractItemView::SelectedClicked` | `4`   | Editing starts when clicking on an already selected item.    |
| `QAbstractItemView::EditKeyPressed`  | `8`   | Editing starts when the platform edit key has been pressed over an item. |
| `QAbstractItemView::AnyKeyPressed`   | `16`  | Editing starts when any key is pressed over an item.         |
| `QAbstractItemView::AllEditTriggers` | `31`  | Editing starts for all above actions.                        |

###### `flags EditTriggers`
###### `enum ScrollHint { EnsureVisible, PositionAtTop, PositionAtBottom, PositionAtCenter }`

| QAbstractItemView::EnsureVisible    | 0  | Scroll to ensure that the item is visible.                 |
| ------------------------------------- | ---- | ---------------------------------------------------------- |
| `QAbstractItemView::PositionAtTop`    | `1`  | Scroll to position the item at the top of the viewport.    |
| `QAbstractItemView::PositionAtBottom` | `2`  | Scroll to position the item at the bottom of the viewport. |
| `QAbstractItemView::PositionAtCenter` | `3`  | Scroll to position the item at the center of the viewport. |

###### `enum ScrollMode { ScrollPerItem, ScrollPerPixel }`

| Constant                            | Value | Description                                            |
| ----------------------------------- | ----- | ------------------------------------------------------ |
| `QAbstractItemView::ScrollPerItem`  | `0`   | The view will scroll the contents one item at a time.  |
| `QAbstractItemView::ScrollPerPixel` | `1`   | The view will scroll the contents one pixel at a time. |

###### `enum SelectionBehavior { SelectItems, SelectRows, SelectColumns }`

| Constant                           | Value | Description             |
| ---------------------------------- | ----- | ----------------------- |
| `QAbstractItemView::SelectItems`   | `0`   | Selecting single items. |
| `QAbstractItemView::SelectRows`    | `1`   | Selecting only rows.    |
| `QAbstractItemView::SelectColumns` | `2`   | Selecting only columns. |

###### `enum SelectionMode { SingleSelection, ContiguousSelection, ExtendedSelection, MultiSelection, NoSelection }`

| Constant                                 | Value | Description                                                  |
| ---------------------------------------- | ----- | ------------------------------------------------------------ |
| `QAbstractItemView::SingleSelection`     | `1`   | When the user selects an item, any already-selected item becomes unselected. It is possible for the user to deselect the selected item.<br />用户的当前选择会取消前面的选择. |
| `QAbstractItemView::ContiguousSelection` | `4`   | When the user selects an item in the usual way, the selection is cleared and the new item selected. However, if the user presses the Shift key while clicking on an item, all items between the current item and the clicked item are selected or unselected, depending on the state of the clicked item.<br />用户可以用Shift键增加选择. |
| `QAbstractItemView::ExtendedSelection`   | `3`   | When the user selects an item in the usual way, the selection is cleared and the new item selected. However, if the user presses the Ctrl key when clicking on an item, the clicked item gets toggled and all other items are left untouched. If the user presses the Shift key while clicking on an item, all items between the current item and the clicked item are selected or unselected, depending on the state of the clicked item. Multiple items can be selected by dragging the mouse over them.<br />用户可以用Ctrl键切换选择项的状态,此时其它项是不受影响的;用户可以选择一个当前项,再用Shift选择一个项,组成矩形选择;拖动鼠标可以多选. |
| `QAbstractItemView::MultiSelection`      | `2`   | When the user selects an item in the usual way, the selection status of that item is toggled and the other items are left alone. Multiple items can be toggled by dragging the mouse over them.<br />用户的当前选择会切换项状态,其它项无影响;拖动鼠标可以切换选择项. |
| `QAbstractItemView::NoSelection`         | `0`   | Items cannot be selected.                                    |

# `Public Functions`

###### `QAbstractItemView(QWidget *parent = Q_NULLPTR)`
###### `~QAbstractItemView()`
###### `bool alternatingRowColors() const`
###### `int autoScrollMargin() const`
###### `void closePersistentEditor(const QModelIndex &index)`
###### `QModelIndex currentIndex() const`
###### `Qt::DropAction defaultDropAction() const`
###### `DragDropMode dragDropMode() const`
###### `bool dragDropOverwriteMode() const`
###### `bool dragEnabled() const`
###### `EditTriggers editTriggers() const`
###### `bool hasAutoScroll() const`
###### `ScrollMode horizontalScrollMode() const`
###### `QSize iconSize() const`
###### `virtual QModelIndex indexAt(const QPoint &point) const = 0`
###### `QWidget * indexWidget(const QModelIndex &index) const`
###### `bool isPersistentEditorOpen(const QModelIndex &index) const`
###### `QAbstractItemDelegate * itemDelegate() const`
###### `QAbstractItemDelegate * itemDelegate(const QModelIndex &index) const`
###### `QAbstractItemDelegate * itemDelegateForColumn(int column) const`
###### `QAbstractItemDelegate * itemDelegateForRow(int row) const`
###### `virtual void keyboardSearch(const QString &search)`
###### `QAbstractItemModel * model() const`
###### `void openPersistentEditor(const QModelIndex &index)`
###### `void resetHorizontalScrollMode()`
###### `void resetVerticalScrollMode()`
###### `QModelIndex rootIndex() const`
###### `virtual void scrollTo(const QModelIndex &index, ScrollHint hint = EnsureVisible) = 0`
###### `QAbstractItemView::SelectionBehavior selectionBehavior() const`
###### `QAbstractItemView::SelectionMode selectionMode() const`
###### `QItemSelectionModel * selectionModel() const`
###### `void setAlternatingRowColors(bool enable)`
###### `void setAutoScroll(bool enable)`
###### `void setAutoScrollMargin(int margin)`
###### `void setDefaultDropAction(Qt::DropAction dropAction)`
###### `void setDragDropMode(DragDropMode behavior)`
###### `void setDragDropOverwriteMode(bool overwrite)`
###### `void setDragEnabled(bool enable)`
###### `void setDropIndicatorShown(bool enable)`
###### `void setEditTriggers(EditTriggers triggers)`
###### `void setHorizontalScrollMode(ScrollMode mode)`
###### `void setIconSize(const QSize &size)`
###### `void setIndexWidget(const QModelIndex &index, QWidget *widget)`
###### `void setItemDelegate(QAbstractItemDelegate *delegate)`
###### `void setItemDelegateForColumn(int column, QAbstractItemDelegate *delegate)`
###### `void setItemDelegateForRow(int row, QAbstractItemDelegate *delegate)`
###### `virtual void setModel(QAbstractItemModel *model)`
###### `void setSelectionBehavior(QAbstractItemView::SelectionBehavior behavior)`
###### `void setSelectionMode(QAbstractItemView::SelectionMode mode)`
###### `virtual void setSelectionModel(QItemSelectionModel *selectionModel)`
###### `void setTabKeyNavigation(bool enable)`
###### `void setTextElideMode(Qt::TextElideMode mode)`
###### `void setVerticalScrollMode(ScrollMode mode)`
###### `bool showDropIndicator() const`
###### `virtual int sizeHintForColumn(int column) const`
###### `QSize sizeHintForIndex(const QModelIndex &index) const`
###### `virtual int sizeHintForRow(int row) const`
###### `bool tabKeyNavigation() const`
###### `Qt::TextElideMode textElideMode() const`
###### `ScrollMode verticalScrollMode() const`
###### `virtual QRect visualRect(const QModelIndex &index) const = 0`

# `Reimplement Public Functions`

###### `virtual QVariant inputMethodQuery(Qt::InputMethodQuery query) const`

# `Public Slots`

###### `void clearSelection()`
###### `void edit(const QModelIndex &index)`
###### `virtual void reset()`
###### `void scrollToBottom()`
###### `void scrollToTop()`
###### `virtual void selectAll()`
###### `void setCurrentIndex(const QModelIndex &index)`
###### `virtual void setRootIndex(const QModelIndex &index)`
###### `void update(const QModelIndex &index)`

# `Signals`

###### `void activated(const QModelIndex &index)`
###### `void clicked(const QModelIndex &index)`
###### `void doubleClicked(const QModelIndex &index)`
###### `void entered(const QModelIndex &index)`
###### `void iconSizeChanged(const QSize &size)`
###### `void pressed(const QModelIndex &index)`
###### `void viewportEntered()`

# `Static Public Members`

# `Protected Types`

###### `enum CursorAction { MoveUp, MoveDown, MoveLeft, MoveRight, ..., MovePrevious }`
###### `enum DropIndicatorPosition { OnItem, AboveItem, BelowItem, OnViewport }`
###### `enum State { NoState, DraggingState, DragSelectingState, EditingState, ..., AnimatingState }`

# `Protected Functions`

###### `QPoint dirtyRegionOffset() const`
###### `DropIndicatorPosition dropIndicatorPosition() const`
###### `virtual bool edit(const QModelIndex &index, EditTrigger trigger, QEvent *event)`
###### `void executeDelayedItemsLayout()`
###### `virtual int horizontalOffset() const = 0`
###### `virtual bool isIndexHidden(const QModelIndex &index) const = 0`
###### `virtual QModelIndex moveCursor(CursorAction cursorAction, Qt::KeyboardModifiers modifiers) = 0`
###### `void scheduleDelayedItemsLayout()`
###### `void scrollDirtyRegion(int dx, int dy)`
###### `virtual QModelIndexList selectedIndexes() const`
###### `virtual QItemSelectionModel::SelectionFlags selectionCommand(const QModelIndex &index, const QEvent *event = Q_NULLPTR) const`
###### `void setDirtyRegion(const QRegion &region)`
###### `virtual void setSelection(const QRect &rect, QItemSelectionModel::SelectionFlags flags) = 0`
###### `void setState(State state)`
###### `virtual void startDrag(Qt::DropActions supportedActions)`
###### `State state() const`
###### `virtual int verticalOffset() const = 0`
###### `virtual QStyleOptionViewItem viewOptions() const`
###### `virtual QRegion visualRegionForSelection(const QItemSelection &selection) const = 0`

# `Reimplement Protected Functions`

###### `virtual void dragEnterEvent(QDragEnterEvent *event)`
###### `virtual void dragLeaveEvent(QDragLeaveEvent *event)`
###### `virtual void dragMoveEvent(QDragMoveEvent *event)`
###### `virtual void dropEvent(QDropEvent *event)`
###### `virtual bool event(QEvent *event)`
###### `virtual void focusInEvent(QFocusEvent *event)`
###### `virtual bool focusNextPrevChild(bool next)`
###### `virtual void focusOutEvent(QFocusEvent *event)`
###### `virtual void inputMethodEvent(QInputMethodEvent *event)`
###### `virtual void keyPressEvent(QKeyEvent *event)`
###### `virtual void mouseDoubleClickEvent(QMouseEvent *event)`
###### `virtual void mouseMoveEvent(QMouseEvent *event)`
###### `virtual void mousePressEvent(QMouseEvent *event)`
###### `virtual void mouseReleaseEvent(QMouseEvent *event)`
###### `virtual void resizeEvent(QResizeEvent *event)`
###### `virtual void timerEvent(QTimerEvent *event)`
###### `virtual bool viewportEvent(QEvent *event)`
###### `virtual QSize viewportSizeHint() const`

# `Protected Slots`

###### `virtual void closeEditor(QWidget *editor, QAbstractItemDelegate::EndEditHint hint)`
###### `virtual void commitData(QWidget *editor)`
###### `virtual void currentChanged(const QModelIndex &current, const QModelIndex &previous)`
###### `virtual void dataChanged(const QModelIndex &topLeft, const QModelIndex &bottomRight, const QVector<int> &roles = QVector<int> ())`
###### `virtual void editorDestroyed(QObject *editor)`
###### `virtual void rowsAboutToBeRemoved(const QModelIndex &parent, int start, int end)`
###### `virtual void rowsInserted(const QModelIndex &parent, int start, int end)`
###### `virtual void selectionChanged(const QItemSelection &selected, const QItemSelection &deselected)`
###### `virtual void updateGeometries()`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`

