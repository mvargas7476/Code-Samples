import numpy as np
import pandas as pd
import os.path
from sklearn.model_selection import train_test_split
from sklearn import preprocessing


class NeuralNet:
    def __init__(self, dataFile, h=2):
        processed_data = self.preprocess(dataFile)
        self.train_dataset, self.test_dataset = train_test_split(processed_data)
        ncols = len(self.train_dataset.columns)
        nrows = len(self.train_dataset.index)

        nTestCols = len(self.test_dataset.columns)
        nTestRows = len(self.test_dataset.index)

        self.X = self.train_dataset.iloc[:, 0:(ncols - 1)].values.reshape(nrows, ncols - 1)
        self.y = self.train_dataset.iloc[:, (ncols - 1)].values.reshape(nrows, 1)

        self.xTest = self.test_dataset.iloc[:, 0:(ncols-1)].values.reshape(nTestRows, nTestCols - 1)
        self.yTest = self.test_dataset.iloc[:, (ncols - 1)].values.reshape(nTestRows, 1)

        # Find number of input and output layers from the dataset
        input_layer_size = len(self.X[1])
        if not isinstance(self.y[0], np.ndarray):
            self.output_layer_size = 1
        else:
            self.output_layer_size = len(self.y[0])

        # assign random weights to matrices in network
        # number of weights connecting layers = (no. of nodes in previous layer) x (no. of nodes in following layer)
        self.W_hidden = 2 * np.random.random((input_layer_size, h)) - 1
        self.Wb_hidden = 2 * np.random.random((1, h)) - 1

        self.W_output = 2 * np.random.random((h, self.output_layer_size)) - 1
        self.Wb_output = np.ones((1, self.output_layer_size))

        self.deltaOut = np.zeros((self.output_layer_size, 1))
        self.deltaHidden = np.zeros((h, 1))
        self.h = h

    # Processes the date before it is split into train and test
    def preprocess(self, dataFile):
        dataFile = dataFile.drop_duplicates()
        for i in range(0, 9):
            dataFile = dataFile.replace({i: {'x': 1, 'o': 2, 'b': 0}})

        dataFile = dataFile.replace({9: {'positive': 1, 'negative': 2}})
        processedFile = pd.DataFrame(preprocessing.normalize(dataFile))
        return processedFile

    # Calls different method based on the activation chosen: sigmoid, tanh, relu
    def activationFunc(self, m, activation):
        if activation == "sigmoid":
            self.sigCalc(m)
        if activation == "tanh":
            self.tanhCalc(m)
        if activation == "relu":
            self.reluCalc(m)

    # Based on the activation a different derivative method is called upon
    def derivativeActivation(self, m, activation):
        if activation == "sigmoid":
            self.sigDerivative(m)
        if activation == "tanh":
            self.tanhDerivative(m)
        if activation == "relu":
            self.reluDerivative(m)

    # This defines the funcions and the derivatives
    def sigCalc(self, m):
        return 1 / (1 + np.exp(-m))

    def sigDerivative(self, m):
        return m * (1 - m)

    def tanhCalc(self, m):
        return np.tanh(m)

    def tanhDerivative(self, m):
        return 1 - np.power(np.tanh(m), 2)

    def reluCalc(self, m):
        return np.maximum(0, m)

    def reluDerivative(self, m):
        if m.any() >= 0:
            return 1
        else:
            return 0

    # Below is the training function, calculatest the forward and the backward pass
    def train(self, activationFunc, max_iterations=10000, learning_rate=0.25):
        for iteration in range(max_iterations):

            out = self.forward_pass(activationFunc)
            trainError = 0.5 * np.power((out - self.y), 2)
            self.backward_pass(out, activationFunc)

            update_weight_output = learning_rate * np.dot(self.X_hidden.T, self.deltaOut)
            update_weight_output_b = learning_rate * np.dot(np.ones((np.size(self.X, 0), 1)).T, self.deltaOut)

            update_weight_hidden = learning_rate * np.dot(self.X.T, self.deltaHidden)
            update_weight_hidden_b = learning_rate * np.dot(np.ones((np.size(self.X, 0), 1)).T, self.deltaHidden)

            self.W_output += update_weight_output
            self.Wb_output += update_weight_output_b
            self.W_hidden += update_weight_hidden
            self.Wb_hidden += update_weight_hidden_b

        print("After " + str(max_iterations) + " iterations, the total train error is " + str(np.sum(trainError)))
        print("The final weight vectors are (starting from input to output layers) \n" + str(self.W_hidden))
        print("The final weight vectors are (starting from input to output layers) \n" + str(self.W_output))

        print("The final bias vectors are (starting from input to output layers) \n" + str(self.Wb_hidden))
        print("The final bias vectors are (starting from input to output layers) \n" + str(self.Wb_output))

        if (os.path.exists("Training_Data_Table.txt") == False):
            f = open("Training_Data_Table.txt", "w")
            f.write("{:^15}".format("Iterations") + "   :   " 
                    + "{:^15}".format("Train Error") + "   :   "
                    + "{:^15}".format("Learning Rate") + "   :   "
                    + "{:^15}".format("Activation Function") + "\n")

            f.write("{:^15}".format(str(max_iterations)) + "   :   " 
                    + "{:^15}".format("{:.4f}".format(np.sum(trainError))) + "   :   "
                    + "{:^15}".format(str(learning_rate) + "   :   "
                    + "{:^15}".format(activationFunc)+ "\n"))
            f.close()
        else:
            f = open("Training_Data_Table.txt", "a")
            f.write("{:^15}".format(str(max_iterations)) + "   :   " 
                    + "{:^15}".format("{:.4f}".format(np.sum(trainError))) + "   :   "
                    + "{:^15}".format(str(learning_rate) + "   :   "
                    + "{:^15}".format(activationFunc) + "\n"))
            f.close()

    def forward_pass(self, activation):
        # pass our inputs through our neural network
        in_hidden = np.dot(self.X, self.W_hidden) + self.Wb_hidden
        if activation == "sigmoid":
            self.X_hidden = self.sigCalc(in_hidden)
        if activation == "tanh":
            self.X_hidden = self.tanhCalc(in_hidden)
        if activation == "relu":
            self.X_hidden = self.reluCalc(in_hidden)

        in_output = np.dot(self.X_hidden, self.W_output) + self.Wb_output
        if activation == "sigmoid":
            out = self.sigCalc(in_output)
        if activation == "tanh":
            out = self.tanhCalc(in_output)
        if activation == "relu":
            out = self.reluCalc(in_output)
        return out

    def backward_pass(self, out, activation):
        # pass our inputs through our neural network
        self.compute_output_delta(out, activation)
        self.compute_hidden_delta(activation)

    def compute_output_delta(self, out, activation):
        if activation == "sigmoid":
            delta_output = (self.y - out) * (self.sigDerivative(out))
        if activation == "tanh":
            delta_output = (self.y - out) * (self.tanhDerivative(out))
        if activation == "relu":
            delta_output = (self.y - out) * (self.reluDerivative(out))

        self.deltaOut = delta_output

    def compute_hidden_delta(self, activation):
        if activation == "sigmoid":
            delta_hidden_layer = (self.deltaOut.dot(self.W_output.T)) * (self.sigDerivative(self.X_hidden))
        if activation == "tanh":
            delta_hidden_layer = (self.deltaOut.dot(self.W_output.T)) * (self.tanhDerivative(self.X_hidden))
        if activation == "relu":
            delta_hidden_layer = (self.deltaOut.dot(self.W_output.T)) * (self.reluDerivative(self.X_hidden))

        self.deltaHidden = delta_hidden_layer

    # Performs the forward pass on the test data set
    def forward_pass_test(self, activation):
        in_hidden = np.dot(self.xTest, self.W_hidden) + self.Wb_hidden
        if activation == "sigmoid":
            self.xTest_hidden = self.sigCalc(in_hidden)
        if activation == "tanh":
            self.xTest_hidden = self.tanhCalc(in_hidden)
        if activation == "relu":
            self.xTest_hidden = self.reluCalc(in_hidden)

        in_output = np.dot(self.xTest_hidden, self.W_output) + self.Wb_output
        if activation == "sigmoid":
            out = self.sigCalc(in_output)
        if activation == "tanh":
            out = self.tanhCalc(in_output)
        if activation == "relu":
            out = self.reluCalc(in_output)
        return out

    # Prediction function of the test data set
    def predict(self, activationFunc):
        out = self.forward_pass_test(activationFunc)
        testError = 0.5 * np.power((out - self.yTest), 2)
        print("the total error of the prediction is: \n" + str(np.sum(testError)))
