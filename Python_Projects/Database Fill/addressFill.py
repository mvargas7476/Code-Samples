import mysql.connector
from faker import Faker

fake = Faker()

mydb = mysql.connector.connect(
  host = "127.0.0.1",
  user = "",
  password = "",
  database = ""
)

addressTable = "AddressInfo"

# # Starting here, a for loop will take care of this section
for row in range (1, 10):

    rowID = row
    personID = row
    address1 = fake.street_address()
    city = fake.city()
    state = fake.state_abbr()
    zipNumber = fake.zipcode()
   
    mycursor = mydb.cursor()

    sql = "INSERT INTO " + addressTable + " (fakeID, addressID, personID, streetAddress, city, state, zip) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    val = (rowID, rowID, personID, address1, city, state, zipNumber)
    mycursor.execute(sql, val)

    mydb.commit()
    
    if(row % 10000 == 0):
      print("Record Number: " + str(row))

print("All records inserted")