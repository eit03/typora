***
`Reference:` manpages
***
[toc]
***

# `1. Concept in Posix Mutex`

# `1.1. Mutex Type`

|Macro |Value |Description |
|---|---|---|
|PTHREAD_MUTEX_NORMAL</br> PTHREAD_MUTEX_DEFAULT |0 | Normal mutex
|PTHREAD_MUTEX_RECURSIVE |1 | Recursive mutex
|PTHREAD_MUTEX_ERRORCHECK |2 |Error when relock/unlock non owner mutex

# `1.2. Effect of Mutex Type`

|Mutex Type |Robustness |Relock         |Unlock When Not Owner
|---|---|---|---|
|NORMAL     |no         |deadlock       |undefined behavior
|NORMAL     |yes        |deadlock       |error returned
|ERRORCHECK |either     |error returned |error returned
|RECURSIVE  |either     |recursive      |error returned

## `1.3. Owner`

Owner is the thread who owner the mutex, see
pthread_mutex_t::__pthread_mutex_s::__owner.

## `1.4. Robustness`

Robustness is Mutex who has a attribution called robust that can set by
pthread_mutexattr_setrobust(), it shall change behavior of function.

PTHREAD_MUTEX_STALLED:
No special actions are taken if the owner of the mutex is terminated while
holding the mutex lock. This can lead to deadlocks if no other thread can
unlock the mutex. This is the default value.

PTHREAD_MUTEX_ROBUST:
If the owning thread of a robust mutex terminates while holding the mutex lock,
the next thread that attempts to acquire the mutex may be notified about the
termination by the return value [EOWNERDEAD].
The notified thread can then mark the mutex state as consistent by calling
pthread_mutex_consistent(). then call pthread_mutex_unlock(), the mutex lock
shall be released and can be used normally by other threads.
If the mutex is unlocked without a call to pthread_mutex_consistent(), it shall
be in a permanently unusable state and all attempts to lock the mutex shall fail
with the error [ENOTRECOVERABLE]. The only permissible operation on such a mutex
is pthread_mutex_destroy().

## `1.5. Deadlock`

Deadlock is the status that a thread is wait for mutex, but the mutex dose not
be unlocked.

## `1.6. Relock`

## `1.7. Shared Attribution`

Same as Shared Attribution of Condition Variable.

# `2. Types`

`pthread_mutex_t`

```
#ifdef __x86_64__
# if __WORDSIZE == 64
#  define __SIZEOF_PTHREAD_MUTEX_T 40
# else
#  define __SIZEOF_PTHREAD_MUTEX_T 32
# endif
#else
# define __SIZEOF_PTHREAD_MUTEX_T 24
#endif

typedef union
{
  struct __pthread_mutex_s  __data;
  char                      __size[__SIZEOF_PTHREAD_MUTEX_T];
  long int                  __align;
} pthread_mutex_t;

struct __pthread_mutex_s
{
    int                 __lock;  // whether lock
    unsigned int        __count;  // count for recursive mutex
    int                 __owner;  // tid of owner thread
    unsigned int        __nusers;
    int                 __kind;  // mutex type
    unsigned int        __nusers;  // thread count of get mutex
    short               __spins;
    short               __elision
    __pthread_list_t    __list;
};

typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;
```

# `3. Functions`

```
pthread_mutexattr_destroy()
pthread_mutexattr_getprioceiling()
pthread_mutexattr_getprotocol()
pthread_mutexattr_getpshared()
pthread_mutexattr_getrobust()
pthread_mutexattr_gettype()
pthread_mutexattr_init()
pthread_mutexattr_setprioceiling()
pthread_mutexattr_setprotocol()
pthread_mutexattr_setpshared()
pthread_mutexattr_setrobust()
pthread_mutexattr_settype()

int pthread_mutexattr_getpshared(const pthread_mutexattr_t *restrict  attr,
                                 int *restrict                        pshared);
int pthread_mutexattr_setpshared(pthread_mutexattr_t *                attr,
                                 int                                  pshared);
```

pthread_mutexattr_getpshared() get process-shared attribution.

pthread_mutexattr_setpshared() set process-shared attribution.

```
int pthread_mutex_init      (pthread_mutex_t*restrict               mutex,
                             const pthread_mutexattr_t *restrict    attr);
int pthread_mutex_destroy   (pthread_mutex_t*                       mutex);

int pthread_mutex_lock      (pthread_mutex_t*                   mutex);
int pthread_mutex_trylock   (pthread_mutex_t*                   mutex);
int pthread_mutex_timedlock (pthread_mutex_t *restrict          mutex,
                             const struct timespec *restrict    abstime);
int pthread_mutex_unlock    (pthread_mutex_t*                   mutex);

int pthread_mutex_getprioceiling(const pthread_mutex_t *restrict  mutex,
                                 int*restrict                     prioceiling);
int pthread_mutex_setprioceiling(pthread_mutex_t *restrict        mutex,
                                 int                              prioceiling,
                                 int *restrict                    old_ceiling);

int pthread_mutexattr_getrobust(const pthread_mutexattr_t * restrict    attr,
                                int *restrict                           robust);
int pthread_mutexattr_setrobust(pthread_mutexattr_t *                   attr,
                                int                                     robust);

int pthread_mutex_consistent(pthread_mutex_t *mutex);
```

pthread_mutex_init() initializes @param mutex and set @param mutex attritutions
to @param attr.

pthread_mutex_destroy() destroys @param mutex.

pthread_mutex_lock() locks @param mutex.

pthread_mutex_trylock() shall be equivalent to pthread_mutex_lock(), except that
if the mutex object @param mutex is currently locked (by any thread, including
the current thread), the call shall return immediately. If the mutex type is
PTHREAD_MUTEX_RECURSIVE and the mutex is currently owned by the calling thread,
the mutex lock count shall be incremented by one and the pthread_mutex_trylock()
shall immediately return success.

pthread_mutex_timedlock() is equivalent to pthread_mutex_lock(), except that it
shall be terminated when the specified timeout expires.

pthread_mutex_unlock() unlocks @param mutex.

pthread_mutex_getprioceiling() get the priority ceiling of @param mutex.

pthread_mutex_setprioceiling() set the priority ceiling of @param mutex.

pthread_mutexattr_getrobust() get the mutex robust attribute.

pthread_mutexattr_setrobust() set the mutex robust attribute.

pthread_mutex_consistent() can mark the mutex state as consistent and then call
pthread_mutex_unlock() to unlock when thread that is holding robust mutex dead.

# `4. Guide of Using`

```
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <assert.h>
#include <errno.h>


int main(/*int argc, char *argv[]*/)
{
    // mutex
    pthread_mutexattr_t mattr;
    if ( pthread_mutexattr_init(&mattr) ||
         pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_NORMAL) ||
         pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST))
        assert(0);

    pthread_mutex_t mtx;
    if (pthread_mutex_init(&mtx, &mattr))
        assert(0);

    //for (int ret = 0; (ret = pthread_mutex_lock(&mtx)); )
    //{
    //    if ( (EOWNERDEAD != ret) ||
    //         pthread_mutex_consistent(&mtx) ||
    //         pthread_mutex_unlock(&mtx))
    //        assert(0);
    //}

    if (pthread_mutex_lock(&mtx))
        assert(0);

    if (pthread_mutex_unlock(&mtx))
        assert(0);

    if (pthread_mutex_destroy(&mtx))
        assert(0);
    if (pthread_mutexattr_destroy(&mattr))
        assert(0);

    return 0;
}
```