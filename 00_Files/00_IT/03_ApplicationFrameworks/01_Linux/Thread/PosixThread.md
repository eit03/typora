***
`Reference:` manpages
***
[toc]
***

# `1. Concept in Posix Thread`

## `1.1. Posix Thread`

POSIX.1 specifies a set of interfaces (functions, header files) for threaded
programming commonly known as POSIX threads, or Pthreads. A single process can
contain multiple threads, all of which are executing the same program. These
threads share the same global memory (data and heap segments), but each thread
has its own stack (automatic variables).

## `1.2. ID of Posix Thread`

Each of the threads in a process has a unique thread identifier (stored in the
type pthread_t). This identifier is returned to the caller of pthread_create(3),
and a thread can obtain its own thread identifier using pthread_self(3).

Thread IDs are guaranteed to be unique only within a process, the system may
reuse a thread ID after a terminated thread has been joined, or a detached
thread has terminated. POSIX says: "If an application attempts to use a thread
ID whose lifetime has ended, the behavior is undefined."

## `1.3. Cancellation points`

POSIX.1 specifies that certain functions must, and certain other functions may,
be cancellation points. If a thread is cancelable, its cancelability type is
deferred, and a cancellation request is pending for the thread, then the thread
is canceled when it calls a function that is a cancellation point.

functions who are required to be cancellation points see Posix.

## `1.4. Detach State`

If thread has detach state, it will clean sources when it die, other than need
someone thread to call pthread_join() waiting exit and then clean sources. We
can set detach state by pthread_attr_setdetachstate() before create thread, and
also can set it by pthread_detach() after thread ran.

## `1.5. Contention`

Contention is the case tha a exclusive source is required by multipul threads.

## `1.6. Scheduling Policy`

The supported values of policy shall include SCHED_FIFO, SCHED_RR, and
SCHED_OTHER. When threads executing with the scheduling policy SCHED_FIFO,
SCHED_RR, or SCHED_SPORADIC are waiting on a mutex, they shall acquire the mutex
in priority order when the mutex is unlocked.

|Macro |Description|
|---|---|
|SCHED_OTHER |
|SCHED_FIFO  |always immediately preempt any currently running SCHED_OTHER thread, will be inserted at the end of the list for its priority, runs until either it is blocked by an I/O request, it is preempted by a higher priority thread, or it calls sched_yield(2) to put itself at the end of the list. First in-first out scheduling.
|SCHED_RR    |Same as SCHED_FIFO, but have a timeout action, put itself at the end of the list.

See pthread_attr_getschedpolicy(), pthread_attr_setschedpolicy().

## `1.7. Scheduling Attribution`

## `1.8. Inheritsched Scheduling Attribution`

PTHREAD_INHERIT_SCHED: Specifies that the thread scheduling attributes shall be
inherited from the creating thread, and the scheduling attributes in this attr
argument shall be ignored.

PTHREAD_EXPLICIT_SCHED: Specifies that the thread scheduling attributes shall be
set to the corresponding values from this attributes object.

See pthread_attr_getinheritsched(), pthread_attr_setinheritsched().

## `1.9. Scheduling Priority`

Processes scheduled under one of the real-time policies (SCHED_FIFO, SCHED_RR)
have a sched_priority value in the range 1 (low) to 99 (high). real-time threads
always have higher priority than normal.

See pthread_attr_getschedparam(), pthread_attr_setschedparam().

## `1.9. Contention Scope`

PTHREAD_SCOPE_PROCESS: process-wide
PTHREAD_SCOPE_SYSTEM: system-wide

See pthread_attr_getscope(), pthread_attr_getscope().

# `2. Types`

## `2.1. pthread_t`

The type of thread identifier (tid). The type is not exposed in order to
compatibility, get tid by pthread_self(), compare tid by pthead_equal().

## `2.2. pthread_attr_t`

```
#ifdef __x86_64__
# if __WORDSIZE == 64
#  define __SIZEOF_PTHREAD_ATTR_T 56
# else
#  define __SIZEOF_PTHREAD_ATTR_T 32
# endif
#else
# define __SIZEOF_PTHREAD_ATTR_T 36
#endif

union pthread_attr_t
{
  char      __size[__SIZEOF_PTHREAD_ATTR_T];
  long int  __align;
};
typedef union pthread_attr_t pthread_attr_t;
```

## `pthread_mutex_t`

## `pthread_cond_t`

# `3. Functions`

```
int pthread_attr_init           (pthread_attr_t*            attr);
int pthread_attr_destroy        (pthread_attr_t*            attr);

int pthread_detach              (pthread_t                  th)
int pthread_attr_getdetachstate (const pthread_attr_t*      attr,
                                 int*                       detachstate);
int pthread_attr_setdetachstate (pthread_attr_t*            attr,
                                 int                        detachstate);

int pthread_attr_getscope(const pthread_attr_t *restrict    attr,
                          int *restrict                     contentionscope);
int pthread_attr_setscope(pthread_attr_t *                  attr,
                          int                               contentionscope);

int pthread_attr_getschedpolicy(const pthread_attr_t *restrict  attr,
                                int *restrict                   policy);
int pthread_attr_setschedpolicy(pthread_attr_t *                attr,
                                int                             policy);

int pthread_attr_getinheritsched(const pthread_attr_t *restrict attr,
                                 int *restrict                  inheritsched);
int pthread_attr_setinheritsched(pthread_attr_t *               attr,
                                 int                            inheritsched);


int pthread_attr_getschedparam(const pthread_attr_t *restrict       attr,
                               struct sched_param *restrict         param);
int pthread_attr_setschedparam(pthread_attr_t *restrict             attr,
                               const struct sched_param *restrict   param);
```

pthread_attr_init() Initialize @param attr whit defualt value.

pthread_attr_destroy() Destroy thread attribute.

pthread_detach() set detach state attribute.

pthread_attr_getdetachstate() get detach state attribute.

pthread_attr_setdetachstate() set detach state attribute.

```
int  pthread_create(pthread_t*              thread,
                    const pthread_attr_t*   attr,
                    void*(*                 start_routine) (void*),
                    void*                   arg);
void pthread_exit  (void*                   retval);
int  pthread_join  (pthread_t               th,
                    void**                  thread_return);
```

pthread_create() creates a thread.
pthread_exit() exits current thread.
pthread_join() waits the thread @param th for exit.

# `4. Guide of Using`

pthread_attr_init() ==>
[pthread_attr_setdetachstate() ==>]
pthread_create() ==>
[pthread_detach ==>]
[pthread_join()]

```
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <assert.h>

typedef void* (*thread_routine_t)(void*);


void* print1_thread_routine(void*)
{
    for (int i = 0; i < 100; i++)
    {
        printf("tid: %ld, i = %d\n", syscall(SYS_gettid), i);
        usleep(10);
    }
    return NULL;
}

void* print2_thread_routine(void*)
{
    for (int i = 0; i < 10; i++)
        printf("tid: %ld, i = %d\n", syscall(SYS_gettid), i);
    return NULL;
}

int main(/*int argc, char *argv[]*/)
{
    pthread_t tid[2];
    pthread_attr_t attr;

    if ( pthread_attr_init(&attr) ||
         pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) ||
         pthread_create(&tid[0], &attr, print1_thread_routine, NULL))
        assert(0);

    pthread_attr_destroy(&attr);
    if ( pthread_attr_init(&attr) ||
         pthread_create(&tid[1], &attr, print2_thread_routine, NULL))
        assert(0);
    if (pthread_join(tid[1], NULL))
        assert(0);

    return 0;
}
```

```
tid: 28130, i = 0
tid: 28130, i = 1
tid: 28131, i = 0
tid: 28131, i = 1
tid: 28131, i = 2
tid: 28131, i = 3
tid: 28131, i = 4
tid: 28131, i = 5
tid: 28131, i = 6
tid: 28131, i = 7
tid: 28131, i = 8
tid: 28131, i = 9
tid: 28130, i = 2
tid: 28130, i = 2
Press <RETURN> to close this window...
```