```
# define Q_PROPERTY(...) QT_ANNOTATE_CLASS(qt_property, __VA_ARGS__)

#ifndef QT_ANNOTATE_CLASS
# ifndef Q_COMPILER_VARIADIC_MACROS
#  define QT_ANNOTATE_CLASS(type, x)
# else
#  define QT_ANNOTATE_CLASS(type, ...)
# endif // Q_COMPILER_VARIADIC_MACROS
#endif // QT_ANNOTATE_CLASS
```
```
A property behaves like a class data member, but it has additional features 
accessible through the Meta-Object System:

A READ accessor function is required if no MEMBER variable was specified. 
It is for reading the property value. Ideally, a const function is used 
for this purpose, and it must return either the property's type or 
a const reference to that type. e.g., QWidget::focus is a read-only property
with READ function, QWidget::hasFocus().

A WRITE accessor function is optional. It is for setting the property value.
It must return void and must take exactly one argument, either of 
the property's type or a pointer or reference to that type. e.g., 
QWidget::enabled has the WRITE function QWidget::setEnabled(). Read-only 
properties do not need WRITE functions. e.g., QWidget::focus has no WRITE 
function.

A MEMBER variable association is required if no READ accessor function is 
specified. This makes the given member variable readable and writable without
the need of creating READ and WRITE accessor functions. It's still possible to
use READ or WRITE accessor functions in addition to MEMBER variable 
association (but not both), if you need to control the variable access.

A RESET function is optional. It is for setting the property back to its 
context specific default value. e.g., QWidget::cursor has the typical READ
and WRITE functions, QWidget::cursor() and QWidget::setCursor(), and it also 
has a RESET function, QWidget::unsetCursor(), since no call to 
QWidget::setCursor() can mean reset to the context specific cursor. The RESET 
function must return void and take no parameters.

A NOTIFY signal is optional. If defined, it should specify one existing signal
in that class that is emitted whenever the value of the property changes.
NOTIFY signals for MEMBER variables must take zero or one parameter, which
must be of the same type as the property. The parameter will take the new value
of the property. The NOTIFY signal should only be emitted when the property 
has really been changed, to avoid bindings being unnecessarily re-evaluated 
in QML, for example. Qt emits automatically that signal when needed for 
MEMBER properties that do not have an explicit setter.

A REVISION number is optional. If included, it defines the property and its 
notifier signal to be used in a particular revision of the API (usually for
exposure to QML). If not included, it defaults to 0.

The DESIGNABLE attribute indicates whether the property should be visible in 
the property editor of GUI design tool (e.g., Qt Designer). Most properties
are DESIGNABLE (default true). Instead of true or false, you can specify a 
boolean member function.

The SCRIPTABLE attribute indicates whether this property should be accessible
by a scripting engine (default true). Instead of true or false, you can specify
a boolean member function.

The STORED attribute indicates whether the property should be thought of as 
existing on its own or as depending on other values. It also indicates whether 
the property value must be saved when storing the object's state. Most 
properties are STORED (default true), but e.g., QWidget::minimumWidth() has
STORED false, because its value is just taken from the width component of
property QWidget::minimumSize(), which is a QSize.

The USER attribute indicates whether the property is designated as the 
user-facing or user-editable property for the class. Normally, there is only
one USER property per class (default false). e.g., QAbstractButton::checked 
is the user editable property for (checkable) buttons. Note that QItemDelegate 
gets and sets a widget's USER property.

The presence of the CONSTANT attribute indicates that the property value is
constant. For a given object instance, the READ method of a constant property
must return the same value every time it is called. This constant value may
be different for different instances of the object. A constant property cannot
have a WRITE method or a NOTIFY signal.

The presence of the FINAL attribute indicates that the property will not be
overridden by a derived class. This can be used for performance optimizations
in some cases, but is not enforced by moc. Care must be taken never to 
override a FINAL property.
```

```
// Object.h
#pragma once

#include <QObject>
#include <QDebug>
#include <QString>


class Object : public QObject
{
	Q_OBJECT
		Q_PROPERTY(int age READ age WRITE setAge NOTIFY ageChanged)
		Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

private:
	const char* prove_;
	int age_;
	QString name_;

public:
	explicit Object() : prove_("I am me!"), age_(0)
	{
		Q_UNUSED(prove_);
		connect(this, SIGNAL(ageChanged(int)),
			this, SLOT(onAgeChanged(int)));
		connect(this, SIGNAL(nameChanged(QString)),
			this, SLOT(onNameChanged(QString)));
	}

public:
	int age() { return age_; }
	void setAge(int age)
	{
		if (age_ != age)
		{
			age_ = age;
			emit ageChanged(age);
		}
	}

	QString name() { return name_; }
	void setName(QString name)
	{
		if (name != name_)
		{
			name_ = name;
			emit nameChanged(name);
		}
	}

Q_SIGNALS:
	void ageChanged(int age);
	void nameChanged(QString name);

protected Q_SLOTS:
	void onAgeChanged(int age) 
	{ 
		printf("age changed: %d\n", age);
		qDebug() << "age changed: " << QString("%1").arg(age);
	}
	void onNameChanged(QString name)
	{ 
		printf("name changed: %s\n", name.toUtf8().data());
		qDebug() << "name changed: " << name;
	}
};
```

```
// main.cpp
#include <QCoreApplication>
#include "Object.h"

int main(int argc, char *argv[])
{
	QCoreApplication a(argc, argv);

	Object obj;
	obj.objectName();
	obj.setAge(1);
	obj.setName("Prove I am me!");

	return a.exec();
}
```

```
// moc_Object.i

class Object : public QObject
{
public: __pragma(warning(push))
	static const QMetaObject staticMetaObject; 
	virtual const QMetaObject *metaObject() const;
	virtual void *qt_metacast(const char *);
	virtual int qt_metacall(QMetaObject::Call, int, void **);
	static inline QString tr
	(const char *s, const char *c = nullptr, int n = -1)
	{ return staticMetaObject.tr(s, c, n); }  
	static inline QString trUtf8
	(const char *s, const char *c = nullptr, int n = -1)
	{ return staticMetaObject.tr(s, c, n); } 
	
private:   
	static void qt_static_metacall
	(QObject *, QMetaObject::Call, int, void **);
	__pragma(warning(pop)) 
	struct QPrivateSignal {}; 
		
		

private:
	const char* prove_;
	int age_;
	QString name_;

public:
	explicit Object() : prove_("I am me!"), age_(0)
	{
		(void)prove_;;
		connect(this, qFlagLocation("2""ageChanged(int)" "\0" "c:\\users\\eit\\documents\\github\\qtstudyprojects_examplesset\\q_prorerty_0000\\q_prorerty_0000\\object.h" ":" "23"),
			this, qFlagLocation("1""onAgeChanged(int)" "\0" "c:\\users\\eit\\documents\\github\\qtstudyprojects_examplesset\\q_prorerty_0000\\q_prorerty_0000\\object.h" ":" "24"));
		connect(this, qFlagLocation("2""nameChanged(QString)" "\0" "c:\\users\\eit\\documents\\github\\qtstudyprojects_examplesset\\q_prorerty_0000\\q_prorerty_0000\\object.h" ":" "25"),
			this, qFlagLocation("1""onNameChanged(QString)" "\0" "c:\\users\\eit\\documents\\github\\qtstudyprojects_examplesset\\q_prorerty_0000\\q_prorerty_0000\\object.h" ":" "26"));
	}

public:
	int age() { return age_; }
	void setAge(int age)
	{
		if (age_ != age)
		{
			age_ = age;
			 ageChanged(age);
		}
	}

	QString name() { return name_; }
	void setName(QString name)
	{
		if (name != name_)
		{
			name_ = name;
			 nameChanged(name);
		}
	}

public :
	void ageChanged(int age);
	void nameChanged(QString name);

protected :
	void onAgeChanged(int age) 
	{ 
		printf("age changed: %d\n", age);
		QMessageLogger("c:\\users\\eit\\documents\\github\\qtstudyprojects_examplesset\\q_prorerty_0000\\q_prorerty_0000\\object.h", 58,  __FUNCSIG__  ).debug() << "age changed: " << QString("%1").arg(age);
	}
	void onNameChanged(QString name)
	{ 
		printf("name changed: %s\n", name.toUtf8().data());
		QMessageLogger("c:\\users\\eit\\documents\\github\\qtstudyprojects_examplesset\\q_prorerty_0000\\q_prorerty_0000\\object.h", 63,  __FUNCSIG__  ).debug() << "name changed: " << name;
	}
};
```
