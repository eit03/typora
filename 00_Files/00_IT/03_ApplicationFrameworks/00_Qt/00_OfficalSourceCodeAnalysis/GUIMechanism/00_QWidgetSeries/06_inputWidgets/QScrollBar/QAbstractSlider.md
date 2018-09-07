***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QAbstractSlider
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_WIDGETS_EXPORT QAbstractSlider : public QWidget
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************
public:
    enum SliderAction {
        SliderNoAction,
        SliderSingleStepAdd,
        SliderSingleStepSub,
        SliderPageStepAdd,
        SliderPageStepSub,
        SliderToMinimum,
        SliderToMaximum,
        SliderMove
    };
protected:
    enum SliderChange {
        SliderRangeChange,
        SliderOrientationChange,
        SliderStepsChange,
        SliderValueChange
    };
    
//*****************************************************************************************************************
//Properties ***************************************************************************************************
public:
    explicit QAbstractSlider(QWidget *parent = Q_NULLPTR);
protected:
    QAbstractSlider(QAbstractSliderPrivate &dd, QWidget *parent = Q_NULLPTR);
    
//*****************************************************************************************************************
//Constructor **************************************************************************************************

//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```
QAbstractSlider::QAbstractSlider(QWidget *parent) : QWidget(*new QAbstractSliderPrivate, parent, 0) {}
QAbstractSlider::QAbstractSlider(QAbstractSliderPrivate &dd, QWidget *parent) :QWidget(dd, parent, 0) {}
```
## `Memeory Model`
```
[QAbstractSlider]
    [QWidget]
```

# `Properties`
###### `invertedAppearance : bool`
###### `invertedControls : bool`
###### `maximum : int`
###### `minimum : int`
###### `orientation : Qt::Orientation`
###### `pageStep : int`
###### `singleStep : int`
###### `sliderDown : bool`
###### `sliderPosition : int`
###### `tracking : bool`
###### `value : int`

# `Public Types`
###### `enum SliderAction { SliderNoAction, SliderSingleStepAdd, SliderSingleStepSub, SliderPageStepAdd, ..., SliderMove }`

# `Public Functions`
###### `QAbstractSlider(QWidget *parent = Q_NULLPTR)`
###### `~QAbstractSlider()`
###### `bool hasTracking() const`
###### `bool invertedAppearance() const`
###### `bool invertedControls() const`
###### `bool isSliderDown() const`
###### `int maximum() const`
###### `int minimum() const`
###### `Qt::Orientation orientation() const`
###### `int pageStep() const`
###### `void setInvertedAppearance(bool)`
###### `void setInvertedControls(bool)`
###### `void setMaximum(int)`
```
void QAbstractSlider::setMaximum(int max)
{
    Q_D(QAbstractSlider);
    setRange(qMin(d->minimum, max), max);
}
```
###### `void setMinimum(int)`
```
void QAbstractSlider::setMinimum(int min)
{
    Q_D(QAbstractSlider);
    setRange(min, qMax(d->maximum, min));
}
```
###### `void setPageStep(int)`
###### `void setSingleStep(int)`
###### `void setSliderDown(bool)`
###### `void setSliderPosition(int)`
###### `void setTracking(bool enable)`
###### `int singleStep() const`
###### `int sliderPosition() const`
###### `void triggerAction(SliderAction action)`
###### `int value() const`

# `Reimplement Public Functions`

# `Public Slots`
###### `void setOrientation(Qt::Orientation)`
###### `void setRange(int min, int max)`
```
void QAbstractSlider::setRange(int min, int max)
{
    Q_D(QAbstractSlider);
    int oldMin = d->minimum;
    int oldMax = d->maximum;
    d->minimum = min;
    d->maximum = qMax(min, max);
    if (oldMin != d->minimum || oldMax != d->maximum) {
        sliderChange(SliderRangeChange);
        emit rangeChanged(d->minimum, d->maximum);
        setValue(d->value); // re-bound
    }
}
```
###### `void setValue(int)`

# `Signals`
###### `void actionTriggered(int action)`
###### `void rangeChanged(int min, int max)`
###### `void sliderMoved(int value)`
###### `void sliderPressed()`
###### `void sliderReleased()`
###### `void valueChanged(int value)`

# `Static Public Members`

# `Protected Types`
###### `enum SliderChange { SliderRangeChange, SliderOrientationChange, SliderStepsChange, SliderValueChange }`

# `Protected Functions`
###### `SliderAction repeatAction() const`
###### `void setRepeatAction(SliderAction action, int thresholdTime = 500, int repeatTime = 50)`
###### `virtual void sliderChange(SliderChange change)`
###### `Reimplemented Protected Functions`
###### `virtual void changeEvent(QEvent *ev)`
###### `virtual bool event(QEvent *e)`
###### `virtual void keyPressEvent(QKeyEvent *ev)`
###### `virtual void timerEvent(QTimerEvent *e)`
###### `virtual void wheelEvent(QWheelEvent *e)`

# `Reimplement Protected Functions`

# `Protected Slots`

# `Protected Public Members`

# `Private Types`

# `Private Functions`

# `Private Slots`

# `Static Private Members`

# `Related Non-Members`

# `Macros`
