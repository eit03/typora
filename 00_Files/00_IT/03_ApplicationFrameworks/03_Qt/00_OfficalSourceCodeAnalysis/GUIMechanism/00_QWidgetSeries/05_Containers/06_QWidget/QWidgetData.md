***
`Version:` 5.10
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

```
class QWidgetData
{
public:
    WId winid;
    uint widget_attributes;
    Qt::WindowFlags window_flags;
    uint window_state : 4;
    uint focus_policy : 4;
    uint sizehint_forced :1;
    uint is_closing :1;
    uint in_show : 1;
    uint in_set_window_state : 1;
    mutable uint fstrut_dirty : 1;
    uint context_menu_policy : 3;
    uint window_modality : 2;
    uint in_destructor : 1;
    uint unused : 13;
    QRect crect;
    mutable QPalette pal;
    QFont fnt;
    QRect wrect;
};
```

```
无
```

```
[QWidgetData]
    WId winid;
    uint widget_attributes;
    Qt::WindowFlags window_flags;
    uint window_state : 4;
    uint focus_policy : 4;
    uint sizehint_forced :1;
    uint is_closing :1;
    uint in_show : 1;
    uint in_set_window_state : 1;
    mutable uint fstrut_dirty : 1;
    uint context_menu_policy : 3;
    uint window_modality : 2;
    uint in_destructor : 1;
    uint unused : 13;
    QRect crect;
    mutable QPalette pal;
    QFont fnt;
    QRect wrect;
```



# `Properties`

# `Public Types`
# `Public Functions`
# `Public Slots`
# `Signals`
# `Static Public Members`

# `Protected Types`
# `Protected Functions`
# `Protected Slots`
# `Protected Public Members`

# `Private Types`
# `Private Functions`
# `Private Slots`
# `Static Private Members`

# `Related Non-Members`
# `Macros`
