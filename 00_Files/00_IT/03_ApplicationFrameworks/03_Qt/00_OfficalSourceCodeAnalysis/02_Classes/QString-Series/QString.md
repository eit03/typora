***

`Version:` Qt 5.12.1, QtCreate 4.8.1

`Declaration:`

`Defination:`

`Reference:`

`Keyword:`

***

[TOC]

***

# `Brief Introduction`

# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```

class Q_CORE_EXPORT QString
{

///> 0. Prepare
public:
    // typedef QTypedArrayData<ushort> QStringData;
    typedef QStringData Data;

///> 1. Properties
private:
    Data *d;

///> 2. Constructor
public:
    inline QString() Q_DECL_NOTHROW;
    explicit QString(const QChar *unicode, int size = -1);
    QString(QChar c);
    QString(int size, QChar c);
    inline QString(QLatin1String latin1);
    inline QString(const QString &) Q_DECL_NOTHROW;
    inline ~QString();

///> 3. Functions

}
```

## `Constructor`

```

```

## `Memory Model`

```

```

# `Public Types`

###### `class Null`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef ConstIterator`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef Iterator`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `enum NormalizationForm { NormalizationForm_D, NormalizationForm_C, NormalizationForm_KD, NormalizationForm_KC }`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `enum SectionFlag { SectionDefault, SectionSkipEmpty, SectionIncludeLeadingSep, SectionIncludeTrailingSep, SectionCaseInsensitiveSeps }`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `flags SectionFlags`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `enum SplitBehavior { KeepEmptyParts, SkipEmptyParts }`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef const_iterator`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef const_pointer`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef const_reference`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef const_reverse_iterator`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef difference_type`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef iterator`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef pointer`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef reference`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef reverse_iterator`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef size_type`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `typedef value_type`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

# `Public Functions`

###### `QString()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString(const QChar* unicode, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString(QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString(int size, QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString(QLatin1String str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString(const QString &other)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString(QString &&other)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString(const char* str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString(const QByteArray &ba)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `~QString()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & append(const QString &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & append(const QChar* str, int len)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & append(QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & append(const QStringRef &reference)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & append(QLatin1String str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & append(const char* str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & append(const QByteArray &ba)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(qulonglong a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(long a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(ulong a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(int a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(uint a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(short a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(ushort a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(double a, int fieldWidth = 0, char format = 'g', int precision = -1, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(char a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(QChar a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(qlonglong a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(QStringView a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(QLatin1String a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a1, const QString &a2) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a1, const QString &a2, const QString &a3) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5, const QString &a6) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5, const QString &a6, const QString &a7) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5, const QString &a6, const QString &a7, const QString &a8) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5, const QString &a6, const QString &a7, const QString &a8, const QString &a9) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QChar at(int position) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QChar back() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QCharRef back()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `iterator begin()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_iterator begin() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int capacity() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_iterator cbegin() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_iterator cend() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void chop(int n)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString chopped(int len) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void clear()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int compare(const QStringRef &ref, Qt::CaseSensitivity cs = ...) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int compare(QLatin1String other, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int compare(QStringView s, Qt::CaseSensitivity cs = ...) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int compare(const QString &other, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_iterator constBegin() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QChar* constData() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_iterator constEnd() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool contains(const QString &str, Qt::CaseSensitivity cs = ...) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool contains(QChar ch, Qt::CaseSensitivity cs = ...) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool contains(QLatin1String str, Qt::CaseSensitivity cs = ...) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool contains(const QStringRef &str, Qt::CaseSensitivity cs = ...) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool contains(const QRegExp &rx) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool contains(QRegExp &rx) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool contains(const QRegularExpression &re) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool contains(const QRegularExpression &re, QRegularExpressionMatch* match) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int count(const QString &str, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int count(QChar ch, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int count() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int count(const QStringRef &str, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int count(const QRegExp &rx) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int count(const QRegularExpression &re) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_reverse_iterator crbegin() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_reverse_iterator crend() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QChar* data()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QChar* data() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `iterator end()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_iterator end() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool endsWith(const QString &s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool endsWith(const QStringRef &s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool endsWith(QStringView str, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool endsWith(QLatin1String s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool endsWith(QChar c, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & fill(QChar ch, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QChar front() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QCharRef front()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int indexOf(const QString &str, int from = 0, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int indexOf(QChar ch, int from = 0, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int indexOf(QLatin1String str, int from = 0, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int indexOf(const QStringRef &str, int from = 0, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int indexOf(const QRegExp &rx, int from = 0) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int indexOf(QRegExp &rx, int from = 0) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int indexOf(const QRegularExpression &re, int from = 0) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int indexOf(const QRegularExpression &re, int from, QRegularExpressionMatch* rmatch) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & insert(int position, const QString &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & insert(int position, const QChar* unicode, int size)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & insert(int position, QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & insert(int position, const QStringRef &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & insert(int position, QLatin1String str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & insert(int position, const char* str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & insert(int position, const QByteArray &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool isEmpty() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool isLower() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool isNull() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool isRightToLeft() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool isUpper() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int lastIndexOf(const QString &str, int from = -1, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int lastIndexOf(QChar ch, int from = -1, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int lastIndexOf(QLatin1String str, int from = -1, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int lastIndexOf(const QStringRef &str, int from = -1, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int lastIndexOf(const QRegExp &rx, int from = -1) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int lastIndexOf(QRegExp &rx, int from = -1) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int lastIndexOf(const QRegularExpression &re, int from = -1) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int lastIndexOf(const QRegularExpression &re, int from, QRegularExpressionMatch* rmatch) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString left(int n) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString leftJustified(int width, QChar fill = QLatin1Char(' '), bool truncate = false) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QStringRef leftRef(int n) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int length() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int localeAwareCompare(const QString &other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int localeAwareCompare(const QStringRef &other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString mid(int position, int n = -1) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QStringRef midRef(int position, int n = -1) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString normalized(QString::NormalizationForm mode, QChar::UnicodeVersion version = QChar::Unicode_Unassigned) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & prepend(const QString &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & prepend(const QChar* str, int len)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & prepend(QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & prepend(const QStringRef &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & prepend(QLatin1String str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & prepend(const char* str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & prepend(const QByteArray &ba)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void push_back(const QString &other)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void push_back(QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void push_front(const QString &other)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void push_front(QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `reverse_iterator rbegin()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_reverse_iterator rbegin() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & remove(int position, int n)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & remove(QChar ch, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & remove(QLatin1String str, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & remove(const QString &str, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & remove(const QRegExp &rx)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & remove(const QRegularExpression &re)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `reverse_iterator rend()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const_reverse_iterator rend() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString repeated(int times) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(int position, int n, const QString &after)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(int position, int n, const QChar* unicode, int size)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(int position, int n, QChar after)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(QChar before, QChar after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(const QChar* before, int blen, const QChar* after, int alen, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(QLatin1String before, QLatin1String after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(QLatin1String before, const QString &after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(const QString &before, QLatin1String after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(const QString &before, const QString &after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(QChar ch, const QString &after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(QChar c, QLatin1String after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(const QRegExp &rx, const QString &after)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & replace(const QRegularExpression &re, const QString &after)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void reserve(int size)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void resize(int size)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void resize(int size, QChar fillChar)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString right(int n) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString rightJustified(int width, QChar fill = QLatin1Char(' '), bool truncate = false) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QStringRef rightRef(int n) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString section(QChar sep, int start, int end = ..., SectionFlags flags = SectionDefault) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString section(const QString &sep, int start, int end = -1, SectionFlags flags = SectionDefault) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString section(const QRegExp &reg, int start, int end = -1, SectionFlags flags = SectionDefault) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString section(const QRegularExpression &re, int start, int end = -1, SectionFlags flags = SectionDefault) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(int n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(ushort n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(short n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(uint n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(long n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(ulong n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(qlonglong n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(qulonglong n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(float n, char format = 'g', int precision = 6)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setNum(double n, char format = 'g', int precision = 6)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setRawData(const QChar* unicode, int size)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setUnicode(const QChar* unicode, int size)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & setUtf16(const ushort* unicode, int size)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void shrink_to_fit()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString simplified() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int size() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QStringList split(const QString &sep, QString::SplitBehavior behavior = KeepEmptyParts, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QStringList split(QChar sep, QString::SplitBehavior behavior = KeepEmptyParts, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QStringList split(const QRegExp &rx, QString::SplitBehavior behavior = KeepEmptyParts) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QStringList split(const QRegularExpression &re, QString::SplitBehavior behavior = KeepEmptyParts) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QVector<QStringRef> splitRef(const QString &sep, QString::SplitBehavior behavior = KeepEmptyParts, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QVector<QStringRef> splitRef(QChar sep, QString::SplitBehavior behavior = KeepEmptyParts, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QVector<QStringRef> splitRef(const QRegExp &rx, QString::SplitBehavior behavior = KeepEmptyParts) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QVector<QStringRef> splitRef(const QRegularExpression &re, QString::SplitBehavior behavior = KeepEmptyParts) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void squeeze()`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool startsWith(const QString &s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool startsWith(const QStringRef &s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool startsWith(QStringView str, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool startsWith(QLatin1String s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool startsWith(QChar c, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void swap(QString &other)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `CFStringRef toCFString() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString toCaseFolded() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `double toDouble(bool* ok = nullptr) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `float toFloat(bool* ok = nullptr) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString toHtmlEscaped() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int toInt(bool* ok = nullptr, int base = 10) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QByteArray toLatin1() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QByteArray toLocal8Bit() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `long toLong(bool* ok = nullptr, int base = 10) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `qlonglong toLongLong(bool* ok = nullptr, int base = 10) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString toLower() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `NSString* toNSString() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `short toShort(bool* ok = nullptr, int base = 10) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `std::string toStdString() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `std::u16string toStdU16String() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `std::u32string toStdU32String() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `std::wstring toStdWString() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `uint toUInt(bool* ok = nullptr, int base = 10) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `ulong toULong(bool* ok = nullptr, int base = 10) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `qulonglong toULongLong(bool* ok = nullptr, int base = 10) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `ushort toUShort(bool* ok = nullptr, int base = 10) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QVector<uint> toUcs4() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString toUpper() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QByteArray toUtf8() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int toWCharArray(wchar_t* array) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString trimmed() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `void truncate(int position)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QChar* unicode() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const ushort* utf16() const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator!=(QLatin1String other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator!=(const char* other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator!=(const QByteArray &other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator+=(const QString &other)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator+=(QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator+=(const QStringRef &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator+=(QLatin1String str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator+=(const char* str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator+=(const QByteArray &ba)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator+=(char ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator<(QLatin1String other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator<(const char* other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator<(const QByteArray &other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator<=(QLatin1String other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator<=(const char* other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator<=(const QByteArray &other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator=(const QString &other)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator=(QChar ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator=(QLatin1String str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator=(QString &&other)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator=(const char* str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator=(const QByteArray &ba)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString & operator=(char ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator==(QLatin1String other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator==(const char* other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator==(const QByteArray &other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator>(QLatin1String other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator>(const char* other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator>(const QByteArray &other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator>=(QLatin1String other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator>=(const char* other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator>=(const QByteArray &other) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QCharRef operator[](int position)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QChar operator[](int position) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QChar operator[](uint position) const`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QCharRef operator[](uint position)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

# `Static Public Members`

###### `QString asprintf(const char* cformat, ...)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int compare(const QString &s1, const QString &s2, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int compare(const QString &s1, QLatin1String s2, Qt::CaseSensitivity cs = Qt::CaseSensitive)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int compare(QLatin1String s1, const QString &s2, Qt::CaseSensitivity cs = ...)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int compare(const QString &s1, const QStringRef &s2, Qt::CaseSensitivity cs = ...)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromCFString(CFStringRef string)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromLatin1(const char* str, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromLatin1(const QByteArray &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromLocal8Bit(const char* str, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromLocal8Bit(const QByteArray &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromNSString(const NSString* string)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromRawData(const QChar* unicode, int size)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromStdString(const std::string &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromStdU16String(const std::u16string &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromStdU32String(const std::u32string &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromStdWString(const std::wstring &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromUcs4(const uint* unicode, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromUcs4(const char32_t* str, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromUtf8(const char* str, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromUtf8(const QByteArray &str)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromUtf16(const ushort* unicode, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromUtf16(const char16_t* str, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString fromWCharArray(const wchar_t* string, int size = -1)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int localeAwareCompare(const QString &s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `int localeAwareCompare(const QString &s1, const QStringRef &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QString::Null null`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString number(long n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString number(uint n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString number(int n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString number(ulong n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString number(qlonglong n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString number(qulonglong n, int base = 10)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString number(double n, char format = 'g', int precision = 6)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QString vasprintf(const char* cformat, va_list ap)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

# `Related Non-Members`

###### `bool operator!=(const char* s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QString operator+(const QString &s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QString operator+(const QString &s1, const char* s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QString operator+(const char* s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QString operator+(const QString &s, char ch)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `const QString operator+(char ch, const QString &s)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator<(const char* s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QDataStream & operator<<(QDataStream &stream, const QString &string)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator<=(const char* s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator==(const char* s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator>(const char* s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `bool operator>=(const char* s1, const QString &s2)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

###### `QDataStream & operator>>(QDataStream &stream, QString &string)`

`Interpretation:`

`StorePosition:`

`Defualt:`

`Access:`

`Remark:`

`Eg 0:`

# `Macros`

###### `QStringLiteral(str)`

###### `QT_NO_CAST_FROM_ASCII`

###### `QT_NO_CAST_TO_ASCII`

###### `QT_RESTRICTED_CAST_FROM_ASCII`