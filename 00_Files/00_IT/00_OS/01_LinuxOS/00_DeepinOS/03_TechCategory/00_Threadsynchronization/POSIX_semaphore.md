***
`Reference:`  ==man sem_overview==
***
[TOC]
***

# `Brief Introducation`

POSIX semaphores 提供进程间异步与线程间异步功能;

POSIX semaphores 有二种类型的信号量: Unnamed semaphores , Named semaphores;

- Unnamed semaphores:
  一个未命名的信号量没有名称,这个信号量是被放置在一个线程间共享的内存区域(线程共享信号量)或一个进程间共享的内存区域(进程共享信号量);
  线程共享信号量被放置在一个进程的线程可访问的内存区域,如全局变量;
  进程共享信号量必须被放置在共享内存区域,可以使用shm_open()创建共享内存对象;
  使用前要用sem_init()初始化,使用sem_post() & sem_wait() 做PV操作,使用sem_destroy()释放;

- Named semaphores:
  命名的semaphores,有一个最大长度名,为 251 == NAME_MAX - strlen("sem."),如果第一个字符为"/",那么会先排除,再计算长度;
  任何进程可以打开 Named semaphores ,前提要有权限;
  其实 Named semaphores 是用文件系统实现的;
  文件是在 /dev/shm/ 目录中, 文件名称是 "sem." 加上给出的名称(排除前面所有的"/"),这也是为什么命名信号量最大长度为251;
  权限也就是文件的权限了,最好用chmod()写定权限;
  使用前要用sem_open()打开或获取命名的信号量,使用sem_post() & sem_wait() 做PV操作,使用sem_close()关闭信号量,使用sem_unlink()释放信号量;
  sem_close()是关闭打开的命名的信号量;
  sem_unlink()是释放命名的信号量,也就是删除文件;


implementation mechanism:

- Unnamed semaphores: 可见内存;
- Named semaphores: 可访问文件



信号量为0时,表示没有信号,所以,注意信号量值-1,可能会导致bug;



# `使用指导`

## `Unnamed semaphores`



## `Named semaphores`

### `sem_open`

```
sem_t *sem_open(const char *name, int oflag);
sem_t *sem_open(const char *name, int oflag, mode_t mode, unsigned int value);
```
`name`

信号量名称;

`oflag`

- O_CREAT: 创建或打开信号量,如果信号量存在,mode参数与value参数是忽略的;

- O_EXCL: 与 O_CREAT 一起使用,表示只创建信号量,如果信号量存在,函数失败;

`mode`

其实就是文件权限,见open(2)

`value`

信号量信号数;

`RETURN VALUE`
On success, sem_open() returns the address of the new semaphore; this address is used when calling other semaphore-related functions.  On error, sem_open() returns SEM_FAILED, with errno set to indicate the error.

`ERRORS`
```
EACCES 	        The semaphore exists, but the caller does not have permission to open it.
EEXIST          Both O_CREAT and O_EXCL were specified in oflag, but a semaphore with this name already exists.
EINVAL          value was greater than SEM_VALUE_MAX.
EINVAL          name consists of just "/", followed by no other characters.
EMFILE          The per-process limit on the number of open file descriptors has been reached.
ENAMETOOLONG    name was too long.
ENFILE          The system-wide limit on the total number of open files has been reached.
ENOENT          The O_CREAT flag was not specified in oflag and no semaphore with this name exists; or, O_CREAT was specified, but name wasn't well formed.
ENOMEM          Insufficient memory.
```

### `sem_getvalue`

### `sem_post`

### `sem_wait`

### `sem_close`

### `sem_unlink`
