# Linear Regression

A gradient-descent linear-regression model implemented from scratch with NumPy, then benchmarked against scikit-learn's `SGDRegressor` on the UCI solar-flare dataset. Includes custom data preprocessing and a train/test split.

## Setup
```bash
python3 -m venv linRegression
source linRegression/bin/activate    # Windows: linRegression\Scripts\activate
pip3 install -r requirements.txt
```

## Notes on the logs
The folder includes text logs of training/test runs. Weight vectors are logged as arrays parsed into strings, which makes the layout dense — search for the iteration count to find where each run begins.

## Libraries
pandas · numpy · scikit-learn
