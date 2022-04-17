import mysql.connector
import names
import random
import datetime

mydb = mysql.connector.connect(
  host = "127.0.0.1",
  user = "",
  password = "",
  database = ""
)

personTable = "PersonInfo"

# Starting here, a for loop will take care of this section
for row in range (1, 1000001):

  day = random.randint(1, 28)
  month = random.randint(1,12)
  year = random.randint(1960, 2002)
  dateTest = datetime.datetime(year, month, day)

  rowID = row
  firstName = names.get_first_name()
  lastName = names.get_last_name()
  dob = dateTest.strftime("%Y-%m-%d")
  cell = str(random.randint(1000000000, 9999999999))

  mycursor = mydb.cursor()

  sql = "INSERT INTO " + personTable + " (fakeID, personID, firstName, lastName, dateOfBirth, cellPhone) VALUES (%s, %s, %s, %s, %s, %s)"
  val = (rowID, rowID, firstName, lastName, dob, cell)
  mycursor.execute(sql, val)

  mydb.commit()
  if(row % 100000 == 0):
    print("Record Number: " + str(row))

print("All records inserted")