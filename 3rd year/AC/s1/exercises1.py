import re 
import random 

def age():
    a = int(input("AGE? "))
    if a < 18:
        print("MINOR CALL FBI")
    elif a >= 18 and a <=65:
        print("ADULT CALL AN AMBULANCE BUT NOT FOR ME")
    else:
        print("SENIOR GET OUT PLS")
#age()

def string_cleaner(phrase):
    f = phrase.replace(" ","")
    l = f.lower()
    sub = re.sub("a","@",l)
    print(sub)
#string_cleaner(' Adenosine Triphosphate ')
"""
def fizz_buzz(string):
    for i in range (1,30):
        s = str(i)
        #print(s)
        string = (string +"\n" + s)
        if i % 3 == 0 and i % 5 == 0:
            re.sub(i,"CompScience",string)
        elif i % 3 == 0:
            re.sub(i,"Comp",string)
        elif i % 5 == 0:
            re.sub(i,"Science",string)
    #print(string)
fizz_buzz("")
"""
def fb():
    for i in range(1,30):
        if i%3==0 and i%5 == 0:
            print("CompScience")
        elif i%3 == 0:
            print("Comp")
        elif i%5 == 0:
            print("Science")
        else:
            print (i)
#fb()

def guess_number():
    x = random.randint(1,20)
    #print(x)
    f = int(input("Guess the number between 1 and 20 "))
    while(f != x):
        if f > x:
            print("Too high")
        else:
            print("Too low")
        f = int(input("Try again "))
    print("you got itttt ")
#guess_number()

def factorial_for():
    x = int(input("Type a number "))
    res = 1
    for i in range (x):
        res = res*x
        x = x-1
    print(res)
#factorial_for()

def factorial_while():
    x = int(input("Type a number "))
    res = 1
    while(x != 1):
        res = res * x
        x = x-1
    print(res)
#factorial_while()

def is_palindrome(word):
    l = len(word)
    middle = int(l/2)
    for a in range (middle):
       f = word[a]
       last = word[l-1]
       l = l-1
       if f != last:
           return False
    return True
#is_palindrome("abba")

def normalize(xs):
    a = sum(xs)
    if a == 0:
        print(0 * xs)
    else:
        print([x/a for x in xs])
#normalize([0])

def freq(s):
    dict = {}
    for x in range (len(s)):
        c = s[x]
        if c not in dict:
            dict[c] = 1
        else:
            dict[c] +=1
    print(dict)
#freq("banana")

def dict_grades():
    records = [('Ana', 15), ('Bruno', 12), ('Carla', 18)]
    grades = {}
    list = []
    for name,grade in records:
        if grade >= 14:
            list.append(name)
        if grade not in grades:
            grades[grade] = name
        else:
            grades[grade].append(name)

    print(grades)
    print(list)
#dict_grades()

def temperature():
    with open("temperatures.txt", 'r', encoding='utf-8') as temp:
        list = [int(line.strip()) for line in temp]
    s = sum(list)
    l = len(list)
    average = s/l
    