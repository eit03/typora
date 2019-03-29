***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QPlainTextEditPrivate
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class QPlainTextEditPrivate : public QAbstractScrollAreaPrivate
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************

//*****************************************************************************************************************
//Properties ***************************************************************************************************
public:
    QPlainTextEditControl *control;
    bool tabChangesFocus; //tab键是否切换焦点.
    QBasicTimer autoScrollTimer; //自动滚动定时器.
    QPoint autoScrollDragPos;
    QPlainTextEdit::LineWrapMode lineWrap; //换行模式.
    QTextOption::WrapMode wordWrap; //单词换行模式.
    uint showCursorOnInitialShow : 1;
    uint backgroundVisible : 1; //中心部件背景可见标志.
    uint centerOnScroll : 1; 
    uint inDrag : 1; 
    uint clickCausedFocus : 1;
    int topLine;
    qreal topLineFracture; // for non-int sized fonts
    QPointer<QPlainTextDocumentLayout> documentLayoutPtr;
    qreal pageUpDownLastCursorY;
    bool pageUpDownLastCursorYIsValid;
#ifdef QT_KEYPAD_NAVIGATION
    QBasicTimer deleteAllTimer;
#endif
    int originalOffsetY;
    QString placeholderText; //占位符文本.
    
//*****************************************************************************************************************
//Constructor **************************************************************************************************
public:
    QPlainTextEditPrivate();
    
//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```
QPlainTextEditPrivate::QPlainTextEditPrivate()
    : control(0),
      tabChangesFocus(false),
      lineWrap(QPlainTextEdit::WidgetWidth),
      wordWrap(QTextOption::WrapAtWordBoundaryOrAnywhere),
      clickCausedFocus(0),topLine(0),topLineFracture(0),
      pageUpDownLastCursorYIsValid(false)
{
    showCursorOnInitialShow = true;
    backgroundVisible = false;
    centerOnScroll = false;
    inDrag = false;
}
```
## `Memeory Model`
```
[QPlainTextEditPrivate]
    [QAbstractScrollAreaPrivate]
    QPlainTextEditControl *control;
    bool tabChangesFocus;
    QBasicTimer autoScrollTimer;
    QPoint autoScrollDragPos;
    QPlainTextEdit::LineWrapMode lineWrap;
    QTextOption::WrapMode wordWrap;
    uint showCursorOnInitialShow : 1;
    uint backgroundVisible : 1;
    uint centerOnScroll : 1;
    uint inDrag : 1;
    uint clickCausedFocus : 1;
    int topLine;
    qreal topLineFracture; // for non-int sized fonts
    QPointer<QPlainTextDocumentLayout> documentLayoutPtr;
    qreal pageUpDownLastCursorY;
    bool pageUpDownLastCursorYIsValid;
#ifdef QT_KEYPAD_NAVIGATION
    QBasicTimer deleteAllTimer;
#endif
    int originalOffsetY;
    QString placeholderText;
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
