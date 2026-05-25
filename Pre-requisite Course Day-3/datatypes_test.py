age = 20

height = 5.6

name = "NES"

is_student = True

marks = [85, 90, 78, 92, 88]

subjects = ("Math", "Science", "English", "History", "Art")

hobbies = {"Reading", "Traveling", "Cooking", "Gaming"}

student = {
    "name": "NES",
    "age": 20,
    "height": 5.6,
    "is_student": True,
    "marks": marks,
    "subjects": subjects,
    "hobbies": hobbies
}

print("Marks: ")
for m in marks:
    print(m)

print("\nHobbies (unique): ", hobbies)

print("\nStudent Dictionary: ", student)

average = sum(marks) / len(marks)

print("Your average mark is:", average)

if average >= 50:
    print("You passed the exam!")
else:
    print("You failed the exam.")