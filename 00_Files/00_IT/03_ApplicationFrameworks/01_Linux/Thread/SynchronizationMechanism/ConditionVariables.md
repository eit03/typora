***
`Reference:` manpages posix
***
[toc]
***

# `1. Concept in Condition Variable`

## `1.1 Mutex`

The mutex passed to pthread_cond_wait() protects the condition. The caller
passes it locked to the function, which then atomically places the calling
thread on the list of threads waiting for the condition and unlocks the mutex.
This closes the window between the time that the condition is checked and the
time that the thread goes to sleep waiting for the condition to change, so that
the thread doesn't miss a change in the condition. When pthread_cond_wait()
returns, the mutex is again locked.

## `1.2 Spurious Wakeup`

pthread_cond_wait() maybe be interrupted, it shall return zero due to spurious
wakeup.

## `1.3. Share Attribution`

The process-shared attribute is set to PTHREAD_PROCESS_SHARED to permit a
condition variable to be operated upon by any thread that has access to the
memory where the condition variable is allocated, even if the condition variable
is allocated in memory that is shared by multiple processes. See Synchronization
The default value of the attribute is PTHREAD_PROCESS_PRIVATE.

```
/* Process shared or private flag.  */
enum
{
  PTHREAD_PROCESS_PRIVATE,
  PTHREAD_PROCESS_SHARED
};
```



# `2. Types`

`pthread_condattr_t`

`pthread_cond_t`


# `3. Functions`

```
int pthread_condattr_init       (pthread_condattr_t*    attr);
int pthread_condattr_destroy    (pthread_condattr_t*    attr);

int pthread_condattr_getclock(const pthread_condattr_t *restrict    attr,
                              clockid_t *restrict                   clock_id);
int pthread_condattr_setclock(pthread_condattr_t *                  attr,
                              clockid_t                             clock_id);

int pthread_condattr_getpshared(const pthread_condattr_t *restrict  attr,
                                int *restrict                       pshared);
int pthread_condattr_setpshared(pthread_condattr_t *                attr,
                                int                                 pshared);
```

pthread_condattr_getclock() get clock selection condition variable attribute.
The clock attribute is the clock ID of the clock that shall be used to measure
the timeout service of pthread_cond_timedwait(). The default value of the clock
attribute shall refer to the system clock.

pthread_condattr_setclock() set clock selection condition variable attribute.

pthread_condattr_getpshared() get process-shared condition variable attributes.

pthread_condattr_setpshared() set process-shared condition variable attributes.

```
int pthread_cond_destroy    (pthread_cond_t *                   cond);
int pthread_cond_init       (pthread_cond_t *restrict           cond,
                             const pthread_condattr_t*restrict  attr);

int pthread_cond_signal     (pthread_cond_t *cond);
int pthread_cond_broadcast  (pthread_cond_t *cond);

int pthread_cond_wait       (pthread_cond_t *restrict           cond,
                             pthread_mutex_t *restrict          mutex);
int pthread_cond_timedwait  (pthread_cond_t *restrict           cond,
                             pthread_mutex_t *restrict          mutex,
                             const struct timespec *restrict    abstime);
```

pthread_cond_signal() shall unblock at least one of the threads that are blocked
on the specified condition variable @param cond.

pthread_cond_broadcast() shall unblock all threads currently blocked on the
specified condition variable @param cond.

pthread_cond_wait() shall atomically release @param mutex and cause the calling
thread to block on the condition variable @param cond. The application shall
ensure that pthread_cond_wait() is called with mutex locked by the calling
thread; otherwise, an error (for PTHREAD_MUTEX_ERRORCHECK and robust mutexes) or
undefined behavior (for other mutexes) results.

pthread_cond_timedwait() shall be equivalent to pthread_cond_wait(), except that
an error is returned if the absolute time @param abstime passed before the
condition cond is signaled or broadcasted, or if the absolute time @param
abstime has already been passed at the time of the call.


# `4. Guide of Using`

```
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <assert.h>
#include <errno.h>
#include <sys/time.h>


int g_count = 0;
pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

void* producer_broadcast_thread_routine(void* /*p*/);
void* producer_signal_thread_routine(void* /*p*/);
void* consumer_wait_thread_routine(void* /*p*/);
void* consumer_timedwait_thread_routine(void*/*p*/);

int main(/*int argc, char *argv[]*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    // thread
    pthread_t tid;
    pthread_attr_t attr;

    if ( pthread_attr_init(&attr) ||
         pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) ||
         pthread_create(&tid, &attr, producer_broadcast_thread_routine, NULL))
        assert(0);

    if ( pthread_attr_init(&attr) ||
         pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) ||
         pthread_create(&tid, &attr, producer_signal_thread_routine, NULL))
        assert(0);

    if ( pthread_attr_init(&attr) ||
         pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) ||
         pthread_create(&tid, &attr, consumer_wait_thread_routine, NULL))
        assert(0);

    if ( pthread_attr_init(&attr) ||
         pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) ||
         pthread_create(&tid, &attr, consumer_timedwait_thread_routine, NULL))
        assert(0);

    while (true)
        sleep(1);

    return 0;
}

void* producer_broadcast_thread_routine(void* /*p*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    assert(!pthread_mutex_lock(&mtx));
    g_count += 10;
    assert(g_count > 0);
    assert(!pthread_cond_broadcast(&cond));
    assert(!pthread_mutex_unlock(&mtx));

    return NULL;
}

void* producer_signal_thread_routine(void* /*p*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    while (true)
    {
        assert(!pthread_mutex_lock(&mtx));
        g_count++;
        assert(g_count > 0);
        assert(!pthread_cond_signal(&cond));
        assert(!pthread_mutex_unlock(&mtx));
        usleep(1000*300);
    }

    return NULL;
}

void* consumer_wait_thread_routine(void* /*p*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    assert(!pthread_mutex_lock(&mtx));
    while (g_count <= 0)
        assert(!pthread_cond_wait(&cond, &mtx));
    assert(g_count > 0);
    g_count--;
    printf("%s tid: %ld g_count = %d\n",
           __FUNCTION__, syscall(SYS_gettid), g_count);
    assert(!pthread_mutex_unlock(&mtx));

    return NULL;
}

void* consumer_timedwait_thread_routine(void*/*p*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    while (true)
    {
        assert(!pthread_mutex_lock(&mtx));
        while (g_count <= 0)
        {
            struct timeval tv;
            gettimeofday(&tv, NULL);
            struct timespec abstime;
            abstime.tv_sec = tv.tv_sec + 1;
            abstime.tv_nsec = tv.tv_usec * 1000;
            printf("Before invoke pthread_cond_timedwait()!\n");
            int kk = pthread_cond_timedwait(&cond, &mtx, &abstime);
            if (ETIMEDOUT == kk)
                printf("timedout\n");
            else if (0 == kk)
                printf("Actived!\n");
            else
                assert(0);
        }
        assert(g_count > 0);
        g_count--;
        printf("%s tid: %ld g_count = %d\n",
               __FUNCTION__, syscall(SYS_gettid), g_count);
        assert(!pthread_mutex_unlock(&mtx));
    }

    return NULL;
}
```

```
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <assert.h>
#include <errno.h>
#include <sys/time.h>

typedef void* (*thread_routine_t)(void*);


int g_count = 0;
pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

void* producer_signal_thread_routine(void* /*p*/);
void* consumer_wait_thread_routine(void* /*p*/);

int main(/*int argc, char *argv[]*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    // thread
    pthread_t tid;
    pthread_attr_t attr;

    if ( pthread_attr_init(&attr) ||
         pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) ||
         pthread_create(&tid, &attr, producer_signal_thread_routine, NULL))
        assert(0);

    // consumer_wait_thread_routine() maybe can not run due to rate of mutex.
    if ( pthread_attr_init(&attr) ||
         pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) ||
         pthread_create(&tid, &attr, consumer_wait_thread_routine, NULL))
        assert(0);

    while (true)
        sleep(1);

    return 0;
}

void* producer_signal_thread_routine(void* /*p*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    while (true)
    {
        assert(!pthread_mutex_lock(&mtx));
        g_count++;
        assert(g_count > 0);
        printf("Before invoke pthread_cond_signal()!\n");
        assert(!pthread_cond_signal(&cond));
        printf("After invoke pthread_cond_signal()!\n");
        assert(!pthread_mutex_unlock(&mtx));
        //usleep(1);
    }

    return NULL;
}

void* consumer_wait_thread_routine(void* /*p*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    while (true)
    {
        assert(!pthread_mutex_lock(&mtx));
        while (g_count <= 0)
        {
            printf("Before invoke pthread_cond_wait()!\n");
            assert(!pthread_cond_wait(&cond, &mtx));
            printf("After invoke pthread_cond_wait()!\n");
        }
        assert(g_count > 0);
        g_count--;
        printf("%s tid: %ld g_count = %d\n", __FUNCTION__, syscall(SYS_gettid), g_count);
        assert(!pthread_mutex_unlock(&mtx));
    }

    return NULL;
}
```

```
#include <stdio.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <assert.h>

#include <glib.h>


int g_count = 0;

GMutex g_mtx;
GCond g_cond;

void* producer(void* /*p*/);
void* consumer(void* /*p*/);

int main(/*int argc, char *argv[]*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    g_mutex_init(&g_mtx);
    g_cond_init(&g_cond);

    // glib-thread
    GThread* producer_thrd =  g_thread_new( "producer", producer, NULL);
    if (!producer_thrd)
        __assert_fail ("", __FILE__, __LINE__, __FUNCTION__);

    GThread* consumer_thrd =  g_thread_new( "consumer", consumer, NULL);
    if (!consumer_thrd)
        __assert_fail ("", __FILE__, __LINE__, __FUNCTION__);

    g_thread_join(producer_thrd);
    g_thread_join(consumer_thrd);

    g_mutex_clear(&g_mtx);
    g_cond_clear(&g_cond);

    return 0;
}

void* producer(void* /*p*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    while (true)
    {
        g_mutex_lock(&g_mtx);
        g_count++;
        assert(g_count > 0);
        printf("Before invoke g_cond_signal()!\n");
        g_cond_signal(&g_cond);
        printf("After invoke g_cond_signal()!\n");
        g_mutex_unlock(&g_mtx);
    }

    return NULL;
}

void* consumer(void* /*p*/)
{
    printf("%s tid: %ld\n", __FUNCTION__, syscall(SYS_gettid));

    while (true)
    {
        g_mutex_lock(&g_mtx);
        while (g_count <= 0)
        {
            printf("Before invoke pthread_cond_wait()!\n");
            g_cond_wait(&g_cond, &g_mtx);
            printf("After invoke pthread_cond_wait()!\n");
        }
        assert(g_count > 0);
        g_count--;
        printf("%s tid: %ld g_count = %d\n", __FUNCTION__, syscall(SYS_gettid), g_count);
        g_mutex_unlock(&g_mtx);
    }

    return NULL;
}
```