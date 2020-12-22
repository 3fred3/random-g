import string
import random

#variables
chars = string.ascii_letters + string.digits
s_chars = string.punctuation

#inputs??
tie = input("use special characters ? Y OR N ")
rg = input("how many strings ? ")
num = input('how manny letters ?')

#num-default
try:
    num = int(num)
except:
    num = 64

#bodyprogram
for i in range(0,int(rg)):
    word = ''
    if (str.upper(tie) == 'Y' or tie == ''):
        word = ''.join(random.choice(chars+s_chars) for i in range(0,num))

    else:
        word = ''.join(random.choice(chars) for i in range(0,num))

    print(word + "\n")
