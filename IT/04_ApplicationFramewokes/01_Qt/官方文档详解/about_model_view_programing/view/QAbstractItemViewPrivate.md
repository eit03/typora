`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QAbstractItemViewPrivate

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

```
class Q_AUTOTEST_EXPORT QAbstractItemViewPrivate : public QAbstractScrollAreaPrivate
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓↓↓ *****

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓ *****
public:
    QAbstractItemModel *model; //模型
    QPointer<QAbstractItemDelegate> itemDelegate; //项代理
    QMap<int, QPointer<QAbstractItemDelegate> > rowDelegates; //行代理
    QMap<int, QPointer<QAbstractItemDelegate> > columnDelegates; //列代理
    QPointer<QItemSelectionModel> selectionModel; //项选择模型
    QItemSelectionModel::SelectionFlag ctrlDragSelectionFlag; //项选择标志
    bool noSelectionOnMousePress;

    QAbstractItemView::SelectionMode selectionMode;
    QAbstractItemView::SelectionBehavior selectionBehavior;

    QEditorIndexHash editorIndexHash;
    QIndexEditorHash indexEditorHash;
    QSet<QWidget*> persistent;
    QWidget *currentlyCommittingEditor;

    QPersistentModelIndex enteredIndex;
    QPersistentModelIndex pressedIndex;
    QPersistentModelIndex currentSelectionStartIndex;
    Qt::KeyboardModifiers pressedModifiers;
    QPoint pressedPosition;
    bool pressedAlreadySelected;

    //forces the next mouseMoveEvent to send the viewportEntered signal
    //if the mouse is over the viewport and not over an item
    bool viewportEnteredNeeded;

    QAbstractItemView::State state;
    QAbstractItemView::State stateBeforeAnimation;
    QAbstractItemView::EditTriggers editTriggers;
    QAbstractItemView::EditTrigger lastTrigger;

    QPersistentModelIndex root;
    QPersistentModelIndex hover;

    bool tabKeyNavigation;

#ifndef QT_NO_DRAGANDDROP
    bool showDropIndicator;
    QRect dropIndicatorRect;
    bool dragEnabled;
    QAbstractItemView::DragDropMode dragDropMode;
    bool overwrite;
    QAbstractItemView::DropIndicatorPosition dropIndicatorPosition;
    Qt::DropAction defaultDropAction;
#endif

    QString keyboardInput;
    QElapsedTimer keyboardInputTime;

    bool autoScroll;
    QBasicTimer autoScrollTimer;
    int autoScrollMargin;
    int autoScrollCount;
    bool shouldScrollToCurrentOnShow; //used to know if we should scroll to current on show event
    bool shouldClearStatusTip; //if there is a statustip currently shown that need to be cleared when leaving.

    bool alternatingColors;

    QSize iconSize;
    Qt::TextElideMode textElideMode;

    QRegion updateRegion; // used for the internal update system
    QPoint scrollDelayOffset;

    QBasicTimer updateTimer;
    QBasicTimer delayedEditing;
    QBasicTimer delayedAutoScroll; //used when an item is clicked
    QBasicTimer delayedReset;

    QAbstractItemView::ScrollMode verticalScrollMode;
    QAbstractItemView::ScrollMode horizontalScrollMode;

#ifndef QT_NO_GESTURES
    // the selection before the last mouse down. In case we have to restore it for scrolling
    QItemSelection oldSelection;
    QModelIndex oldCurrent;
#endif

    bool currentIndexSet;

    bool wrapItemText;
    mutable bool delayedPendingLayout;
    bool moveCursorUpdatedView;

    // Whether scroll mode has been explicitly set or its value come from SH_ItemView_ScrollMode
    bool verticalScrollModeSet;
    bool horizontalScrollModeSet;

private:
    mutable QBasicTimer delayedLayout;
    mutable QBasicTimer fetchMoreTimer;
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    QAbstractItemViewPrivate();
    
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓ *****
}
```

```
QAbstractItemViewPrivate::QAbstractItemViewPrivate()
    :   model(QAbstractItemModelPrivate::staticEmptyModel()),
        itemDelegate(0),
        selectionModel(0),
        ctrlDragSelectionFlag(QItemSelectionModel::NoUpdate),
        noSelectionOnMousePress(false),
        selectionMode(QAbstractItemView::ExtendedSelection),
        selectionBehavior(QAbstractItemView::SelectItems),
        currentlyCommittingEditor(0),
        pressedModifiers(Qt::NoModifier),
        pressedPosition(QPoint(-1, -1)),
        pressedAlreadySelected(false),
        viewportEnteredNeeded(false),
        state(QAbstractItemView::NoState),
        stateBeforeAnimation(QAbstractItemView::NoState),
        editTriggers(QAbstractItemView::DoubleClicked|QAbstractItemView::EditKeyPressed),
        lastTrigger(QAbstractItemView::NoEditTriggers),
        tabKeyNavigation(false),
#ifndef QT_NO_DRAGANDDROP
        showDropIndicator(true),
        dragEnabled(false),
        dragDropMode(QAbstractItemView::NoDragDrop),
        overwrite(false),
        dropIndicatorPosition(QAbstractItemView::OnItem),
        defaultDropAction(Qt::IgnoreAction),
#endif
        autoScroll(true),
        autoScrollMargin(16),
        autoScrollCount(0),
        shouldScrollToCurrentOnShow(false),
        shouldClearStatusTip(false),
        alternatingColors(false),
        textElideMode(Qt::ElideRight),
        verticalScrollMode(QAbstractItemView::ScrollPerItem),
        horizontalScrollMode(QAbstractItemView::ScrollPerItem),
        currentIndexSet(false),
        wrapItemText(false),
        delayedPendingLayout(true),
        moveCursorUpdatedView(false),
        verticalScrollModeSet(false),
        horizontalScrollModeSet(false)
{
    keyboardInputTime.invalidate();
}
```

```
[QAbstractItemViewPrivate]
    [QAbstractScrollAreaPrivate]
    QAbstractItemModel *model;
    QPointer<QAbstractItemDelegate> itemDelegate;
    QMap<int, QPointer<QAbstractItemDelegate> > rowDelegates;
    QMap<int, QPointer<QAbstractItemDelegate> > columnDelegates;
    QPointer<QItemSelectionModel> selectionModel;
    QItemSelectionModel::SelectionFlag ctrlDragSelectionFlag;
    bool noSelectionOnMousePress;
    QAbstractItemView::SelectionMode selectionMode;
    QAbstractItemView::SelectionBehavior selectionBehavior;
    QEditorIndexHash editorIndexHash;
    QIndexEditorHash indexEditorHash;
    QSet<QWidget*> persistent;
    QWidget *currentlyCommittingEditor;
    QPersistentModelIndex enteredIndex;
    QPersistentModelIndex pressedIndex;
    QPersistentModelIndex currentSelectionStartIndex;
    Qt::KeyboardModifiers pressedModifiers;
    QPoint pressedPosition;
    bool pressedAlreadySelected;
    //forces the next mouseMoveEvent to send the viewportEntered signal
    //if the mouse is over the viewport and not over an item
    bool viewportEnteredNeeded;
    QAbstractItemView::State state;
    QAbstractItemView::State stateBeforeAnimation;
    QAbstractItemView::EditTriggers editTriggers;
    QAbstractItemView::EditTrigger lastTrigger;
    QPersistentModelIndex root;
    QPersistentModelIndex hover;
    bool tabKeyNavigation;
#ifndef QT_NO_DRAGANDDROP
    bool showDropIndicator;
    QRect dropIndicatorRect;
    bool dragEnabled;
    QAbstractItemView::DragDropMode dragDropMode;
    bool overwrite;
    QAbstractItemView::DropIndicatorPosition dropIndicatorPosition;
    Qt::DropAction defaultDropAction;
#endif
    QString keyboardInput;
    QElapsedTimer keyboardInputTime;
    bool autoScroll;
    QBasicTimer autoScrollTimer;
    int autoScrollMargin;
    int autoScrollCount;
    bool shouldScrollToCurrentOnShow; //used to know if we should scroll to current on show event
    bool shouldClearStatusTip; //if there is a statustip currently shown that need to be cleared when leaving.
    bool alternatingColors;
    QSize iconSize;
    Qt::TextElideMode textElideMode;
    QRegion updateRegion; // used for the internal update system
    QPoint scrollDelayOffset;
    QBasicTimer updateTimer;
    QBasicTimer delayedEditing;
    QBasicTimer delayedAutoScroll; //used when an item is clicked
    QBasicTimer delayedReset;
    QAbstractItemView::ScrollMode verticalScrollMode;
    QAbstractItemView::ScrollMode horizontalScrollMode;
#ifndef QT_NO_GESTURES
    // the selection before the last mouse down. In case we have to restore it for scrolling
    QItemSelection oldSelection;
    QModelIndex oldCurrent;
#endif
    bool currentIndexSet;
    bool wrapItemText;
    mutable bool delayedPendingLayout;
    bool moveCursorUpdatedView;
    // Whether scroll mode has been explicitly set or its value come from SH_ItemView_ScrollMode
    bool verticalScrollModeSet;
    bool horizontalScrollModeSet;
    mutable QBasicTimer delayedLayout;
    mutable QBasicTimer fetchMoreTimer;
```

# `Properties`

# `Public Types`

# `Public Functions`

# `Reimplement Public Functions`

# `Public Slots`

# `Signals`

# `Static Public Members`

# `Protected Types`

# `Protected Functions`

# `Reimplement Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`

