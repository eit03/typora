***
[toc]
***

# `ELF`

## `1. In A Nutshell`

## `2. Details`

## `3. Verbose`

### `3.1 Categorize`

| Type | Descriptions |
|---|---|
| relocatable object | holds sections containing code and data; This file is suitable to be linked with other relocatable object files to create dynamic executable files, shared object files, or another relocatable object; |
| shared object | holds code and data that is suitable for additional linking; The link-editor can process this file with other relocatable object files and/or shared object files to create other object files; |
| dynamic executable | holds a program that is ready to execute; The file specifies how exec(2) creates a program's process image; This file is typically bound to shared object files at runtime to create a process image; The runtime linker combines this file with a dynamic executable file and other shared object files to create a process image; |

### `3.2 Organize`

| Linking View | Execution View |
| --- | --- |
| ELF header | ELF header |
| Program header table (optional) | Program header table |
| Section 1 | Segment 1 |
| ... | Segment 2 |
| Section n | ... |
| ... | ... |
| ... | ... |
| Section header table | Section header table (optional) |

**ELF header** resides at the beginning of an object file and holds a road map
describing the file's organization.

**Note:** Only the ELF header has a fixed position in the file. The flexibility
of the ELF format requires no specified order for header tables, sections or
segments. However, this figure is typical of the layout used in the Oracle
Solaris OS.

**Sections** represent the smallest indivisible units that can be processed
within an ELF file.

Sections hold the bulk of object file information for the linking view. This
data includes instructions, data, symbol table, and relocation information.
Descriptions of sections appear in the first part of this chapter. The second
part of this chapter discusses segments and the program execution view of the
file.

**Section header table** contains information describing the file's sections.
Every section has an entry in the table. Each entry gives information such as
the section name and section size. Files that are used in link-editing must have
a section header table.

**Segments** are a collection of sections. Segments represent the smallest
individual units that can be mapped to a memory image by exec(2) or by the
runtime linker.

**Program header table**, if present, tells the system how to create a process
image. Files used to generate a process image, executable files and shared
objects, must have a program header table. Relocatable object files do not need
a program header table.

### `3.3 Data Representation`

The object file format supports various processors with 8-bit bytes, 32–bit
architectures and 64–bit architectures. Nevertheless, the data representation
is intended to be extensible to larger, or smaller, architectures.

**Table ELF 32–Bit Data Types:**
| Name | Size | Alignment | Purpose |
|---|---|---|---|
| Elf32_Addr    | 4 | 4 | Unsigned program address
| Elf32_Half    | 2 | 2 | Unsigned medium integer
| Elf32_Off     | 4 | 4 | Unsigned file offset
| Elf32_Sword   | 4 | 4 | Signed integer
| Elf32_Word    | 4 | 4 | Unsigned integer
| unsigned char | 1 | 1 | Unsigned small integer

**Table ELF 64–Bit Data Types:**
| Name | Size | Alignment | Purpose |
|---|---|---|---|
| Elf64_Addr    | 8 | 8 | Unsigned program address
| Elf64_Half    | 2 | 2 | Unsigned medium integer
| Elf64_Off     | 8 | 8 | Unsigned file offset
| Elf64_Sword   | 4 | 4 | Signed integer
| Elf64_Word    | 4 | 4 | Unsigned integer
| Elf64_Xword   | 8 | 8 | Unsigned long integer
| Elf64_Sxword  | 8 | 8 | Signed long integer
| unsigned char | 1 | 1 | Unsigned small integer

### `3.4 EFL Header`

Some control structures within object files can grow because the ELF header
contains their actual sizes. If the object file format does change, a program
can encounter control structures that are larger or smaller than expected.
Programs might therefore ignore extra information. The treatment of missing
information depends on context and is specified if and when extensions are
defined.

**EFL header** is a structure what is Elf632_Ehdr/Elf64_Ehdr.

### `3.5 Sections`

**Sections** hold the bulk of object file information for the linking view. This
data includes instructions, data, symbol table, and relocation information.
Descriptions of sections appear in the first part of this chapter. The second
part of this chapter discusses segments and the program execution view of the
file.

Sections represent the smallest indivisible units that can be processed
within an ELF file.

### `3.6 Section Header`

**Section header** is a structure what is Elf32_Shdr/Elf64_Shdr, it gives some
informations for suitable section. Every section has an section header in the
table.

### `3.7 Section Header Table`

**Section header table** of object file allows you to locate all of the sections
of the file. The section header table is an array of Elf32_Shdr or Elf64_Shdr
structures, a section header table index is a subscript into this array.

Files that are used in link-editing must have a section header table.

**Elf64_Shdr::e_shoff** member indicates the byte offset from the beginning of
the file to the section header table.

**Elf64_Shdr::e_shnum** member indicates how many entries that the section
header table contains.

**Elf64_Shdr::e_shentsize** member indicates the size in bytes of each entry.

**Note:** If the number of sections is greater than or equal to SHN_LORESERVE
(0xff00), e_shnum has the value SHN_UNDEF (0). The actual number of section
header table entries is contained in the sh_size field of the section header
at index 0. Otherwise, the sh_size member of the initial entry contains the
value zero.

Some section header table indexes are reserved in contexts where index size is
restricted. For example, the st_shndx member of a symbol table entry and the
e_shnum and e_shstrndx members of the ELF header. In such contexts, the reserved
values do not represent actual sections in the object file. Also in such
contexts, an escape value indicates that the actual section index is to be found
elsewhere, in a larger field.

## `Parallel Universe`

### `pu.1 ELf64Ehdr`

``` text
#define EI_NIDENT       16

typedef struct {
  unsigned char  e_ident[EI_NIDENT];
  Elf32_Half     e_type;
  Elf32_Half     e_machine;
  Elf32_Word     e_version;
  Elf32_Addr     e_entry;
  Elf32_Off      e_phoff;
  Elf32_Off      e_shoff;
  Elf32_Word     e_flags;
  Elf32_Half     e_ehsize;
  Elf32_Half     e_phentsize;
  Elf32_Half     e_phnum;
  Elf32_Half     e_shentsize;
  Elf32_Half     e_shnum;
  Elf32_Half     e_shstrndx;
} Elf32_Ehdr;

typedef struct {
  unsigned char  e_ident[EI_NIDENT];
  Elf64_Half     e_type;
  Elf64_Half     e_machine;
  Elf64_Word     e_version;
  Elf64_Addr     e_entry;
  Elf64_Off      e_phoff;
  Elf64_Off      e_shoff;
  Elf64_Word     e_flags;
  Elf64_Half     e_ehsize;
  Elf64_Half     e_phentsize;
  Elf64_Half     e_phnum;
  Elf64_Half     e_shentsize;
  Elf64_Half     e_shnum;
  Elf64_Half     e_shstrndx;
} Elf64_Ehdr;
```

`e_ident`
The initial bytes mark the file as an object file. These bytes provide
machine-independent data with which to decode and interpret the file's contents.
Complete descriptions appear in ELF Identification.

`e_type`
Identifies the object file type, as listed in the following table.

| Name      | Value  | Meaning
| --- | ---| ---
| ET_NONE   | 0      | No file type
| ET_REL    | 1      | Relocatable file
| ET_EXEC   | 2      | Executable file
| ET_DYN    | 3      | Shared object file
| ET_CORE   | 4      | Core file
| ET_LOPROC | 0xff00 | Processor-specific
| ET_HIPROC | 0xffff | Processor-specific

Although the core file contents are unspecified, type ET_CORE is reserved to
mark the file. Values from ET_LOPROC through ET_HIPROC (inclusive) are reserved
for processor-specific semantics. Other values are reserved for future use.

`e_machine`
Specifies the required architecture for an individual file. Relevant
architectures are listed in the following table.

| Name      | Value  | Meaning
| --- | ---| ---
| EM_NONE        | 0  | No machine
| EM_SPARC       | 2  | SPARC
| EM_386         | 3  | Intel 80386
| EM_SPARC32PLUS | 18 | Sun SPARC 32+
| EM_SPARCV9     | 43 | SPARC V9
| EM_AMD64       | 62 | AMD 64

Other values are reserved for future use. Processor-specific ELF names are
distinguished by using the machine name. For example, the flags defined for
e_flags use the prefix EF_. A flag that is named WIDGET for the EM_XYZ machine
would be called EF_XYZ_WIDGET.

`e_version`
Identifies the object file version, as listed in the following table.

| Name      | Value  | Meaning
| --- | ---| ---
EV_NONE    | 0   | Invalid version
EV_CURRENT | >=1 | Current version

The value 1 signifies the original file format. The value of EV_CURRENT changes
as necessary to reflect the current version number.

`e_entry`
The virtual address to which the system first transfers control, thus starting
the process. If the file has no associated entry point, this member holds zero.

`e_phoff`
The program header table's file offset in bytes. If the file has no program
header table, this member holds zero.

`e_shoff`
The section header table's file offset in bytes. If the file has no section
header table, this member holds zero.

`e_flags`
Processor-specific flags associated with the file. Flag names take the form
EF_machine_flag. This member is presently zero for x86. The SPARC flags are
listed in the following table.

| Name      | Value  | Meaning
| --- | ---| ---
EF_SPARCV9_TSO    | 0x0      | Total Store Ordering
EF_SPARCV9_PSO    | 0x1      | Partial Store Ordering
EF_SPARCV9_RMO    | 0x2      | Relaxed Memory Ordering
EF_SPARCV9_MM     | 0x3      | Mask for Memory Model
EF_SPARC_32PLUS   | 0x000100 | Generic V8+ features
EF_SPARC_SUN_US1  | 0x000200 | Sun UltraSPARC 1 Extensions
EF_SPARC_HAL_R1   | 0x000400 | HAL R1 Extensions
EF_SPARC_SUN_US3  | 0x000800 | Sun UltraSPARC 3 Extensions
EF_SPARC_EXT_MASK | 0xffff00 | Vendor Extension mask

`e_ehsize`
The ELF header's size in bytes.

`e_phentsize`
The size in bytes of one entry in the file's program header table. All entries
are the same size.

`e_phnum`
The number of entries in the program header table. The product of e_phentsize
and e_phnum gives the table's size in bytes. If a file has no program header
table, e_phnum holds the value zero.

If the number of program headers is greater than or equal to PN_XNUM (0xffff),
this member has the value PN_XNUM (0xffff). The actual number of program header
table entries is contained in the sh_info field of the section header at index
0. Otherwise, the sh_info member of the initial section header entry contains
the value zero. See Table 12-6 and Table 12-7.

`e_shentsize`
A section header's size in bytes. A section header is one entry in the section
header table. All entries are the same size.

`e_shnum`
The number of entries in the section header table. The product of e_shentsize
and e_shnum gives the section header table's size in bytes. If a file has no
section header table, e_shnum holds the value zero.

If the number of sections is greater than or equal to SHN_LORESERVE (0xff00),
e_shnum has the value zero. The actual number of section header table entries is
contained in the sh_size field of the section header at index 0. Otherwise, the
sh_size member of the initial section header entry contains the value zero.

`e_shstrndx`
The section header table index of the entry that is associated with the section
name string table. If the file has no section name string table, this member
holds the value SHN_UNDEF.

If the section name string table section index is greater than or equal to
SHN_LORESERVE (0xff00), this member has the value SHN_XINDEX (0xffff) and the
actual index of the section name string table section is contained in the
sh_link field of the section header at index 0. Otherwise, the sh_link member of
the initial section header entry contains the value zero.

### `pu.2 ELF Identification`

ELF provides an object file framework to support multiple processors, multiple
data encoding, and multiple classes of machines. To support this object file
family, the initial bytes of the file specify how to interpret the file. These
bytes are independent of the processor on which the inquiry is made and
independent of the file's remaining contents.

The initial bytes of an ELF header and an object file correspond to the
Elf64_Ehdr::e_ident member.

**Table pu.2-1 ELF Identification Index:**
| Name | Value | Purpose
| --- | ---| ---
| EI_MAG0       | 0  | File identification
| EI_MAG1       | 1  | File identification
| EI_MAG2       | 2  | File identification
| EI_MAG3       | 3  | File identification
| EI_CLASS      | 4  | File class
| EI_DATA       | 5  | Data encoding
| EI_VERSION    | 6  | File version
| EI_OSABI      | 7  | Operating system/ABI identification
| EI_ABIVERSION | 8  | ABI version
| EI_PAD        | 9  | Start of padding bytes
| EI_NIDENT     | 16 | Size of e_ident[]

**EI_MAG0 - EI_MAG3:**

A 4–byte magic number, identifying the file as an ELF object file, as listed in
the following table.

| Name    | Value | Position
| --- | ---| ---
| ELFMAG0 | 0x7f  | e_ident[EI_MAG0]
| ELFMAG1 | 'E'   | e_ident[EI_MAG1]
| ELFMAG2 | 'L'   | e_ident[EI_MAG2]
| ELFMAG3 | 'F'   | e_ident[EI_MAG3]

**EI_CLASS:**

Byte e_ident[EI_CLASS] identifies the file's class, or capacity, as listed in
the following table.

| Name | Value | Meaning
|  --- | ---| ---
| ELFCLASSNONE | 0 | Invalid class
| ELFCLASS32   | 1 | 32–bit objects
| ELFCLASS64   | 2 | 64–bit objects

**EI_DATA:**

Byte e_ident[EI_DATA] specifies the data encoding of the processor-specific data
in the object file, as listed in the following table.

| Name | Value | Meaning
|  --- | ---| ---
| ELFDATANONE | 0 | Invalid data encoding
| ELFDATA2LSB | 1 | little endian
| ELFDATA2MSB | 2 | big endian

**EI_VERSION:**

Byte e_ident[EI_VERSION] specifies the ELF header version number. Currently,
this value must be EV_CURRENT.

**EI_OSABI:**

Byte e_ident[EI_OSABI] identifies the operating system together with the ABI to
which the object is targeted. Some fields in other ELF structures have flags
and values that have operating system or ABI specific meanings. The
interpretation of those fields is determined by the value of this byte.

| Name | Value | Meaning
|  --- | ---| ---
| ELFOSABI_NONE       | 0   | UNIX System V ABI.
| ELFOSABI_SYSV       | 0   | Alias.
| ELFOSABI_HPUX       | 1   | HP-UX.
| ELFOSABI_NETBSD     | 2   | NetBSD.
| ELFOSABI_GNU        | 3   | Object uses GNU ELF extensions.
| ELFOSABI_LINUX      | 3   | Compatibility alias.
| ELFOSABI_SOLARIS    | 6   | Sun Solaris.
| ELFOSABI_AIX        | 7   | IBM AIX.
| EI_OSABI            | 7   | OS ABI identification
| ELFOSABI_IRIX       | 8   | SGI Irix.
| ELFOSABI_FREEBSD    | 9   | FreeBSD.
| ELFOSABI_TRU64      | 10  | Compaq TRU64 UNIX.
| ELFOSABI_MODESTO    | 11  | Novell Modesto.
| ELFOSABI_OPENBSD    | 12  | OpenBSD.
| ELFOSABI_ARM_AEABI  | 64  | ARM EABI.
| ELFOSABI_ARM        | 97  | ARM.
| ELFOSABI_STANDALONE | 255 | Standalone (embedded:) application.

**EI_ABIVERSION:**

Byte e_ident[EI_ABIVERSION] identifies the version of the ABI[^ABI] to which the
object is targeted. This field is used to distinguish among incompatible
versions of an ABI. The interpretation of this version number is dependent on
the ABI identified by the EI_OSABI field. If no values are specified for the
EI_OSABI field for the processor, or no version values are specified for the
ABI determined by a particular value of the EI_OSABI byte, the value zero is
used to indicate unspecified.

**EI_PAD:**

This value marks the beginning of the unused bytes in e_ident. These bytes are
reserved and are set to zero. Programs that read object files should ignore
these values.

### `pu.3 Section Header`

``` text
typedef struct {
  elf32_Word  sh_name;
  Elf32_Word  sh_type;
  Elf32_Word  sh_flags;
  Elf32_Addr  sh_addr;
  Elf32_Off   sh_offset;
  Elf32_Word  sh_size;
  Elf32_Word  sh_link;
  Elf32_Word  sh_info;
  Elf32_Word  sh_addralign;
  Elf32_Word  sh_entsize;
} Elf32_Shdr;

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

`sh_name`
The name of the section. This members value is an index into the section header
string table section giving the location of a null-terminated string. Section
names and their descriptions are listed in
<a href="#tc1-section-names-elf64_shdrsh_name"> Tables Collection tc.1</a>.

`sh_type`
Categorizes the section's contents and semantics. Section types and their
descriptions are listed in
<a href="#tc2-section-type-elf64_shdrsh_type"> Tables Collection tc.2</a>.

`sh_flags`
Sections support 1-bit flags that describe miscellaneous attributes. Flag
definitions are listed in
<a href="#tc3-section-flag-elf64_shdrsh_flags"> Tables Collection tc.3</a>.

`sh_addr`
If the section appears in the memory image of a process, this member gives the
address at which the section's first byte should reside. Otherwise, the member
contains the value zero.

`sh_offset`
The byte offset from the beginning of the file to the first byte in the section.
For a SHT_NOBITS section, this member indicates the conceptual offset in the
file, as the section occupies no space in the file.

`sh_size`
The section's size in bytes. Unless the section type is SHT_NOBITS, the section
occupies sh_size bytes in the file. A section of type SHT_NOBITS can have a
nonzero size, but the section occupies no space in the file.

`sh_link`
A section header table index link, whose interpretation depends on the section
type. Details see
<a href="#tc4-section-link-elf64_shdrsh_link"> Tables Collection tc.4</a>.

tc.4 Section Link (Elf64_Shdr::sh_link)
tc.5 Section Info (Elf64_Shdr::sh_info)

`sh_info`
Extra information, whose interpretation depends on the section type. If the
sh_flags field for this section header includes the attribute SHF_INFO_LINK,
then this member represents a section header table index. Details See
<a href="#tc5-section-info-elf64_shdrsh_info"> Tables Collection tc.5</a>.

`sh_addralign`
Some sections have address alignment constraints. For example, if a section
holds a double-word, the system must ensure double-word alignment for the entire
section. In this case, the value of sh_addr must be congruent to 0, modulo the
value of sh_addralign. Currently, only 0 and positive integral powers of two are
allowed. Values 0 and 1 mean the section has no alignment constraints.

`sh_entsize`
Some sections hold a table of fixed-size entries, such as a symbol table. For
such a section, this member gives the size in bytes of each entry. The member
contains the value zero if the section does not hold a table of fixed-size
entries.

## `Tables Collection`

### `tc.1 Section Names (Elf64_Shdr::sh_name)`

| Name | Type | Attribute
| --- | --- | ---
| .bss                | SHT_NOBITS        | SHF_ALLOC + SHF_WRITE
| .comment            | SHT_PROGBITS      | None
| .data, .data1       | SHT_PROGBITS      | SHF_ALLOC + SHF_WRITE
| .dynamic            | SHT_DYNAMIC       | SHF_ALLOC + SHF_WRITE
| .dynstr             | SHT_STRTAB        | SHF_ALLOC
| .dynsym             | SHT_DYNSYM        | SHF_ALLOC
| .eh_frame_hdr       | SHT_AMD64_UNWIND  | SHF_ALLOC
| .eh_frame           | SHT_AMD64_UNWIND  | SHF_ALLOC + SHF_WRITE
| .fini               | SHT_PROGBITS      | SHF_ALLOC + SHF_EXECINSTR
| .fini_array         | SHT_FINI_ARRAY    | SHF_ALLOC + SHF_WRITE
| .got                | SHT_PROGBITS      | See Global Offset Table (Processor-Specific)
| .hash               | SHT_HASH          | SHF_ALLOC
| .init               | SHT_PROGBITS      | SHF_ALLOC + SHF_EXECINSTR
| .init_array         | SHT_INIT_ARRAY    | SHF_ALLOC + SHF_WRITE
| .interp             | SHT_PROGBITS      | See Program Interpreter
| .note               | SHT_NOTE          | None
| .lbss               | SHT_NOBITS        | SHF_ALLOC + SHF_WRITE + SHF_AMD64_LARGE
| .ldata, .ldata1     | SHT_PROGBITS      | SHF_ALLOC + SHF_WRITE + SHF_AMD64_LARGE
| .lrodata, .lrodata1 | SHT_PROGBITS      | SHF_ALLOC + SHF_AMD64_LARGE
| .plt                | SHT_PROGBITS      | See Procedure Linkage Table (Processor-Specific)
| .preinit_array      | SHT_PREINIT_ARRAY | SHF_ALLOC + SHF_WRITE
| .rela               | SHT_RELA          | None
| .relname            | SHT_REL           | See Relocation Sections
| .relaname           | SHT_RELA          | See Relocation Sections
| .rodata, .rodata1   | SHT_PROGBITS      | SHF_ALLOC
| .shstrtab           | SHT_STRTAB        | None
| .strtab             | SHT_STRTAB        | Refer to the explanation following this table.
| .symtab             | SHT_SYMTAB        | See Symbol Table Section
| .symtab_shndx       | SHT_SYMTAB_SHNDX  | See Symbol Table Section
| .tbss               | SHT_NOBITS        | SHF_ALLOC + SHF_WRITE + SHF_TLS
| .tdata, .tdata1     | SHT_PROGBITS      | SHF_ALLOC + SHF_WRITE + SHF_TLS
| .text               | SHT_PROGBITS      | SHF_ALLOC + SHF_EXECINSTR
| .SUNW_bss           | SHT_NOBITS        | SHF_ALLOC + SHF_WRITE
| .SUNW_cap           | SHT_SUNW_cap      | SHF_ALLOC
| .SUNW_capchain      | SHT_SUNW_capchain | SHF_ALLOC
| .SUNW_capinfo       | SHT_SUNW_capinfo  | SHF_ALLOC
| .SUNW_heap          | SHT_PROGBITS      | SHF_ALLOC + SHF_WRITE
| .SUNW_ldynsym       | SHT_SUNW_LDYNSYM  | SHF_ALLOC
| .SUNW_dynsymsort    | SHT_SUNW_symsort  | SHF_ALLOC
| .SUNW_dymtlssort    | SHT_SUNW_tlssort  | SHF_ALLOC
| .SUNW_move          | SHT_SUNW_move     | SHF_ALLOC
| .SUNW_reloc         | SHT_REL SHT_RELA  | SHF_ALLOC
| .SUNW_syminfo       | SHT_SUNW_syminfo  | SHF_ALLOC
| .SUNW_version       | SHT_SUNW_verdef SHT_SUNW_verneed SHT_SUNW_versym | SHF_ALL

### `tc.2 Section Type (Elf64_Shdr::sh_type)`

A section header's sh_type member specifies the section's semantics, as shown
in the following table.

| Name | Value
| --- | ---
| SHT_NULL          | 0
| SHT_PROGBITS      | 1
| SHT_SYMTAB        | 2
| SHT_STRTAB        | 3
| SHT_RELA          | 4
| SHT_HASH          | 5
| SHT_DYNAMIC       | 6
| SHT_NOTE          | 7
| SHT_NOBITS        | 8
| SHT_REL           | 9
| SHT_SHLIB         | 10
| SHT_DYNSYM        | 11
| SHT_INIT_ARRAY    | 14
| SHT_FINI_ARRAY    | 15
| SHT_PREINIT_ARRAY | 16
| SHT_GROUP         | 17
| SHT_SYMTAB_SHNDX  | 18
| SHT_LOOS          | 0x60000000
| SHT_LOSUNW        | 0x6fffffef
| SHT_SUNW_capchain | 0x6fffffef
| SHT_SUNW_capinfo  | 0x6ffffff0
| SHT_SUNW_symsort  | 0x6ffffff1
| SHT_SUNW_tlssort  | 0x6ffffff2
| SHT_SUNW_LDYNSYM  | 0x6ffffff3
| SHT_SUNW_dof      | 0x6ffffff4
| SHT_SUNW_cap      | 0x6ffffff5
| SHT_SUNW_SIGNATURE| 0x6ffffff6
| SHT_SUNW_ANNOTATE | 0x6ffffff7
| SHT_SUNW_DEBUGSTR | 0x6ffffff8
| SHT_SUNW_DEBUG    | 0x6ffffff9
| SHT_SUNW_move     | 0x6ffffffa
| SHT_SUNW_COMDAT   | 0x6ffffffb
| SHT_SUNW_syminfo  | 0x6ffffffc
| SHT_SUNW_verdef   | 0x6ffffffd
| SHT_SUNW_verneed  | 0x6ffffffe
| SHT_SUNW_versym   | 0x6fffffff
| SHT_HISUNW        | 0x6fffffff
| SHT_HIOS          | 0x6fffffff
| SHT_LOPROC        | 0x70000000
| SHT_SPARC_GOTDATA | 0x70000000
| SHT_AMD64_UNWIND  | 0x70000001
| SHT_HIPROC        | 0x7fffffff
| SHT_LOUSER        | 0x80000000
| SHT_HIUSER        | 0xffffffff

`SHT_NULL`
`SHT_PROGBITS`
`SHT_SYMTAB`
`SHT_STRTAB`
`SHT_RELA`
`SHT_HASH`
`SHT_DYNAMIC`
`SHT_NOTE`
`SHT_NOBITS`
`SHT_REL`
`SHT_SHLIB`
`SHT_DYNSYM`
`SHT_INIT_ARRAY`
`SHT_FINI_ARRAY`
`SHT_PREINIT_ARRAY`
`SHT_GROUP`
`SHT_SYMTAB_SHNDX`
`SHT_LOOS`
`SHT_LOSUNW`
`SHT_SUNW_capchain`
`SHT_SUNW_capinfo`
`SHT_SUNW_symsort`
`SHT_SUNW_tlssort`
`SHT_SUNW_LDYNSYM`
`SHT_SUNW_dof`
`SHT_SUNW_cap`
`SHT_SUNW_SIGNATURE`
`SHT_SUNW_ANNOTATE`
`SHT_SUNW_DEBUGSTR`
`SHT_SUNW_DEBUG`
`SHT_SUNW_move`
`SHT_SUNW_COMDAT`
`SHT_SUNW_syminfo`
`SHT_SUNW_verdef`
`SHT_SUNW_verneed`
`SHT_SUNW_versym`
`SHT_HISUNW`
`SHT_HIOS`
`SHT_LOPROC`
`SHT_SPARC_GOTDATA`
`SHT_AMD64_UNWIND`
`SHT_HIPROC`
`SHT_LOUSER`
`SHT_HIUSER`

### `tc.3 Section Flag (Elf64_Shdr::sh_flags)`

### `tc.4 Section Link (Elf64_Shdr::sh_link)`

### `tc.5 Section Info (Elf64_Shdr::sh_info)`

See <a href="#tc4-section-link-elf64_shdrsh_link"> Tables Collection tc.4</a>.

## `Examples`



## `Footnotes`

[^ELF]: Executable and Linking Format.

[^ABI]: Application Binary Interfaces.