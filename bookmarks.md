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

# `4. 格式分析`

## `4.2 ELF header`

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

## `Program header`

*Executable file* and *Shared object file* 的程序头表是一个数组结构.每一个描述一个段或执行时需要的其它信息;

一个目标文件段包含一个或多个节;

程序头表只对 *Executable file* and *Shared object file* 有意义;



Program header Phdr:

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

## `Section header table`

An object file's **section header table** allows you to locate all of the sections of the file. The section header table is an array of *Elf32_Shdr* or *Elf64_Shdr* structures. A section header table index is a subscript into this array. The ELF header's *e_shoff* member indicates the byte offset from the beginning of the file to the section header table. The *e_shnum* member indicates how many entries that the section header table contains. The *e_shentsize* member indicates the size in bytes of each entry.

If the number of sections is greater than or equal to *SHN_LORESERVE*, *e_shnum* has the value *SHN_UNDEF*. The actual number of section header table entries is contained in the *sh_size* field of the section header at index 0. Otherwise, the *sh_size* member of the initial entry contains the value zero.

Some section header table indexes are reserved in contexts where index size is restricted. For example, the *st_shndx* member of a symbol table entry and the *e_shnum* and *e_shstrndx* members of the ELF header. In such contexts, the reserved values do not represent actual sections in the object file. Also in such contexts, an escape value indicates that the actual section index is to be found elsewhere, in a larger field.

### `ELF Special Section Indexes`

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

##### `sh_name`

Give the section name indirectly. This members value is an index into the *section header string table* section giving the location of a null-terminated string.

A lot of section name is generate by linker, so they have default functionality.

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

##### `sh_type`

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
   SHT_NUM           19     Number of defined types.
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

##### `sh_flags`

Specify section content attributions use combined flag bits.

Legal values for sh_flags (section flags).
  SHF_WRITE      (1 << 0)  Writable
  SHF_ALLOC      (1 << 1)  Occupies memory during execution
  SHF_EXECINSTR  (1 << 2)  Executable
  SHF_MERGE      (1 << 4)  Might be merged
  SHF_STRINGS    (1 << 5)  Contains nul-terminated strings
  SHF_INFO_LINK  (1 << 6)  sh_info contains SHT index
  SHF_LINK_ORDER (1 << 7)  Preserve order after combining
  SHF_OS_NONCONFORMING (1 << 8)  Non-standard OS specific handling required
  SHF_GROUP      (1 << 9)   Section is member of a group.
  SHF_TLS        (1 << 10)  Section hold thread-local data.
  SHF_COMPRESSED (1 << 11)  Section with compressed data.
  SHF_MASKOS     0x0ff00000 OS-specific.
  SHF_MASKPROC   0xf0000000 Processor-specific
  SHF_ORDERED    (1 << 30)  Special ordering requirement (Solaris).
  SHF_EXCLUDE    (1U << 31) Section is excluded unless referenced or
                            allocated (Solaris).

##### `sh_addr`
##### `sh_offset`

##### `sh_size`

##### `sh_link`
##### `sh_info`
##### `sh_addralign`
##### `sh_entsize`

### `一些节`





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