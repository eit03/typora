***
[toc]
***


# `Data-written breakpoint`
`watch [-l|-location] expr [thread thread-id] [mask maskvalue]`

GDB will break when the expression **expr** is written into by the program
and its value changes. In a nutshell, GDB will break when value of the address
**expr** had changed.

# `Data-read breakpoint`
`rwatch [-l|-location] expr [thread thread-id] [mask maskvalue]`

Set a watchpoint that will break when the value of expr is read by the program.

# `Data-accessed breakpoint`
`awatch [-l|-location] expr [thread thread-id] [mask maskvalue]`

Set a watchpoint that will break when expr is either read from or written into
by the program.

# `Examine data breakpoint`
`info watchpoints [list...]`

This command prints a list of watchpoints, using the same format as info break.
