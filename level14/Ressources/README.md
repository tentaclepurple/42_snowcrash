

Here they won't give us a file to look at, but if we run ltrace flag14 we can see something.
ltrace is a debugging tool used to trace library calls made by a program, along with the system calls and functions from dynamically linked libraries such as libc.

    level14@SnowCrash:~$ ltrace /bin/getflag
    __libc_start_main(0x8048946, 1, 0xbffff7f4, 0x8048ed0, 0x8048f40 <unfinished ...>
    ptrace(0, 0, 1, 0, 0)                       = -1
    puts("You should not reverse this"You should not reverse this
    )         = 28
    +++ exited (status 1) +++

The program uses ptrace() as a defense mechanism against debugging. The call ptrace(PTRACE_TRACEME) allows a process to detect if it’s being traced by a debugger. If the process is already being debugged (as when using ltrace or gdb), the ptrace() call fails, returning -1. In this case, the program detects the tracing and prints the message "You should not reverse this," terminating to prevent further analysis.

Using gdb we can disassemble the code to see what we can do.

    (gdb) disassemble main

   0x08048aa1 <+347>:   movl   $0x1,0x10(%esp)
   0x08048aa9 <+355>:   jmp    0x8048e89 <main+1347>
   0x08048aae <+360>:   cmpl   $0x0,0x10(%esp)
   0x08048ab3 <+365>:   je     0x8048e89 <main+1347>
   0x08048ab9 <+371>:   movl   $0x8049068,0x4(%esp)
   0x08048ac1 <+379>:   lea    0x1c(%esp),%eax
   0x08048ac5 <+383>:   mov    %eax,(%esp)
   0x08048ac8 <+386>:   call   0x8048843 <isLib>
   0x08048acd <+391>:   test   %eax,%eax
   0x08048acf <+393>:   je     0x8048e46 <main+1280>
   0x08048ad5 <+399>:   mov    0x804b060,%eax
   0x08048ada <+404>:   mov    %eax,%edx
   0x08048adc <+406>:   mov    $0x804906c,%eax
   0x08048ae1 <+411>:   mov    %edx,0xc(%esp)
   0x08048ae5 <+415>:   movl   $0x20,0x8(%esp)
   0x08048aed <+423>:   movl   $0x1,0x4(%esp)
   0x08048af5 <+431>:   mov    %eax,(%esp)
   0x08048af8 <+434>:   call   0x80484c0 <fwrite@plt>
   0x08048afd <+439>:   call   0x80484b0 <getuid@plt>
   0x08048b02 <+444>:   mov    %eax,0x18(%esp)
   0x08048b06 <+448>:   mov    0x18(%esp),%eax
   0x08048b0a <+452>:   cmp    $0xbbe,%eax
   0x08048b0f <+457>:   je     0x8048ccb <main+901>
   0x08048b15 <+463>:   cmp    $0xbbe,%eax

We see that in the code they use getenuid to get the id to execute the code.

First we look at what the UI of flag14 is.
    level14@SnowCrash:~$ id flag14
    uid=3014(flag14) gid=3014(flag14) groups=3014(flag14),1001(flag)

Now that we know it is 3014, we must create a dupuration routine to give us the flag as if we were flag14

    Load the Program in gdb: file /bin/getflag
    Set a Breakpoint on ptrace: catch syscall ptrace
    Define Commands for the Breakpoint:
        commands 1
        set $eax=0
        continue
        end
    Set a Breakpoint on getuid: break getuid
    Run the Program: run
    Step Through the Code: step
    Print the Value of eax: print $eax
    Modify the Value of eax: set $eax=3014
    Continue Execution: continue
    Retrieve the Flag: If successful, the program will print the flag.

gdb (GNU Debugger) is a powerful tool used to analyze and control the execution of programs, making it useful for inspecting and modifying a program’s behavior during runtime. In this case, you're using gdb to bypass the security check performed by ptrace() in /bin/getflag, which prevents debugging. By setting a breakpoint on the ptrace() system call and overriding its result (set $eax=0), you trick the program into thinking it's not being debugged. Additionally, modifying the result of the getuid() system call to return 3014 (the UID of flag14) allows you to bypass the permission check and retrieve the flag.