***

`Keyword for search:` Q_PROPERTY    The Property System

***

```
class Q_CORE_EXPORT QObject
{
    Q_PROPERTY(QString objectName READ objectName WRITE setObjectName NOTIFY objectNameChanged)
}

# define Q_PROPERTY(...) QT_ANNOTATE_CLASS(qt_property, __VA_ARGS__)

#  define QT_ANNOTATE_CLASS(type, ...)
```

```
Q_PROPERTY(type name
             (READ getFunction [WRITE setFunction] |
              MEMBER memberName [(READ getFunction | WRITE setFunction)])
             [RESET resetFunction]
             [NOTIFY notifySignal]
             [REVISION int]
             [DESIGNABLE bool]
             [SCRIPTABLE bool]
             [STORED bool]
             [USER bool]
             [CONSTANT]
             [FINAL])
```
>Type:属性的类型
>Name：属性的名称
>READ getFunction：属性的访问函数
>WRITE setFunction：属性的设置函数
>RESET resetFunction：属性的复位函数
>NOTIFY notifySignal：属性发生变化的地方发射的notifySignal信号
>REVISION int：属性的版本，属性暴露到QML中
>DESIGNABLE bool：属性在GUI设计器中是否可见，默认为true
>SCRIPTABLE bool：属性是否可以被脚本引擎访问，默认为true
>STORED bool：
>USER bool：
>CONSTANT：标识属性的值是常量，值为常量的属性没有WRITE、NOTIFY
>FINAL：标识属性不会被派生类覆写
>注意：NOTIFY notifySignal声明了属性发生变化时发射notifySignal信号，但并没有实现，因此程序员需要在属性发生变化的地方发射notifySignal信号。

- 可以看的出来,对于标准C++来说,它是不存在的;只是给元对象系统用的.
- 我们可以给对象设置一个属性type name;它有读函数,写函数,重置函数,通知信号等等.
- 可以用QObject::Property() & QObject::setProperty() 访问.
- 数据在QMeataObject中.


