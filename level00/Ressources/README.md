How to find:

Intra snowcrash video shows a README file:
Search a file that can be run by flag00 user:


    level00@SnowCrash:~$ find / -user flag00 2>/dev/null
    /usr/sbin/john

    /rofs/usr/sbin/john

    level00@SnowCrash:~$ cat /usr/sbin/john
    cdiiddwpgswtgt
    
    level00@SnowCrash:~$ cat /rofs/usr/sbin/john
    cdiiddwpgswtgt

Apply ROT-13 cypher at decode.fr

nottoohardhere

    level00@SnowCrash:~$ su flag00
    Password: 
    Don't forget to launch getflag !

    flag00@SnowCrash:~$ getflag
    Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
