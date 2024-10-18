How to find:
dr-x------ 1 level13 level13  120 Mar  5  2016 .
d--x--x--x 1 root    users    340 Aug 30  2015 ..
-r-x------ 1 level13 level13  220 Apr  3  2012 .bash_logout
-r-x------ 1 level13 level13 3518 Aug 30  2015 .bashrc
-rwsr-sr-x 1 flag13  level13 7303 Aug 30  2015 level13
-r-x------ 1 level13 level13  675 Apr  3  2012 .profile

And when we execute the executable level13 we get :

    level13@SnowCrash:~$ ./level13 
    UID 2013 started us but we we expect 4242

The process began by reviewing the level13 program, which was identified as a SUID executable. This means that when executed, it runs with the permissions of the file owner (in this case, flag13).

Compiling the Library:

    A file named getuid.c was created to redefine the getuid() function to return a specific UID (4242). This was done to simulate the execution of the program with the privileges of a privileged user.
    This file was compiled into a shared library called getuid.so using the following command: 
        level13@SnowCrash:/tmp$ gcc -shared -fPIC -o getuid.so getuid.c -ldl

Exporting LD_PRELOAD:

    The LD_PRELOAD environment variable was exported so that the level13 program would utilize the shared library we just created:
        export LD_PRELOAD="/tmp/lib.so"

Executing the Program:

    The level13 program was executed, allowing the getuid() function to be intercepted and return 4242 as the UID. This enabled the program to run with elevated permissions, as if it were the user flag13:

        level13@SnowCrash:~$ /tmp/level13
        your token is 2A31L79asukciNyi8uppkEuSx

Description: This project focuses on exploring and learning about code injection techniques in Linux environments, specifically using the concepts of LD_PRELOAD and the SUID (Set User ID) bit. Through a series of levels, it examines security vulnerabilities that can be exploited in executable programs, as well as techniques to modify their behavior.


