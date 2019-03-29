***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` \[QString\]
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

//Prepare *** *** *** *** *** *** *** *** *** *** *** ***
typedef QStringData Data;

//Properties *** *** *** *** *** *** *** *** *** *** *** ***
private:
	Data *d;

//Constructor *** *** *** *** *** *** *** *** *** *** *** ***
public:
    inline QString() Q_DECL_NOTHROW;
    explicit QString(const QChar *unicode, int size = -1);
    QString(QChar c);
    QString(int size, QChar c);
    inline QString(QLatin1String latin1);
    inline QString(const QString &) Q_DECL_NOTHROW;
    
#ifdef Q_COMPILER_RVALUE_REFS
    inline QString(QString && other) Q_DECL_NOTHROW : d(other.d) { other.d = Data::sharedNull(); }
#endif
    inline ~QString(); 
    
    // ASCII compatibility
#if defined(QT_RESTRICTED_CAST_FROM_ASCII)
    template <int N>
    inline QString(const char (&ch)[N]) : d(fromAscii_helper(ch, N - 1)) {}
    template <int N>
    QString(char (&)[N]) = delete;
#endif

#if !defined(QT_NO_CAST_FROM_ASCII) && !defined(QT_RESTRICTED_CAST_FROM_ASCII)
    inline QT_ASCII_CAST_WARN QString(const char *ch) : d(fromAscii_helper(ch, ch ? int(strlen(ch)) : -1)) {}
    inline QT_ASCII_CAST_WARN QString(const QByteArray &a) : d(fromAscii_helper(a.constData(), qstrnlen(a.constData(), a.size()))) {}
#endif

    // compatibility
#if QT_DEPRECATED_SINCE(5, 9)
    inline QString(const Null &): d(Data::sharedNull()) {}
#endif

    QString(int size, Qt::Initialization);
    Q_DECL_CONSTEXPR inline QString(QStringDataPtr dd) : d(dd.ptr) {}
    
private:
#if defined(QT_NO_CAST_FROM_ASCII)
    QString(const char *ch);
    QString(const QByteArray &a);
#endif

//Functions ***
}
```



## `Constructor`

## `Memory Model`

```
[QString]
    Data *d; ==> [QStringData*] ==> [QTypedArrayData<ushort>*] ==> [template <class T> struct QTypedArrayData : QArrayData]
        [QTypedArrayData<ushort>*]
            [QArrayData*]
                QtPrivate::RefCount ref;    //引用计数(atomic operation)
                int size;                   //元素个数(这里是字符个数)
                uint alloc : 31;            //最大元素个数
                uint capacityReserved : 1;  //
                qptrdiff offset;            //数组指针 (this + offset)
```





# `Public Types`

###### `class Null`

###### `typedef ConstIterator`
###### `typedef Iterator`
###### `enum NormalizationForm { NormalizationForm_D, NormalizationForm_C, NormalizationForm_KD, NormalizationForm_KC }`
###### `enum SectionFlag { SectionDefault, SectionSkipEmpty, SectionIncludeLeadingSep, SectionIncludeTrailingSep, SectionCaseInsensitiveSeps }`
###### `flags SectionFlags`
###### `enum SplitBehavior { KeepEmptyParts, SkipEmptyParts }`
###### `typedef const_iterator`
###### `typedef const_pointer`
###### `typedef const_reference`
###### `typedef const_reverse_iterator`
###### `typedef difference_type`
###### `typedef iterator`
###### `typedef pointer`
###### `typedef reference`
###### `typedef reverse_iterator`
###### `typedef size_type`
###### `typedef value_type`



# `Public Functions`
###### ` QString()`
###### ` QString(const QChar* unicode, int size = -1)`
###### ` QString(QChar ch)`
###### ` QString(int size, QChar ch)`
###### ` QString(QLatin1String str)`
###### ` QString(const QString &other)`
###### ` QString(QString &&other)`
###### ` QString(const char* str)`
###### ` QString(const QByteArray &ba)`
###### ` ~QString()`

###### `QString & append(const QString &str)`
###### `QString & append(const QChar* str, int len)`
###### `QString & append(QChar ch)`
###### `QString & append(const QStringRef &reference)`
###### `QString & append(QLatin1String str)`
###### `QString & append(const char* str)`
###### `QString & append(const QByteArray &ba)`
###### `QString arg(const QString &a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(qulonglong a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(long a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(ulong a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(int a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(uint a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(short a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(ushort a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`

###### `QString arg(double a, int fieldWidth = 0, char format = 'g', int precision = -1, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(char a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(QChar a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(qlonglong a, int fieldWidth = 0, int base = 10, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(QStringView a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(QLatin1String a, int fieldWidth = 0, QChar fillChar = QLatin1Char(' ')) const`
###### `QString arg(const QString &a1, const QString &a2) const`
###### `QString arg(const QString &a1, const QString &a2, const QString &a3) const`
###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4) const`
###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5) const`
###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5, const QString &a6) const`
###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5, const QString &a6, const QString &a7) const`
###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5, const QString &a6, const QString &a7, const QString &a8) const`
###### `QString arg(const QString &a1, const QString &a2, const QString &a3, const QString &a4, const QString &a5, const QString &a6, const QString &a7, const QString &a8, const QString &a9) const`
###### `const QChar at(int position) const`
###### `QChar back() const`
###### `QCharRef back()`
###### `QString::iterator begin()`
###### `QString::const_iterator begin() const`
###### `int capacity() const`
###### `QString::const_iterator cbegin() const`
###### `QString::const_iterator cend() const`
###### `void chop(int n)`
###### `QString chopped(int len) const`
###### `void clear()`
###### `int compare(QLatin1String other, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int compare(const QString &other, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int compare(const QStringRef &ref, Qt::CaseSensitivity cs = ...) const`
###### `QString::const_iterator constBegin() const`
###### `const QChar* constData() const`
###### `QString::const_iterator constEnd() const`
###### `bool contains(const QString &str, Qt::CaseSensitivity cs = ...) const`
###### `bool contains(QChar ch, Qt::CaseSensitivity cs = ...) const`
###### `bool contains(QLatin1String str, Qt::CaseSensitivity cs = ...) const`
###### `bool contains(const QStringRef &str, Qt::CaseSensitivity cs = ...) const`
###### `bool contains(const QRegExp &rx) const`
###### `bool contains(QRegExp &rx) const`
###### `bool contains(const QRegularExpression &re) const`
###### `bool contains(const QRegularExpression &re, QRegularExpressionMatch* match) const`
###### `int count(const QString &str, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int count(QChar ch, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int count() const`
###### `int count(const QStringRef &str, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int count(const QRegExp &rx) const`
###### `int count(const QRegularExpression &re) const`
###### `QString::const_reverse_iterator crbegin() const`
###### `QString::const_reverse_iterator crend() const`
###### `QChar* data()`
###### `const QChar* data() const`
###### `QString::iterator end()`
###### `QString::const_iterator end() const`
###### `bool endsWith(const QString &s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `bool endsWith(const QStringRef &s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `bool endsWith(QStringView str, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `bool endsWith(QLatin1String s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `bool endsWith(QChar c, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `QString & fill(QChar ch, int size = -1)`
###### `QChar front() const`
###### `QCharRef front()`
###### `int indexOf(const QString &str, int from = 0, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int indexOf(QChar ch, int from = 0, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int indexOf(QLatin1String str, int from = 0, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int indexOf(const QStringRef &str, int from = 0, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int indexOf(const QRegExp &rx, int from = 0) const`
###### `int indexOf(QRegExp &rx, int from = 0) const`
###### `int indexOf(const QRegularExpression &re, int from = 0) const`
###### `int indexOf(const QRegularExpression &re, int from, QRegularExpressionMatch* rmatch) const`
###### `QString & insert(int position, const QString &str)`
###### `QString & insert(int position, const QChar* unicode, int size)`
###### `QString & insert(int position, QChar ch)`
###### `QString & insert(int position, const QStringRef &str)`
###### `QString & insert(int position, QLatin1String str)`
###### `QString & insert(int position, const char* str)`
###### `QString & insert(int position, const QByteArray &str)`
###### `bool isEmpty() const`
###### `bool isNull() const`
###### `bool isRightToLeft() const`
###### `int lastIndexOf(const QString &str, int from = -1, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int lastIndexOf(QChar ch, int from = -1, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int lastIndexOf(QLatin1String str, int from = -1, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int lastIndexOf(const QStringRef &str, int from = -1, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `int lastIndexOf(const QRegExp &rx, int from = -1) const`
###### `int lastIndexOf(QRegExp &rx, int from = -1) const`
###### `int lastIndexOf(const QRegularExpression &re, int from = -1) const`
###### `int lastIndexOf(const QRegularExpression &re, int from, QRegularExpressionMatch* rmatch) const`
###### `QString left(int n) const`
###### `QString leftJustified(int width, QChar fill = QLatin1Char(' '), bool truncate = false) const`
###### `QStringRef leftRef(int n) const`
###### `int length() const`
###### `int localeAwareCompare(const QString &other) const`
###### `int localeAwareCompare(const QStringRef &other) const`
###### `QString mid(int position, int n = -1) const`
###### `QStringRef midRef(int position, int n = -1) const`
###### `QString normalized(QString::NormalizationForm mode, QChar::UnicodeVersion version = QChar::Unicode_Unassigned) const`
###### `QString & prepend(const QString &str)`
###### `QString & prepend(const QChar* str, int len)`
###### `QString & prepend(QChar ch)`
###### `QString & prepend(const QStringRef &str)`
###### `QString & prepend(QLatin1String str)`
###### `QString & prepend(const char* str)`
###### `QString & prepend(const QByteArray &ba)`
###### `void push_back(const QString &other)`
###### `void push_back(QChar ch)`
###### `void push_front(const QString &other)`
###### `void push_front(QChar ch)`
###### `QString::reverse_iterator rbegin()`
###### `QString::const_reverse_iterator rbegin() const`
###### `QString & remove(int position, int n)`
###### `QString & remove(QChar ch, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & remove(QLatin1String str, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & remove(const QString &str, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & remove(const QRegExp &rx)`
###### `QString & remove(const QRegularExpression &re)`
###### `QString::reverse_iterator rend()`
###### `QString::const_reverse_iterator rend() const`
###### `QString repeated(int times) const`
###### `QString & replace(int position, int n, const QString &after)`
###### `QString & replace(int position, int n, const QChar* unicode, int size)`
###### `QString & replace(int position, int n, QChar after)`
###### `QString & replace(QChar before, QChar after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & replace(const QChar* before, int blen, const QChar* after, int alen, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & replace(QLatin1String before, QLatin1String after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & replace(QLatin1String before, const QString &after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & replace(const QString &before, QLatin1String after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & replace(const QString &before, const QString &after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & replace(QChar ch, const QString &after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & replace(QChar c, QLatin1String after, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `QString & replace(const QRegExp &rx, const QString &after)`
###### `QString & replace(const QRegularExpression &re, const QString &after)`
###### `void reserve(int size)`
###### `void resize(int size)`
###### `void resize(int size, QChar fillChar)`
###### `QString right(int n) const`
###### `QString rightJustified(int width, QChar fill = QLatin1Char(' '), bool truncate = false) const`
###### `QStringRef rightRef(int n) const`
###### `QString section(QChar sep, int start, int end = ..., QString::SectionFlags flags = SectionDefault) const`
###### `QString section(const QString &sep, int start, int end = -1, QString::SectionFlags flags = SectionDefault) const`
###### `QString section(const QRegExp &reg, int start, int end = -1, QString::SectionFlags flags = SectionDefault) const`
###### `QString section(const QRegularExpression &re, int start, int end = -1, QString::SectionFlags flags = SectionDefault) const`
###### `QString & setNum(int n, int base = 10)`
###### `QString & setNum(ushort n, int base = 10)`
###### `QString & setNum(short n, int base = 10)`
###### `QString & setNum(uint n, int base = 10)`
###### `QString & setNum(long n, int base = 10)`
###### `QString & setNum(ulong n, int base = 10)`
###### `QString & setNum(qlonglong n, int base = 10)`
###### `QString & setNum(qulonglong n, int base = 10)`
###### `QString & setNum(float n, char format = 'g', int precision = 6)`
###### `QString & setNum(double n, char format = 'g', int precision = 6)`
###### `QString & setRawData(const QChar* unicode, int size)`
###### `QString & setUnicode(const QChar* unicode, int size)`
###### `QString & setUtf16(const ushort* unicode, int size)`
###### `void shrink_to_fit()`
###### `QString simplified() const`
###### `int size() const`
###### `QStringList split(const QString &sep, QString::SplitBehavior behavior = KeepEmptyParts, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `QStringList split(QChar sep, QString::SplitBehavior behavior = KeepEmptyParts, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `QStringList split(const QRegExp &rx, QString::SplitBehavior behavior = KeepEmptyParts) const`
###### `QStringList split(const QRegularExpression &re, QString::SplitBehavior behavior = KeepEmptyParts) const`
###### `QVector<QStringRef> splitRef(const QString &sep, QString::SplitBehavior behavior = KeepEmptyParts, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `QVector<QStringRef> splitRef(QChar sep, QString::SplitBehavior behavior = KeepEmptyParts, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `QVector<QStringRef> splitRef(const QRegExp &rx, QString::SplitBehavior behavior = KeepEmptyParts) const`
###### `QVector<QStringRef> splitRef(const QRegularExpression &re, QString::SplitBehavior behavior = KeepEmptyParts) const`
###### `void squeeze()`
###### `bool startsWith(const QString &s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `bool startsWith(const QStringRef &s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `bool startsWith(QStringView str, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `bool startsWith(QLatin1String s, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `bool startsWith(QChar c, Qt::CaseSensitivity cs = Qt::CaseSensitive) const`
###### `void swap(QString &other)`
###### `CFStringRef toCFString() const`
###### `QString toCaseFolded() const`
###### `double toDouble(bool* ok = nullptr) const`
###### `float toFloat(bool* ok = nullptr) const`
###### `QString toHtmlEscaped() const`
###### `int toInt(bool* ok = nullptr, int base = 10) const`
###### `QByteArray toLatin1() const`
###### `QByteArray toLocal8Bit() const`
###### `long toLong(bool* ok = nullptr, int base = 10) const`
###### `qlonglong toLongLong(bool* ok = nullptr, int base = 10) const`
###### `QString toLower() const`
###### `NSString* toNSString() const`
###### `short toShort(bool* ok = nullptr, int base = 10) const`
###### `std::string toStdString() const`
###### `std::u16string toStdU16String() const`
###### `std::u32string toStdU32String() const`
###### `std::wstring toStdWString() const`
###### `uint toUInt(bool* ok = nullptr, int base = 10) const`
###### `ulong toULong(bool* ok = nullptr, int base = 10) const`
###### `qulonglong toULongLong(bool* ok = nullptr, int base = 10) const`
###### `ushort toUShort(bool* ok = nullptr, int base = 10) const`
###### `QVector<uint> toUcs4() const`
###### `QString toUpper() const`
###### `QByteArray toUtf8() const`
###### `int toWCharArray(wchar_t* array) const`
###### `QString trimmed() const`
###### `void truncate(int position)`
###### `const QChar* unicode() const`
###### `const ushort* utf16() const`
###### `bool operator!=(QLatin1String other) const`
###### `bool operator!=(const char* other) const`
###### `bool operator!=(const QByteArray &other) const`
###### `QString & operator+=(const QString &other)`
###### `QString & operator+=(QChar ch)`
###### `QString & operator+=(const QStringRef &str)`
###### `QString & operator+=(QLatin1String str)`
###### `QString & operator+=(const char* str)`
###### `QString & operator+=(const QByteArray &ba)`
###### `QString & operator+=(char ch)`
###### `bool operator<(QLatin1String other) const`
###### `bool operator<(const char* other) const`
###### `bool operator<(const QByteArray &other) const`
###### `bool operator<=(QLatin1String other) const`
###### `bool operator<=(const char* other) const`
###### `bool operator<=(const QByteArray &other) const`
###### `QString & operator=(const QString &other)`
###### `QString & operator=(QChar ch)`
###### `QString & operator=(QLatin1String str)`
###### `QString & operator=(QString &&other)`
###### `QString & operator=(const char* str)`
###### `QString & operator=(const QByteArray &ba)`
###### `QString & operator=(char ch)`
###### `bool operator==(QLatin1String other) const`
###### `bool operator==(const char* other) const`
###### `bool operator==(const QByteArray &other) const`
###### `bool operator>(QLatin1String other) const`
###### `bool operator>(const char* other) const`
###### `bool operator>(const QByteArray &other) const`
###### `bool operator>=(QLatin1String other) const`
###### `bool operator>=(const char* other) const`
###### `bool operator>=(const QByteArray &other) const`
###### `QCharRef operator[](int position)`
###### `const QChar operator[](int position) const`
###### `const QChar operator[](uint position) const`
###### `QCharRef operator[](uint position)`



# `Static Public Members`
###### `QString asprintf(const char* cformat, ...)`
###### `int compare(const QString &s1, const QString &s2, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `int compare(const QString &s1, QLatin1String s2, Qt::CaseSensitivity cs = Qt::CaseSensitive)`
###### `int compare(QLatin1String s1, const QString &s2, Qt::CaseSensitivity cs = ...)`
###### `int compare(const QString &s1, const QStringRef &s2, Qt::CaseSensitivity cs = ...)`
###### `QString fromCFString(CFStringRef string)`
###### `QString fromLatin1(const char* str, int size = -1)`
###### `QString fromLatin1(const QByteArray &str)`
###### `QString fromLocal8Bit(const char* str, int size = -1)`
###### `QString fromLocal8Bit(const QByteArray &str)`
###### `QString fromNSString(const NSString* string)`
###### `QString fromRawData(const QChar* unicode, int size)`
###### `QString fromStdString(const std::string &str)`
###### `QString fromStdU16String(const std::u16string &str)`
###### `QString fromStdU32String(const std::u32string &str)`
###### `QString fromStdWString(const std::wstring &str)`
###### `QString fromUcs4(const uint* unicode, int size = -1)`
###### `QString fromUcs4(const char32_t* str, int size = -1)`
###### `QString fromUtf8(const char* str, int size = -1)`
###### `QString fromUtf8(const QByteArray &str)`
###### `QString fromUtf16(const ushort* unicode, int size = -1)`
###### `QString fromUtf16(const char16_t* str, int size = -1)`
###### `QString fromWCharArray(const wchar_t* string, int size = -1)`
###### `int localeAwareCompare(const QString &s1, const QString &s2)`
###### `int localeAwareCompare(const QString &s1, const QStringRef &s2)`
###### `QString number(long n, int base = 10)`

###### `QString number(uint n, int base = 10)`
###### `QString number(int n, int base = 10)`
###### `QString number(ulong n, int base = 10)`
###### `QString number(qlonglong n, int base = 10)`
###### `QString number(qulonglong n, int base = 10)`
###### `QString number(double n, char format = 'g', int precision = 6)`
###### `QString vasprintf(const char* cformat, va_list ap)`



# `Related Non-Members`

###### `bool operator!=(const QString &s1, const QString &s2)`
###### `bool operator!=(const char* s1, const QString &s2)`
###### `const QString operator+(const QString &s1, const QString &s2)`
###### `const QString operator+(const QString &s1, const char* s2)`
###### `const QString operator+(const char* s1, const QString &s2)`
###### `const QString operator+(const QString &s, char ch)`

###### `const QString operator+(char ch, const QString &s)`
###### `bool operator<(const QString &s1, const QString &s2)`
###### `bool operator<(const char* s1, const QString &s2)`
###### `QDataStream & operator<<(QDataStream &stream, const QString &string)`
###### `bool operator<=(const QString &s1, const QString &s2)`
###### `bool operator<=(const char* s1, const QString &s2)`
###### `bool operator==(const QString &s1, const QString &s2)`
###### `bool operator==(const char* s1, const QString &s2)`
###### `bool operator>(const QString &s1, const QString &s2)`
###### `bool operator>(const char* s1, const QString &s2)`
###### `bool operator>=(const QString &s1, const QString &s2)`
###### `bool operator>=(const char* s1, const QString &s2)`
###### `QDataStream & operator>>(QDataStream &stream, QString &string)`



# `Macros`
###### ` QStringLiteral(str)`

###### ` QT_NO_CAST_FROM_ASCII`

###### ` QT_NO_CAST_TO_ASCII`
###### ` QT_RESTRICTED_CAST_FROM_ASCII`



# `说人话`

1. 一个非派生的类
2. 一个没有虚函数的类
3. 只有一个成员 *private: Date\* d*
4. 所以 **8 == sizeof(QString)**
5. 管理一个数组数据,
          [QTypedArrayData\<ushort\>\][QArrayData\*]
                  QtPrivate::RefCount ref;    //引用计数(atomic operation)
                  int size;                   //元素个数(这里是字符个数)
                  uint alloc : 31;            //最大元素个数
                  uint capacityReserved : 1;  //
                  qptrdiff offset;            //数组指针 (this + offset)
6. **24 == sizeof(QArryDate)**            **8 == alignof(QArrayData)**
7. 这个数据的结构是数组属性与使用情况的说明: **引用计数** **贮存元素个数** **最大元素个数** **数组指针**
8. 真正的数组数据是 *offset* 指向的.
9. 牛逼没意思,放码过来.


`QString::fromUtf8()`

```
#include <QString>

int main()
{
    const unsigned char szUtf8[] = {0xE8, 0xBF, 0x99, 0xE6, 0x98, 0xAF, 0xE6, 0x88, 0x91};	//这是我的utf8码
    QString str = QString::fromUtf8(reinterpret_cast<const char*>(szUtf8));
    return 0;
}
```

```
    static inline QString fromUtf8(const char *str, int size = -1)
    {
        return fromUtf8_helper(str, (str && size == -1) ? int(strlen(str)) : size);
    }
```

```
QString QString::fromUtf8_helper(const char *str, int size)
{
    if (!str)
        return QString();

    Q_ASSERT(size != -1);
    return QUtf8::convertToUnicode(str, size);
}
```



```
QString QUtf8::convertToUnicode(const char *chars, int len)
{
    // UTF-8 to UTF-16 always needs the exact same number of words or less:
    //    UTF-8     UTF-16
    //   1 byte     1 word
    //   2 bytes    1 word
    //   3 bytes    1 word
    //   4 bytes    2 words (one surrogate pair)
    // That is, we'll use the full buffer if the input is US-ASCII (1-byte UTF-8),
    // half the buffer for U+0080-U+07FF text (e.g., Greek, Cyrillic, Arabic) or
    // non-BMP text, and one third of the buffer for U+0800-U+FFFF text (e.g, CJK).
    //
    // The table holds for invalid sequences too: we'll insert one replacement char
    // per invalid byte.
    QString result(len, Qt::Uninitialized);
    QChar *data = const_cast<QChar*>(result.constData()); // we know we're not shared
    const QChar *end = convertToUnicode(data, chars, len);
    result.truncate(end - data);
    return result;
}

1 QString result(len, Qt::Uninitialized); ==> 分配了空间,包括最大的数组空间
2 QChar *data = const_cast<QChar*>(result.constData());  ==> 数组开始元素位置
3 const QChar *end = convertToUnicode(data, chars, len); ==> 数组最后元素位置; 转换成Unicode.
4 result.truncate(end - data); ==> 设置正确的元素个数,且确保 double-zero terminal characters.

==============================================
QString result(len, Qt::Uninitialized); ==>
QString::QString(int size, Qt::Initialization)
{
    d = Data::allocate(size + 1);
    Q_CHECK_PTR(d);
    d->size = size;
    d->data()[size] = '\0';
}

QtPrivate::RefCount ref;    //引用计数
int size;                   //元素个数,在这里还不是这个意思,指向最后一个元素
uint alloc : 31;            //最大数组个数
uint capacityReserved : 1;  //
qptrdiff offset;            //数组开始指针

==============================================
d = Data::allocate(size + 1); ==>
Q_REQUIRED_RESULT static QTypedArrayData *allocate(size_t capacity, AllocationOptions options = Default)
{
    Q_STATIC_ASSERT(sizeof(QTypedArrayData) == sizeof(QArrayData));
    return static_cast<QTypedArrayData *>(QArrayData::allocate(sizeof(T), Q_ALIGNOF(AlignmentDummy), capacity, options));
}

==============================================
return static_cast<QTypedArrayData *>(QArrayData::allocate(sizeof(T), Q_ALIGNOF(AlignmentDummy), capacity, options)); ==>
QArrayData *QArrayData::allocate(size_t objectSize, size_t alignment, size_t capacity, AllocationOptions options) Q_DECL_NOTHROW
{
    // Alignment is a power of two
    Q_ASSERT(alignment >= Q_ALIGNOF(QArrayData)
            && !(alignment & (alignment - 1)));

    // Don't allocate empty headers
    if (!(options & RawData) && !capacity) {
#if !defined(QT_NO_UNSHARABLE_CONTAINERS)
        if (options & Unsharable)
            return const_cast<QArrayData *>(&qt_array_unsharable_empty);
#endif
        return const_cast<QArrayData *>(&qt_array_empty);
    }

    size_t headerSize = sizeof(QArrayData);

    // Allocate extra (alignment - Q_ALIGNOF(QArrayData)) padding bytes so we
    // can properly align the data array. This assumes malloc is able to
    // provide appropriate alignment for the header -- as it should!
    // Padding is skipped when allocating a header for RawData.
    if (!(options & RawData))
        headerSize += (alignment - Q_ALIGNOF(QArrayData));

    if (headerSize > size_t(MaxAllocSize))
        return 0;

    size_t allocSize = calculateBlockSize(capacity, objectSize, headerSize, options);
    QArrayData *header = static_cast<QArrayData *>(::malloc(allocSize));
    if (header) {
        quintptr data = (quintptr(header) + sizeof(QArrayData) + alignment - 1)
                & ~(alignment - 1);

#if !defined(QT_NO_UNSHARABLE_CONTAINERS)
        header->ref.atomic.store(bool(!(options & Unsharable)));
#else
        header->ref.atomic.store(1);
#endif
        header->size = 0;
        header->alloc = capacity;
        header->capacityReserved = bool(options & CapacityReserved);
        header->offset = data - quintptr(header);
    }

    return header;
}

// Arg0:元素占用字节数
// Arg1:对齐因子
// Arg2:外部字符有效字节数+1
// Arg3:AllocationOption enum

内部有一个分配空间尺寸的方式: size_t allocSize = calculateBlockSize(capacity, objectSize, headerSize, options); ==> 结构体尺寸+数组尺寸

分配一个类QArrayData空间: QArrayData *header = static_cast<QArrayData *>(::malloc(allocSize));

//初始化:
    header->ref.atomic.store(bool(!(options & Unsharable)));
    header->size = 0;
    header->alloc = capacity;
    header->capacityReserved = bool(options & CapacityReserved);
    header->offset = data - quintptr(header);
        
//返回分配好的类空间
	return header;
```

`QString str = "这是我";`

```
#include <QString>

int main()
{
    QString str = "这是我";
    return 0;
}
```

```
inline QT_ASCII_CAST_WARN QString(const char *ch) 
: d(fromAscii_helper(ch, ch ? int(strlen(ch)) : -1))
{}
```

```
00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f

fd fd fd fd 01 00 00 00 06 00 00 00 07 00 00 00
cd cd cd cd 18 00 00 00 00 00 00 00 fd ff fd ff
fd ff fd ff fd ff fd ff 00 00 fd fd fd fd

==>
01 00 00 00 06 00 00 00 07 00 00 00 cd cd cd cd
18 00 00 00 00 00 00 00 fd ff fd ff fd ff fd ff 
fd ff fd ff 00 00

==>
QtPrivate::RefCount ref;    ==> ref = 1;
int size;                   ==> size = 6;
uint alloc : 31;            ==> alloc = 7;
uint capacityReserved : 1;  ==> capacityReserved = 0;
qptrdiff offset;            ==> offset = 18;

==>
ushort[7] = {0xfffd, 0xfffd, 0xfffd, 0xfffd ,0xfffd ,0xfffd ,0x0000};

==>
乱码.因为我的环境是GB2312编码,它的解码用fromAscii_helper.
可以看下解码器:
compare_helper
localeAwareCompare_helper
toLower_helper
toUpper_helper
toCaseFolded_helper
trimmed_helper

simplified_helper
fromLatin1_helper
fromAscii_helper
fromUtf8_helper
fromLocal8Bit_helper

toLatin1_helper
toUtf8_helper
toLocal8Bit_helper
toUcs4_helper
toIntegral_helper
replace_helper
```

`QString::fromLocal8Bit( "这是我" )`

```
#include <QString>

int main()
{
    QString str = QString::fromLocal8Bit( "这是我" );
    return 0;
}
```

```
static inline QString fromLocal8Bit(const char *str, int size = -1)
{
    return fromLocal8Bit_helper(str, (str && size == -1) ? int(strlen(str)) : size);
}
```

```
QString QString::fromLocal8Bit_helper(const char *str, int size)
{
    if (!str)
        return QString();
    if (size == 0 || (!*str && size < 0)) {
        QStringDataPtr empty = { Data::allocate(0) };
        return QString(empty);
    }
#if !defined(QT_NO_TEXTCODEC)
    if (size < 0)
        size = qstrlen(str);
    QTextCodec *codec = QTextCodec::codecForLocale();
    if (codec)
        return codec->toUnicode(str, size);
#endif // !QT_NO_TEXTCODEC
    return fromLatin1(str, size);
}

==>
QTextCodec *codec = QTextCodec::codecForLocale();
if (codec)
    return codec->toUnicode(str, size);
    
==============================================
/*!
    \threadsafe
    Returns a pointer to the codec most suitable for this locale.

    On Windows, the codec will be based on a system locale. On Unix
    systems, the codec will might fall back to using the \e iconv
    library if no builtin codec for the locale can be found.

    Note that in these cases the codec's name will be "System".
*/
QTextCodec* QTextCodec::codecForLocale()
{
    QCoreGlobalData *globalData = QCoreGlobalData::instance();
    if (!globalData)
        return 0;

    QTextCodec *codec = globalData->codecForLocale.loadAcquire();
    if (!codec) {
#if QT_CONFIG(icu)
        textCodecsMutex()->lock();
        codec = QIcuCodec::defaultCodecUnlocked();
        textCodecsMutex()->unlock();
#else
        // setupLocaleMapper locks as necessary
        codec = setupLocaleMapper();
#endif
    }

    return codec;
}

后面的转码代码:
while (!(len=MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED|MB_ERR_INVALID_CHARS,
            mb, mblen, wc.data(), wc.length()))) {
    int r = GetLastError();
    if (r == ERROR_INSUFFICIENT_BUFFER) {
            const int wclen = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,
                                mb, mblen, 0, 0);
            wc.resize(wclen);
    } else if (r == ERROR_NO_UNICODE_TRANSLATION) {
        //find the last non NULL character
        while (mblen > 1  && !(mb[mblen-1]))
            mblen--;
        //check whether,  we hit an invalid character in the middle
        if ((mblen <= 1) || (remainingChars && state_data))
            return convertToUnicodeCharByChar(chars, length, state);
        //Remove the last character and try again...
        state_data = mb[mblen-1];
        remainingChars = 1;
        mblen--;
    } else {
        // Fail.
        qWarning("MultiByteToWideChar: Cannot convert multibyte text");
        break;
    }
}
```

