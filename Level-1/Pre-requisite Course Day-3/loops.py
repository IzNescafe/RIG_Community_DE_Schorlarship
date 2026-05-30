i = 1

while i <= 5:
    print(i)
    i += 1
print("While loop ended.")

for i in range(1, 6):
    print(i)
    if (i==3):
        print("Breaking the loop at i =", i)
        break
print("For loop ended.")

for i in range(1, 6):
    if (i==3):
        print("Skipping the iteration at i =", i)
        continue
    print(i)
print("For loop with continue ended.")
