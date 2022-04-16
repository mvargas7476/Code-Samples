# Creating Virtual Environment
Here are the steps that are needed to run the project in a terminal with BASH:
    1. python3 -m venv linRegression
    2. source linRegression/bin/activate
        - This will create a virtual environment to install all the requirements
    3. pip3 install -r requirements.txt

# Results Notes
## Description of  for Sklearn logs:
This folder also contains the text files created that log the attempts on the data and the results that I obtained. Its worth to mention that the weight values of the project was returned as an array and parsed into a String. This creates a confusing layout for the log. One that luckily it is not impossible to read. It is easier to search for the number of iterations to understand where each new line begins

## Libraries used in this project:
These are the libraries used for part 2 of the project: pandas, numpy, boto3, scikit-learn. All of these libraries are in the requirements.txt file that needs to be installed to run the code