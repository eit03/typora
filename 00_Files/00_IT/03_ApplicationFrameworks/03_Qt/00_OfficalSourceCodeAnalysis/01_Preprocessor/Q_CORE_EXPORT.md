```
Q_CORE_EXPORT

#if defined(QT_SHARED) || !defined(QT_STATIC)
#  ifdef QT_STATIC
#    error "Both QT_SHARED and QT_STATIC defined, please make up your mind"
#  endif
#  ifndef QT_SHARED
#    define QT_SHARED
#  endif
#  if defined(QT_BUILD_CORE_LIB)
#    define Q_CORE_EXPORT Q_DECL_EXPORT
#  else
#    define Q_CORE_EXPORT Q_DECL_IMPORT
#  endif
#else
#  define Q_CORE_EXPORT
#endif

//_MSC_VER
#define Q_DECL_EXPORT __declspec(dllexport)
#define Q_DECL_IMPORT __declspec(dllimport)
//Linux
#define Q_CORE_EXPORT

可以看的出来,
```