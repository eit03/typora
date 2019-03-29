`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QWidgetPrivate

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_WIDGETS_EXPORT QFramePrivate : public QWidgetPrivate
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    QRect       frect;
    int         frameStyle;
    short       lineWidth; //边界线宽
    short       midLineWidth; //路线宽.
    short       frameWidth; //
    short       leftFrameWidth;
    short       rightFrameWidth;
    short       topFrameWidth;
    short       bottomFrameWidth;
    
//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****
public:
    QFramePrivate();
    
//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
}
```

## `Construtor`

```
QFramePrivate::QFramePrivate()
    : frect(0, 0, 0, 0),
      frameStyle(QFrame::NoFrame | QFrame::Plain),
      lineWidth(1),
      midLineWidth(0),
      frameWidth(0),
      leftFrameWidth(0), rightFrameWidth(0),
      topFrameWidth(0), bottomFrameWidth(0)
{}
```

## `Memeory Model`

```
[QFramePrivate]
    [QWidgetPrivate]
    QRect       frect;
    int         frameStyle;
    short       lineWidth;
    short       midLineWidth;
    short       frameWidth;
    short       leftFrameWidth;
    short       rightFrameWidth;
    short       topFrameWidth;
    short       bottomFrameWidth;
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

