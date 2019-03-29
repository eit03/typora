***
`Version:` 5.11.1
`Declaration:`
`Defination:`
`Reference:`
`Keyword:` \[QWidgetData\]

***
[TOC]
***


# `Brief Introduction`
# `Detailed Description`

# `Data Struct`

## `Type Declaration`

```
class QWidgetData
{
public:
    WId             winid;
    uint            widget_attributes;
    Qt::WindowFlags window_flags;            //窗口标志集
    uint            window_state : 4;
    uint            focus_policy : 4;
    uint            sizehint_forced :1;
    uint            is_closing :1;
    uint            in_show : 1;
    uint            in_set_window_state : 1;
    mutable uint    fstrut_dirty : 1;
    uint            context_menu_policy : 3;
    uint            window_modality : 2;
    uint            in_destructor : 1;
    uint            unused : 13;
    QRect           crect;
    mutable         QPalette pal;
    QFont           fnt;
    QRect           wrect;
};
```

## `Construtor`
```

```
## `Memeory Model`
```
[QWidgetData]
    WId             winid;
    uint            widget_attributes;
    Qt::WindowFlags window_flags;
    uint            window_state : 4;
    uint            focus_policy : 4;
    uint            sizehint_forced :1;
    uint            is_closing :1;
    uint            in_show : 1;
    uint            in_set_window_state : 1;
    mutable uint    fstrut_dirty : 1;
    uint            context_menu_policy : 3;
    uint            window_modality : 2;
    uint            in_destructor : 1;
    uint            unused : 13;
    QRect           crect;
    mutable         QPalette pal;
    QFont           fnt;
    QRect           wrect;
```

# `Properties`

# `Public Types`
# `Public Functions`
# `Reimplemented Public Functions`
# `Public Slots`

# `Static Public Members`

# `Protected Types`
# `Protected Functions`
# `Reimplemented Protected Functions`
# `Protected Slots`
# `staitc Protected Members`

# `Private Types`
# `Private Functions`
# `Private Slots`
# `Static Private Members`

# `Signals`
# `Related Non-Members`
# `Macros`
