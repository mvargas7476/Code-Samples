# Neural Networks

A feed-forward neural network implemented from scratch — sigmoid, tanh, and ReLU activations with backpropagation — trained on the UCI Tic-Tac-Toe Endgame dataset.

- **Dataset:** https://archive.ics.uci.edu/ml/datasets/Tic-Tac-Toe+Endgame

## Setup
```bash
python3 -m venv neuralNetwork
source neuralNetwork/bin/activate    # Windows: neuralNetwork\Scripts\activate
pip3 install -r requirements.txt
python3 NN_Main.py
```

## Results table
The generated table (`Training_Data_Table.txt`) summarizes each training run: the error, the activation function used, the learning rate, and the number of iterations.

## Libraries
pandas · numpy · scikit-learn (used only for `train_test_split` / preprocessing)
