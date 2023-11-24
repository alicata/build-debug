import time
import sys

print("hello world", len(sys.argv))
if len(sys.argv) > 1:
    print(sys.argv[1])
print('start')
b = 0
for i in range(5):
    time.sleep(1)
    print("process ...", time.time())
    print("b1")
    print("b2")
    b = b+1
    print(b)
print("ended.")


