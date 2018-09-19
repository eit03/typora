1. 安装deepin

2. 设置root密码
   ```
   sudo passwd root
   ```

3. 安装vmTools

4. fonts

5. Teminal 

   ```
   export PS1='\[\e[1;31;40m\][\w]\$\[\e[0m\] '
   ```

6. sources.list

   ```
   deb file:///media/kylin/Kylin-4.0.2 juniper main
   deb http://archive.kylinos.cn/yhkylin/ juniper main restricted universe multiverse
   
   deb http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
   deb http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
   deb http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
   deb http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
   deb http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse
   deb-src http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
   deb-src http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
   deb-src http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
   deb-src http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
   deb-src http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse
   
   
   deb-src http://archive.ubuntu.com/ubuntu xenial main restricted #Added by software-properties
   deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe #Added by software-properties
   deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe #Added by software-properties
   deb http://mirrors.aliyun.com/ubuntu/ xenial universe
   deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
   deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse
   deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse
   deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse #Added by software-properties
   deb http://archive.canonical.com/ubuntu xenial partner
   deb-src http://archive.canonical.com/ubuntu xenial partner
   deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted
   deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe #Added by software-properties
   deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe
   deb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse
   ```



6. file manager

7. task bar

8. Qt

   1. install
   2. -lGL link
   3. xterm

9. 010editor

   1. png12

10. manpages

    ```
    1、安装POSIX标准相关帮助文档:
    sudo apt-get install manpages-posix-dev
    
    2、安装标准c的相关的帮助文档
    sudo apt-get install libc-dev
    sudo apt-get install glibc-doc
    
    3、安装标准c++的帮助文档:(版本号以tab键自动提示的为准)
    sudo apt-get install libstdc++6-4.7-dev
    sudo apt-get install libstdc++6-4.7-doc
    
    4、安装 c++ STL 相关帮助文档:
    sudo apt-get install stl-manual 
    ```
