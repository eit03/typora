# `umask() is MT-Unsafe`

``` text
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <sys/stat.h>


void* thread_routine1(void*)
{
    FILE* fp = fopen("2.txt", "w");
    if (fp) fclose(fp);

    mode_t preMode = umask(0133);

    fp = fopen("3.txt", "w");
    if (fp) fclose(fp);

    return NULL;
}

void* thread_routine2(void*)
{
    sleep(3);

    FILE* fp = fopen("4.txt", "w");
    if (fp) fclose(fp);

    return NULL;
}


int main(int argc, char *argv[])
{
    FILE* fp = fopen("1.txt", "w");
    if (fp) fclose(fp);

    mode_t preMode = umask(0133);
    preMode = umask(preMode);

    pthread_t thrd[2];
    assert(!pthread_create(&thrd[0], 0, thread_routine1, NULL));
    assert(!pthread_create(&thrd[1], 0, thread_routine2, NULL));

    while (1)
        sleep(1);

    return 0;
}
```