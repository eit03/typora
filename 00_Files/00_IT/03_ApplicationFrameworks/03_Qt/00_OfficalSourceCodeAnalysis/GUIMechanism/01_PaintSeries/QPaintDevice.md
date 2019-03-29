***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` \[QPaintDevice\]

***
[TOC]
***



# `Brief Introduction`



# `Detailed Description`



# `Data Struct`
## `Type Declaration`
```
class Q_GUI_EXPORT QPaintDevice
{
//Prepare *** *** *** *** *** *** *** *** *** *** *** *** **
protected:
    ushort painters; // refcount
private:
    QPaintDevicePrivate *reserved;
    
//Properties *** *** *** *** *** *** *** *** *** *** *** ***

//Constructor *** *** *** *** *** *** *** *** *** *** *** **
public:
    virtual ~QPaintDevice();
protected:
    QPaintDevice() Q_DECL_NOEXCEPT;

//Functions *** *** *** *** *** *** *** *** *** *** ***  ***

}
```
## `Constructor`
```

```
## `Memory Model`
```
[QPaintDevice]
    __vfptr
    ushort painters;
    QPaintDevicePrivate *reserved;
```



# `Public Types`
###### `enum `
###### `PaintDeviceMetric { PdmWidth, PdmHeight, PdmWidthMM, PdmHeightMM, ..., PdmDevicePixelRatioScaled }`



# `Public Functions`
###### `virtual `
###### `~QPaintDevice()`
###### `int `
###### `colorCount() const`
###### `int `
###### `depth() const`
###### `int `
###### `devicePixelRatio() const`
###### `qreal `
###### `devicePixelRatioF() const`
###### `int `
###### `height() const`
###### `int `
###### `heightMM() const`
###### `int `
###### `logicalDpiX() const`
###### `int `
###### `logicalDpiY() const`
###### `virtual QPaintEngine* `
###### `paintEngine() const = 0`
###### `bool `
###### `paintingActive() const`
###### `int `
###### `physicalDpiX() const`
###### `int `
###### `physicalDpiY() const`
###### `int `
###### `width() const`
###### `int `
###### `widthMM() const`



# `Protected Functions`
###### `QPaintDevice()`
###### `virtual int `
###### `metric(QPaintDevice::PaintDeviceMetric metric) const`


