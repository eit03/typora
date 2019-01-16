***
[TOC]
***

# `5.Stopping and Continuing`

## `5.1 Breakpoints, Watchpoints, and Catchpoints`

A breakpoint makes your program stop whenever a certain point in the program is reached. For each breakpoint, you can add conditions to control in finer detail whether your program stops. You can set breakpoints with the break command and its variants (see Section 5.1.1 [Setting Breakpoints], page 48), to specify the place where your program should stop by line number, function name or exact address in the program.

On some systems, you can set breakpoints in shared libraries before the executable is run.



A watchpoint is a special breakpoint that stops your program when the value of an expression changes. The expression may be a value of a variable, or it could involve values of one or more variables combined by operators, such as ‘a + b’. This is sometimes called data breakpoints. You must use a different command to set watchpoints (see Section 5.1.2 [Setting Watchpoints], page 54), but aside from that, you can manage a watchpoint like any other breakpoint: you enable, disable, and delete both breakpoints and watchpoints using the same commands.

You can arrange to have values from your program displayed automatically whenever gdb stops at a breakpoint. See Section 10.7 [Automatic Display], page 130.



A catchpoint is another special breakpoint that stops your program when a certain kind of event occurs, such as the throwing of a C++ exception or the loading of a library. As with watchpoints, you use a different command to set a catchpoint (see Section 5.1.3 [Setting Catchpoints], page 56), but aside from that, you can manage a catchpoint like any other breakpoint. (To stop when your program receives a signal, use the handle command; see Section 5.4 [Signals], page 76.)

#  `25. GDB Text User Interface`

The gdb Text User Interface (TUI) is a terminal interfac to show infos in separate text windows:
  1) source file
  2) assembly output
  3) program registers
  4) gdb commands

The TUI mode is supported only on platforms where a suitable version of the curses library is available.

The TUI mode is enabled by default when you invoke gdb as ‘gdb -tui’. You can also switch in and out of TUI mode while gdb runs by using various TUI commands and key bindings, such as tui enable or C-x C-a.
  1) gdb -tui
  2) ctl-x a

## `25.1 TUI Overview`

In TUI mode, gdb can display several text windows:
  1) command:  This window is the gdb command window with the gdb prompt and 
               the gdb output. The gdb input is still managed using readline.
  2) source:   The source window shows the source file of the program. The
               current line and active breakpoints are displayed in this 
               window. 
  3) assembly: The assembly window shows the disassembly output of the
               program. 
  4) register: This window shows the processor registers. Registers are
               highlighted when their values change. 
