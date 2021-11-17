import string
import random
import time
import sqlite3
import hashlib, binascii
import os

#variables
chars = string.ascii_letters + string.digits
salt = string.punctuation
word = ''  
hase = ''

#directory change
os.chdir('random-g') #change here

#sqilite database lol
conn = sqlite3.connect('ranwords.sqlite')
cur = conn.cursor()
cur.executescript('''

CREATE TABLE IF NOT EXISTS Words (
    ran    TEXT UNIQUE,
    hash_id TEXT UNIQUE
);

''')

#inputs!!
select = input("use special characters ? Y OR N ")
num = input("how many strings ?")
length = input('how many letters ?')

#num-default
try:
    num = int(num)
    length = int(length)
except:
    num = 64
    length = 64

def words(num,selector,width,word):
# words creation
    for i in range(0,num):         
        if (str.upper(selector) == 'Y' or selector == ''):
            word = ''.join(random.choice(chars+salt) for i in range(0,width))
        else:
            word = ''.join(random.choice(chars) for i in range(0,width))

# encryptor sha256 (you can change the enpcrytion to md5, sha1 ...etc , just change the first paramter)
        lol = hashlib.pbkdf2_hmac('sha256', word.encode('utf-8'), salt.encode('utf-8'), 1000000)
        hase = binascii.hexlify(lol)
        hase = str(hase)

# putting everything in a .txt
        with open('words.txt', 'a+') as fale:
            fale.write(word + '  ' + hase + '/n')

# database save and commit
        cur.execute(''' INSERT INTO Words (ran, hash_id) VALUES (?, ?)''',(word,hase))
        conn.commit()
    return 0


#bodyprogram
while True:
    words(num,select,length,word)
    break
print(time.process_time())
