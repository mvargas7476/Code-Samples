import numpy as np
from DataFrame import DataFrameClass
from LinRegCalc import LinRegCalc

dataFrame = DataFrameClass("flare.data1.txt")

# Storing the data to create train and test Matrices
x = dataFrame.getXTrainData()
y = dataFrame.getYTrainData()

xt = dataFrame.getXTestData()
yt = dataFrame.getYTestData()

# Creating the Train Vectors
xTrain = x.to_numpy()
yTrain = y.to_numpy()

# #Creating the Test Vectors
xTest = xt.to_numpy()
yTest = yt.to_numpy()

linCalc = LinRegCalc()

colunnsNum = dataFrame.getColumns()

wVector = linCalc.originWeight(int(len(colunnsNum)))

# Based on trials, these parameters gave the most accurate results
maxIterations = 10000
learningRate = .0001

# Linear regression for the train data
mseTrain = linCalc.linearReg(maxIterations, xTrain, wVector, yTrain, learningRate)

print(linCalc.predictY([1, 3, 2, 1, 2, 1, 1, 2, 0, 0, 0]))