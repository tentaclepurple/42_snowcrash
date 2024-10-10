import sys

hash = sys.argv[1]
result = ""
for i in range(0, len(hash)):
    result = result + chr(ord(hash[i]) - i)
print(result)