a = 10
b = 3

print("Arithmetic Operators:")
print("Addition:", a + b)
print("Subtraction:", a - b)
print("Multiplication:", a * b)
print("Division:", a / b)
print("Modulus:", a % b)
print("Exponentiation:", a ** b)

print("\nLogical Operators:")
print("AND:", a > 5 and b < 5)
print("OR:", a > 5 or b > 5)
print("NOT:", not(a > 5))

print("\nAssignment Operators:")
c = 10
print("c =", c)
c += 3
print("c += 3:", c)
c -= 3
print("c -= 3:", c)
c *= 3
print("c *= 3:", c)
c /= 3
print("c /= 3:", c)

print("\nMembership Operators:")
numbers = [1, 2, 3, 4, 5]
print("5 in numbers:", 5 in numbers)
print("6 in numbers:", 6 in numbers)
print("6 not in numbers:", 6 not in numbers)

print("\nIdentity Operators:")
list1 = [1, 2, 3]
list2 = list1
list3 = [1, 2, 3]
print("list1 is list2:", list1 is list2)
print("list1 is list3:", list1 is list3)
print("list1 is not list3:", list1 is not list3)