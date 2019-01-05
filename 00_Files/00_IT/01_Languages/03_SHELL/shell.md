***
Reference from: 

- [x] GNU bash
- [x] Wikipedia

***
[TOC]
***

# `1. Introduction`
## `1.1 What is shell`

The shell has certain meaning:
​	1) application.
​	2) programming language.
​	3) shell script.

In computing, a shell is a user interface for access to an operating system's services. In general, operating system shells use either a command-line interface (CLI) or graphical user interface (GUI), depending on a computer's role and particular operation. It is named a shell because it is the outermost layer around the operating system kernel.

A Unix shell is both a command interpreter and a programming language. As a command interpreter, the shell provides the user interface to the rich set of gnu utilities. The programming language features allow these utilities to be combined. Files containing commands can be created, and become commands themselves. These new commands have the same status as system commands in directories such as /bin, allowing users or groups to establish custom environments to automate their common tasks.

A shell allows execution of gnu commands, both synchronously and asynchronously.
Shells also provide a small set of built-in commands (builtins) implementing functionality impossible or inconvenient to obtain via separate utilities.

Shells offer features geared specifically for interactive use rather than to augment the programming language. These interactive features include job control, command line editing, command history and aliases.

## `1.2 What is Bash`

Bash is the shell or command language interpreter, for the gnu operating system. The name is an acronym for the ‘Bourne-Again SHell’, a pun on Stephen Bourne, the author of the direct ancestor of the current Unix shell sh, which appeared in the Seventh Edition Bell Labs Research version of Unix.

Bash is largely compatible with sh and incorporates useful features from the Korn shell ksh and the C shell csh. It is intended to be a conformant implementation of the ieee posix Shell and Tools portion of the ieee posix specification (ieee Standard 1003.1). It offers functional improvements over sh for both interactive and programming use.

# `2. Definitions`

## `2.1 POSIX`

A family of open system standards based on Unix. Bash is primarily concerned with the Shell and Utilities portion of the posix 1003.1 standard.

## `2.2 blank`

A space or tab character.

## `2.3 bulitin`

A command that is implemented internally by the shell itself, rather than by an executable program somewhere in the file system.

## `2.4 control oprerator`

A token that performs a control function. It is a newline or one of the following:
||
&&
&
;
;;
;&
;;&
|
|&
(
)

## `2.5 exit status`

The value returned by a command to its caller. The value is restricted to eight bits, so the maximum value is 255.

## `2.6 field`

A unit of text that is the result of one of the shell expansions. After expansion, when executing a command, the resulting fields are used as the command name and arguments.

## `2.7 filename`

A string of characters used to identify a file.

## `2.8 job`

A set of processes comprising a pipeline, and any processes descended from it, that are all in the same process group.

## `2.9 job control`

A mechanism by which users can selectively stop (suspend) and restart (resume) execution of processes

## `2.a metacharacter`

A character that, when unquoted, separates words. A metacharacter is a space,
tab, newline, or one of the following characters:
|
&
;
(
)
<
\>

## `2.b name`

A word consisting solely of letters, numbers, and underscores, and beginning with a letter or underscore. Names are used as shell variable and function names. Also referred to as an identifier.

## `2.c operator`

A control operator or a redirection operator. Operators contain at least one unquoted metacharacter.

## `2.d process group`

A collection of related processes each having the same process group id.

## `2.e process group ID`

A unique identifier that represents a process group during its lifetime.

## `2.f reserved word`

A word that has a special meaning to the shell. Most reserved words introduce shell flow control constructs, such as for and while.

## `2.11 return status`

A synonym for exit status.

## `2.12 signal`

A mechanism by which a process may be notified by the kernel of an event occurring in the system.

## `2.13 special builtin`

A shell builtin command that has been classified as special by the posix standard.

## `2.14 token`

A sequence of characters considered a single unit by the shell. It is either a word or an operator

## `2.15 word`

A sequence of characters treated as a unit by the shell. Words may not include unquoted metacharacters.

# `3. Basic Shell Features`

Bash is an acronym for ‘Bourne-Again SHell’. The Bourne shell is the traditional Unix shell originally written by Stephen Bourne. ==All of the Bourne shell builtin commands are available in Bash==,The rules for evaluation and quoting are taken from the posix specification for the ‘standard’ Unix shell.

This chapter briefly summarizes the shell’s ‘building blocks’:
​    1) commands
​    2) control structures
​    3) shell functions
​    4) shell parameters
​    5) shell expansions
​    6) redirections, which are a way to direct input and output from and to named files
​    7) how the shell executes commands.

## `3.1 Shell Syntax`

When the shell reads input, it proceeds through a sequence of operations. If the input indicates the beginning of a comment, the shell ignores the comment symbol (‘#’), and the rest of that line. Otherwise, roughly speaking, 
​	1) the shell reads its input 
​	2) divides the input into words and operators
​	3) employing the quoting rules to select which meanings to assign various words and characters.
​	4) The shell then parses these tokens into commands and other constructs
​	5) removes the special meaning of certain words or characters
​	6) expands others
​	7) redirects input and output as needed
​	8) executes the specified command
​	9) waits for the command’s exit status, and makes that exit status available for further inspection or processing.

### `3.1.1 Shell Operation`

The following is a brief description of the shell’s operation when it reads and executes a command. Basically, the shell does the following:
​	1) Reads its input from a file, from a string supplied as an argument to the -c invocation option, or from the user’s terminal.
​	2) Breaks the input into words and operators, obeying the quoting rules described in [Quoting]. These tokens are separated by metacharacters. 			   			
​           Alias expansion is performed by this step.
​	3) Parses the tokens into simple and compound commands.
​	4) Performs the various shell expansions, breaking the expanded tokens into lists of filenames and commands and arguments.
​	5) Performs any necessary redirections and removes the redirection operators and their operands from the argument list.
​	6) Executes the command.
​	7) Optionally waits for the command to complete and collects its exit status.

### `3.1.2 Quoting`

Quoting is used to remove the special meaning of certain characters or words to the shell. Quoting can be used to disable special treatment for special characters, to prevent reserved words from being recognized as such, and to prevent parameter expansion.

There are three quoting mechanisms:
​	1) the escape character
​	2) single quotes
​	3) double quotes

#### `3.1.2.1 Escape Character`

A non-quoted backslash ‘\’ is the Bash escape character. It preserves the literal value of the next character that follows, with the ==exception of newline==. If a \newline pair appears, and the backslash itself is not quoted, the \newline is treated as a line continuation (that is, it is removed from the input stream and effectively ignored).

#### `3.1.2.2 Single Quotes`

Enclosing characters in single quotes (‘’’) preserves the literal value of each character within the quotes. A single quote may not occur between single quotes, even when preceded by a backslash.

[~]$ var='\r 123'
[~]$ echo $var
\r 123
[~]$ var='\n 123\n'
[~]$ echo $var
\n 123\n
[~]$ var='\n \t \v 123\n'
[~]$ echo $var
\n \t \v 123\n

#### `3.1.2.3 Double Quotes`

Enclosing characters in double quotes (‘"’) preserves the literal value of all characters within the quotes, with the exception of ==‘$’==, ==‘‘’==, ==‘\’==, and, when history expansion is enabled, ==‘!’==.
​	1) When the shell is in posix mode (see Section 6.11 [Bash POSIX Mode], page 96), the ‘!’ has no special meaning within double quotes, even
​           when history expansion is enabled.  
​	2) The characters ‘$’ and ‘‘’ retain their special meaning within double quotes.  
​	3) The backslash retains its special meaning only when followed by one of the following characters: ‘$’, ‘‘’, ‘"’, ‘\’, or newline, Within
​           double quotes, backslashes that are followed by one of these characters are removed.
​	4) Backslashes preceding characters without a special meaning are left unmodified.
​	5) A double quote may be quoted within double quotes by preceding it with a backslash.
​	6) If enabled, history expansion will be performed unless an ‘!’ appearing in double quotes is escaped using a backslash. The backslash
​           preceding the ‘!’ is not removed.
​	7) The special parameters ‘*’ and ‘@’ have special meaning when in double quotes (see Section 3.5.3 [Shell Parameter Expansion], page 23).

#### `3.1.2.4 ANSI-C Quoting`

Words of the form $’string’ are treated specially. The word expands to string, with backslash-escaped characters replaced as specified by the ANSI C standard. Backslash escape sequences, if present, are decoded as follows:
==\a== 
==\b== 
==\e== 
==\E== 
==\f== 
==\n== 
==\r== 
==\t== 
==\v== 
==\\\\== 
==\'== 
==\"== 
==\nnn==       the eight-bit character whose value is the octal value nnn (one to three digits)
==\xHH==       the eight-bit character whose value is the hexadecimal value HH (one or two hex digits)
==\uHHHH==     the Unicode (ISO/IEC 10646) character whose value is the hexadecimal value HHHH (one to four hex digits)
==\UHHHHHHHH== the Unicode (ISO/IEC 10646) character whose value is the hexadecimal value HHHHHHHH (one to eight hex digits)
==\cx==        a control-x character, control + special-character of x

[~]$ str=$'\a'
[~]$ echo $str  
[~]$ str=$'123\b'
[~]$ echo $str
123
[~]$ str=$'123\b\b'
[~]$ echo $str
123
[~]$ str=$'1\f23'
[~]$ echo $str
1
 23
[~]$ str=$'14\f23'
[~]$ echo $str
14
  23
[~]$ str=$'14\n23'
[~]$ echo $str
14 23
[~]$ str=$'14\n\n23'
[~]$ echo $str
14 23
[~]$ str=$'14\r23'
[~]$ echo $str
23
[~]$ str=$'1234\r56'
[~]$ echo $str
5634
[~]$ str=$'1234\t56'
[~]$ echo $str
1234 56
[~]$ str=$'\t1'
[~]$ echo $str
1
[~]$ echo $str
1
 1
[~]$ str=$'12\\123\\\\'
[~]$ echo $str
12\123\\\\
[~]$ str=$'\' \"'
[~]$ echo $str
' "
[~]$ str=$' \255 \256 \999 \xff \xFF \u1111 \u12345 \U12345678 \U123456789 '
[~]$ echo $str
� � \999 � � ᄑ ሴ5 ������ ������9
[~]$ str=$' \101 \x41 \u0041 \u6211'
[~]$ echo $str
A A A 我
[~]$ str=$'\cv'
[~]$ echo $str


#### `3.1.2.5 Locale-Specific Translation`

### `3.1.3 Comments`

A word beginning with ‘#’ causes that word and all remaining characters on that line to be ignored.
An interactive shell without the interactive_comments option enabled does not allow comments. The interactive_comments option is on by default in interactive shells

## `3.2 Shell Commands`

A simple shell command such as ==echo a b c== consists of the command itself followed by arguments, separated by spaces.

More complex shell commands are composed of simple commands arranged together in a variety of ways:
​	1) in a pipeline in which the output of one command becomes the input of a second
​	2) in a loop or conditional construct
​	3) in some other grouping

### `3.2.1 Simple Commands`

A simple command is the kind of command encountered most often. It’s just a sequence of words separated by blanks, terminated by one of the shell’s control operators (see Chapter 2 [Definitions], page 3). The first word generally specifies a command to be executed, with the rest of the words being that command’s arguments.

The return status (see Section 3.7.5 [Exit Status], page 39) of a simple command is its exit status as provided by the posix 1003.1 waitpid function, or 128+n if the command was terminated by signal n.

### `3.2.2 Pipelines`

A pipeline is a sequence of one or more commands separated by one of the control operators ==|== or ==|&==.

The format for a pipeline is
​	`[time [-p]][!] command1 [ | or |& command2 ] ...` 

The output of each command in the pipeline is connected via a pipe to the input of the next command. That is, each command reads the previous command’s output. This connection is performed before any redirections specified by the command.

If ‘|&’ is used, command1’s standard error, in addition to its standard output, is connected to command2’s standard input through the pipe; it is shorthand for 2>&1 |. This implicit redirection of the standard error to the standard output is performed after any redirections specified by the command.

The reserved word time causes timing statistics to be printed for the pipeline once it finishes. The statistics currently consist of elapsed (wall-clock) time and user and system time consumed by the command’s execution.

The -p option changes the output format to that specified by posix.

Each command in a pipeline is executed in its own subshell (see Section 3.7.3 [Command Execution Environment], page 37). The exit status of a pipeline is the exit status of the last command in the pipeline, unless the pipefail option is enabled (see Section 4.3.1 [The Set Builtin], page 60). If pipefail is enabled, the pipeline’s return status is the value of the last (rightmost) command to exit with a non-zero status, or zero if all commands exit successfully. If the reserved word ‘!’ precedes the pipeline, the exit status is the logical negation of the exit status as described above. The shell waits for all commands in the pipeline to terminate before returning a value.

### `3.2.3 Lists of Commands`

A list is a sequence of one or more pipelines separated by one of the operators ==;== ==&== ==&&== ==||== and optionally terminated by one of ==;== ==&==, or a newline.

Of these list operators, ‘&&’ and ‘||’ have equal precedence, followed by ‘;’ and ‘&’, which have equal precedence.

A sequence of one or more newlines may appear in a list to delimit commands, equivalent to a semicolon.

If a command is terminated by the control operator ‘&’, the shell executes the command asynchronously in a subshell. This is known as executing the command in the background. The shell does not wait for the command to finish, and the return status is 0 (true). When job control is not active (see Chapter 7 [Job Control], page 100), the standard input for asynchronous commands, in the absence of any explicit redirections, is redirected from
/dev/null.

Commands separated by a ‘;’ are executed sequentially; the shell waits for each command to terminate in turn. The return status is the exit status of the last command executed.

and and or lists are sequences of one or more pipelines separated by the control operators ‘&&’ and ‘||’, respectively. and and or lists are executed with left associativity.
An and list has the form:
​	`command1 && command2`
command2 is executed if, and only if, command1 returns an exit status of zero(right).
An or list has the form:
​	`command1 || command2`
command2 is executed if, and only if, command1 returns a non-zero(error) exit status.
The return status of and and or lists is the exit status of the last command executed in the list.

### `3.2.4 Compound Commands`

Compound commands are the shell programming constructs. Each construct begins with a reserved word or control operator and is terminated by a corresponding reserved word or operator.

Bash provides looping constructs, conditional commands, and mechanisms to group commands and execute them as a unit.

#### `3.2.4.1 Looping Constructs`

Bash supports the following looping constructs. Note that wherever a ‘;’ appears in the description of a command’s syntax, it may be replaced with one or more newlines.

The break and continue builtins (see Section 4.1 [Bourne Shell Builtins], page 42) may be used to control loop execution.

##### `until`

The syntax of the until command is:
​	`until test-commands; do consequent-commands; done`  (理解:直到测试命令成功为止)

Execute consequent-commands ==as long as== test-commands has an exit status which is not zero. The return status is the exit status of the last command
executed in consequent-commands, or zero if none was executed.

```
[~]$ until mkdir /1; do ls; done
mkdir: cannot create directory ‘/1’: Permission denied
Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
mkdir: cannot create directory ‘/1’: Permission denied
Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
...
[~]$ until mkdir 1.sh; do ls; done
[~]$ ls
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
```

##### `while`

The syntax of the while command is:
​	`while test-commands; do consequent-commands; done` (理解:当测试命令成功,执行do命令)

Execute consequent-commands ==as long as== test-commands has an exit status of zero. The return status is the exit status of the last command executed in
consequent-commands, or zero if none was executed.

```
[~]$ var=1; while (($var<=5)); do ls; echo "var=$var"; ((var++)); done
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
var=1
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
var=2
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
var=3
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
var=4
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
var=5
```

##### `for`

The syntax of the for command is:
​	`for name [ [in [words ...] ] ; ] do commands; done`

Expand words, and execute commands once for each member in the resultant list, with name bound to the current member. If ‘in words’ is not present, the
for command executes the commands once for each positional parameter that is set, as if ‘in "$@"’ had been specified (see Section 3.4.2 [Special Parameters], page 20). The return status is the exit status of the last command that executes. If there are no items in the expansion of words, no commands are executed, and the return status is zero.

```
[~]$ for i in 1 2 3 4 5; do echo "i=$i"; ls; done
i=1
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
i=2
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
i=3
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
i=4
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
i=5
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
```

An alternate form of the for command is also supported:
​	`for (( expr1 ; expr2 ; expr3 )) ; do commands ; done`

First, the arithmetic expression expr1 is evaluated according to the rules described below (see Section 6.5 [Shell Arithmetic], page 89). The arithmetic expression expr2 is then evaluated repeatedly until it evaluates to zero. Each time expr2 evaluates to a non-zero value, commands are executed and the arithmetic expression expr3 is evaluated. If any expression is omitted, it behaves as if it evaluates to 1. The return value is the exit status of the last command in commands that is executed, or false if any of the expressions is invalid.

```
[~]$ for (( i=1; i<5; i++ )); do echo "i=$i"; ls; done
i=1
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
i=2
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
i=3
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
i=4
1.sh  Desktop  Documents  Downloads  muduo  Music  Pictures  Public  Templates  Videos
```

#### `3.2.4.2 Conditional Constructs `

#### `3.2.4.3 Grouping Commands `

### `3.2.5 Coprocesses`

### `3.2.6 GNU Parallel`

## `3.3 Shell Functions`

## `3.4 Shell Parameters`



## `3.5 Shell Expansions`

Expansion is performed on the command line after it has been split into tokens. There are seven kinds of expansion performed:
​	1) brace expansion
​	2) tilde expansion
​	3) parameter and variable expansion
​	4) command substitution
​	5) arithmetic expansion
​	6) word splitting
​	7) filename expansion

The order of expansions is: brace expansion; tilde expansion, parameter and variable expansion, arithmetic expansion, and command substitution (done in a left-to-right fashion); word splitting; and filename expansion.

On systems that can support it, there is an additional expansion available: process
substitution. This is performed at the same time as tilde, parameter, variable, and arithmetic expansion and command substitution.

After these expansions are performed, quote characters present in the original word are
removed unless they have been quoted themselves (quote removal).

Only brace expansion, word splitting, and filename expansion can change the number
of words of the expansion; other expansions expand a single word to a single word. The
only exceptions to this are the expansions of "$@" (see Section 3.4.2 [Special Parameters],
page 20) and "${name[@]}" (see Section 6.7 [Arrays], page 91).

After all expansions, quote removal (see Section 3.5.9 [Quote Removal], page 32) is performed.

### `3.5.1 Brace Expansion`

Brace expansion is a mechanism by which arbitrary strings may be generated. This mechanism is similar to filename expansion (see Section 3.5.8 [Filename Expansion], page 30), but the filenames generated need not exist. Patterns to be brace expanded take the form of an ==optional preamble==, followed by either ==a series of comma-separated strings or a sequence
expression== between a pair of braces, followed by ==an optional postscript==. The preamble is
prefixed to each string contained within the braces, and the postscript is then appended to
each resulting string, expanding left to right.

Brace expansions may be nested. The results of each expanded string are not sorted; left to right order is preserved.

Brace expansion is performed before any other expansions, and any characters special to other expansions are preserved in the result. It is strictly textual. Bash does not apply
any syntactic interpretation to the context of the expansion or the text between the braces. To avoid conflicts with parameter expansion, the string ‘${’ is not considered eligible for brace expansion.

1) A correctly-formed brace expansion must contain unquoted opening and closing braces.
2) At least one unquoted comma or a valid sequence expression.
3) A { or ‘,’ may be quoted with a backslash to prevent its being considered part of a
   brace expression.
4) space can not occur in every part,if do that, please quote them use quotation sign pair.
5) To avoid conflicts with parameter expansion, the string ‘${’ is not considered eligible 
   for brace expansion.

​	`[preamble]{1,2,3,...,N}[postscript]`
​	`[preamble]{x..y[..incr]}[postscript]`

```
[~]$ echo a{}b
a{}b
[~]$ echo a{,}b
ab ab
[~]$ echo a{\,}b
a{,}b
[~]$ echo a{\,,}b
a,b ab
[~]$ echo a{},}b
a}b ab
[~]$ echo a{\\},}b
a}b ab
[~]$ echo a{{,}b
a{b a{b
[~]$ echo a{\\{,}b
a{b ab
[~]$ echo a{1,2, 3}b
a{1,2, 3}b
```

```
[~]$ echo a{1,2,3}b
a1b a2b a3b
[~]$ echo a{1..10..1}b
a1b a2b a3b a4b a5b a6b a7b a8b a9b a10b
[~]$ echo a{1..10..2}b
a1b a3b a5b a7b a9b
[~]$ echo a{1..-10..2}b
a1b a-1b a-3b a-5b a-7b a-9b
[~]$ echo +{a..d}+
+a+ +b+ +c+ +d+
[~]$ echo +{a..c}{1..3}+
+a1+ +a2+ +a3+ +b1+ +b2+ +b3+ +c1+ +c2+ +c3+
[~]$ echo +{{a..c}{1..3}}+
+{a1}+ +{a2}+ +{a3}+ +{b1}+ +{b2}+ +{b3}+ +{c1}+ +{c2}+ +{c3}+
[~]$ echo +{{a..c},{1..3}}+
+a+ +b+ +c+ +1+ +2+ +3+
[~]$ mkdir  /home/eit/{1,2,3,4}
[~]$ rm -rf /home/eit/{1,2,3,4}
```

### `3.5.2 Tilde Expansion`

If a word begins with an unquoted tilde character (‘~’), all of the characters up to the first unquoted slash (or all characters, if there is no unquoted slash) are considered a tilde-prefix. If none of the characters in the tilde-prefix are quoted, the characters in the tilde-prefix following the tilde are treated as a possible login name. If this login name is the null string, the tilde is replaced with the value of the HOME shell variable. If HOME is unset, the home directory of the user executing the shell is substituted instead. Otherwise, the tilde-prefix is replaced with the home directory associated with the specified login name.

If the tilde-prefix is ‘~+’, the value of the shell variable PWD replaces the tilde-prefix. If the tilde-prefix is ‘~-’, the value of the shell variable OLDPWD, if it is set, is substituted.

```
[~/Desktop/cups]$ pwd
/home/eit/Desktop/cups
[~/Desktop/cups]$ echo ~+
/home/eit/Desktop/cups
[~/Desktop/cups]$ echo ~-
/home/eit/Desktop
[~/Desktop/cups]$ echo ~
/home/eit
```

### `3.5.3 Shell Parameter Expansion`

The ‘$’ character introduces parameter expansion, command substitution, or arithmetic
expansion. The parameter name or symbol to be expanded may be ==enclosed== in braces, which
are optional but serve to ==protect== the variable to be expanded from characters immediately following it which could be interpreted as part of the name.

When braces are used, the matching ending brace is the first ‘}’ not escaped by a backslash or within a quoted string, and not within an embedded arithmetic expansion, command substitution, or parameter expansion.

The basic form of parameter expansion is:
​	`${parameter}`

The braces are required when parameter is a positional parameter with more than one digit,
or when parameter is followed by a character that is not to be interpreted as part of its name.

In each of the cases below, word is subject to tilde expansion, parameter expansion, command substitution, and arithmetic expansion.

When not performing substring expansion, using the form described below (e.g., ‘:-’),
Bash tests for a parameter that is unset or null. 
  1) colon:  parameter that is null.
  2) hyphen: parameter that is unset.
​	`${parameter-word}`   
​	(if parameter is unset, take value from word)
​	`${parameter:-word}`  
​	(if parameter is unset or null, take value from word)

#### `3.5.3.1 ${parameter:−word}`

If parameter is unset or null, the expansion of word is substituted. Otherwise, the value of parameter is substituted.

```
[~]$ echo ${unsetString-"hyphen test whether this is a unset variable"}
hyphen test whether this is a unset variable  
[~]$ echo ${unsetString:"hyphen test whether this is a unset variable"}
[~]$ unset unsetString
[~]$ var=123
[~]$ echo ${unsetString-$var}
123
[~]$ nullString=
[~]$ echo ${nullString}
[~]$ echo ${nullString-"nullString is set"}
[~]$ echo ${nullString:-dk}
dk
```

#### `3.5.3.2 ${parameter:=word}`

If parameter is unset or null, the expansion of word is assigned to parameter. The value of parameter is then substituted. Positional parameters and special parameters may not be assigned to in this way.

```
[~]$ unset var
[~]$ echo ${var:=assignment}
assignment
[~]$ echo ${var}
assignment
```

#### `3.5.3.3 ${parameter:?word}`

If parameter is null or unset, the expansion of word (or a message to that effect, if word is not present) is written to the standard error and the shell, if it is not interactive, exits. Otherwise, the value of parameter is substituted.

```
[~]$ unset var
[~]$ echo ${var:?newValue}
bash: var: newValue
[~]$ echo ${var}
```

#### `3.5.3.4 ${parameter:+word}`

If parameter is null or unset, nothing is substituted, otherwise the expansion of word is substituted.

```
[~]$ var=123
[~]$ echo ${var:+456}
456
[~]$ echo $var
123
```

#### `3.5.3.5 ${parameter:offset}`

#### `3.5.3.6 ${parameter:offset:length}`

This is referred to as Substring Expansion. 

#### `3.5.3.7 ${!prefix*}`

#### `3.5.3.8 ${!prefix@}`
#### `3.5.3.9 ${!name[@]}`

#### `3.5.3.A ${!name[*]}`
#### `3.5.3.B ${#parameter}`

The length in characters of the expanded value of parameter is substituted.

#### `3.5.3.C ${parameter#word}`

#### `3.5.3.D ${parameter##word}`

The word is expanded to produce a pattern.If the pattern matches the beginning of the expanded value of parameter, then the result of the expansion is the expanded value of parameter with the shortest matching pattern (the ‘#’ case) or the longest matching pattern (the ‘##’ case) deleted.
```
[~]$ var=http.www.baidu.com
[~]$ echo ${var#.}
http.www.baidu.com
[~]$ echo ${var#*.}
www.baidu.com
[~]$ echo ${var##.}
http.www.baidu.com
[~]$ echo ${var##*.}
com
```

#### `3.5.3.E ${parameter%word}`

#### `3.5.3.F ${parameter%%word}`

The word is expanded to produce a pattern. If the pattern matches a trailing portion of the expanded value of parameter, then the result of the expansion is the value of parameter with the shortest matching pattern (the ‘%’ case) or the longest matching pattern (the ‘%%’ case) deleted.

```
[~]$ var=http.www.baidu.com
[~]$ echo ${var%*.}
http.www.baidu.com
[~]$ echo ${var%.*}
http.www.baidu
[~]$ echo ${var%%.*}
http
[~]$ echo ${var%%*.}
http.www.baidu.com

[~]$ var=http.www.baidu.com.
[~]$ echo ${var%%*.}
[~]$ echo ${var%%.*}
http
```

#### `3.5.3.G ${parameter/pattern/string}`

The pattern is expanded to produce a pattern. Parameter is expanded and the longest match of pattern against its value is replaced with string.

```
[~]$ var=http.www.baidu.com.
[~]$ echo ${var/.*./123}
http123
[~]$ echo ${var/baidu/google}
http.www.google.com.
```

#### `3.5.3.H ${parameter^pattern}`

#### `3.5.3.I ${parameter^^pattern}`

#### `3.5.3.J ${parameter,pattern}`

#### `3.5.3.K ${parameter,,pattern}`

This expansion modifies the case of alphabetic characters in parameter. The pattern is expanded to produce a pattern. Each character in the expanded value of parameter is tested against pattern, and, if it matches the pattern, its case is converted.  The pattern should not attempt to match more than one character.
  1) Just convert the first character:
​     The ‘^’ operator converts lowercase letters matching pattern to uppercase.  
​     The ‘,’ operator converts matching uppercase letters to lowercase.
  2) convert all characters:
​     The ‘^^’ operator converts lowercase letters matching pattern to uppercase.  
​     The ‘,,’ operator converts matching uppercase letters to lowercase.
If pattern is omitted, it is treated like a ‘?’, which matches every character. The ‘^’ and ‘,’ expansions match and convert only the first character in the expanded value. The ‘^^’ and ‘,,’ expansions convert each matched character in the expanded value.

```
[~]$ var=abcdefghijkABCDEFGHIJK
[~]$ echo ${var^}
AbcdefghijkABCDEFGHIJK
[~]$ echo ${var^a}
AbcdefghijkABCDEFGHIJK
[~]$ echo ${var^b}
abcdefghijkABCDEFGHIJK

[~]$ var=abcdefghijkABCDEFGHIJK
[~]$ echo ${var^^}
ABCDEFGHIJKABCDEFGHIJK
[~]$ echo ${var^^a}
AbcdefghijkABCDEFGHIJK
[~]$ echo ${var^^ab}
abcdefghijkABCDEFGHIJK

[~]$ var=ABCDEFGHIJKabcdefghijk
[~]$ echo ${var,,}
abcdefghijkabcdefghijk
[~]$ echo ${var,a}
ABCDEFGHIJKabcdefghijk
[~]$ echo ${var,A}
aBCDEFGHIJKabcdefghijk
[~]$ echo ${var,B}
ABCDEFGHIJKabcdefghijk
```

#### `3.5.3.L ${parameter@operator}`

The expansion is either a transformation of the value of parameter or information about parameter itself, depending on the value of operator. Each operator is a single letter:
1) `Q`
The expansion is a string that is the value of parameter quoted in a format that can be reused as input.
2) `E`
The expansion is a string that is the value of parameter with backslash escape sequences expanded as with the $’...’ quoting mechansim.
3) `P`
The expansion is a string that is the result of expanding the value of parameter as if it were a prompt string (see Section 6.9 [Controlling the Prompt], page 94).
4) `A`
The expansion is a string in the form of an assignment statement or declare command that, if evaluated, will recreate parameter with its attributes and value.
5) `a`
The expansion is a string consisting of flag values representing parameter’s attributes.

### `3.5.4 Command Substitution`

bash:
Command substitution allows the output of a command to replace the command itself.
Wikipedia:
In computing, command substitution is a facility that allows a command to be run and its output to be pasted back on the command line as arguments to another command.

Command substitution occurs when a command is enclosed as follows:
```
$(command)
`command`
```

```
[~]$ for f in $(ls ~); do echo $f; done
Desktop
Documents
Downloads
muduo
Music
Pictures
Public
Templates
Videos
[~]$ for f in `ls ~`; do echo $f; done
Desktop
Documents
Downloads
muduo
Music
Pictures
Public
Templates
Videos
```

### `3.5.5 Arithmetic Expansion`

Arithmetic expansion allows the evaluation of an arithmetic expression and the substitution
of the result. The format for arithmetic expansion is:
​	`$(( expression ))`

The expression is treated as if it were within double quotes, but a double quote inside the parentheses is not treated specially. All tokens in the expression undergo parameter and variable expansion, command substitution, and quote removal. The result is treated as the arithmetic expression to be evaluated. Arithmetic expansions may be nested.

The evaluation is performed according to the rules listed below (see Section 6.5 [Shell
Arithmetic], page 89). If the expression is invalid, Bash prints a message indicating failure to the standard error and no substitution occurs.

### `3.5.6 Process Substitution`

### `3.5.7 Word Splitting`

### `3.5.8 Filename Expansion`

#### `3.5.8.1 Pattern Matching`



### `3.5.9 Quote Removal`

## `3.6 Redirections`

## `3.7 Executing Commands`

## `3.8 Shell Scripts`
  ```

  ```