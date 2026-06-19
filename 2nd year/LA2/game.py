import random
responses=["Yes - definitely","It is decidedly so",
"Without a doubt.","Reply hazy, try again","Ask again later","Better not tell you now."
"My sources say no.","Outlook not so good.","Very doubtful."
]
a=  random.choice(responses)
input("Ask a question\n")
print(a)




height= int(input('Whats your height?\n'))
credits=int(input('How many credits do you have\n'))
if height>=137 and credits>=10:
  print('Enjoy the ride!')
elif height<137 and credits>=10:
  print('You are not tall enough to ride.')
elif height>=137 and credits<10:
  print('You dont have enough credits.')
else:
  print('You dont have height neither credits')




Gryffindor=0
Ravenclaw=0
Hufflepuff=0
Slytherin=0
a=int(input("Do you like Dawn or Dusk\n"
           " 1) Dawn \n"
           " 2) Dusk\n"))
if a==1:
  Gryffindor+=1
  Ravenclaw+=1
elif a==2:
  Hufflepuff+=1
  Slytherin+=1
else:
  print('Wrong input dumbass')
b = int(input("When I'm dead, I want people to remember me as:\n"
              " 1) The Good \n"
              " 2) The Great \n"
              " 3) The Wise \n"
              " 4) The Bold \n"))
if b==1:
  Hufflepuff+=2
elif b==2:
  Slytherin+=2
elif b==3:
  Ravenclaw+=2
elif b==4:
  Gryffindor+=2
else:
  print('Wrong input dumbass')

c=int(input("Which kind of instrument most pleases your ear\n"
            "1) The violin\n"
            "2) The trumpet\n"
            "3) The piano\n"
            "4) The drum\n"))

if c==1:
  Slytherin+=4
elif c==2:
  Hufflepuff+=4
elif c==3:
  Ravenclaw+=4
elif c==4:
  Gryffindor+=4
else:
  print(f"Wrong input dumbass\n")
print(f"Gryffindor points: {Gryffindor}")
print(f"Ravenclaw points:{Ravenclaw}")
print(f"Hufflepuff points:{Hufflepuff}")
print(f"Slytherin points: {Slytherin}")
house_scores = {
    "Gryffindor": Gryffindor,
    "Ravenclaw": Ravenclaw,
    "Hufflepuff": Hufflepuff,
    "Slytherin": Slytherin
}

max_points = max(house_scores.values())
winning_houses = [house for house, points in house_scores.items() if points == max_points]
if len(winning_houses) > 1:
    print(f"It's a tie between: {', '.join(winning_houses)}!")
else:
    print(f"🏅 House with the most points: {winning_houses[0]}")


for bottles in range(99, 0, -1):
    if bottles > 1:
        print(f"{bottles} bottles of beer on the wall, {bottles} bottles of beer.")
        print(f"Take one down and pass it around, {bottles - 1} bottles of beer on the wall.\n")
    elif bottles == 1:
        print(f"{bottles} bottle of beer on the wall, {bottles} bottle of beer.")
        print("Take one down and pass it around, no more bottles of beer on the wall.\n")

print("No more bottles of beer on the wall, no more bottles of beer.")
print("Go to the store and buy some more, 99 bottles of beer on the wall!")



for i in range(1,100):
  if i%3==0 and i%5==0:
    print("FizzBuzz")
  elif i%3==0:
    print("Fizz")
  elif i%5==0:
    print("Buzz")
  else:
    print(i)

#dictionary
art={
  'artist':'Antonio Stradivari',
  'culture':'Cremona',
  'date':'1693',
}
print(art['artist'])

fruits1={'strawberry', 'grapes', 'apples', 'pineapple'}
fruits2={'raspberry', 'banana', 'orange','strawberry'}
intersectionresult=fruits1.intersection(fruits2)
unitresult=fruits1.union(fruits2)
print(unitresult)
print(intersectionresult)