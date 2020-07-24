import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import SGDRegressor
from sklearn.pipeline import Pipeline
from sklearn.metrics import mean_squared_error
from DataFrame import DataFrameClass
from LinRegCalc import LinRegCalc

dataFrame = DataFrameClass("flare.data1.txt")
linCalc = LinRegCalc()

#Storing the data to create train and test matrices
x = dataFrame.getXTrainData()
y = dataFrame.getYTrainData()

xt = dataFrame.getXTestData()
yt = dataFrame.getYTestData()

# #Creating the Train Vectors
xTrain = x.to_numpy()
yTrain = y.to_numpy().transpose().flatten()

# #Creating the Test Vectors
xTest = xt.to_numpy()
yTest = yt.to_numpy().transpose().flatten()

maxIterations = 10000
tolerance = 1e-3

#Creates the pipelone for the gradient descent
pipe_sgd = Pipeline([('scl', StandardScaler()),
                    ('sgd', SGDRegressor(max_iter=maxIterations, tol=tolerance))])

#user variables to obtain the scaler and regresor
scaler = pipe_sgd.named_steps['scl']
regressor = pipe_sgd.named_steps['sgd']

#Doing regression o the training data and getting the weight - coef and the r^2 - score
pipe_sgd.fit(xTrain, yTrain)
coefTrain = regressor.coef_
scoreTrain = regressor.score(xTrain, yTrain)

#calculating the mse for the train data
hTrain = np.dot(xTrain, coefTrain)
mseTrain = mean_squared_error(yTrain, hTrain)

linCalc.logLibValues("SkLearn_Train_Log.txt", maxIterations, tolerance, coefTrain, scoreTrain, mseTrain)

#doing regression on the test data and getting the weight - coef and the r^2 - score
pipe_sgd.fit(xTest, yTest)
coefTest = regressor.coef_
scoreTest = regressor.score(xTrain, yTrain)

#calculating the mse for the test data
hTest = np.dot(xTest, coefTest)
mseTest = mean_squared_error(yTest, hTest)

linCalc.logLibValues("SkLearn_Test_Log.txt", maxIterations, tolerance, coefTest, scoreTest, mseTest)