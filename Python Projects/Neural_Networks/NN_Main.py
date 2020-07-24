import pandas as pd
import numpy as np
import boto3
from NeuralNet import NeuralNet

tic_tac_toe_data = pd.read_csv('tic-tac-toe.data', sep=",", header=None)

functions = ["sigmoid", "tanh", "relu"]

neural_network = NeuralNet(tic_tac_toe_data)
neural_network.train(functions[0])
print("")
print("===============================================")
print("")
neural_network.predict(functions[0])