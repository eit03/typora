***
[toc]
***

# `linux-ubuntu-x64`

## `x64 code`

``` text
int fun(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8)
{ return a1+a2; }

104 [1]    fun(1, 2, 3, 4,5,6,7,8);
0x5592ea956f04  <+40>    6a 08                pushq  $0x8
0x5592ea956f06  <+42>    6a 07                pushq  $0x7
0x5592ea956f08  <+44>    41 b9 06 00 00 00    mov    $0x6,%r9d
0x5592ea956f0e  <+50>    41 b8 05 00 00 00    mov    $0x5,%r8d
0x5592ea956f14  <+56>    b9 04 00 00 00       mov    $0x4,%ecx
0x5592ea956f19  <+61>    ba 03 00 00 00       mov    $0x3,%edx
0x5592ea956f1e  <+66>    be 02 00 00 00       mov    $0x2,%esi
0x5592ea956f23  <+71>    bf 01 00 00 00       mov    $0x1,%edi
0x5592ea956f28  <+76>    e8 8d ff ff ff       callq  0x5592ea956eba
0x5592ea956f2d  <+81>    48 83 c4 10          add    $0x10,%rsp

arg7: push $0x8
arg6: push $0x7
arg5: push $r9
arg4: push $r8
arg3: push $rcx
arg2: push $rdx
arg1: push $rsi
arg0: push $rdi
```

``` text
class Object
{
public:
    int fun(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8)
    { return a1+a2; }
};

121 [1]    obj.fun(1, 2, 3, 4,5,6,7,8);
0x562e375c0f31  <+ 85>    48 8d 85 ff fe ff ff     lea    -0x101(%rbp),%rax
0x562e375c0f38  <+ 92>    48 83 ec 08              sub    $0x8,%rsp
0x562e375c0f3c  <+ 96>    6a 08                    pushq  $0x8
0x562e375c0f3e  <+ 98>    6a 07                    pushq  $0x7
0x562e375c0f40  <+100>    6a 06                    pushq  $0x6
0x562e375c0f42  <+102>    41 b9 05 00 00 00        mov    $0x5,%r9d
0x562e375c0f48  <+108>    41 b8 04 00 00 00        mov    $0x4,%r8d
0x562e375c0f4e  <+114>    b9 03 00 00 00           mov    $0x3,%ecx
0x562e375c0f53  <+119>    ba 02 00 00 00           mov    $0x2,%edx
0x562e375c0f58  <+124>    be 01 00 00 00           mov    $0x1,%esi
0x562e375c0f5d  <+129>    48 89 c7                 mov    %rax,%rdi
0x562e375c0f60  <+132>    e8 05 04 00 00           callq  0x562e375c136a
0x562e375c0f65  <+137>    48 83 c4 20              add    $0x20,%rsp

arg7: push $0x8
arg6: push $0x7
arg5: push $0x6
arg4: push $r9
arg3: push $r8
arg2: push $rcx
arg1: push $rdx
arg0: push $rsi
this: push $rdi
```