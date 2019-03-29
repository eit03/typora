***
`Title:` Signal
`Reference:` [POSIX:Signal](http://pubs.opengroup.org/onlinepubs/9699919799/nframe.html)
***
[toc]
***

# `1. Signal Concepts`

## `1.1. Signal`

A signal is said to be "generated" for (or sent to) a process or thread when the
event that causes the signal first occurs.

## `1.2. Pending Signal`

Pending is a status that signal was be generated but does not be cancellation.

## `1.3. Block Signal`

Block is a process method of signal, signal will remain in queue, but does not
preform action, it has a status of pending. It is diff to ignore, ignore means
that signal is accepted, and preform ignore action.

## `1.4. Signal Mask`

Set of block signals.

**Note:** Each thread has a "signal mask" that defines the set of signals
currently blocked from delivery to it. The signal mask for a thread shall be
initialized from that of its parent or creating thread, or from the
corresponding thread in the parent process if the thread was created as the
result of a call to fork(). The pthread_sigmask(), sigaction(), sigprocmask(),
and sigsuspend() functions control the manipulation of the signal mask.

## `1.5. Signal Set`

Set of some signals.

## `1.6 Realtime Signal`

Realtime Signal are also known as Reliable Signal. So, signal can be classified
as Rliable Signal and Unreliable Signal.

Realtime Signal is not discard when same signal come, it has the range of
SIGRTMIN ~ SIGRTMAX

## `1.7. Action`

A function who will handle the associated signal.

## `1.8. Queue`

Queue that Store signals.

## `Catch Signal`

On delivery of the signal, the receiving process is to execute the
signal-catching function at the specified address. After returning from the
signal-catching function, the receiving process shall resume execution at the
point at which it was interrupted.

## `Interrupt`

System call maybe be Interrupted. Such as recv(), it is directly returned and be
a errno EINTR.
We can set SA_RESTART to signal, then, the the invocation interrupted will be
auto restart. but, Not all invocation can do that.

## `Signal Invocation`

程序运行在用户态时 ->
进程由于系统调用或中断进入内核 ->
转向用户态执行信号处理函数 ->
信号处理函数完毕后进入内核 ->
返回用户态继续执行程序

# `2. Signals Marco Defination`

See <a href="#tc1-signals-marco-defination"> Table Collection tc.1</a>.

**Note:** SIGKILL and SIGSTOP can not be cuptured, signal() will be SIG_ERR returned
if do that; signal that 32 and 33 is not define, signal() will be SIG_ERR
returned if do that, program will be exited for unknown signal if do that.

# `3. Signal Functions`

## `signal()`

```text
void *signal(int sig,
             void (*func)(int)));
```

Signal management.

## `sigset`

```
void sigset(int sig,
            void (*disp)(int)));
```

modify signal dispositions.

## `sigaction()`

`Brief`
Get and/or set the action for signal SIG.

`Syntax`

```text
int sigaction(int sig,
              const struct sigaction *restrict act,
              struct sigaction *restrict oact);
```

`Params`

@param sig
signal number.

@param act
If the @param act is not a null pointer, it points to a structure specifying
the action to be associated with the specified signal @param sig. If the @param
oact is not a null pointer, the action previously associated with the signal is
stored in the location pointed to by the @param oact.
If the @param act is a null pointer, signal handling is unchanged; thus, the
call can be used to enquire about the current handling of a given signal. Detail
See <a href="#pu2-struct-sigaction"> Table Collection pu.2</a>.

@param oact
Get current handling of a given signal when @param act is a null pointer, else,
get previously handling.

`Return`
returns 0 on success; on error, -1 is returned, and errno is set to indicate the
error.

## `sigaddset()`


```text
int sigaddset(sigset_t *set, int signo);
```

Add signal @param signo to signal set @param set.

## `sigdelset()`


```text
int sigdelset(sigset_t *set, int signo);
```

Delete signal @param signo from signal set @param set.

## `sigemptyset`

```
int sigemptyset(sigset_t *set);
```

Initialize and empty a signal set @param set.

## `sigfillset`

```
int sigfillset(sigset_t *set);
```

Initialize and fill a signal set @param set.

## `sigismember`

```
int sigismember(const sigset_t *set, int signo);
```

test for a signal @param sig in a signal @param set.

## `sighold`

```
int sighold(int sig);
```

add @param sig to the signal mask of the calling process.

## `sigrelse`

```
int sigrelse(int sig);
```

remove @param sig from the signal mask of the calling process.

## `sigignore`

```
int sigignore(int sig);
```

set the disposition of @param sig to SIG_IGN.

## `sigpause`

```
int sigpause(int sig);
```

remove @param sig from the signal mask of the calling process and suspend the
calling process until a signal is received. The sigpause() function shall
restore the signal mask of the process to its original state before returning.

## `sigsuspend`

```
int sigsuspend(const sigset_t *sigmask);
```

Replace the current signal mask of the calling thread with the set of signals
pointed to by @param sigmask, then suspend the thread until delivery of a signal
whose action is either to execute a signal-catching function or to terminate the
process. This shall not cause any other signals that may have been pending on
the process to become pending on the thread.

## `sigwait`

```
int sigwait(const sigset_t *restrict set, int *restrict sig);
```

Select a pending signal from @param set, atomically clear it from the system's
set of pending signals, and return that signal number in the location referenced
by @param sig.
If prior to the call to sigwait() there are multiple pending instances of a
single signal number, it is implementation-defined whether upon successful
return there are any remaining pending signals for that signal number. If the
implementation supports queued signals and there are multiple signals queued for
the signal number selected, the first such queued signal shall cause a return
from sigwait() and the remainder shall remain queued. If no signal in @param set
is pending at the time of the call, the thread shall be suspended until one or
more becomes pending. The signals defined by @param set shall have been blocked
at the time of the call to sigwait(); otherwise, the behavior is undefined. The
effect of sigwait() on the signal actions for the signals in @param set is
unspecified.

## `sigwaitinfo`

```
int sigwaitinfo(const sigset_t *restrict set, siginfo_t *restrict info);
```

Selects the pending signal from the set specified by @param set. Should any of
multiple pending signals in the range SIGRTMIN to SIGRTMAX be selected, it shall
be the lowest numbered one. The selection order between realtime and
non-realtime signals, or between multiple pending non-realtime signals, is
unspecified. If no signal in @param set is pending at the time of the call, the
calling thread shall be suspended until one or more signals in @param set become
pending or until it is interrupted by an unblocked, caught signal.

## `sigtimedwait`

```
int sigtimedwait(const sigset_t *restrict set,
                 siginfo_t *restrict info,
                 const struct timespec *restrict timeout);
```

## `sigaltstack`

```
int sigaltstack(const stack_t *restrict ss, stack_t *restrict oss);
```

set and get signal alternate stack context.

# `Parallel Universe`

## `pu.1. Intent of Signals Marco Defination`

`SIGHUP`
`SIGINT`
`SIGQUIT`
`SIGILL`
`SIGTRAP`
`SIGABRT`
`SIGBUS`
`SIGFPE`
`SIGKILL`
`SIGUSR1`
`SIGSEGV`
`SIGUSR2`
`SIGPIPE`
`SIGALRM`
`SIGTERM`
`SIGSTKFLT`
`SIGCHLD`
`SIGCONT`
`SIGSTOP`
`SIGTSTP`
`SIGTTIN`
`SIGTTOU`
`SIGURG`
`SIGXCPU`
`SIGXFSZ`
`SIGVTALRM`
`SIGPROF`
`SIGWINCH`
`SIGIO`
`SIGPWR`
`SIGSYS`
`SIGRTMIN`
`SIGRTMAX`

## `pu.2. struct sigaction`

``` text
struct sigaction {
  void      (*sa_handler)(int);
  void      (*sa_sigaction)(int, siginfo_t *, void *);
  sigset_t    sa_mask;
  int         sa_flags;
  void      (*sa_restorer)(void);
};
```

`sa_handler`
The action to be associated with signum.

`sa_sigaction`
The action to be associated with signum.

`sa_mask`
Block signal set.

| Macro | Value | Description |
|---|---|---|
| SA_NOCLDSTOP |          1 | Don't send SIGCHLD when children stop. |
| SA_NOCLDWAIT |          2 | Don't create zombie on child death.
| SA_SIGINFO   |          4 | Invoke signal-catching function with three arguments instead of one.
| SA_ONSTACK   | 0x08000000 | Use signal stack by using `sa_restorer'.
| SA_RESTART   | 0x10000000 | Restart functions if interrupted by handler.
| SA_NODEFER   | 0x40000000 | Don't automatically block the signal when its handler is being executed.
| SA_RESETHAND | 0x80000000 | Reset to SIG_DFL on entry to handler.

`sa_flags`
Used to modify the behavior of the specified signal.

`sa_restorer`
Used for kernel.

# `Table Collection`

## `tc.1. Signals Marco Defination`

| Macro | Value | Description |
| ----------- | -- | -- |
| SIGHUP      |  1 | Hangup |
| SIGINT      |  2 | ctrl-c |
| SIGQUIT     |  3 | ctrl-\ |
| SIGILL      |  4 | Illegal instruction |
| SIGTRAP     |  5 | Trace/breakpoint trap |
| SIGABRT     |  6 | Abnormal termination |
| SIGBUS      |  7 | Bus error |
| SIGFPE      |  8 | Erroneous arithmetic operation</br>(floating-point exception) |
| SIGKILL     |  9 | Killed |
| SIGUSR1     | 10 | User-defined signal 1 |
| SIGSEGV     | 11 | Invalid access to storage |
| SIGUSR2     | 12 | User-defined signal 2 |
| SIGPIPE     | 13 | Broken pipe |
| SIGALRM     | 14 | Alarm clock (timeout) |
| SIGTERM     | 15 | Termination request |
| SIGSTKFLT   | 16 | Stack fault (obsolete) |
| SIGCHLD     | 17 | Child terminated or stopped |
| SIGCONT     | 18 | Continue program |
| SIGSTOP     | 19 | Stop program |
| SIGTSTP     | 20 | Same as SIGSTOP, but can be capture |
| SIGTTIN     | 21 | Background read from control terminal |
| SIGTTOU     | 22 | Background write to control terminal |
| SIGURG      | 23 | Socket has urgent data available to read |
| SIGXCPU     | 24 | CPU time limit exceeded |
| SIGXFSZ     | 25 | File size limit exceeded |
| SIGVTALRM   | 26 | Virtual timer expired |
| SIGPROF     | 27 | Profiling timer expired |
| SIGWINCH    | 28 | Window size change (4.3 BSD, Sun) |
| SIGIO</br>SIGPOLL | 29 | I/O now possible (4.2 BSD) |
| SIGPWR      | 30 | Power failure imminent |
| SIGSYS      | 31 | Bad system call |
|             | 32 | |
|             | 33 | |
| SIGRTMIN    | 34 |  |
| SIGRTMAX    | 64 |  |

The Detail see <a href="#pu1-intent-of-signals-marco-defination">pu.1</a>