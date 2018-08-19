***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QTextDocumentPrivate
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_GUI_EXPORT QTextDocumentPrivate : public QObjectPrivate
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************

//*****************************************************************************************************************
//Properties ***************************************************************************************************
ublic:
    QTextOption defaultTextOption;
    Qt::CursorMoveStyle defaultCursorMoveStyle;
#ifndef QT_NO_CSSPARSER
    QCss::StyleSheet parsedDefaultStyleSheet;
#endif
    int maximumBlockCount;
    uint needsEnsureMaximumBlockCount : 1;
    uint inContentsChange : 1;
    uint blockCursorAdjustment : 1;
    QSizeF pageSize;
    QString title;
    QString url;
    qreal indentWidth;
    qreal documentMargin;
    QUrl baseUrl;
    
//*****************************************************************************************************************
//Constructor **************************************************************************************************

//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```
QTextDocumentPrivate::QTextDocumentPrivate()
    : wasUndoAvailable(false),
    wasRedoAvailable(false),
    docChangeOldLength(0),
    docChangeLength(0),
    framesDirty(true),
    rtFrame(0),
    initialBlockCharFormatIndex(-1) // set correctly later in init()
{
    editBlock = 0;
    editBlockCursorPosition = -1;
    docChangeFrom = -1;

    undoState = 0;
    revision = -1; // init() inserts a block, bringing it to 0

    lout = 0;

    modified = false;
    modifiedState = 0;

    undoEnabled = true;
    inContentsChange = false;
    blockCursorAdjustment = false;

    defaultTextOption.setTabStopDistance(80); // same as in qtextengine.cpp
    defaultTextOption.setWrapMode(QTextOption::WrapAtWordBoundaryOrAnywhere);
    defaultCursorMoveStyle = Qt::LogicalMoveStyle;

    indentWidth = 40;
    documentMargin = 4;

    maximumBlockCount = 0;
    needsEnsureMaximumBlockCount = false;
    unreachableCharacterCount = 0;
    lastBlockCount = 0;
}

```
## `Memeory Model`
```

```

# `Properties`

# `Public Types`

# `Public Functions`

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
