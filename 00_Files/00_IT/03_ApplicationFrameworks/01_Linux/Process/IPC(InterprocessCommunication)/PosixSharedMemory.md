
***
`Reference:`
***
[toc]
***

# `1. Concept in Posix Shared Memory`

## `1.1. Protect Attribution of Shared Memory`

| Macro | Value | Description |
|---|---|---|
| PROT_READ  | 0x1 | Page can be read.
| PROT_WRITE | 0x2 | Page can be written.
| PROT_EXEC  | 0x4 | Page can be executed.
| PROT_NONE  | 0x0 | Page can not be accessed.

## `1.2. Flag of Shared Memory`

| Macro | Value | Description |
|---|---|---|
| MAP_SHARED  | 0x1 | Share changes.
| MAP_PRIVATE | 0x2 | Changes are private.
| MAP_TYPE    | 0xf | Mask for type of mapping.

# `2. Types`

# `3. Functions`

```
int shm_open(const char *name, int oflag, mode_t mode);
int shm_unlink(const char *name);
void* mmap(void *addr, size_t len, int prot, int flags, int fildes, off_t off);
int munmap(void *addr, size_t len);

// XSI, System V style API.
int shmget(key_t key, size_t size, int shmflg);
int shmctl(int shmid, int cmd, struct shmid_ds *buf);
void* shmat(int shmid, const void *shmaddr, int shmflg);
int shmdt(const void *shmaddr);
```

shm_open() Create or open object. This is analogous to open(2). The call returns
a file descriptor for use by the other interfaces. ftruncate(2) set the size of
the shared memory object. close(2) close the file descriptor when it is no
longer needed. fstat(2) obtain a stat structure that describes the shared memory
object, the object's size (st_size), permissions (st_mode), owner (st_uid), and
group (st_gid). fchown(2) to change the ownership of a shared memory object.
fchmod(2) to change the permissions of a shared memory object.

shm_unlink() remove a shared memory object name.

shmdt() detach operation of shared memory.

mmap() map the shared memory object into the virtual address space of the
calling process.

munmap() unmap the shared memory object from the virtual address space of the
calling process.

# `4. Guide of Using`
