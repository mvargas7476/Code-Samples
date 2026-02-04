import pandas as pd
import numpy as np

class DataFrameClass():
    msk = 0

    def __init__(self, data):
        self.data = pd.read_csv(data, sep=" ", header=None)
        self.data = self.data.drop_duplicates()
        self.data = self.data.replace({0: {'A':1, 'B':2,'C':3,'D':4,'E':5,'F':6,'H':7}})
        self.data = self.data.replace({1: {'X':1, 'R':2,'S':3,'A':4,'H':5,'K':6}})
        self.data = self.data.replace({2: {'X':1, 'O':2,'I':3,'C':4}})
        self.data = self.data.drop(columns = [6,7])
        
        self.msk = np.random.rand(len(self.data)) < 0.8
        
    def written (self):
        print(self.data)

    def getXTrainData (self):
        xData = self.data.copy()
        xData = xData.drop(columns = [0])
        xData.insert(loc=0, column=0, value=1)
        xTrainData = xData[self.msk]
        return xData

    def getYTrainData (self):
        yData = self.data[[0]].copy()
        yTrainData = yData[self.msk]
        return yData

    def getXTestData (self):
        xData = self.data.copy()
        xData = xData.drop(columns = [0])
        xData.insert(loc=0, column=0, value=1)
        xTestData = xData[~self.msk]
        return xTestData

    def getYTestData (self):
        yData = self.data[[0]].copy()
        yTestData = yData[~self.msk]
        return yTestData

    def getColumns (self):
        return (self.data.columns)
