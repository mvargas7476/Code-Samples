import pymysql
import random
from faker import Faker

fake = Faker()

mydb = pymysql.connect(
  host = "127.0.0.1",
  user = "",
  password = "",
  database = ""
)

jobTable = "JobInfo"
genderArr = ['M', 'F']

# # Starting here, a for loop will take care of this section
for row in range (1, 1000001):
    currentWorker = random.randint(0, 1)  

    rowID = row
    gender = genderArr[random.randint(0, 1)]
    job = fake.job()
    start = fake.date_object()
    if (currentWorker == 0):
        end = fake.date_between("-31y", "-11y")
    else:
        end = None
    salary = str(random.randint(50000, 150000))

    mycursor = mydb.cursor()

    sql = "INSERT INTO " + jobTable + " (employeeID, personID, gender, jobTitle, startDate, endDate, salary) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    val = (rowID, rowID, gender, job, start, end, salary)
    mycursor.execute(sql, val)


    mydb.commit()
    if(row % 10000 == 0):
        print("Record Number: " + str(row))

print("All records inserted")