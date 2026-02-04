import numpy as np  
import pandas as pd
from sklearn.cluster import KMeans
from sklearn import preprocessing
import os.path
import requests
from zipfile import ZipFile

# Method to Print to the text file and the format
def writeResult (fileName, expNum, kVal, errorVal):
    if (os.path.exists(fileName) == False):
        f = open(fileName, "w")
        f.write("{:^15}".format("Experiment Number") + "   :   "
            + "{:^15}".format("K-Value") + "   :   "
            + "{:^15}".format("Sum Squared Error") + "\n")

        f.write("{:^15}".format(str(expNum)) + "   :   "
            + "{:^15}".format(str(kVal)) + "   :   "
            + "{:^15}".format("{:.7f}".format(errorVal) + "\n"))
        f.close()
    else:
        f = open(fileName, "a")
        f.write("{:^15}".format(str(expNum)) + "   :   "
            + "{:^15}".format(str(kVal)) + "   :   "
            + "{:^15}".format("{:.7f}".format(errorVal) + "\n"))
        f.close()

# Downloading the data that is used by the project and extracting the information
url = "https://archive.ics.uci.edu/ml/machine-learning-databases/00526/data.zip"
r = requests.get(url) 
   
with open("BitcoinHeistData.zip",'wb') as f: 
    f.write(r.content) 

with ZipFile("BitcoinHeistData.zip", 'r') as zip: 
    zip.extractall() 

# Preprocessing the data
# Data is between years 2009 to 2018. Value 0 = 2009 and value 9 = 2018
# Dropped the columns of values that are not quantitative
# Created teh numpy arrary for the use of the k-cluster SSE calculation
data = pd.read_csv("BitcoinHeistData.csv", sep = ",", header = 0)
data = data.replace({"year": {2009: 0, 2010: 1, 2011: 2, 2012: 3, 2013: 4, 2014:5, 2015: 6,
                            2016: 7, 2017: 8, 2018: 9}})
data = data.drop(columns=["address", "looped","label","neighbors"])
data = data.drop_duplicates()
arrData = data.values
arrData = preprocessing.normalize(arrData)

fileName = "K-Cluster_Log.txt"
kVal = 2
expNum = 9

# # Calculating the SSE of the data
kmeans = KMeans(n_clusters= kVal).fit(arrData)
errorVal = kmeans.inertia_

# # Writing the table with the results
writeResult(fileName, expNum, kVal, errorVal)