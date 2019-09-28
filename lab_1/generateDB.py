from faker import Faker
from random import randint
from random import uniform
from random import choice

MAX_N = 1000

sex = ['m', 'f']


def generate_people():
    faker = Faker()
    f = open('people.csv', 'w')
    for i in range(MAX_N):
        age = randint(0, 111)
        h = randint(40, 250)
        w = h * h * 0.00225 + randint(0, 15)
        calorie_norm = randint(1000,3000)
        line = "{0},{1},{2},{3},{4},{5}\n".format(
                                                  faker.name(),
                                                  choice(sex),
                                                  age,
                                                  h,
                                                  int(w),
                                                  calorie_norm)
        f.write(line)
    f.close()

def generate_diet():
    f = open('diet.csv', 'w')
    fr = open('foodcode.txt', 'r')
    lines = []
    for line in fr:
        lines.append(line[0:-1])
    lenLines = len(lines)
    for i in range(MAX_N):
        line = "{0},{1},{2}\n".format(randint(0, MAX_N -1),
                                      lines[randint(0,lenLines-1)],
                                      randint(1, 100)/10)
        f.write(line)
        
    f.close()
    fr.close()

if __name__ == "__main__":
    generate_people()
    #generate_diet()
        
