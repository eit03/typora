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

## `4.1 一个简单的程序`

```
//HelloWorld.c

#include <stdio.h>


int main()
{
	printf("Hello World!\n");
	return 0;
}
```

```
gcc HelloWorld.c -o HelloWorld.exe
```

```
./HelloWorld.exe
```

## `4.2 ELF header (Ehdr)`  

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

- EI_PAD:
  填充6位.没有什么作用,只是为了占位&对齐.

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

节头表的文件偏移;

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

节头表的单个条目的尺寸,表中每个条目尺寸相同;

###### `e_shnum`

节头表的条目数;

如果没有节头表为零;

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
    PT_INTERP    =3,         /* 段给出一个 NULL 结尾的字符串的位置和长度,该字符串将被当作解释器调用。
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

### `sh_name`

是一个索引;

字符串表节中的某索引,指出节名位置;

名节是零结尾的字符串;

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
### `sh_addr`
### `sh_offset`
### `sh_size`
### `sh_link`
### `sh_info`
### `sh_addralign`
### `sh_entsize`























# `footnote`

[^1]: Executable and Linkable Format
[^2]: Application Binary Interfaces
[^3]: Operation System Application Binary Interfaces

