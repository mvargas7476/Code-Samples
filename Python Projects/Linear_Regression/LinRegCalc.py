import numpy as np
import pandas as pd
import os.path
import random

class LinRegCalc:
    weightVector = 0

    # Uses all of the parameters to calculte the linear regression based on the data given
    def linearReg(self, reps, dataVector, randomWeight, targetVector, learningRate):
        self.weightVector = 0

        for i in range(0,reps):
            hVector = np.dot(dataVector, randomWeight)
            eVector = np.subtract(hVector, targetVector)
            lRate = learningRate
            errorLength = len(eVector)
            mse = 0
            total = 0

            for i in range(0, errorLength-1):
                total += (eVector[i,0] * dataVector[i,0])

            total /= 187

            for i in range(0,10):
                wNew = randomWeight[i,0] - (learningRate*total)
                np.put(randomWeight, [i,0] , wNew)
        
        self.weightVector = randomWeight
        hVector = np.dot(dataVector, randomWeight)
        eVector = np.subtract(hVector, targetVector)

        mse = self.mseCalculator(eVector)

        return mse

    #Training vector is used to create the prediction for the data
    def testPrediction(self, dataVector, weightVector):
        hVector = np.dot(dataVector, weightVector)

    #Creates the original weight vector
    def originWeight (self, columnNumber):
        weight = []

        for i in range(0, columnNumber):
            weight.append(random.random())

        wVectorData = pd.DataFrame(weight)
        wVector = wVectorData.to_numpy()
        return wVector

    #Calculates the MSE Value
    def mseCalculator (self, errorVector):
        mseValue = 0
        length = len(errorVector)

        for i in range (0, length - 1):
            mseValue += errorVector[i,0] * errorVector[i,0]

        mseValue = (.5/length) * mseValue
        return mseValue

    # Logging in the values
    def logValues(self, fileName, lRate, mseValue, iterations):
        if (os.path.exists(fileName) == False):
            f = open(fileName, "w")
            f.write("{:^15}".format("Learning Rate") + "   :   " 
                    + "{:^15}".format("MSE Value") + "   :   "
                    + "{:^15}".format("Iteration") + "\n")

            f.write("{:^15}".format(str(lRate)) + "   :   " 
                    + "{:^15}".format("{:.4f}".format(mseValue)) + "   :   "
                    + "{:^15}".format(str(iterations) + "\n"))
            f.close()
        else:
            f = open(fileName, "a")
            f.write("{:^15}".format(str(lRate)) + "   :   " 
                    + "{:^15}".format("{:.4f}".format(mseValue)) + "   :   "
                    + "{:^15}".format(str(iterations) + "\n"))
            f.close()

    # Logging in the values for the Scikit Library Log
    def logLibValues(self, fileName, iter, toler, weightV, rSquared, mseValue):
        if (os.path.exists(fileName) == False):
            f = open(fileName, "w")
            f.write("{:^15}".format("Iterations") + "   :   "
                    + "{:^15}".format("Tolerance") + "   :   "
                    + "{:^15}".format("MSE Value") + "   :   " 
                    + "{:^15}".format("R^2") + "   :   "
                    + "{:^15}".format("Weight Vector") + "\n")

            f.write("{:^15}".format(str(iter)) + "   :   "
                    + "{:^15}".format(str(toler)) + "   :   "
                    + "{:^15}".format("{:.4f}".format(mseValue)) + "   :   " 
                    + "{:^15}".format("{:.4f}".format(rSquared)) + "   :   "
                    + "{:^15}".format(str(weightV) + "\n"))
            f.close()
        else:
            f = open(fileName, "a")
            f.write("{:^15}".format(str(iter)) + "   :   "
                    + "{:^15}".format(str(toler)) + "   :   "
                    + "{:^15}".format("{:.4f}".format(mseValue)) + "   :   " 
                    + "{:^15}".format("{:.4f}".format(rSquared)) + "   :   "
                    + "{:^15}".format(str(weightV) + "\n"))
            f.close()

    def getWeight(self):
        return(self.weightVector)

    def setWeight(self, wNew):
        self.weightVector = wNew

    # Predicts the needed value of y based on the training and testing data
    def predictY(self, dataVector):
        hVector = np.dot(dataVector, self.weightVector)
        return hVector

