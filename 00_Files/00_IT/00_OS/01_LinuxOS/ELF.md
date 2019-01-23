***
[TOC]
***

# `1. Brief Introduction`

ELF[^1]是对象文件的格式,用于定义不同类型的对象文件中都放了什么东西,以及都以什么样的格式去放这些东西.

# `2. Category`

There has three type file for ELF:
  1) relocatable object file
  2) shared object file
  3) dynamic executable file

## `2.1 relocatable object file`

A **relocatable object** file holds sections containing code and data. This file is suitable to be linked with other relocatable object files to create dynamic executable files, shared object files, or another relocatable object.

## `2.2 shared object file`

A **shared object** file holds code and data that is suitable for additional linking. The link-editor can process this file with other relocatable object files and shared object files to create other object files. The runtime linker combines this file with a dynamic executable file and other shared object files to create a process image.

## `2.3 dynamic executable file`

A **dynamic executable** file holds a program that is ready to execute. The file specifies how exec(2)  creates a program's process image. This file is typically bound to shared object files at runtime to create a process image.

# `3. 作用`

ELF文件参与程序的连接和程序的执行,所以可以从不同的角度来看待elf格式的文件:
  1) linker links standpoint
  2) program executes standpoint

|      Linking standpoint       |     Execution standpoint      |
| :---------------------------: | :---------------------------: |
|          ELF header           |          ELF header           |
| Program header table (option) |     Program header table      |
|           Section 1           |           Segment 1           |
|              ...              |           Segment 2           |
|           Section n           |              ...              |
|              ...              |              ...              |
|     Section header table      | Section header table (option) |

如果用于编译和链接(可重定位文件),则编译器和链接器将把elf文件看作是节头表描述的节的集合,程序头表可选.

如果用于加载执行(可执行文件),则加载器则将把elf文件看作是程序头表描述的段的集合,一个段可能包含多个节,节头表可选.

如果是共享文件,则两者都含有.

Only the ELF header has a fixed position in the file. The flexibility of the ELF format requires no specified order for header tables, sections or segments. However, this figure is typical of the layout used in the Oracle Solaris OS.

**Sections** represent the smallest indivisible units that can be processed within an ELF file. **Segments** are a collection of sections. Segments represent the smallest individual units that can be mapped to a memory image by exec(2) or by the runtime linker.

**Sections** hold the bulk of object file information for the linking view. This data includes instructions, data, symbol table, and relocation information.

A **program header table**, if present, tells the system how to create a process image. Files used to generate a process image, executable files and shared objects, must have a program header table. Relocatable object files do not need a program header table.

A **section header table* contains information describing the file's sections. Every section has an entry in the table. Each entry gives information such as the section name and section size. Files that are used in link-editing must have a section header table.

# `格式分析`

## `ELF header`

An **ELF header** resides at the beginning of an object file, and holds a **road map** describing the file's organization. The ELF header is described by the type Elf32_Ehdr or Elf64_Ehdr:

```
reference from /usr/include/elf.h
#define EI_NIDENT (16)

typedef struct {
  unsigned char e_ident[EI_NIDENT];  /* ELF indentification */
  Elf64_Half    e_type;      /* Object file type */
  Elf64_Half    e_machine;   /* Architecture */
  Elf64_Word    e_version;   /* Object file version */
  Elf64_Addr    e_entry;     /* Entry point virtual address */
  Elf64_Off     e_phoff;     /* Program header table file offset */
  Elf64_Off     e_shoff;     /* Section header table file offset */
  Elf64_Word    e_flags;     /* Processor-specific flags */
  Elf64_Half    e_ehsize;    /* ELF header size in bytes */
  Elf64_Half    e_phentsize; /* Program header table entry size */
  Elf64_Half    e_phnum;     /* Program header table entry count */
  Elf64_Half    e_shentsize; /* Section header table entry size */
  Elf64_Half    e_shnum;     /* Section header table entry count */
  Elf64_Half    e_shstrndx;  /* Section header string table index */
} Elf64_Ehdr;
```

###### `e_ident`

**ELF Identification**, ELF provides an object file framework to support multiple processors, multiple data encoding, and multiple classes of machines. To support this object file family, the initial bytes of the file specify how to interpret the file. These bytes are independent of the processor on which the inquiry is made and independent of the file's remaining contents.

```
reference from /usr/include/elf.h
ELF Identification Index:

Name           Value  Purpose
EI_MAG0        0      File identification
EI_MAG1        1      File identification
EI_MAG2        2      File identification
EI_MAG3        3      File identification
EI_CLASS       4      File class
EI_DATA        5      Data encoding
EI_VERSION     6      File version
EI_OSABI       7      Operating system/ABI identification
EI_ABIVERSION  8      ABI version
EI_PAD         9      Start of padding bytes
EI_NIDENT      16     Size of e_ident[]
```

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

`e_ident[EI_MAG0]`
`e_ident[EI_MAG1]`
`e_ident[EI_MAG2]`
`e_ident[EI_MAG3]`
A 4–byte **magic number**, identifying the file as an ELF object file, has fixed vaule:
  0) e_ident[EI_MAG0] == 0x7f  
  1) e_ident[EI_MAG1] == 0x45
  2) e_ident[EI_MAG2] == 0x4c
  3) e_ident[EI_MAG3] == 0x46

`e_ident[EI_CLASS]`
identifies the file's class, or capacity, has certain value:
  0) ELFCLASSNONE   0   Invalid class
  1) ELFCLASS32     1   32–bit objects
  2) ELFCLASS64     2   64–bit objects

`e_ident[EI_DATA]`
specifies the data encoding of the processor-specific data in the object file, has fixed vaule:  
  0) ELFDATANONE    0   Invalid data encoding
  1) ELFDATA2LSB    1   little endian
  2) ELFDATA2MSB    2   big endian

`e_ident[EI_VERSION]`
specifies the ELF header version number. Currently, this value must be *EV_CURRENT*:
  0) EV_NONE        0   Invalid version.
  1) EV_CURRENT     1   Current version.

`e_ident[EI_OSABI]`
identifies the operating system and ABI to which the object is targeted. Some fields in other ELF structures have flags  and  values  that  have  platform-specific meanings; the interpretation of those fields is determined by the value of this byte.
  ELFOSABI_NONE       0      UNIX System V ABI. 
  ELFOSABI_SYSV       0      Alias.
  ELFOSABI_HPUX       1      HP-UX.
  ELFOSABI_NETBSD     2      NetBSD.
  ELFOSABI_GNU        3      Object uses GNU ELF extensions.  
  ELFOSABI_LINUX      3      Compatibility alias.  
  ELFOSABI_SOLARIS    6      Sun Solaris.
  ELFOSABI_AIX        7      IBM AIX.  
  EI_OSABI            7      OS ABI identification 
  ELFOSABI_IRIX       8      SGI Irix.  
  ELFOSABI_FREEBSD    9      FreeBSD.  
  ELFOSABI_TRU64      10     Compaq TRU64 UNIX.  
  ELFOSABI_MODESTO    11     Novell Modesto.  
  ELFOSABI_OPENBSD    12     OpenBSD.  
  ELFOSABI_ARM_AEABI  64     ARM EABI. 
  ELFOSABI_ARM        97     ARM. 
  ELFOSABI_STANDALONE 255    Standalone (embedded:) application. 

`e_ident[EI_ABIVERSION]`
identifies the version of the ABI to which the object is targeted. This field is used to distinguish among incompatible versions of an ABI. The interpretation of this version number is dependent on the ABI identified by the *EI_OSABI* field. If no values are specified for the *EI_OSABI* field for the processor, or no version values are specified for the ABI determined by a particular value of the *EI_OSABI* byte, the value zero is used to indicate unspecified.

`e_ident[EI_PAD]`
tart of padding. These bytes are reserved and set to zero. Programs which read them should ignore them.

`e_ident[EI_NIDENT]`
The size of the e_ident array.

###### `e_type`

Identifies the object file type:
  ET_NONE      0         No file type 
  ET_REL       1         Relocatable file 
  ET_EXEC      2         Executable file 
  ET_DYN       3         Shared object file 
  ET_CORE      4         Core file 
  ET_NUM       5         Number of defined types 
  ET_LOOS      0xfe00    OS-specific range start 
  ET_HIOS      0xfeff    OS-specific range end 
  ET_LOPROC    0xff00    Processor-specific range start 
  ET_HIPROC    0xffff    Processor-specific range end 

###### `e_machine`

机器架构:
  EM_NONE         0      No machine 
  EM_M32          1      AT&T WE 32100 
  EM_SPARC        2      SUN SPARC 
  EM_386          3      Intel 80386 
  EM_68K          4      Motorola m68k family 
  EM_88K          5      Motorola m88k family 
  EM_IAMCU        6      Intel MCU 
  EM_860          7      Intel 80860 
  EM_MIPS         8      MIPS R3000 big-endian 
  EM_S370         9      IBM System370 
  EM_MIPS_RS3_LE  10     MIPS R3000 little-endian 
                            reserved 11-14 
  EM_PARISC       15     HPPA 
                            reserved 16 
  EM_VPP500       17     Fujitsu VPP500 
  EM_SPARC32PLUS  18     Sun's "v8plus" 
  EM_960          19     Intel 80960 
  EM_PPC          20     PowerPC 
  EM_PPC64        21     PowerPC 64-bit 
  EM_S390         22     IBM S390 
  EM_SPU          23     IBM SPUSPC 
                            reserved 24-35 
  EM_V800         36     NEC V800 series 
  EM_FR20         37     Fujitsu FR20 
  EM_RH32         38     TRW RH-32 
  EM_RCE          39     Motorola RCE 
  EM_ARM          40     ARM 
  EM_FAKE_ALPHA   41     Digital Alpha 
  EM_SH           42     Hitachi SH 
  EM_SPARCV9      43     SPARC v9 64-bit 
  EM_TRICORE      44     Siemens Tricore 
  EM_ARC          45     Argonaut RISC Core 
  EM_H8_300       46     Hitachi H8300 
  EM_H8_300H      47     Hitachi H8300H 
  EM_H8S          48     Hitachi H8S 
  EM_H8_500       49     Hitachi H8500 
  EM_IA_64        50     Intel Merced 
  EM_MIPS_X       51     Stanford MIPS-X 
  EM_COLDFIRE     52     Motorola Coldfire 
  EM_68HC12       53     Motorola M68HC12 
  EM_MMA          54     Fujitsu MMA Multimedia Accelerator 
  EM_PCP          55     Siemens PCP 
  EM_NCPU         56     Sony nCPU embeeded RISC 
  EM_NDR1         57     Denso NDR1 microprocessor 
  EM_STARCORE     58     Motorola StartCore processor 
  EM_ME16         59     Toyota ME16 processor 
  EM_ST100        60     STMicroelectronic ST100 processor 
  EM_TINYJ        61     Advanced Logic Corp. Tinyj emb.fam 
  EM_X86_64       62     AMD x86-64 architecture 
  EM_PDSP         63     Sony DSP Processor 
  EM_PDP10        64     Digital PDP-10 
  EM_PDP11        65     Digital PDP-11 
  EM_FX66         66     Siemens FX66 microcontroller 
  EM_ST9PLUS      67     STMicroelectronics ST9+ 816 mc 
  EM_ST7          68     STmicroelectronics ST7 8 bit mc 
  EM_68HC16       69     Motorola MC68HC16 microcontroller 
  EM_68HC11       70     Motorola MC68HC11 microcontroller 
  EM_68HC08       71     Motorola MC68HC08 microcontroller 
  EM_68HC05       72     Motorola MC68HC05 microcontroller 
  EM_SVX          73     Silicon Graphics SVx 
  EM_ST19         74     STMicroelectronics ST19 8 bit mc 
  EM_VAX          75     Digital VAX 
  EM_CRIS         76     Axis Communications 32-bit emb.proc 
  EM_JAVELIN      77     Infineon Technologies 32-bit emb.proc 
  EM_FIREPATH     78     Element 14 64-bit DSP Processor 
  EM_ZSP          79     LSI Logic 16-bit DSP Processor 
  EM_MMIX         80     Donald Knuth's educational 64-bit proc 
  EM_HUANY        81     Harvard University machine-independent object files 
  EM_PRISM        82     SiTera Prism 
  EM_AVR          83     Atmel AVR 8-bit microcontroller 
  EM_FR30         84     Fujitsu FR30 
  EM_D10V         85     Mitsubishi D10V 
  EM_D30V         86     Mitsubishi D30V 
  EM_V850         87     NEC v850 
  EM_M32R         88     Mitsubishi M32R 
  EM_MN10300      89     Matsushita MN10300 
  EM_MN10200      90     Matsushita MN10200 
  EM_PJ           91     picoJava 
  EM_OPENRISC     92     OpenRISC 32-bit embedded processor 
  EM_ARC_COMPACT  93     ARC International ARCompact 
  EM_XTENSA       94     Tensilica Xtensa Architecture 
  EM_VIDEOCORE    95     Alphamosaic VideoCore 
  EM_TMM_GPP      96     Thompson Multimedia General Purpose Proc 
  EM_NS32K        97     National Semi. 32000 
  EM_TPC          98     Tenor Network TPC 
  EM_SNP1K        99     Trebia SNP 1000 
  EM_ST200        100     STMicroelectronics ST200 
  EM_IP2K         101     Ubicom IP2xxx 
  EM_MAX          102     MAX processor 
  EM_CR           103     National Semi. CompactRISC 
  EM_F2MC16       104     Fujitsu F2MC16 
  EM_MSP430       105     Texas Instruments msp430 
  EM_BLACKFIN     106     Analog Devices Blackfin DSP 
  EM_SE_C33       107     Seiko Epson S1C33 family 
  EM_SEP          108     Sharp embedded microprocessor 
  EM_ARCA         109     Arca RISC 
  EM_UNICORE      110     PKU-Unity & MPRC Peking Uni. mc series 
  EM_EXCESS       111     eXcess configurable cpu 
  EM_DXP          112     Icera Semi. Deep Execution Processor 
  EM_ALTERA_NIOS2 113     Altera Nios II 
  EM_CRX          114     National Semi. CompactRISC CRX 
  EM_XGATE        115     Motorola XGATE 
  EM_C166         116     Infineon C16xXC16x 
  EM_M16C         117     Renesas M16C 
  EM_DSPIC30F     118     Microchip Technology dsPIC30F 
  EM_CE           119     Freescale Communication Engine RISC 
  EM_M32C         120     Renesas M32C 
                             reserved 121-130 
  EM_TSK3000      131     Altium TSK3000 
  EM_RS08         132     Freescale RS08 
  EM_SHARC        133     Analog Devices SHARC family 
  EM_ECOG2        134     Cyan Technology eCOG2 
  EM_SCORE7       135     Sunplus S+core7 RISC 
  EM_DSP24        136     New Japan Radio (NJR) 24-bit DSP 
  EM_VIDEOCORE3   137     Broadcom VideoCore III 
  EM_LATTICEMICO32   138     RISC for Lattice FPGA 
  EM_SE_C17          139     Seiko Epson C17 
  EM_TI_C6000        140     Texas Instruments TMS320C6000 DSP 
  EM_TI_C2000        141     Texas Instruments TMS320C2000 DSP 
  EM_TI_C5500        142     Texas Instruments TMS320C55x DSP 
  EM_TI_ARP32        143     Texas Instruments App. Specific RISC 
  EM_TI_PRU          144     Texas Instruments Prog. Realtime Unit 
                                reserved 145-159 
  EM_MMDSP_PLUS      160     STMicroelectronics 64bit VLIW DSP 
  EM_CYPRESS_M8C     161     Cypress M8C 
  EM_R32C            162     Renesas R32C 
  EM_TRIMEDIA        163     NXP Semi. TriMedia 
  EM_QDSP6           164     QUALCOMM DSP6 
  EM_8051            165     Intel 8051 and variants 
  EM_STXP7X          166     STMicroelectronics STxP7x 
  EM_NDS32           167     Andes Tech. compact code emb. RISC 
  EM_ECOG1X          168     Cyan Technology eCOG1X 
  EM_MAXQ30          169     Dallas Semi. MAXQ30 mc 
  EM_XIMO16          170     New Japan Radio (NJR) 16-bit DSP 
  EM_MANIK           171     M2000 Reconfigurable RISC 
  EM_CRAYNV2         172     Cray NV2 vector architecture 
  EM_RX              173     Renesas RX 
  EM_METAG           174     Imagination Tech. META 
  EM_MCST_ELBRUS     175     MCST Elbrus 
  EM_ECOG16          176     Cyan Technology eCOG16 
  EM_CR16            177     National Semi. CompactRISC CR16 
  EM_ETPU            178     Freescale Extended Time Processing Unit 
  EM_SLE9X           179     Infineon Tech. SLE9X 
  EM_L10M            180     Intel L10M 
  EM_K10M            181     Intel K10M 
                                reserved 182 
  EM_AARCH64         183     ARM AARCH64 
                                reserved 184 
  EM_AVR32           185     Amtel 32-bit microprocessor 
  EM_STM8            186     STMicroelectronics STM8 
  EM_TILE64          187     Tileta TILE64 
  EM_TILEPRO         188     Tilera TILEPro 
  EM_MICROBLAZE      189     Xilinx MicroBlaze 
  EM_CUDA            190     NVIDIA CUDA 
  EM_TILEGX          191     Tilera TILE-Gx 
  EM_CLOUDSHIELD     192     CloudShield 
  EM_COREA_1ST       193     KIPO-KAIST Core-A 1st gen. 
  EM_COREA_2ND       194     KIPO-KAIST Core-A 2nd gen. 
  EM_ARC_COMPACT2    195     Synopsys ARCompact V2 
  EM_OPEN8           196     Open8 RISC 
  EM_RL78            197     Renesas RL78 
  EM_VIDEOCORE5      198     Broadcom VideoCore V 
  EM_78KOR           199     Renesas 78KOR 
  EM_56800EX         200     Freescale 56800EX DSC 
  EM_BA1             201     Beyond BA1 
  EM_BA2             202     Beyond BA2 
  EM_XCORE           203     XMOS xCORE 
  EM_MCHP_PIC        204     Microchip 8-bit PIC(r) 
                                reserved 205-209 
  EM_KM32            210     KM211 KM32 
  EM_KMX32           211     KM211 KMX32 
  EM_EMX16           212     KM211 KMX16 
  EM_EMX8            213     KM211 KMX8 
  EM_KVARC           214     KM211 KVARC 
  EM_CDP             215     Paneve CDP 
  EM_COGE            216     Cognitive Smart Memory Processor 
  EM_COOL            217     Bluechip CoolEngine 
  EM_NORC            218     Nanoradio Optimized RISC 
  EM_CSR_KALIMBA     219     CSR Kalimba 
  EM_Z80             220     Zilog Z80 
  EM_VISIUM          221     Controls and Data Services VISIUMcore 
  EM_FT32            222     FTDI Chip FT32 
  EM_MOXIE           223     Moxie processor 
  EM_AMDGPU          224     AMD GPU 
                                reserved 225-242 
  EM_RISCV           243     RISC-V 
  EM_BPF             247     Linux BPF -- in-kernel virtual machine 
  EM_NUM             248

###### `e_version`

Identifies the object file version, as listed in the following table:
  EV_NONE      0    Invalid ELF version
  EV_CURRENT   1    Current version
  EV_NUM       2

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

处理器特有的标志:
  EF_SPARCV9_TSO      0
  EF_SPARCV9_PSO      1
  EF_SPARCV9_RMO      2
  EF_SPARCV9_MM       3
  EF_SPARC_LEDATA     0x800000   little endian data 
  EF_SPARC_EXT_MASK   0xFFFF00
  EF_SPARC_32PLUS     0x000100   generic V8+ features 
  EF_SPARC_SUN_US1    0x000200   Sun UltraSPARC1 extensions 
  EF_SPARC_HAL_R1     0x000400   HAL R1 extensions 
  EF_SPARC_SUN_US3    0x000800   Sun UltraSPARCIII extensions 

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

The section header table index of the entry that is associated with the section name string table:
  SHN_UNDEF      0       Undefined section
  SHN_LORESERVE  0xff00  Start of reserved indices
  SHN_LOPROC     0xff00  Start of processor-specific
  SHN_BEFORE     0xff00  Order section before all others (Solaris).
  SHN_AFTER      0xff01  Order section after all others (Solaris).
  SHN_HIPROC     0xff1f  End of processor-specific
  SHN_LOOS       0xff20  Start of OS-specific
  SHN_HIOS       0xff3f  End of OS-specific
  SHN_ABS        0xfff1  Associated symbol is absolute
  SHN_COMMON     0xfff2  Associated symbol is common
  SHN_XINDEX     0xffff  Index is in extra table.
  SHN_HIRESERVE  0xffff  End of reserved indices

If the file has no section name string table, this member holds the value *SHN_UNDEF*.

If the section name string table section index is greater than or equal to *SHN_LORESERVE*, this member has the value *SHN_XINDEX* and the actual index of the section name string table section is contained in the sh_link field of the section header at index 0. Otherwise, the sh_link member of the initial section header entry contains the value zero.

## `Section header table`

An object file's **section header table** allows you to locate all of the sections of the file. The section header table is an array of *Elf32_Shdr* or *Elf64_Shdr* structures. A section header table index is a subscript into this array. The ELF header's *e_shoff* member indicates the byte offset from the beginning of the file to the section header table. The *e_shnum* member indicates how many entries that the section header table contains. The *e_shentsize* member indicates the size in bytes of each entry.

If the number of sections is greater than or equal to *SHN_LORESERVE*, *e_shnum* has the value *SHN_UNDEF*. The actual number of section header table entries is contained in the *sh_size* field of the section header at index 0. Otherwise, the *sh_size* member of the initial entry contains the value zero.

Some section header table indexes are reserved in contexts where index size is restricted. For example, the *st_shndx* member of a symbol table entry and the *e_shnum* and *e_shstrndx* members of the ELF header. In such contexts, the reserved values do not represent actual sections in the object file. Also in such contexts, an escape value indicates that the actual section index is to be found elsewhere, in a larger field.

### `Special Section Indexes`

Special section indices:
  SHN_UNDEF      0        Undefined section
  SHN_LORESERVE  0xff00  Start of reserved indices
  SHN_LOPROC     0xff00  Start of processor-specific
  SHN_BEFORE     0xff00  Order section before all others (Solaris).
  SHN_AFTER      0xff01  Order section after all others (Solaris).
  SHN_HIPROC     0xff1f  End of processor-specific
  SHN_LOOS       0xff20  Start of OS-specific
  SHN_HIOS       0xff3f  End of OS-specific
  SHN_ABS        0xfff1  Associated symbol is absolute
  SHN_COMMON     0xfff2  Associated symbol is common
  SHN_XINDEX     0xffff  Index is in extra table.
  SHN_HIRESERVE  0xffff  End of reserved indices

### `section header`

```
typedef struct {
  Elf64_Word   sh_name;
  Elf64_Word   sh_type;
  Elf64_Xword  sh_flags;
  Elf64_Addr   sh_addr;
  Elf64_Off    sh_offset;
  Elf64_Xword  sh_size;
  Elf64_Word   sh_link;
  Elf64_Word   sh_info;
  Elf64_Xword  sh_addralign;
  Elf64_Xword  sh_entsize;
} Elf64_Shdr;
```

###### `sh_name`

Give the section name indirectly. This members value is an index into the *section header string table* section giving the location of a null-terminated string.

A lot of section name is generate by linker, so they have default functionality.

###### `sh_type`

Categorizes the section's contents and semantics.

Legal values for sh_type (section type):
  SHT_NULL           0      Section header table entry unused
  SHT_PROGBITS       1      Program data
  SHT_SYMTAB         2      Symbol table
  SHT_STRTAB         3      String table
  SHT_RELA           4      Relocation entries with addends
  SHT_HASH           5      Symbol hash table
  SHT_DYNAMIC        6      Dynamic linking information
  SHT_NOTE           7      Notes
  SHT_NOBITS         8      Program space with no data (bss)
  SHT_REL            9      Relocation entries, no addends
  SHT_SHLIB          10     Reserved
  SHT_DYNSYM         11     Dynamic linker symbol table
  SHT_INIT_ARRAY     14     Array of constructors
  SHT_FINI_ARRAY     15     Array of destructors
  SHT_PREINIT_ARRAY  16     Array of pre-constructors
  SHT_GROUP          17     Section group
  SHT_SYMTAB_SHNDX   18     Extended section indeces
  SHT_NUM            19     Number of defined types.
  SHT_LOOS           0x60000000   Start OS-specific.
  SHT_GNU_ATTRIBUTES 0x6ffffff5   Object attributes.
  SHT_GNU_HASH       0x6ffffff6   GNU-style hash table.
  SHT_GNU_LIBLIST    0x6ffffff7   Prelink library list
  SHT_CHECKSUM       0x6ffffff8   Checksum for DSO content.
  SHT_LOSUNW         0x6ffffffa   Sun-specific low bound.
  SHT_SUNW_move      0x6ffffffa
  SHT_SUNW_COMDAT    0x6ffffffb
  SHT_SUNW_syminfo   0x6ffffffc
  SHT_GNU_verdef     0x6ffffffd   Version definition section.
  SHT_GNU_verneed    0x6ffffffe   Version needs section.
  SHT_GNU_versym     0x6fffffff   Version symbol table.
  SHT_HISUNW         0x6fffffff   Sun-specific high bound.
  SHT_HIOS           0x6fffffff   End OS-specific type
  SHT_LOPROC         0x70000000   Start of processor-specific
  SHT_HIPROC         0x7fffffff   End of processor-specific
  SHT_LOUSER         0x80000000   Start of application-specific
  SHT_HIUSER         0x8fffffff   End of application-specific

###### `sh_flags`

Specify section content attributions use combined flag bits.

Legal values for sh_flags (section flags).
  SHF_WRITE      (1 << 0)  Writable
  SHF_ALLOC      (1 << 1)  Occupies memory during execution
  SHF_EXECINSTR  (1 << 2)  Executable
  SHF_MERGE      (1 << 4)  Might be merged
  SHF_STRINGS    (1 << 5)  Contains nul-terminated strings
  SHF_INFO_LINK  (1 << 6)  sh_info contains SHT index
  SHF_LINK_ORDER (1 << 7)  Preserve order after combining
  SHF_OS_NONCONFORMING 
                 (1 << 8)  Non-standard OS specific handling required
  SHF_GROUP      (1 << 9)   Section is member of a group.
  SHF_TLS        (1 << 10)  Section hold thread-local data.
  SHF_COMPRESSED (1 << 11)  Section with compressed data.
  SHF_MASKOS     0x0ff00000 OS-specific.
  SHF_MASKPROC   0xf0000000 Processor-specific
  SHF_ORDERED    (1 << 30)  Special ordering requirement (Solaris).
  SHF_EXCLUDE    (1U << 31) Section is excluded unless referenced or
                            allocated (Solaris).

###### `sh_addr`

If the section appears in the memory image of a process, this member gives the address at which the section's first byte should reside. Otherwise, the member contains the value zero.

The member is relative VAO to *ELF header* VA in memory. We can check that:
  1) make a program name is hello.
  2) view section: 
     $ readelf -S hello
     Name:     .interp
     Address:  00000000000002a8
     Offset:   000002a8
     Size:     000000000000001c
     \# readelf -x 1 hello
     Hex dump of section '.interp':
     0x000002a8 2f6c6962 36342f6c 642d6c69 6e75782d /lib64/ld-linux-
     0x000002b8 7838362d 36342e73 6f2e3200          x86-64.so.2.
  3) $ gcc -q hello
     (gdb) start
  4) \# cat /proc/\<process_id\>/maps
     555555554000-555555555000 r--p 00000000 103:03 1054030 /home/eit/hello
     555555555000-555555556000 r-xp 00001000 103:03 1054030 /home/eit/hello
     555555556000-555555557000 r--p 00002000 103:03 1054030 /home/eit/hello
     555555557000-555555558000 r--p 00002000 103:03 1054030 /home/eit/hello
     555555558000-555555559000 rw-p 00003000 103:03 1054030 /home/eit/hello
     ...
  5) view ELF header:
      (gdb) x/64xb 0x555555554000
      0x555555554000: 0x7f  0x45  0x4c  0x46  0x02  0x01  0x01  0x00
      0x555555554008: 0x00  0x00  0x00  0x00  0x00  0x00  0x00  0x00
      0x555555554010: 0x03  0x00  0x3e  0x00  0x01  0x00  0x00  0x00
      0x555555554018: 0x90  0x10  0x00  0x00  0x00  0x00  0x00  0x00
      0x555555554020: 0x40  0x00  0x00  0x00  0x00  0x00  0x00  0x00
      0x555555554028: 0x38  0x43  0x00  0x00  0x00  0x00  0x00  0x00
      0x555555554030: 0x00  0x00  0x00  0x00  0x40  0x00  0x38  0x00
      0x555555554038: 0x0b  0x00  0x40  0x00  0x22  0x00  0x21  0x00
      \# hexdump -C -n 64 hello
      00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00
      00000010  03 00 3e 00 01 00 00 00  90 10 00 00 00 00 00 00
      00000020  40 00 00 00 00 00 00 00  38 43 00 00 00 00 00 00
      00000030  00 00 00 00 40 00 38 00  0b 00 40 00 22 00 21 00
  6) view section in memory:
      (gdb) x/28xb 0x555555554000+0x2a8
      0x5555555542a8: 0x2f  0x6c  0x69  0x62  0x36  0x34  0x2f  0x6c
      0x5555555542b0: 0x64  0x2d  0x6c  0x69  0x6e  0x75  0x78  0x2d
      0x5555555542b8: 0x78  0x38  0x36  0x2d  0x36  0x34  0x2e  0x73
      0x5555555542c0: 0x6f  0x2e  0x32  0x00

###### `sh_offset`

The byte offset from the beginning of the file to the first byte in the section. For a *SHT_NOBITS* section, this member indicates the conceptual offset in the file, as the section occupies no space in the file.

###### `sh_size`

The section's size in bytes. Unless the section type is *SHT_NOBITS*, the section occupies *sh_size* bytes in the file. A section of type *SHT_NOBITS* can have a nonzero size, but the section occupies no space in the file.

###### `sh_link`

A section header table index link, whose interpretation depends on the section type.

###### `sh_info`

Extra information, whose interpretation depends on the section type.

If the *sh_flags* field for this section header includes the attribute *SHF_INFO_LINK*, then this member represents a section header table index.

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

###### `sh_addralign`

Some sections have address alignment constraints. For example, if a section holds a double-word, the system must ensure double-word alignment for the entire section. In this case, the value of *sh_addr* must be congruent to 0, modulo the value of *sh_addralign*. Currently, only 0 and positive integral powers of two are allowed. Values 0 and 1 mean the section has no alignment constraints.

###### `sh_entsize`

Some sections hold a table of fixed-size entries, such as a symbol table. For such a section, this member gives the size in bytes of each entry. The member contains the value zero if the section does not hold a table of fixed-size entries.

### `Section Merging`

The *SHF_MERGE* section flag can be used to mark *SHT_PROGBITS* sections within relocatable objects. This flag indicates that the section can be merged with compatible sections from other objects. Such merging has the potential to reduce the size of any executable or shared object that is built from these relocatable objects. This size reduction can also have a positive effect on the runtime performance of the resulting object.

A *SHF_MERGE* flagged section indicates that the section adheres to the following characteristics.
  1) The section is read-only. It must not be possible for a program containing
     this section to alter the section data at runtime.
  2) Every item in the section is accessed from an individual relocation record. 
     The program code must not make any assumptions about the relative position
     of items in the section when generating the code that accesses the items.
  3) If the section also has the *SHF_STRINGS* flag set, then the section can only 
     contain null terminated strings. Null characters are only allowed as string 
     terminators, and null characters must not appear within the middle of any
     string.

*SHF_MERGE* is an optional flag indicating a possible optimization. The link-editor is allowed to perform the optimization, or to ignore the optimization. The link-editor creates a valid output object in either case. The link-editor presently implements section merging only for sections containing string data marked with the *SHF_STRINGS* flag.

When the *SHF_STRINGS* section flag is set in conjunction with the *SHF_MERGE* flag, the strings in the section are available to be merged with strings from other compatible sections. The link-editor merges such sections using the same string compression algorithm as used to compress the *SHT_STRTAB* string tables, *.strtab* and *.dynstr*.
  1) Duplicate strings are reduced to a single copy.
  2) Tail strings are eliminated. For example, if input sections contain the 
     strings “bigdog” and “dog”, then the smaller “dog” string is eliminated, 
     and the tail of the larger string is used to represent the smaller string.

The link-editor currently implements string merging only for strings that consist of byte sized characters that do not have special alignment constraints. Specifically, the following section characteristics are required:
  1) *sh_entsize* must be 0, or 1. Sections containing wide characters are not 
     supported.
  2) Only sections with byte alignment, where *sh_addralign* is 0, or 1, are 
     merged.

### `Special Sections`

| Name      | Descriptions                                                 |
| --------- | ------------------------------------------------------------ |
| .bbs      | 未初始化数据节区,程序运行时,会被初始化为0;                   |
| .comment  | 版本控制信息;                                                |
| .data     | 初始化的数据;                                                |
| .data1    |                                                              |
| .debug    | 调试符号信息;                                                |
| .dynamic  | 动态链接表                                                |
| .dynstr   | 保存了动态符号,节区头指向的节区是null-terminate字符串集; |
| .dynsym   | 动态符号表间接给出了调试符号字符串; <br />**sh_link** 的内容是节区头的索引,这个节区头一般是 **.dynstr** ,它的节区的数据是null-terminate字符串集; <br />**.dynsym** 的节区的数据是 **Elf64_Sym** 结构的数组,每个结构指出一个调试符号位置, **Elf64_Shdr::sh_entsize**指出条目尺寸,**Elf64_Shdr::sh_size**指出总条目尺寸,间接的就可以得到条目数量了;<br />**Elf64_Sym::st_name** 字段给出了相对于 **sh_link** 指出的节区的数据的 FAO[^FAO],这个FAO的位置就是我们要的动态符号了; |
| .fini     | 某些节区包含可执行的指令,是进程终止代码的一的部分;程序正常退出时,<br />系统将安排执行这里的代码; |
| .got      | 全局偏移表;                                                  |
| .hash     | 符号哈希表;                                                  |
| .init     | 节区包含可执行的指令,是进程初始化代码的一的部分;程序开始执行时,<br />系统在调用入口函数之前,系统将安排执行这里的代码; |
| .interp   | 节区包含程序解释器[^4]的路径名;如果程序包含一个可加载的段,段中包含此节区,<br />那么节区的属性将包含SHF_ALLOC; |
| .line     | 调试行号信息,描述了源码与机器码之间的对应关系;               |
| .note     | 注释信息,有独立的格式; |
| .note.ABI-tag | 节区用于声明ELF镜像预期的运行时ABI;可能包含操作系统名各运行时版本; |
| .note.gnu.build-id | 节区用于保存id,唯一标识ELF镜像的id;有相同id的不同文件应该包含相同的可执行的内容;详见GNU链接器(ld)的 **--build-id** 选项; |
| .note.GNU-stack | 声明栈属性;表明GNU链接器,目标文件请求一个求执行的堆栈; |
| .note.openbsd.ident | OpenBSD原生可执行程序通常包含这个部分来标识自己，这样内核就可以在加载文件时绕过任何兼容ELF二进制模拟测试。 |
| .plt      | 过程链接表; |
| .relname  | 重定位信息;如果文件中包含可加载的段,段中有重定位内容,节区的属性将包含<br />SHF_ALLOC位,否为0;传统上的name根据重定位所适用的节区给定;例如, .text节区<br />的重定位名为 .rel.text 或 .rela.text; |
| .relaname | 重定位信息;如果文件中包含可加载的段,段中有重定位内容,节区的属性将包含<br />SHF_ALLOC位,否为0;传统上的name根据重定位所适用的节区给定;例如, .text节区<br />的重定位名为 .rel.text 或 .rela.text; |
| .rodata   | 只读数据; |
| .rodata1  | 只读数据; |
| .shstrtab | 节区名字符串表,管理的空间保存所有的节区名字符串; |
| .strtab   | 字符串表;与符号表项相关的名称; |
| .symtab   | 符号表;  **Elf64_Sym**; |
| .text     | 程序代码节区; |

### `COMDAT Section`

### `Group Section`

### `Hash Table Section`

A hash table consists of *Elf32_Word* or *Elf64_Word* objects that provide for symbol table access. The *SHT_HASH* section provides this hash table. The symbol table to which the hashing is associated is specified in the *sh_link* entry of the hash table's section header.

### `Move Section`

Typically, within ELF files, initialized data variables are maintained within the object file. If a data variable is very large, and contains only a small number of initialized (nonzero) elements, the entire variable is still maintained in the object file.

Objects that contain large partially initialized data variables, such as *FORTRAN* *COMMON* blocks, can result in a significant disk space overhead. The *SHT_SUNW_move* section provides a mechanism of compressing these data variables. This compression reduces the disk size of the associated object.

### `Note Section`

A vendor or system engineer might need to mark an object file with special information that other programs can check for conformance or compatibility. Sections of type *SHT_NOTE* and program header elements of type *PT_NOTE* can be used for this purpose.

### `Relocation Sections`

Relocation is the process of connecting symbolic references with symbolic definitions. For example, when a program calls a function, the associated call instruction must transfer control to the proper destination address at execution. Relocatable files must have information that describes how to modify their section contents. This information allows executable and shared object files to hold the right information for a process's program image. Relocation entries are these data.

###### `Relocation Table Entry`

Relocation entry can have the following structure:

```
typedef struct {
  Elf64_Addr      r_offset;
  Elf64_Xword     r_info;
} Elf64_Rel;

typedef struct {
  Elf64_Addr      r_offset;
  Elf64_Xword     r_info;
  Elf64_Sxword    r_addend;
} Elf64_Rela;
```

`r_offset`

This member gives the location at which to apply the relocation action. Different object files have slightly different interpretations for this member.

For a relocatable file, the value indicates a section offset. The relocation section describes how to modify another section in the file. Relocation offsets designate a storage unit within the second section.

For an executable or shared object, the value indicates the virtual address of the storage unit affected by the relocation. This information makes the relocation entries more useful for the runtime linker.

Although the interpretation of the member changes for different object files to allow efficient access by the relevant programs, the meanings of the relocation types stay the same.

`r_info`

This member gives both the symbol table index, with respect to which the relocation must be made, and the type of relocation to apply. For example, a call instruction's relocation entry holds the symbol table index of the function being called. If the index is *STN_UNDEF*, the undefined symbol index, the relocation uses zero as the symbol value.

Relocation types are processor-specific. A relocation entry's relocation type or symbol table index is the result of applying *ELF32_R_TYPE* or *ELF32_R_SYM*, respectively, to the entry's *r_info* member.

```
#define ELF32_R_SYM(info)             ((info)>>8)
#define ELF32_R_TYPE(info)            ((unsigned char)(info))
#define ELF32_R_INFO(sym, type)       (((sym)<<8)+(unsigned char)(type))

#define ELF64_R_SYM(info)             ((info)>>32)
#define ELF64_R_TYPE(info)            ((Elf64_Word)(info))
#define ELF64_R_INFO(sym, type)       (((Elf64_Xword)(sym)<<32)+ \ 
                                        (Elf64_Xword)(type))
```

For 64–bit SPARC *Elf64_Rela* structures, the *r_info* field is further broken down into an 8–bit type identifier and a 24–bit type dependent data field. For the existing relocation types, the data field is zero. New relocation types, however, might make use of the data bits.

```
#define ELF64_R_TYPE_DATA(info)       (((Elf64_Xword)(info)<<32)>>40)
#define ELF64_R_TYPE_ID(info)         (((Elf64_Xword)(info)<<56)>>56)
#define ELF64_R_TYPE_INFO(data, type) (((Elf64_Xword)(data)<<8)+ \ 
                                        (Elf64_Xword)(type))
```

`r_addend`

This member specifies a constant addend used to compute the value to be stored into the relocatable field.

### `String Table Section`

String table sections hold null-terminated character sequences, commonly called strings. The object file uses these strings to represent symbol and section names. You reference a string as an index into the string table section.

The first byte, which is index zero, holds a null character. Likewise, a string table's last byte holds a null character, ensuring null termination for all strings. A string whose index is zero specifies either no name or a null name, depending on the context.

An empty string table section is permitted. The section header's *sh_size* member contains zero. Nonzero indexes are invalid for an empty string table.

A section header's *sh_name* member holds an index into the section header string table section. The section header string table is designated by the *e_shstrndx* member of the ELF header. 

### `Symbol Table Section`

**Symbol Table Entry** stores in symbol table section, the size of symbol table entry is specified in the member *sh_entsize* of certain section header table entry who\`s type is *SHT_SYMTAB*; **Symbol Table Section** consists of symbol table entry array, it is specified by certain section header table entry who\`s type is *SHT_SYMTAB*.

An object file's symbol table holds information needed to locate and relocate a program's symbolic definitions and symbolic references. A symbol table index is a subscript into this array. Index 0 both designates the first entry in the table and serves as the undefined symbol index.

###### `Symbol Table Entry`

```
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

FAO, st_name.FAO = \<symbol_name_string\>.FA - \<sht_strtab_section\>.FA;

An index into the object file's symbol string table, which holds the character representations of the symbol names. If the value is nonzero, the value represents a string table index that gives the symbol name. Otherwise, the symbol table entry has no name.

`st_info`

The symbol's type and binding attributes. 

```
#define ELF32_ST_BIND(info)          ((info) >> 4)
#define ELF32_ST_TYPE(info)          ((info) & 0xf)
#define ELF32_ST_INFO(bind, type)    (((bind)<<4)+((type)&0xf))

#define ELF64_ST_BIND(info)          ((info) >> 4)
#define ELF64_ST_TYPE(info)          ((info) & 0xf)
#define ELF64_ST_INFO(bind, type)    (((bind)<<4)+((type)&0xf))
```

ELF Symbol Binding, ELF32_ST_BIND and ELF64_ST_BIND:
  STB_LOCAL       0   Local symbol
  STB_GLOBAL      1   Global symbol
  STB_WEAK        2   Weak symbol
  STB_NUM         3   Number of defined types.
  STB_LOOS        10  Start of OS-specific
  STB_GNU_UNIQUE  10  Unique symbol.
  STB_HIOS        12  End of OS-specific
  STB_LOPROC      13  Start of processor-specific
  STB_HIPROC      15  End of processor-specific

ELF Symbol Types, ELF32_ST_TYPE and ELF64_ST_TYPE:
  STT_NOTYPE      0    Symbol type is unspecified 
  STT_OBJECT      1    Symbol is a data object 
  STT_FUNC        2    Symbol is a code object 
  STT_SECTION     3    Symbol associated with a section 
  STT_FILE        4    Symbol's name is file name 
  STT_COMMON      5    Symbol is a common data object 
  STT_TLS         6    Symbol is thread-local data object
  STT_NUM         7    Number of defined types.  
  STT_LOOS        10   Start of OS-specific 
  STT_GNU_IFUNC   10   Symbol is indirect code object 
  STT_HIOS        12   End of OS-specific 
  STT_LOPROC      13   Start of processor-specific 
  STT_HIPROC      15   End of processor-specific 

`st_other`

A symbol's visibility. Other bits are set to zero, and have no defined meaning.

```
#define ELF32_ST_VISIBILITY(o)       ((o)&0x3)
#define ELF64_ST_VISIBILITY(o)       ((o)&0x3)
```

  STV_DEFAULT	0  Default symbol visibility rules
  STV_INTERNAL	1  Processor specific hidden class
  STV_HIDDEN	2  Sym unavailable in other modules
  STV_PROTECTED	3  Not preemptible, not exported

`st_shndx`

section header table index or special section index.

Every symbol table entry is defined in relation to some section. This member holds the relevant section header table index. Some section indexes indicate special meanings.

If this member contains *SHN_XINDEX*, then the actual section header index is too large to fit in this field. The actual value is contained in the associated section of type *SHT_SYMTAB_SHNDX*.

`st_value`

The value of the associated symbol. The value can be an absolute value or an address, depending on the context.

Symbol table entries for different object file types have slightly different interpretations for the *st_value* member:
  1) In relocatable files, *st_value* holds alignment constraints for a symbol 
     whose section index *st_shndx* is *SHN_COMMON*.
  2) In relocatable files, *st_value* holds a section offset for a defined symbol. 
     *st_value* is an offset from the beginning of the section that *st_shndx* 
     identifies.
  3) In executable and shared object files, *st_value* holds a virtual address. To 
     make these files' symbols more useful for the runtime linker, the section 
     offset (file interpretation) gives way to a virtual address 
     (memory interpretation) for which the section number is irrelevant.

`st_size`

Many symbols have associated sizes. For example, a data object's size is the number of bytes that are contained in the object. This member holds the value zero if the symbol has no size or an unknown size.

### `Dynamic Section`

**Dynamic Section** consists of dynamic section entry array, it is specified by certain section header table entry who\`s type is *SHT_DYNAMIC*.
*sh_offset* specifies physical pos of dynamic section.
*sh_size* specifies physical size of dynamic section.
*sh_link* specifies section header table index of the associated string table.
*sh_entsize* specifies size of dynamic header entry.

###### `Dynamic Section Entry`

```
typedef struct {
  Elf32_Sword d_tag;
  union {
    Elf32_Word      d_val;
    Elf32_Addr      d_ptr;
    Elf32_Off       d_off;
  } d_un;
} Elf32_Dyn;

typedef struct {
  Elf64_Xword d_tag;
  union {
    Elf64_Xword     d_val;
    Elf64_Addr      d_ptr;
  } d_un;
} Elf64_Dyn;
```

`d_tag`

For each object with this type, *d_tag* controls the interpretation of *d_un*.

`d_val`

These objects represent integer values with various interpretations.

`d_ptr`

These objects represent program virtual addresses. A file's virtual addresses might not match the memory virtual addresses during execution. When interpreting addresses contained in the dynamic structure, the runtime linker computes actual addresses, based on the original file value and the memory base address. For consistency, files do not contain relocation entries to **correct** addresses in the dynamic structure.

`d_off`

## `Program header table`
**Program header table** of executable or shared object file is an array of structures. Each structure describes a segment or other information that the system needs to prepare the program for execution. An object file segment contains one or more sections, as described in segment contents.

Program headers are meaningful only for executable and shared object files. A file specifies its own program header size with the ELF header's *e_phentsize* and *e_phnum* members.

### `Program header`

```
typedef struct {
  Elf64_Word      p_type;
  Elf64_Word      p_flags;
  Elf64_Off       p_offset;
  Elf64_Addr      p_vaddr;
  Elf64_Addr      p_paddr;
  Elf64_Xword     p_filesz;
  Elf64_Xword     p_memsz;
  Elf64_Xword     p_align;
} Elf64_Phdr;
```

###### `p_type`

The kind of segment this array element describes or how to interpret the array element's information.

Legal values for p_type (segment type): 
  PT_NULL         0    Program header table entry unused 
  PT_LOAD         1    Loadable program segment 
  PT_DYNAMIC      2    Dynamic linking information 
  PT_INTERP       3    Program interpreter 
  PT_NOTE         4    Auxiliary information 
  PT_SHLIB        5    Reserved 
  PT_PHDR         6    Entry for header table itself 
  PT_TLS          7    Thread-local storage segment 
  PT_NUM          8    Number of defined types 
  PT_LOOS         0x60000000   Start of OS-specific 
  PT_GNU_EH_FRAME 0x6474e550   GCC .eh_frame_hdr segment 
  PT_GNU_STACK    0x6474e551   Indicates stack executability 
  PT_GNU_RELRO    0x6474e552   Read-only after relocation 
  PT_LOSUNW       0x6ffffffa
  PT_SUNWBSS      0x6ffffffa   Sun Specific segment 
  PT_SUNWSTACK    0x6ffffffb   Stack segment 
  PT_HISUNW       0x6fffffff
  PT_HIOS         0x6fffffff   End of OS-specific 
  PT_LOPROC       0x70000000   Start of processor-specific 
  PT_HIPROC       0x7fffffff   End of processor-specific 

###### `p_flags`

Flags that are relevant to the segment.

Legal values for p_flags (segment flags):
  PF_X        (1 << 0)    Segment is executable 
  PF_W        (1 << 1)    Segment is writable 
  PF_R        (1 << 2)    Segment is readable 
  PF_MASKOS   0x0ff00000  OS-specific 
  PF_MASKPROC 0xf0000000  Processor-specific 

###### `p_offset`

FA. The offset from the beginning of the file at which the first byte of the segment resides.

###### `p_vaddr`

VA, The virtual address at which the first byte of the segment resides in memory.

###### `p_paddr`

FA. The segment's physical address for systems in which physical addressing is relevant. Because the system ignores physical addressing for application programs, this member has unspecified contents for executable files and shared objects.

###### `p_filesz`

The number of bytes in the file image of the segment, which can be zero.

###### `p_memsz`

The number of bytes in the memory image of the segment, which can be zero.

###### `p_align`
Loadable process segments must have equal values for p_vaddr and p_offset, modulo the page size. This member gives the value to which the segments are aligned in memory and in the file. Values 0 and 1 mean no alignment is required. Otherwise, p_align should be a positive, integral power of 2, and p_vaddr should equal p_offset, modulo p_align.


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