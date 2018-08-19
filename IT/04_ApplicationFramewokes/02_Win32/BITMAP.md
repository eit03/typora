***
[TOC]
***

# `1. 简述`
> The BITMAP structure defines the height, width, color format, and bit values of a logical bitmap .

# `2. Structure prototype`

```
/* Bitmap Header Definition */
typedef struct tagBITMAP
{
    LONG        bmType;
    LONG        bmWidth;
    LONG        bmHeight;
    LONG        bmWidthBytes;
    WORD        bmPlanes;
    WORD        bmBitsPixel;
    LPVOID      bmBits;
} BITMAP, *PBITMAP, NEAR *NPBITMAP, FAR *LPBITMAP;
```

# `3. Parameters`

`bmType`

> Specifies the bitmap type. For logical bitmaps, this member must be 0.

`bmWidth`

> Specifies the width of the bitmap in pixels. The width must be greater than 0.

`bmHeight`

> Specifies the height of the bitmap in raster lines. The height must be greater than 0.

`bmWidthBytes`

> 　Specifies the number of bytes in each raster line. This value must be an even number since the graphics device interface (GDI) assumes that the bit values of a bitmap form an array of integer (2-byte) values. In other words, bmWidthBytes * 8 must be the next multiple of 16 greater than or equal to the value obtained when the bmWidth member is multiplied by the bmBitsPixel member.

`bmPlanes`

> Specifies the number of color planes in the bitmap.

`bmBitsPixel`

> Specifies the number of adjacent color bits on each plane needed to define a pixel.

`bmBits`

> Points to the location of the bit values for the bitmap. The bmBits member must be a long pointer to an array of 1-byte values.

