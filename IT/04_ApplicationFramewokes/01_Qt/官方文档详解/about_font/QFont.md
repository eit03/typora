***
`Version:` 5.10
`Declaration:` 
`Defination:` 
`Reference:` 
`Keyword:` QFont
***
[TOC]
***
# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class Q_GUI_EXPORT QFont
{
//*****************************************************************************************************************
//Prepare ******************************************************************************************************
public:
    enum StyleHint {
        Helvetica,  SansSerif = Helvetica,
        Times,      Serif = Times,
        Courier,    TypeWriter = Courier,
        OldEnglish, Decorative = OldEnglish,
        System,
        AnyStyle,
        Cursive,
        Monospace,
        Fantasy
    };
    Q_ENUM(StyleHint)

    enum StyleStrategy {
        PreferDefault       = 0x0001,
        PreferBitmap        = 0x0002,
        PreferDevice        = 0x0004,
        PreferOutline       = 0x0008,
        ForceOutline        = 0x0010,
        PreferMatch         = 0x0020,
        PreferQuality       = 0x0040,
        PreferAntialias     = 0x0080,
        NoAntialias         = 0x0100,
        OpenGLCompatible    = 0x0200,
        ForceIntegerMetrics = 0x0400,
        NoSubpixelAntialias = 0x0800,
        PreferNoShaping     = 0x1000,
        NoFontMerging       = 0x8000
    };
    Q_ENUM(StyleStrategy)

    enum HintingPreference {
        PreferDefaultHinting        = 0,
        PreferNoHinting             = 1,
        PreferVerticalHinting       = 2,
        PreferFullHinting           = 3
    };
    Q_ENUM(HintingPreference)

    // Mapping OpenType weight value.
    enum Weight {
        Thin     = 0,    // 100
        ExtraLight = 12, // 200
        Light    = 25,   // 300
        Normal   = 50,   // 400
        Medium   = 57,   // 500
        DemiBold = 63,   // 600
        Bold     = 75,   // 700
        ExtraBold = 81,  // 800
        Black    = 87    // 900
    };
    Q_ENUM(Weight)

    enum Style {
        StyleNormal,
        StyleItalic,
        StyleOblique
    };
    Q_ENUM(Style)

    enum Stretch {
        AnyStretch     =   0,
        UltraCondensed =  50,
        ExtraCondensed =  62,
        Condensed      =  75,
        SemiCondensed  =  87,
        Unstretched    = 100,
        SemiExpanded   = 112,
        Expanded       = 125,
        ExtraExpanded  = 150,
        UltraExpanded  = 200
    };
    Q_ENUM(Stretch)

    enum Capitalization {
        MixedCase,
        AllUppercase,
        AllLowercase,
        SmallCaps,
        Capitalize
    };
    Q_ENUM(Capitalization)

    enum SpacingType {
        PercentageSpacing,
        AbsoluteSpacing
    };
    Q_ENUM(SpacingType)

    enum ResolveProperties {
        FamilyResolved              = 0x0001,
        SizeResolved                = 0x0002,
        StyleHintResolved           = 0x0004,
        StyleStrategyResolved       = 0x0008,
        WeightResolved              = 0x0010,
        StyleResolved               = 0x0020,
        UnderlineResolved           = 0x0040,
        OverlineResolved            = 0x0080,
        StrikeOutResolved           = 0x0100,
        FixedPitchResolved          = 0x0200,
        StretchResolved             = 0x0400,
        KerningResolved             = 0x0800,
        CapitalizationResolved      = 0x1000,
        LetterSpacingResolved       = 0x2000,
        WordSpacingResolved         = 0x4000,
        HintingPreferenceResolved   = 0x8000,
        StyleNameResolved           = 0x10000,
        AllPropertiesResolved       = 0x1ffff
    };
    
//*****************************************************************************************************************
//Properties ***************************************************************************************************
private:
    QExplicitlySharedDataPointer<QFontPrivate> d;
    uint resolve_mask;
//*****************************************************************************************************************
//Constructor **************************************************************************************************
public:
    QFont();
    QFont(const QString &family, int pointSize = -1, int weight = -1, bool italic = false);
    QFont(const QFont &, QPaintDevice *pd);
    QFont(const QFont &);
    QFont::QFont(QFontPrivate *data);
    
//*****************************************************************************************************************
//Functions ****************************************************************************************************
}
```
## `Construtor`
```
QFont::QFont() : d(QGuiApplicationPrivate::instance() ? QGuiApplication::font().d.data() : new QFontPrivate()), resolve_mask(0) {}

QFont::QFont(const QString &family, int pointSize, int weight, bool italic) : d(new QFontPrivate()), resolve_mask(QFont::FamilyResolved)
{
    if (pointSize <= 0) {
        pointSize = 12;
    } else {
        resolve_mask |= QFont::SizeResolved;
    }

    if (weight < 0) {
        weight = Normal;
    } else {
        resolve_mask |= QFont::WeightResolved | QFont::StyleResolved;
    }

    if (italic)
        resolve_mask |= QFont::StyleResolved;

    d->request.family = family;
    d->request.pointSize = qreal(pointSize);
    d->request.pixelSize = -1;
    d->request.weight = weight;
    d->request.style = italic ? QFont::StyleItalic : QFont::StyleNormal;
}

QFont::QFont(const QFont &font, QPaintDevice *pd) : resolve_mask(font.resolve_mask)
{
    Q_ASSERT(pd != 0);
    int dpi = pd->logicalDpiY();
    const int screen = 0;
    if (font.d->dpi != dpi || font.d->screen != screen ) {
        d = new QFontPrivate(*font.d);
        d->dpi = dpi;
        d->screen = screen;
    } else {
        d = font.d;
    }
}

QFont::QFont(const QFont &font) : d(font.d), resolve_mask(font.resolve_mask) {}

QFont::QFont(QFontPrivate *data) : d(data), resolve_mask(QFont::AllPropertiesResolved) {}
```
## `Memeory Model`
```

```

# `Properties`

# `Public Types`
###### `enum Capitalization { MixedCase, AllUppercase, AllLowercase, SmallCaps, Capitalize }`
###### `enum HintingPreference { PreferDefaultHinting, PreferNoHinting, PreferVerticalHinting, PreferFullHinting }`
###### `enum SpacingType { PercentageSpacing, AbsoluteSpacing }`
###### `enum Stretch { AnyStretch, UltraCondensed, ExtraCondensed, Condensed, ..., UltraExpanded }`
###### `enum Style { StyleNormal, StyleItalic, StyleOblique }`
###### `enum StyleHint { AnyStyle, SansSerif, Helvetica, Serif, ..., System }`
###### `enum StyleStrategy { PreferDefault, PreferBitmap, PreferDevice, PreferOutline, ..., ForceIntegerMetrics }`
###### `enum Weight { Thin, ExtraLight, Light, Normal, ..., Black }`

# `Public Functions`
###### `QFont()`
###### `QFont(const QString &family, int pointSize = -1, int weight = -1, bool italic = false)`
###### `QFont(const QFont &font, QPaintDevice *pd)`
###### `QFont(const QFont &font)`
###### `~QFont()`
###### `bool bold() const`
###### `Capitalization capitalization() const`
###### `QString defaultFamily() const`
###### `bool exactMatch() const`
###### `QString family() const`
###### `bool fixedPitch() const`
###### `bool fromString(const QString &descrip)`
###### `HintingPreference hintingPreference() const`
###### `bool isCopyOf(const QFont &f) const`
###### `bool italic() const`
###### `bool kerning() const`
###### `QString key() const`
###### `QString lastResortFamily() const`
###### `QString lastResortFont() const`
###### `qreal letterSpacing() const`
###### `SpacingType letterSpacingType() const`
###### `bool overline() const`
###### `int pixelSize() const`
###### `int pointSize() const`
###### `qreal pointSizeF() const`
###### `QFont resolve(const QFont &other) const`
###### `void setBold(bool enable)`
###### `void setCapitalization(Capitalization caps)`
###### `void setFamily(const QString &family)`
###### `void setFixedPitch(bool enable)`
###### `void setHintingPreference(HintingPreference hintingPreference)`
###### `void setItalic(bool enable)`
###### `void setKerning(bool enable)`
###### `void setLetterSpacing(SpacingType type, qreal spacing)`
###### `void setOverline(bool enable)`
###### `void setPixelSize(int pixelSize)`
###### `void setPointSize(int pointSize)`
###### `void setPointSizeF(qreal pointSize)`
###### `void setStretch(int factor)`
###### `void setStrikeOut(bool enable)`
###### `void setStyle(Style style)`
###### `void setStyleHint(StyleHint hint, StyleStrategy strategy = PreferDefault)`
###### `void setStyleName(const QString &styleName)`
###### `void setStyleStrategy(StyleStrategy s)`
###### `void setUnderline(bool enable)`
###### `void setWeight(int weight)`
###### `void setWordSpacing(qreal spacing)`
###### `int stretch() const`
###### `bool strikeOut() const`
###### `Style style() const`
###### `StyleHint styleHint() const`
###### `QString styleName() const`
###### `StyleStrategy styleStrategy() const`
###### `void swap(QFont &other)`
###### `QString toString() const`
###### `bool underline() const`
###### `int weight() const`
###### `qreal wordSpacing() const`
###### `operator QVariant() const`
###### `bool operator!=(const QFont &f) const`
###### `bool operator<(const QFont &f) const`
###### `QFont & operator=(const QFont &font)`
###### `QFont & operator=(QFont &&other)`
###### `bool operator==(const QFont &f) const`

# `Reimplemented Public Functions`

# `Public Slots`

# `Signals`

# `Static Public Members`
###### `void insertSubstitution(const QString &familyName, const QString &substituteName)`
###### `void insertSubstitutions(const QString &familyName, const QStringList &substituteNames)`
###### `void removeSubstitutions(const QString &familyName)`
###### `QString substitute(const QString &familyName)`
###### `QStringList substitutes(const QString &familyName)`
###### `QStringList substitutions()`

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
###### `uint qHash(const QFont &font, uint seed = 0)`
###### `QDataStream & operator<<(QDataStream &s, const QFont &font)`
###### `QDataStream & operator>>(QDataStream &s, QFont &font)`

# `Macros`
