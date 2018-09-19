***
[TOC]
***

# `1. Brief Introduction`

ELF[^1]是一种对象文件的格式，用于定义不同类型的对象文件(Object files)中都放了什么东西、以及都以什么样的格式去放这些东西。

# `2. Category`

- 可执行文件(Executable File) .exe) 包含适合于执行的一个程序，此文件规定了exec() 如何创建一个程序的进程映像。

- 可重定位文件(Relocatable File) .o)包含适合于与其他目标文件链接来创建可执行文件或者共享目标文件的代码和数据。

- 共享目标文件(Shared Object File) .so) 包含可在两种上下文中链接的代码和数据。
  - 首先链接编辑器可以将它和其它可重定位文件和共享目标文件一起处理， 生成另外一个目标文件。
  - 其次动态链接器(Dynamic Linker)可能将它与某个可执行文件以及其它共享目标一起组合，创建进程映像。

# `3. 作用`

ELF文件参与程序的连接(建立一个程序)和程序的执行(运行一个程序)，所以可以从不同的角度来看待elf格式的文件：

- 如果用于编译和链接（可重定位文件），则编译器和链接器将把elf文件看作是节头表描述的节的集合,程序头表可选。

- 如果用于加载执行（可执行文件），则加载器则将把elf文件看作是程序头表描述的段的集合，一个段可能包含多个节，节头表可选。

- 如果是共享文件，则两者都含有。

# `4. 格式分析`

## `4.2 ELF header (Ehdr)`  



```
/* Type for a 16-bit quantity.  */
typedef uint16_t Elf32_Half;
typedef uint16_t Elf64_Half;

/* Types for signed and unsigned 32-bit quantities.  */
typedef uint32_t Elf32_Word;
typedef	int32_t  Elf32_Sword;
typedef uint32_t Elf64_Word;
typedef	int32_t  Elf64_Sword;

/* Types for signed and unsigned 64-bit quantities.  */
typedef uint64_t Elf32_Xword;
typedef	int64_t  Elf32_Sxword;
typedef uint64_t Elf64_Xword;
typedef	int64_t  Elf64_Sxword;

/* Type of addresses.  */
typedef uint32_t Elf32_Addr;
typedef uint64_t Elf64_Addr;

/* Type of file offsets.  */
typedef uint32_t Elf32_Off;
typedef uint64_t Elf64_Off;

/* Type for section indices, which are 16-bit quantities.  */
typedef uint16_t Elf32_Section;
typedef uint16_t Elf64_Section;

/* Type for version symbol information.  */
typedef Elf32_Half Elf32_Versym;
typedef Elf64_Half Elf64_Versym;
```



The ELF header is described by the type Elf32_Ehdr or Elf64_Ehdr:

```
reference from /usr/include/elf.h
/* The ELF file header.  This appears at the start of every ELF file.  */

#define EI_NIDENT (16)

typedef struct {
    unsigned char e_ident[EI_NIDENT];  /* Magic number and other info */
    Elf32_Half    e_type;              /* Object file type */
    Elf32_Half    e_machine;           /* Architecture */
    Elf32_Word    e_version;           /* Object file version */
    Elf32_Addr    e_entry;             /* Entry point virtual address */
    Elf32_Off     e_phoff;             /* Program header table file offset */
    Elf32_Off     e_shoff;             /* Section header table file offset */
    Elf32_Word    e_flags;             /* Processor-specific flags */
    Elf32_Half    e_ehsize;            /* ELF header size in bytes */
    Elf32_Half    e_phentsize;         /* Program header table entry size */
    Elf32_Half    e_phnum;             /* Program header table entry count */
    Elf32_Half    e_shentsize;         /* Section header table entry size */
    Elf32_Half    e_shnum;             /* Section header table entry count */
    Elf32_Half    e_shstrndx;          /* Section header string table index */
} Elf32_Ehdr;

typedef struct {
    unsigned char e_ident[EI_NIDENT];  /* Magic number and other info */
    Elf64_Half    e_type;              /* Object file type */
    Elf64_Half    e_machine;           /* Architecture */
    Elf64_Word    e_version;           /* Object file version */
    Elf64_Addr    e_entry;             /* Entry point virtual address */
    Elf64_Off     e_phoff;             /* Program header table file offset */
    Elf64_Off     e_shoff;             /* Section header table file offset */
    Elf64_Word    e_flags;             /* Processor-specific flags */
    Elf64_Half    e_ehsize;            /* ELF header size in bytes */
    Elf64_Half    e_phentsize;         /* Program header table entry size */
    Elf64_Half    e_phnum;             /* Program header table entry count */
    Elf64_Half    e_shentsize;         /* Section header table entry size */
    Elf64_Half    e_shnum;             /* Section header table entry count */
    Elf64_Half    e_shstrndx;          /* Section header string table index */
} Elf64_Ehdr;
```

###### `e_ident`

这个字节数组说明如何解释文件,依赖于处理器或后面的内容.数组内的任何事物(key and valueIndex)被命名为宏,key的前缀为**EI_**,valueIndex的前缀为**ELF**,每一字节宏与意图如下:



```
typedef struct {
    unsigned char    ei_identification[4];
    unsigned char    ei_class;
    unsigned char    ei_data;
    unsigned char    ei_version;
    unsigned char    ei_osabi;
    unsigned char    ei_pad[6];
    unsigned char    ei_ident_size;
} e_ident_t;
```



- EI_MAG0 EI_MAG1 EI_MAG2 EI_MAG3: 
  被称为*Magic number*,ELF文件格式标志;

  ```
  /* Fields in the e_ident array.  The EI_* macros are indices into the
     array.  The macros under each EI_* macro are the values the byte
     may have.  */
  
  #define EI_MAG0		0		/* File identification byte 0 index */
  #define ELFMAG0		0x7f	 /* Magic number byte 0 */
  
  #define EI_MAG1		1		/* File identification byte 1 index */
  #define ELFMAG1		'E'		/* Magic number byte 1 */
  
  #define EI_MAG2		2		/* File identification byte 2 index */
  #define ELFMAG2		'L'		/* Magic number byte 2 */
  
  #define EI_MAG3		3		/* File identification byte 3 index */
  #define ELFMAG3		'F'		/* Magic number byte 3 */
  ```

- EI_CLASS:
  目标架构;

  ```
  #define EI_CLASS      4    /* File class byte index */
  
  #define ELFCLASSNONE  0    /* Invalid class */
  #define ELFCLASS32    1    /* 32-bit objects */
  #define ELFCLASS64    2    /* 64-bit objects */
  #define ELFCLASSNUM   3
  ```

- EI_DATA:
  文件大小端格式;

  ```
  #define EI_DATA	    5		/* Data encoding byte index */
  
  #define ELFDATANONE	0		/* Invalid data encoding */
  #define ELFDATA2LSB	1		/* 2's complement, little endian */
  #define ELFDATA2MSB	2		/* 2's complement, big endian */
  #define ELFDATANUM	3
  ```

- EI_VERSION:
  文件版本;

  ```
  #define EI_VERSION	  6		/* File version byte index */
  
  #define EV_NONE       0      /* Invalid ELF version */
  #define EV_CURRENT    1      /* Current version */
  #define EV_NUM        2
  ```
- EI_OSABI[^3]:
    reference from */usr/include/elf.h*

  ```
  #define EI_OSABI    7        /* OS ABI identification */
                 
  #define ELFOSABI_NONE        0             /* UNIX System V ABI */
  #define ELFOSABI_SYSV        0             /* Alias.  */
  #define ELFOSABI_HPUX        1             /* HP-UX */
  #define ELFOSABI_NETBSD      2             /* NetBSD.  */
  #define ELFOSABI_GNU         3             /* Object uses GNU ELF extensions.  */
  #define ELFOSABI_LINUX       ELFOSABI_GNU  /* Compatibility alias.  */
  #define ELFOSABI_SOLARIS     6             /* Sun Solaris.  */
  #define ELFOSABI_AIX         7             /* IBM AIX.  */
  #define ELFOSABI_IRIX        8             /* SGI Irix.  */
  #define ELFOSABI_FREEBSD     9             /* FreeBSD.  */
  #define ELFOSABI_TRU64       10            /* Compaq TRU64 UNIX.  */
  #define ELFOSABI_MODESTO     11            /* Novell Modesto.  */
  #define ELFOSABI_OPENBSD     12            /* OpenBSD.  */
  #define ELFOSABI_ARM_AEABI   64            /* ARM EABI */
  #define ELFOSABI_ARM         97            /* ARM */
  #define ELFOSABI_STANDALONE  255           /* Standalone (embedded) application */
  ```

- EI_ABIVERSION

  ```
  #define EI_ABIVERSION	8		/* ABI version */
  ```

- EI_PAD:
  填充6位.没有什么作用,只是为了占位&对齐.

  ```
  #define EI_PAD		9		/* Byte index of padding bytes */
  ```

- EI_NIDENT:
  *e_ident*数组的尺寸;
  但是有的没有使用它,为0;

###### `e_type`

目标文件类型;

```
typedef enum <Elf32_Half> {
    ET_NONE		=0,        /* unknow file type */
    ET_REL       =1,        /* A relocatable file */
    ET_EXEC		=2,        /* An executable file */
    ET_DYN       =3,        /* A shared object */
    ET_CORE		=4,        /* A core file */
    ET_LOOS		=0xfe00,
    ET_HIOS		=0xfeff,
    ET_LOPROC	=0xff00,
    ET_HIPROC	=0xffff
} e_type32_e;
typedef e_type32_e e_type64_e;
```

###### `e_machine`

机器架构;

```
typedef enum <Elf32_Half> {    // list has to to be completed
    EM_NONE           =0,      //No machine    
    EM_M32            =1,      //AT&T WE 32100    
    EM_SPARC          =2,      //SPARC    
    EM_386            =3,      //Intel 80386    
    EM_68K            =4,      //Motorola 68000    
    EM_88K            =5,      //Motorola 88000    
    reserved6         =6,      //Reserved for future use (was EM_486)    
    EM_860            =7,      //Intel 80860    
    EM_MIPS           =8,      //MIPS I Architecture    
    EM_S370           =9,      //IBM System/370 Processor    
    EM_MIPS_RS3_LE    =10,     //MIPS RS3000 Little-endian    
    reserved11        =11,     //Reserved for future use
    reserved12        =12,     //Reserved for future use
    reserved13        =13,     //Reserved for future use    
    reserved14        =14,     //Reserved for future use
    EM_PARISC         =15,     //Hewlett-Packard PA-RISC    
    reserved16        =16,     //Reserved for future use    
    EM_VPP500         =17,     //Fujitsu VPP500    
    EM_SPARC32PLUS    =18,     //Enhanced instruction set SPARC    
    EM_960            =19,     //Intel 80960    
    EM_PPC            =20,     //PowerPC    
    EM_PPC64          =21,     //64-bit PowerPC    
    EM_S390           =22,     //IBM System/390 Processor    
    reserved23        =23,     //Reserved for future use    
    reserved24        =24,     //Reserved for future use    
    reserved25        =25,     //Reserved for future use    
    reserved26        =26,     //Reserved for future use    
    reserved27        =27,     //Reserved for future use    
    reserved28        =28,     //Reserved for future use    
    reserved29        =29,     //Reserved for future use    
    reserved30        =30,     //Reserved for future use    
    reserved31        =31,     //Reserved for future use    
    reserved32        =32,     //Reserved for future use    
    reserved33        =33,     //Reserved for future use    
    reserved34        =34,     //Reserved for future use    
    reserved35        =35,     //Reserved for future use    
    EM_V800           =36,     //NEC V800    
    EM_FR20           =37,     //Fujitsu FR20    
    EM_RH32           =38,     //TRW RH-32    
    EM_RCE            =39,     //Motorola RCE    
    EM_ARM            =40,     //Advanced RISC Machines ARM    
    EM_ALPHA          =41,     //Digital Alpha    
    EM_SH             =42,     //Hitachi SH    
    EM_SPARCV9        =43,     //SPARC Version 9    
    EM_TRICORE        =44,     //Siemens TriCore embedded processor    
    EM_ARC            =45,     //Argonaut RISC Core, Argonaut Technologies Inc.    
    EM_H8_300         =46,     //Hitachi H8/300    
    EM_H8_300H        =47,     //Hitachi H8/300H    
    EM_H8S            =48,     //Hitachi H8S    
    EM_H8_500         =49,     //Hitachi H8/500    
    EM_IA_64          =50,     //Intel IA-64 processor architecture    
    EM_MIPS_X         =51,     //Stanford MIPS-X    
    EM_COLDFIRE       =52,     //Motorola ColdFire    
    EM_68HC12         =53,     //Motorola M68HC12    
    EM_MMA            =54,     //Fujitsu MMA Multimedia Accelerator    
    EM_PCP            =55,     //Siemens PCP    
    EM_NCPU           =56,     //Sony nCPU embedded RISC processor    
    EM_NDR1           =57,     //Denso NDR1 microprocessor    
    EM_STARCORE       =58,     //Motorola Star*Core processor    
    EM_ME16           =59,     //Toyota ME16 processor    
    EM_ST100          =60,     //STMicroelectronics ST100 processor    
    EM_TINYJ          =61,     //Advanced Logic Corp. TinyJ embedded processor family    
    EM_X86_64         =62,     //AMD x86-64 architecture    
    EM_PDSP           =63,     //Sony DSP Processor    
    EM_PDP10          =64,     //Digital Equipment Corp. PDP-10    
    EM_PDP11          =65,     //Digital Equipment Corp. PDP-11    
    EM_FX66           =66,     //Siemens FX66 microcontroller    
    EM_ST9PLUS        =67,     //STMicroelectronics ST9+ 8/16 bit microcontroller    
    EM_ST7            =68,     //STMicroelectronics ST7 8-bit microcontroller    
    EM_68HC16         =69,     //Motorola MC68HC16 Microcontroller    
    EM_68HC11         =70,       //Motorola MC68HC11 Microcontroller    
    EM_68HC08         =71,     //Motorola MC68HC08 Microcontroller    
    EM_68HC05         =72,     //Motorola MC68HC05 Microcontroller    
    EM_SVX            =73,     //Silicon Graphics SVx    
    EM_ST19           =75,     //Digital VAX    
    EM_CRIS           =76,     //Axis Communications 32-bit embedded processor    
    EM_JAVELIN        =77,     //Infineon Technologies 32-bit embedded processor    
    EM_FIREPATH       =78,     //Element 14 64-bit DSP Processor    
    EM_ZSP            =79,     //LSI Logic 16-bit DSP Processor    
    EM_MMIX           =80,     //Donald Knuth's educational 64-bit processor    
    EM_HUANY          =81,     //Harvard University machine-independent object files    
    EM_PRISM          =82,     //SiTera Prism    
    EM_AVR            =83,     //Atmel AVR 8-bit microcontroller    
    EM_FR30           =84,     //Fujitsu FR30    
    EM_D10V           =85,     //Mitsubishi D10V    
    EM_D30V           =86,     //Mitsubishi D30V    
    EM_V850           =87,     //NEC v850    
    EM_M32R           =88,     //Mitsubishi M32R    
    EM_MN10300        =89,     //Matsushita MN10300    
    EM_MN10200        =90,     //Matsushita MN10200    
    EM_PJ             =91,     //picoJava    
    EM_OPENRISC       =92,     //OpenRISC 32-bit embedded processor    
    EM_ARC_A5         =93,     //ARC Cores Tangent-A5    
    EM_XTENSA         =94,     //Tensilica Xtensa Architecture    
    EM_VIDEOCORE      =95,     //Alphamosaic VideoCore processor    
    EM_TMM_GPP        =96,     //Thompson Multimedia General Purpose Processor    
    EM_NS32K          =97,     //National Semiconductor 32000 series    
    EM_TPC            =98,     //Tenor Network TPC processor    
    EM_SNP1K          =99,     //Trebia SNP 1000 processor    
    EM_ST200          =100,    //STMicroelectronics (www.st.com) ST200 microcontroller    
    EM_IP2K           =101,    //Ubicom IP2xxx microcontroller family    
    EM_MAX            =102,    //MAX Processor    
    EM_CR             =103,    //National Semiconductor CompactRISC microprocessor    
    EM_F2MC16         =104,    //Fujitsu F2MC16    
    EM_MSP430         =105,    //Texas Instruments embedded microcontroller msp430    
    EM_BLACKFIN       =106,    //Analog Devices Blackfin (DSP) processor    
    EM_SE_C33         =107,    //S1C33 Family of Seiko Epson processors    
    EM_SEP            =108,    //Sharp embedded microprocessor    
    EM_ARCA           =109,    //Arca RISC Microprocessor    
    EM_UNICORE        =110     //Microprocessor series from PKU-Unity Ltd. and MPRC of Peking University
} e_machine32_e;
typedef e_machine32_e e_machine64_e;
```



###### `e_version`

ELF版本;

````
#define EV_NONE       0      /* Invalid version */
#define EV_CURRENT    1      /* Current version */
````

###### `e_entry`

程序入口点;

如果没有入口点,为零;

###### `e_phoff`

程序头表的文件偏移;

如果没有,为零;

###### `e_shoff`

节区头表的文件偏移;

如果没有,为零;

###### `e_flags`

处理器特有的标志;

###### `e_ehsize`

ELF头的尺寸;

###### `e_phentsize`

程序头表的单个条目的尺寸,表中每个条目尺寸相同;

###### `e_phnum`

程序头表的条目数;
如果大于等于*PN_XNUM(0xffff)*,真实的数据是保存在*sh_info*中.否,*sh_info*为零;

###### `e_shentsize`

节区头表的单个条目的尺寸,表中每个条目尺寸相同;

###### `e_shnum`

节区头表的条目数;

如果没有节区头表为零;

如果大于等于*SHN_LORESERVE(0xff00)*,字段保存零,真实的数据是保存在*sh_size*中.否,*sh_size*为零;

###### `e_shstrndx`

节头表的条目*节名字符串表*的索引;

如果没有节头表条目*节名字符串表*为零;

如果大于等于*SHN_LORESERVE(0xff00)*,字段保存*SHN_XINDEX(0xffff)*,真实的数据是保存在*sh_link*中.否,*sh_link*为零;

```
typedef enum <Elf32_Word> {
	SHN_UNDEF     = 0x0,    /* undefined, e.g. undefined symbol */
	SHN_LORESERVE = 0xff00, /* Lower bound of reserved indices */
	SHN_LOPROC    = 0xff00, /* Lower bound processor-specific index */
	SHN_HIPROC    = 0xff1f, /* Upper bound processor-specific index */
	SHN_LOOS      = 0xff20, /* Lower bound OS-specific index */
	SHN_HIOS      = 0xff3f, /* Upper bound OS-specific index */
	SHN_ABS       = 0xfff1, /* Absolute value, not relocated */
	SHN_COMMON    = 0xfff2, /* FORTRAN common or unallocated C */
	SHN_HIRESERVE = 0xffff  /* Upper bound of reserved indices */
} s_name32_e;
typedef s_name32_e s_name64_e;
```

## `Program header (Phdr)`
*Executable file* and *Shared object file* 的程序头表是一个数组结构.每一个描述一个段或执行时需要的其它信息;

一个目标文件段包含一个或多个节;

程序头表只对 *Executable file* and *Shared object file* 有意义;



Program header Phdr:

```
typedef struct {
	uint32_t   p_type;
	Elf32_Off  p_offset;
	Elf32_Addr p_vaddr;
	Elf32_Addr p_paddr;
	uint32_t   p_filesz;
	uint32_t   p_memsz;
	uint32_t   p_flags;
	uint32_t   p_align;
} Elf32_Phdr;

typedef struct {
	uint32_t   p_type;
	uint32_t   p_flags;
	Elf64_Off  p_offset;
	Elf64_Addr p_vaddr;
	Elf64_Addr p_paddr;
	uint64_t   p_filesz;
	uint64_t   p_memsz;
	uint64_t   p_align;
} Elf64_Phdr;
```

###### `p_type`

段类型;

```
// Program Header Types
typedef enum <Elf32_Word> {
    PT_NULL     =0,          /* 条目未使用,条目其它数据未定义的 */
    PT_LOAD     =1,          /* 此数组元素给出一个可加载的段,段的大小由 p_filesz 和 p_memsz 描述。文件中的字节被映射到
                                内存段开始处。如果 p_memsz 大于 p_filesz,“剩余”的字节要清零。
                                p_filesz 不能大于 p_memsz。可加载的段在程序头部表格中根据 p_vaddr 成员按升序排列。 */                 
    PT_DYNAMIC  =2,          /* 动态链接段 */
    PT_INTERP   =3,          /* 段给出一个 NULL 结尾的字符串的位置和长度,该字符串将被当作解释器调用。
                                这种段类型仅对与可执行文件有意义(尽管也可能在共享目标文件上发生)。在一个文件中不能出现一次以上。
                                如果存在这种类型的段,它必须在所有可加载段项目的前面。 */      
    PT_NOTE     =4,          /* 段指定注释的位置 */
    PT_SHLIB    =5,          /* 此段类型被保留,不过语义未指定。包含这种类型的段的程序与 ABI不符。 */
    PT_PHDR     =6,          /* 此类型的数组元素如果存在,则给出了程序头部表自身的大小和位置,既包括在文件中也包括在内存中的信息。
                                此类型的段在文件中不能出现一次以上。并且只有程序头部表是程序的内存映像的一部分时才起作用。
                                如果存在此类型段,则必须在所有可加载段项目的前面。 */
    PT_LOOS     =0x60000000, /*  */
    PT_HIOS     =0x6fffffff, /*  */
    PT_LOPROC   =0x70000000, /* 最小保留类型,处理器专用语义 */
    PT_HIPROC   =0x7fffffff  /* 最大保留类型,处理器专用语义 */
} p_type32_e;
typedef p_type32_e p_type64_e;
```


###### `p_flags`

与段相关的标志掩码;

代码段通常有 read and execute 权限;

数据段通常有 read and write and execute 权限;

```
#define PF_X		(1 << 0)	/* Segment is executable */
#define PF_W		(1 << 1)	/* Segment is writable */
#define PF_R		(1 << 2)	/* Segment is readable */
#define PF_MASKOS	0x0ff00000	/* OS-specific */
#define PF_MASKPROC	0xf0000000	/* Processor-specific */
```


###### `p_offset`

文件头到该段第一个字节的偏移;

###### `p_vaddr`

段映射到虚拟内容的地址;

###### `p_paddr`

此成员仅用于与物理地址相关的系统中;

在BSD系统中,这个字段必须为零;

###### `p_filesz`

段在文件映射中的尺寸;

###### `p_memsz`

段在内容映射中的尺寸;

###### `p_align`

段在内存中和在文件中对齐值;

可加载的进程段的 *p_vaddr* 和 *p_offset* 取值必须合适,相对于对页面大小的取模而言;

数值 0 和 1 表示不需要对齐,否则 *p_align* 应该是个正整数,并且是 2 的幂次数, *p_vaddr* 和 *p_offset* 对 *p_align* 取模后应该相等;

## `Section header (Shdr)`

节头表使得可以定位整个文件的节;  
节头表是一个 *Elf32_Shdr* or *Elf64_Shdr* 结构的数组;

**ELF**头的 *e_shoff* 指定节头表在文件中的位置;

**ELF**头的 *e_shnum* 指定节头表中的节的数量;

**ELF**头的 *e_shnentsize* 指定节头表中的节的尺寸(每个节的尺寸都相同);



节头表索引是数组的下标;

一些索引是保留的: *SHN_LORESERVE* and *SHN_HIRESERVE*;

```
/* Special section indices.  */

#define SHN_UNDEF      0         /* Undefined section */
#define SHN_LORESERVE  0xff00    /* Start of reserved indices */
#define SHN_LOPROC     0xff00    /* Start of processor-specific */
#define SHN_BEFORE     0xff00    /* Order section before all others (Solaris).  */
#define SHN_AFTER      0xff01    /* Order section after all others (Solaris).  */
#define SHN_HIPROC     0xff1f    /* End of processor-specific */
#define SHN_LOOS       0xff20    /* Start of OS-specific */
#define SHN_HIOS       0xff3f    /* End of OS-specific */
#define SHN_ABS        0xfff1    /* Associated symbol is absolute */
#define SHN_COMMON     0xfff2    /* Associated symbol is common */
#define SHN_XINDEX     0xffff    /* Index is in extra table.  */
#define SHN_HIRESERVE  0xffff    /* End of reserved indices */
```



结构:

```
/* Section header.  */

typedef struct
{
    Elf32_Word    sh_name;        /* Section name (string tbl index) */
    Elf32_Word    sh_type;        /* Section type */
    Elf32_Word    sh_flags;       /* Section flags */
    Elf32_Addr    sh_addr;        /* Section virtual addr at execution */
    Elf32_Off     sh_offset;      /* Section file offset */
    Elf32_Word    sh_size;        /* Section size in bytes */
    Elf32_Word    sh_link;        /* Link to another section */
    Elf32_Word    sh_info;        /* Additional section information */
    Elf32_Word    sh_addralign;   /* Section alignment */
    Elf32_Word    sh_entsize;     /* Entry size if section holds table */
} Elf32_Shdr;

typedef struct
{
    Elf64_Word    sh_name;        /* Section name (string tbl index) */
    Elf64_Word    sh_type;        /* Section type */
    Elf64_Xword   sh_flags;       /* Section flags */
    Elf64_Addr    sh_addr;        /* Section virtual addr at execution */
    Elf64_Off     sh_offset;      /* Section file offset */
    Elf64_Xword   sh_size;        /* Section size in bytes */
    Elf64_Word    sh_link;        /* Link to another section */
    Elf64_Word    sh_info;        /* Additional section information */
    Elf64_Xword   sh_addralign;   /* Section alignment */
    Elf64_Xword   sh_entsize;     /* Entry size if section holds table */
} Elf64_Shdr;
```



一些节:

| Name      | Type         | Attributions                        | Descriptions                                                 |
| --------- | ------------ | ----------------------------------- | ------------------------------------------------------------ |
| .bbs      | SHT_NOBITS   | SHF_ALLOC<br />SHF_WRITE<br />+     | 未初始化数据节区,程序运行时,会被初始化为0;                   |
| .comment  | SHT_PROGBITS | -                                   | 版本控制信息;                                                |
| .data     | SHT_PROGBITS | SHF_ALLOC<br />SHF_WRITE<br />+     | 初始化的数据;                                                |
| .data1    | SHT_PROGBITS | SHF_ALLOC<br />SHF_WRITE<br />+     |                                                              |
| .debug    | SHT_PROGBITS | -                                   | 调试符号信息;                                                |
| .dynamic  | SHT_DYNAMIC  | SHF_WRITE<br />+                    | 动态链接表                                                |
| .dynstr   | SHT_STRTAB   | SHF_ALLOC                           | 保存了动态符号,节区头指向的节区是null-terminate字符串集; |
| .dynsym   | SHT_DYNSYM   | SHF_ALLOC                           | 动态符号表间接给出了调试符号字符串; <br />**sh_link** 的内容是节区头的索引,这个节区头一般是 **.dynstr** ,它的节区的数据是null-terminate字符串集; <br />**.dynsym** 的节区的数据是 **Elf64_Sym** 结构的数组,每个结构指出一个调试符号位置, **Elf64_Shdr::sh_entsize**指出条目尺寸,**Elf64_Shdr::sh_size**指出总条目尺寸,间接的就可以得到条目数量了;<br />**Elf64_Sym::st_name** 字段给出了相对于 **sh_link** 指出的节区的数据的 FAO[^FAO],这个FAO的位置就是我们要的动态符号了; |
| .fini     | SHT_PROGBITS | SHF_ALLOC<br />SHF_EXECINSTR<br />+ | 某些节区包含可执行的指令,是进程终止代码的一的部分;程序正常退出时,<br />系统将安排执行这里的代码; |
| .got      | SHT_PROGBITS | -                                   | 全局偏移表;                                                  |
| .hash     | SHT_HASH     | SHF_ALLOC                           | 符号哈希表;                                                  |
| .init     | SHT_PROGBITS | SHF_ALLOC<br />SHF_EXECINSTR<br />+ | 节区包含可执行的指令,是进程初始化代码的一的部分;程序开始执行时,<br />系统在调用入口函数之前,系统将安排执行这里的代码; |
| .interp   | SHT_PROGBITS |                                     | 节区包含程序解释器[^4]的路径名;如果程序包含一个可加载的段,段中包含此节区,<br />那么节区的属性将包含SHF_ALLOC; |
| .line     | SHT_PROGBITS | -                                   | 调试行号信息,描述了源码与机器码之间的对应关系;               |
| .note     | SHT_NOTE     |                                     | 注释信息,有独立的格式; |
| .note.ABI-tag | SHT_NOTE | | 节区用于声明ELF镜像预期的运行时ABI;可能包含操作系统名各运行时版本; |
| .note.gnu.build-id | SHT_NOTE | | 节区用于保存id,唯一标识ELF镜像的id;有相同id的不同文件应该包含相同的可执行的内容;详见GNU链接器(ld)的 **--build-id** 选项; |
| .note.GNU-stack | SHT_PROGBITS | SHF_EXECINSTR | 声明栈属性;表明GNU链接器,目标文件请求一个求执行的堆栈; |
| .note.openbsd.ident | SHT_NOTE | | OpenBSD原生可执行程序通常包含这个部分来标识自己，这样内核就可以在加载文件时绕过任何兼容ELF二进制模拟测试。 |
| .plt      | SHT_PROGBITS |                                     | 过程链接表; |
| .relname  | SHT_REL      | SHF_ALLOC | 重定位信息;如果文件中包含可加载的段,段中有重定位内容,节区的属性将包含<br />SHF_ALLOC位,否为0;传统上的name根据重定位所适用的节区给定;例如, .text节区<br />的重定位名为 .rel.text 或 .rela.text; |
| .relaname | SHT_RELA     | SHF_ALLOC | 重定位信息;如果文件中包含可加载的段,段中有重定位内容,节区的属性将包含<br />SHF_ALLOC位,否为0;传统上的name根据重定位所适用的节区给定;例如, .text节区<br />的重定位名为 .rel.text 或 .rela.text; |
| .rodata   | SHT_PROGBITS |                                     | 只读数据; |
| .rodata1  | SHT_PROGBITS |                                     | 只读数据; |
| .shstrtab | SHT_STRTAB   |                                     | 节区名字符串表,管理的空间保存所有的节区名字符串; |
| .strtab   | SHT_STRTAB   |                                     | 字符串表;与符号表项相关的名称; |
| .symtab   | SHT_SYMTAB   |                                     | 符号表;  **Elf64_Sym**; |
| .text     | SHT_PROGBITS | SHF_ALLOC<br />SHF_EXECINSTR<br />+ | 程序代码节区; |



```
.bbs
未初始化的数据;
```

### `sh_name`

间接指出节区名,节区名是一个null结尾的字符串;

字段的值是一个偏移,相对于**节区名字符串表**的**内容**的偏移;

### `sh_type`

节区的内容和语义的分类;

```
/* Legal values for sh_type (section type).  */

#define SHT_NULL           0     /* Section header table entry unused */
#define SHT_PROGBITS       1     /* Program data */
#define SHT_SYMTAB         2     /* Symbol table */
#define SHT_STRTAB         3     /* String table */
#define SHT_RELA           4     /* Relocation entries with addends */
#define SHT_HASH           5     /* Symbol hash table */
#define SHT_DYNAMIC        6     /* Dynamic linking information */
#define SHT_NOTE           7     /* Notes */
#define SHT_NOBITS         8     /* Program space with no data (bss) */
#define SHT_REL            9     /* Relocation entries, no addends */
#define SHT_SHLIB          10    /* Reserved */
#define SHT_DYNSYM         11    /* Dynamic linker symbol table */
#define SHT_INIT_ARRAY     14    /* Array of constructors */
#define SHT_FINI_ARRAY     15    /* Array of destructors */
#define SHT_PREINIT_ARRAY  16    /* Array of pre-constructors */
#define SHT_GROUP          17    /* Section group */
#define SHT_SYMTAB_SHNDX   18    /* Extended section indeces */
#define  SHT_NUM           19    /* Number of defined types.  */
#define SHT_LOOS           0x60000000  /* Start OS-specific.  */
#define SHT_GNU_ATTRIBUTES 0x6ffffff5  /* Object attributes.  */
#define SHT_GNU_HASH       0x6ffffff6  /* GNU-style hash table.  */
#define SHT_GNU_LIBLIST    0x6ffffff7  /* Prelink library list */
#define SHT_CHECKSUM       0x6ffffff8  /* Checksum for DSO content.  */
#define SHT_LOSUNW         0x6ffffffa  /* Sun-specific low bound.  */
#define SHT_SUNW_move      0x6ffffffa
#define SHT_SUNW_COMDAT    0x6ffffffb
#define SHT_SUNW_syminfo   0x6ffffffc
#define SHT_GNU_verdef     0x6ffffffd  /* Version definition section.  */
#define SHT_GNU_verneed    0x6ffffffe  /* Version needs section.  */
#define SHT_GNU_versym     0x6fffffff  /* Version symbol table.  */
#define SHT_HISUNW         0x6fffffff  /* Sun-specific high bound.  */
#define SHT_HIOS           0x6fffffff  /* End OS-specific type */
#define SHT_LOPROC         0x70000000  /* Start of processor-specific */
#define SHT_HIPROC         0x7fffffff  /* End of processor-specific */
#define SHT_LOUSER         0x80000000  /* Start of application-specific */
#define SHT_HIUSER         0x8fffffff  /* End of application-specific */
```



### `sh_flags`

节区属性集标志;

```
/* Legal values for sh_flags (section flags).  */
#define SHF_WRITE             (1 << 0)      /* Writable */
#define SHF_ALLOC             (1 << 1)      /* Occupies memory during execution */
#define SHF_EXECINSTR         (1 << 2)      /* Executable */
#define SHF_MERGE             (1 << 4)      /* Might be merged */
#define SHF_STRINGS           (1 << 5)      /* Contains null-terminated strings */
#define SHF_INFO_LINK         (1 << 6)      /* `sh_info' contains SHT index */
#define SHF_LINK_ORDER        (1 << 7)      /* Preserve order after combining */
#define SHF_OS_NONCONFORMING  (1 << 8)      /* Non-standard OS specific handling required */
#define SHF_GROUP             (1 << 9)      /* Section is member of a group.  */
#define SHF_TLS               (1 << 10)     /* Section hold thread-local data.  */
#define SHF_COMPRESSED        (1 << 11)     /* Section with compressed data. */
#define SHF_MASKOS            0x0ff00000    /* OS-specific.  */
#define SHF_MASKPROC          0xf0000000    /* Processor-specific */
#define SHF_ORDERED           (1 << 30)     /* Special ordering requirement (Solaris).  */
#define SHF_EXCLUDE           (1U << 31)    /* Section is excluded unless referenced or allocated (Solaris).*/
```



### `sh_addr`

如果节区出现在进程的内存映像中,给出第一个字节应处的位置;否为零;

### `sh_offset`

节区在文件的位置;

如果节区的类型是*SHT_NOBITS*,在文件中它是没有空间的,给出的位置只是概念性的;

### `sh_size`

节区的尺寸;

除开节区类型*SHT_NOBITS*,其它类型说明其节区尺寸在这个字段中;

如果节区的类型是*SHT_NOBITS*,在文件中它是没有空间的,但尺寸可能非零;

### `sh_link`

### `sh_info`

| sh_type                   | sh_link                                                      | sh_info                                                      |
| ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `SHT_DYNAMIC`             | The section header index of the associated string table;此节区头的节区中元素所引用的字符串的节区头索引; | `0`                                                          |
| `SHT_HASH`                | The section header index of the associated symbol table.     | `0`                                                          |
| `SHT_REL` `SHT_RELA`      | The section header index of the associated symbol table.     | If the `sh_flags` member contains the `SHF_INFO_LINK` flag, the section header index of the section to which the relocation applies, otherwise `0`. See also [Table 12-10](https://docs.oracle.com/cd/E23824_01/html/819-0690/chapter7-1.html#chapter6-28341) and [Relocation Sections](https://docs.oracle.com/cd/E23824_01/html/819-0690/chapter6-54839.html#scrolltoc). |
| `SHT_SYMTAB` `SHT_DYNSYM` | The section header index of the associated string table.     | One greater than the symbol table index of the last local symbol, `STB_LOCAL`. |
| `SHT_GROUP`               | The section header index of the associated symbol table.     | The symbol table index of an entry in the associated symbol table. The name of the specified symbol table entry provides a signature for the section group. |
| `SHT_SYMTAB_SHNDX`        | The section header index of the associated symbol table.     | `0`                                                          |
| `SHT_SUNW_cap`            | If symbol capabilities exist, the section header index of the associated `SHT_SUNW_capinfo` table, otherwise `0`. | If any capabilities refer to named strings, the section header index of the associated string table, otherwise `0`. |
| `SHT_SUNW_capinfo`        | The section header index of the associated symbol table.     | For a dynamic object, the section header index of the associated `SHT_SUNW_capchain` table, otherwise `0`. |
| `SHT_SUNW_symsort`        | The section header index of the associated symbol table.     | `0`                                                          |
| `SHT_SUNW_tlssort`        | The section header index of the associated symbol table.     | `0`                                                          |
| `SHT_SUNW_LDYNSYM`        | The section header index of the associated string table. This index is the same string table used by the `SHT_DYNSYM` section. | One greater than the symbol table index of the last local symbol, `STB_LOCAL`. Since `SHT_SUNW_LDYNSYM` only contains local symbols, `sh_info` is equivalent to the number of symbols in the table. |
| `SHT_SUNW_move`           | The section header index of the associated symbol table.     | `0`                                                          |
| `SHT_SUNW_COMDAT`         | `0`                                                          | `0`                                                          |
| `SHT_SUNW_syminfo`        | The section header index of the associated symbol table.     | The section header index of the associated `.dynamic` section. |
| `SHT_SUNW_verdef`         | The section header index of the associated string table.     | The number of version definitions within the section.        |
| `SHT_SUNW_verneed`        | The section header index of the associated string table.     | The number of version dependencies within the section.       |
| `SHT_SUNW_versym`         | The section header index of the associated symbol table.     | `0`                                                          |

### `sh_addralign`

某些节区有地址对齐的约束;

如果一个节区保存了双字,必须确保整个节区以双字对齐;

*sh_addr*对*sh_addralign*取模,结果必须为零;

只有0或2的整数幂被允许;

0或1表明没有对齐约束;

### `sh_entsize`

有些节区的内容是一张表,其中每一个条目的大小是固定的,比如符号表;

对于这种表来说,该字段指明这种表中的每一个表项的大小;

如果该字段的值为0,则表示该节的内容不是这种表;



# `重定位表条目结构`

```
/* Relocation table entry without addend (in section of type SHT_REL).  */

typedef struct
{
  Elf32_Addr	r_offset;		/* Address */
  Elf32_Word	r_info;			/* Relocation type and symbol index */
} Elf32_Rel;

/* I have seen two different definitions of the Elf64_Rel and
   Elf64_Rela structures, so we'll leave them out until Novell (or
   whoever) gets their act together.  */
/* The following, at least, is used on Sparc v9, MIPS, and Alpha.  */

typedef struct
{
  Elf64_Addr	r_offset;		/* Address */
  Elf64_Xword	r_info;			/* Relocation type and symbol index */
} Elf64_Rel;
```



```
/* Relocation table entry with addend (in section of type SHT_RELA).  */

typedef struct
{
  Elf32_Addr	r_offset;		/* Address */
  Elf32_Word	r_info;			/* Relocation type and symbol index */
  Elf32_Sword	r_addend;		/* Addend */
} Elf32_Rela;

typedef struct
{
  Elf64_Addr	r_offset;		/* Address */
  Elf64_Xword	r_info;			/* Relocation type and symbol index */
  Elf64_Sxword	r_addend;		/* Addend */
} Elf64_Rela;
```



# `.dynmic节区条目结构`

```
/* Dynamic section entry.  */

typedef struct {
	Elf32_Sword	     d_tag;       /* Dynamic entry type */
	union {
		Elf32_Word  d_val;       /* Integer value */
		Elf32_Addr  d_ptr;		/* Address value */
	} d_un;
} Elf32_Dyn;

typedef struct {
	Elf64_Sxword	 d_tag;		/* Dynamic entry type */
	union {
		Elf64_Xword  d_val;		/* Integer value */
		Elf64_Addr   d_ptr;		/* Address value */
	} d_un;
} Elf64_Dyn;
```

```
/* Legal values for d_tag (dynamic entry type).  */

#define DT_NULL		0		/* Marks end of dynamic section */
#define DT_NEEDED	1		/* Name of needed library */
#define DT_PLTRELSZ	2		/* Size in bytes of PLT relocs */
#define DT_PLTGOT	3		/* Processor defined value */
#define DT_HASH		4		/* Address of symbol hash table */
#define DT_STRTAB	5		/* Address of string table */
#define DT_SYMTAB	6		/* Address of symbol table */
#define DT_RELA		7		/* Address of Rela relocs */
#define DT_RELASZ	8		/* Total size of Rela relocs */
#define DT_RELAENT	9		/* Size of one Rela reloc */
#define DT_STRSZ	10		/* Size of string table */
#define DT_SYMENT	11		/* Size of one symbol table entry */
#define DT_INIT		12		/* Address of init function */
#define DT_FINI		13		/* Address of termination function */
#define DT_SONAME	14		/* Name of shared object */
#define DT_RPATH	15		/* Library search path (deprecated) */
#define DT_SYMBOLIC	16		/* Start symbol search here */
#define DT_REL		17		/* Address of Rel relocs */
#define DT_RELSZ	18		/* Total size of Rel relocs */
#define DT_RELENT	19		/* Size of one Rel reloc */
#define DT_PLTREL	20		/* Type of reloc in PLT */
#define DT_DEBUG	21		/* For debugging; unspecified */
#define DT_TEXTREL	22		/* Reloc might modify .text */
#define DT_JMPREL	23		/* Address of PLT relocs */
#define	DT_BIND_NOW	24		/* Process relocations of object */
#define	DT_INIT_ARRAY	25		/* Array with addresses of init fct */
#define	DT_FINI_ARRAY	26		/* Array with addresses of fini fct */
#define	DT_INIT_ARRAYSZ	27		/* Size in bytes of DT_INIT_ARRAY */
#define	DT_FINI_ARRAYSZ	28		/* Size in bytes of DT_FINI_ARRAY */
#define DT_RUNPATH	29		/* Library search path */
#define DT_FLAGS	30		/* Flags for the object being loaded */
#define DT_ENCODING	32		/* Start of encoded range */
#define DT_PREINIT_ARRAY 32		/* Array with addresses of preinit fct*/
#define DT_PREINIT_ARRAYSZ 33		/* size in bytes of DT_PREINIT_ARRAY */
#define	DT_NUM		34		/* Number used */
#define DT_LOOS		0x6000000d	/* Start of OS-specific */
#define DT_HIOS		0x6ffff000	/* End of OS-specific */
#define DT_LOPROC	0x70000000	/* Start of processor-specific */
#define DT_HIPROC	0x7fffffff	/* End of processor-specific */
#define	DT_PROCNUM	DT_MIPS_NUM	/* Most used by any processor */

/* DT_* entries which fall between DT_VALRNGHI & DT_VALRNGLO use the
   Dyn.d_un.d_val field of the Elf*_Dyn structure.  This follows Sun's
   approach.  */
#define DT_VALRNGLO	0x6ffffd00
#define DT_GNU_PRELINKED 0x6ffffdf5	/* Prelinking timestamp */
#define DT_GNU_CONFLICTSZ 0x6ffffdf6	/* Size of conflict section */
#define DT_GNU_LIBLISTSZ 0x6ffffdf7	/* Size of library list */
#define DT_CHECKSUM	0x6ffffdf8
#define DT_PLTPADSZ	0x6ffffdf9
#define DT_MOVEENT	0x6ffffdfa
#define DT_MOVESZ	0x6ffffdfb
#define DT_FEATURE_1	0x6ffffdfc	/* Feature selection (DTF_*).  */
#define DT_POSFLAG_1	0x6ffffdfd	/* Flags for DT_* entries, effecting
					   the following DT_* entry.  */
#define DT_SYMINSZ	0x6ffffdfe	/* Size of syminfo table (in bytes) */
#define DT_SYMINENT	0x6ffffdff	/* Entry size of syminfo */
#define DT_VALRNGHI	0x6ffffdff
#define DT_VALTAGIDX(tag)	(DT_VALRNGHI - (tag))	/* Reverse order! */
#define DT_VALNUM 12

/* DT_* entries which fall between DT_ADDRRNGHI & DT_ADDRRNGLO use the
   Dyn.d_un.d_ptr field of the Elf*_Dyn structure.
   If any adjustment is made to the ELF object after it has been
   built these entries will need to be adjusted.  */
#define DT_ADDRRNGLO	0x6ffffe00
#define DT_GNU_HASH	0x6ffffef5	/* GNU-style hash table.  */
#define DT_TLSDESC_PLT	0x6ffffef6
#define DT_TLSDESC_GOT	0x6ffffef7
#define DT_GNU_CONFLICT	0x6ffffef8	/* Start of conflict section */
#define DT_GNU_LIBLIST	0x6ffffef9	/* Library list */
#define DT_CONFIG	    0x6ffffefa	/* Configuration information.  */
#define DT_DEPAUDIT	    0x6ffffefb	/* Dependency auditing.  */
#define DT_AUDIT	    0x6ffffefc	/* Object auditing.  */
#define	DT_PLTPAD	    0x6ffffefd	/* PLT padding.  */
#define	DT_MOVETAB	    0x6ffffefe	/* Move table.  */
#define DT_SYMINFO	    0x6ffffeff	/* Syminfo table.  */
#define DT_ADDRRNGHI	0x6ffffeff
#define DT_ADDRTAGIDX(tag)	(DT_ADDRRNGHI - (tag))	/* Reverse order! */
#define DT_ADDRNUM 11

/* The versioning entry types.  The next are defined as part of the
   GNU extension.  */
#define DT_VERSYM	    0x6ffffff0
#define DT_RELACOUNT	0x6ffffff9
#define DT_RELCOUNT	     0x6ffffffa

/* These were chosen by Sun.  */
#define DT_FLAGS_1	   0x6ffffffb	/* State flags, see DF_1_* below.  */
#define	DT_VERDEF	  0x6ffffffc	/* Address of version definition table */
#define	DT_VERDEFNUM   0x6ffffffd	/* Number of version definitions */
#define	DT_VERNEED     0x6ffffffe	/* Address of table with needed versions */
#define	DT_VERNEEDNUM  0x6fffffff	/* Number of needed versions */
#define DT_VERSIONTAGIDX(tag)	(DT_VERNEEDNUM - (tag))	/* Reverse order! */
#define DT_VERSIONTAGNUM 16

/* Sun added these machine-independent extensions in the "processor-specific" range.  Be compatible.  */
#define DT_AUXILIARY    0x7ffffffd      /* Shared object to load before self */
#define DT_FILTER       0x7fffffff      /* Shared object to get values from */
#define DT_EXTRATAGIDX(tag)	((Elf32_Word)-((Elf32_Sword) (tag) <<1>>1)-1)
#define DT_EXTRANUM	3
```

| macro     | value | d_un                                                         |
| --------- | ----- | ------------------------------------------------------------ |
| DT_NEEDED | 1     | 此条目指出依赖库名null-terminal字符串; **d_un.d_val**的值是一个FAO,相对于**.dynmic**节区头指出的节区头的节区的偏移; |
| DT_INIT   | 12    | 此条目指出初始化函数(在入口点前运行的函数)地址; 好像越界了,以后再理解; |
| DT_FINI   | 13    | 此条目指出结束函数地址; 好像越界了,以后再理解;               |
|           |       |                                                              |
|           |       |                                                              |
|           |       |                                                              |
|           |       |                                                              |

# `Specified Section`



## `String Table Section`

字符串表节区保存null-terminated字符序列集;目标文件使用这些字符串代表符号各节区名;

如果要引用这些字符串,一般给定字符串表节区头,再给定这个节区头的节区的FAO;



字符串表的第一个字节是0,被当作空字符串;最后一个字节也是0;引用字符串表的第一个字节,可能代表是一个**空名**或**没有名字**,依赖于环境;



一个空字符串表节区是被允许的,这样的节区,节区头的**sh_size**必须为0;对于空字符串表节区,非0的FAO是无效的;

一个字符串表FAO可以引用字符串表任何字节;

一个字符串可能出现多次;

可以引用子串;

未引用的字符串也是被允许的;



### `Section Header String Table Section`

节区头字符串表节区保存节区名字符串集;

ELF头指出这个节区头在节区头表的索引;

每个节区头的**sh_name**字段给出相对于节区头字符串表节区的FAO,这样也就拿到节区名了;

命名是.shstrtab;





### `String Table Section`



## `Symbol Table Section`

符号表节区保存**符号定义**和**符号引用**信息;

符号表的的元素是 **Elf64_Sym** 结构序列;

符号表索引是数组的下标,索引0指定表中的第一个条目,并充当未定义的符号索引;



### `Elf64_Sym`

```
typedef struct {
    Elf32_Word      st_name;
    Elf32_Addr      st_value;
    Elf32_Word      st_size;
    unsigned char   st_info;
    unsigned char   st_other;
    Elf32_Half      st_shndx;
} Elf32_Sym;

typedef struct {
    Elf64_Word      st_name;
    unsigned char   st_info;
    unsigned char   st_other;
    Elf64_Half      st_shndx;
    Elf64_Addr      st_value;
    Elf64_Xword     st_size;
} Elf64_Sym;


```

`st_name`

FAO,相对于某一节区(由节区表给出),这个位置就是符号字符串了;

如果为零,代表没有符号;

`st_info`

符号的类型与绑定属性;

这1字节分二部份来看:高4位是绑定属性,低4位是类型属性;

| Name | Value | Descriptions |
| ------------ | ----- | ------------ |
| STB_LOCAL  | 0   | Local symbol. These symbols are not visible outside the object file containing their definition. Local symbols of the same name can exist in multiple files without interfering with each other. |
| STB_GLOBAL | 1   | Global symbols. These symbols are visible to all object files being combined. One file's definition of a global symbol satisfies another file's undefined reference to the same global symbol. |
| STB_WEAK   | 2   | Weak symbols. These symbols resemble global symbols, but their definitions have lower precedence. |
| STB_LOOS   | 10  | Values in this inclusive range are reserved for operating system-specific semantics. |
| STB_HIOS   | 12  | Values in this inclusive range are reserved for operating system-specific semantics. |
| STB_LOPROC | 13  | Values in this inclusive range are reserved for processor-specific semantics. |
| STB_HIPROC | 15  | Values in this inclusive range are reserved for processor-specific semantics. |

| Name | Value | Descriptions |
| ------------ | ----- | ------------ |
| STT_NOTYPE         | 0  | The symbol type is not specified. |
| STT_OBJECT         | 1  | This symbol is associated with a data object, such as a variable, an array, and so forth. |
| STT_FUNC           | 2  | This symbol is associated with a function or other executable code. |
| STT_SECTION        | 3  | This symbol is associated with a section. Symbol table entries of this type exist primarily for relocation and normally have `STB_LOCAL` binding. |
| STT_FILE           | 4  | Conventionally, the symbol's name gives the name of the source file that is associated with the object file. A file symbol has `STB_LOCAL` binding and a section index of `SHN_ABS`. This symbol, if present, precedes the other `STB_LOCAL` symbols for the file.                                                                                            Symbol index 1 of the `SHT_SYMTAB` is an `STT_FILE` symbol representing the object file. Conventionally, this symbol is followed by the files `STT_SECTION` symbols. These section symbols are then followed by any global symbols that have been reduced to locals. |
| STT_COMMON         | 5  | This symbol labels an uninitialized common block. This symbol is treated exactly the same as `STT_OBJECT`. |
| STT_TLS            | 6  | The symbol specifies a thread-local storage entity. When defined,  this symbol gives the assigned offset for the symbol, not the actual  address.                                                                                        Thread-local storage relocations can only reference symbols with type `STT_TLS`. A reference to a symbol of type `STT_TLS` from an allocatable section, can only be achieved by using special thread-local storage relocations. See [Chapter 14, Thread-Local Storage](https://docs.oracle.com/cd/E23824_01/html/819-0690/chapter8-1.html#scrolltoc) for details. A reference to a symbol of type `STT_TLS` from a non-allocatable section does not have this restriction. |
| STT_LOOS           | 10 | Values in this inclusive range are reserved for operating system-specific semantics. |
| STT_HIOS           | 12 | Values in this inclusive range are reserved for operating system-specific semantics. |
| STT_LOPROC STT_SPARC_REGISTER | 13 | Values in this inclusive range are reserved for processor-specific semantics. |
| STT_HIPROC         | 15 | Values in this inclusive range are reserved for processor-specific semantics. |

`st_other`

指明符号的可见性;

| Name            | Value | Descriptions |
| --------------- | ----- | --------------- |
| STV_DEFAULT   | 0   | The visibility of symbols with the `STV_DEFAULT` attribute is specified by the symbol's binding type. Global symbols and weak symbols are visible outside of their defining component, the executable file or shared object. Local symbols are hidden. Global symbols and weak symbols can also be preempted. These symbols can by interposed by definitions of the same name in another component. |
| STV_INTERNAL  | 1   | This visibility attribute is currently reserved. |
| STV_HIDDEN    | 2   | A symbol that is defined in the current component is hidden if its name is not visible to other components. Such a symbol is necessarily protected. This attribute is used to control the external interface of a component. An object named by such a symbol can still be referenced from another component if its address is passed outside.                                A hidden symbol contained in a relocatable object is either removed or converted to `STB_LOCAL` binding when the object is included in an executable file or shared object. |
| STV_PROTECTED | 3   | This visibility attribute ensures that a symbol remains global. This visibility can not be demoted, or eliminated by any other symbol visibility technique. A symbol with `STB_LOCAL` binding will not have `STV_EXPORTED` visibility. |
| STV_EXPORTED  | 4   | This visibility attribute ensures that a symbol remains global, and that a single instance of the symbol definition is bound to by all references within a process. This visibility can not be demoted, or eliminated by any other symbol visibility technique. A symbol with `STB_LOCAL` binding will not have `STV_SINGLETON` visibility. A `STV_SINGLETON` can not be directly bound to. |
| STV_SINGLETON | 5   | This visibility attribute extends `STV_HIDDEN`. A symbol that is defined in the current component as eliminate is not visible to other components. The symbol is not written to any symbol table of a dynamic executable or shared object from which the component is used. |
| STV_ELIMINATE | 6   |  |

The `STV_SINGLETON` visibility attribute can affect the resolution of symbols within an executable or shared object during link-editing. Only one instance of a singleton can be bound to from any reference within a process.

A `STV_SINGLETON` can be combined with a `STV_DEFAULT` visibility attribute, with the `STV_SINGLETON` taking precedence. A `STV_EXPORT` can be combined with a `STV_DEFAULT` visibility attribute, with the `STV_EXPORT` taking precedence. A `STV_SINGLETON` or `STV_EXPORT` visibility can not be combined with any other visibility attribute. Such an event is deemed fatal to the link-edit.

Other visibility attributes do not affect the resolution of symbols within an executable or shared object during link-editing. Such resolution is controlled by the binding type. Once the link-editor has chosen its resolution, these attributes impose two requirements. Both requirements are based on the fact that references in the code being linked might have been optimized to take advantage of the attributes.

- All of the non-default visibility attributes, when applied to a  symbol reference, imply that a definition to satisfy that reference must  be provided within the object being linked. If this type of symbol  reference has no definition within the object being linked, then the  reference must have `STB_WEAK` binding. In this case, the reference is resolved to zero.
- If any reference to a name, or definition of a name is a symbol with a  non-default visibility attribute, the visibility attribute is  propagated to the resolving symbol in the object being linked. If  different visibility attributes are specified for distinct instances of a  symbol, the most constraining visibility attribute is propagated to the  resolving symbol in the object being linked. The attributes, ordered  from least to most constraining, are `STV_PROTECTED`, `STV_HIDDEN` and `STV_INTERNAL`.



`st_shndx`

Every symbol table entry is defined in relation to some section. This member holds the relevant section header table index. Some section indexes indicate special meanings. 

If this member contains `SHN_XINDEX`, then the actual section header index is too large to fit in this field. The actual value is contained in the associated section of type `SHT_SYMTAB_SHNDX`.



| Name                | Value    | Descriptions |
| ------------------- | -------- | ------------------- |
| SHN_UNDEF         | 0      | An undefined, missing, irrelevant, or otherwise meaningless section reference. For example, a symbol **defined** relative to section number `SHN_UNDEF` is an undefined symbol. |
| SHN_LORESERVE     | 0xff00 | The lower boundary of the range of reserved indexes. |
| SHN_LOPROC        | 0xff00 | Values in this inclusive range are reserved for processor-specific semantics. |
| SHN_BEFORE        | 0xff00 | Provide for initial and final section ordering in conjunction with the `SHF_LINK_ORDER` and `SHF_ORDERED` section flags. |
| SHN_AFTER         | 0xff01 | Provide for initial and final section ordering in conjunction with the `SHF_LINK_ORDER` and `SHF_ORDERED` section flags. |
| SHN_AMD64_LCOMMON | 0xff02 | x64 specific common block label. This label is similar to `SHN_COMMON`, but provides for identifying a large common block. |
| SHN_HIPROC        | 0xff1f | Values in this inclusive range are reserved for processor-specific semantics. |
| SHN_LOOS          | 0xff20 | Values in this inclusive range are reserved for operating system-specific semantics. |
| SHN_LOSUNW        | 0xff3f | Values in this inclusive range are reserved for Sun-specific semantics. |
| SHN_SUNW_IGNORE   | 0xff3f | This section index provides a temporary symbol definition within relocatable objects. Reserved for internal use by [`dtrace`(1M)](https://docs.oracle.com/cd/E23824_01/html/821-1462/index.html). |
| SHN_HISUNW        | 0xff3f | Values in this inclusive range are reserved for Sun-specific semantics. |
| SHN_HIOS          | 0xff3f | Values in this inclusive range are reserved for operating system-specific semantics. |
| SHN_ABS           | 0xfff1 | Absolute values for the corresponding reference. For example, symbols defined relative to section number `SHN_ABS` have absolute values and are not affected by relocation. |
| SHN_COMMON        | 0xfff2 | Symbols defined relative to this section are common symbols, such as FORTRAN `COMMON` or unallocated C external variables. These symbols are sometimes referred to as tentative. |
| SHN_XINDEX        | 0xffff | An escape value indicating that the actual section header index is too large to fit in the containing field. The header section index is found in another location specific to the structure where the section index appears. |
| SHN_HIRESERVE     | 0xffff | The upper boundary of the range of reserved indexes. The system reserves indexes between `SHN_LORESERVE` and `SHN_HIRESERVE`, inclusive. The values do not reference the section header table. The section header table does not contain entries for the reserved indexes. |



`st_value`

与符号相关的值,可以是绝对值或地址,依赖于环境;

- In relocatable files, `st_value` holds alignment constraints for a symbol whose section index is `SHN_COMMON`.

- In relocatable files, `st_value` holds a section offset for a defined symbol. `st_value` is an offset from the beginning of the section that `st_shndx` identifies.

- In executable and shared object files, `st_value` holds a  virtual address. To make these files' symbols more useful for the runtime linker, the section offset (file interpretation) gives way to a  virtual address (memory interpretation) for which the section number is irrelevant.

Although the symbol table values have similar meanings for different object files, the data allow efficient access by the appropriate programs.



`st_size`

许多符号都有相应的大小,例如,数据对象的大小是对象中包含的字节数.如果符号没有大小或大小未知,则此成员将保持值为零;



## `Hash Table Section`
















# `footnote`

[^1]: Executable and Linkable Format
[^2]: Application Binary Interfaces
[^3]: Operation System Application Binary Interfaces
[^4]: 程序解释器:加载动态库的程序,如ld-linux.so
[^FA]: file address, offset value between file header to address specified
[^FAO]: file address offset, offset value between two FA[^FA]
[^VA]: virtual address
[^VAO]: virtual address offset, offset value between two VA[^VA]
[^RVA]: relative virtual addresses, offset value between image base address to  address specified