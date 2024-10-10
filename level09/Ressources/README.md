How to find:

    level09@SnowCrash:~$ ls -la
    total 24
    dr-x------ 1 level09 level09  140 Mar  5  2016 .
    d--x--x--x 1 root    users    340 Aug 30  2015 ..
    -r-x------ 1 level09 level09  220 Apr  3  2012 .bash_logout
    -r-x------ 1 level09 level09 3518 Aug 30  2015 .bashrc
    -rwsr-sr-x 1 flag09  level09 7640 Mar  5  2016 level09
    -r-x------ 1 level09 level09  675 Apr  3  2012 .profile
    ----r--r-- 1 flag09  level09   26 Mar  5  2016 token

Similar as before:

    level09@SnowCrash:~$ ./level09 
    You need to provied only one arg.

    level09@SnowCrash:~$ cat token 
    f4kmm6p|=�p�n��DB�Du{��

    level09@SnowCrash:~$ ./level09 token
    tpmhr
    level09@SnowCrash:~$ ./level09 a
    a
    level09@SnowCrash:~$ ./level09 aa
    ab
    level09@SnowCrash:~$ ./level09 aaa
    abc
    level09@SnowCrash:~$ ./level09 abc
    ace
    level09@SnowCrash:~$ ./level09 xyz
    xz|
    level09@SnowCrash:~$ ./level09 zzz
    z{|

Seems like a pattern

    level09@SnowCrash:~$ ./level09 $(cat token)
    
    f5mpq;v�E��{�{��TS�W�����

Run script with the output of cat token

    level09@SnowCrash:~$ python /tmp/script.py `cat token`
    
    f3iji1ju5yuevaus41q1afiuq


    level09@SnowCrash:~$ su flag09
    Password: 
    Don't forget to launch getflag !
    
    flag09@SnowCrash:~$ getflag
    Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
