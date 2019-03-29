`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` 

------

[TOC]

------

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class QAbstractSliderPrivate : public QWidgetPrivate
{
//**************************************************************************************************************
//Prepare ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ********

//**************************************************************************************************************
//Properties ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ *****
public:
    int minimum; //页控件范围最小值,可以为负值.
    int maximum; //页控件范围最大值,可以为负值.
    int pageStep; //页步.
    int value; //滑块头位置在页控件范围中表的值.
    int position;
    int pressValue; //拖动时,滑块头位置在页控件范围中表的值.
    
    int singleStep; //单步(行步). //Call effectiveSingleStep() when changing the slider value.
    int singleStepFromItemView; // If we have itemViews we track the views preferred singleStep value.
    bool viewMayChangeSingleStep;

    float offset_accumulated;
    uint tracking : 1; //是否跟踪滑块按下.
    uint blocktracking :1;
    uint pressed : 1; //滑块是否按下.
    uint invertedAppearance : 1; //反转滑块方向.
    uint invertedControls : 1; //反转page up\down 快捷键.
    Qt::Orientation orientation; //部件的方向

    QBasicTimer repeatActionTimer;
    int repeatActionTime;
    QAbstractSlider::SliderAction repeatAction;

#ifdef QT_KEYPAD_NAVIGATION
    int origValue;
    bool isAutoRepeating;
    qreal repeatMultiplier; //When we're auto repeating, we multiply singleStep with this value to get our effective step.
    QElapsedTimer firstRepeat; //The time of when the first auto repeating key press event occurs.
#endif

//**************************************************************************************************************
//Constructor ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ****

//**************************************************************************************************************
//Functions ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ↓↓↓↓ ******
}
```

## `Construtor`

```
QAbstractSliderPrivate::QAbstractSliderPrivate()
    : minimum(0), maximum(99), pageStep(10), value(0), position(0), pressValue(-1),
      singleStep(1), singleStepFromItemView(-1), viewMayChangeSingleStep(true), offset_accumulated(0), tracking(true),
      blocktracking(false), pressed(false),
      invertedAppearance(false), invertedControls(false),
      orientation(Qt::Horizontal), repeatAction(QAbstractSlider::SliderNoAction)
#ifdef QT_KEYPAD_NAVIGATION
      , isAutoRepeating(false)
      , repeatMultiplier(1)
{
    firstRepeat.invalidate();
#else
{
#endif
}
```

## `Memeory Model`

```
[QAbstractSliderPrivate]
    [QWidgetPrivate]
    int minimum;
    int maximum;
    int pageStep;
    int value;
    int position;
    int pressValue;
    int singleStep;
    int singleStepFromItemView;
    bool viewMayChangeSingleStep;
    float offset_accumulated;
    uint tracking : 1;
    uint blocktracking :1;
    uint pressed : 1;
    uint invertedAppearance : 1;
    uint invertedControls : 1;
    Qt::Orientation orientation;
    QBasicTimer repeatActionTimer;
    int repeatActionTime;
    QAbstractSlider::SliderAction repeatAction;
#ifdef QT_KEYPAD_NAVIGATION
    int origValue;
    bool isAutoRepeating;
    qreal repeatMultiplier;
    QElapsedTimer firstRepeat;
#endif
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

