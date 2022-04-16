# Creating Virtual Environment
Here are the steps that are needed to run the project in a terminal with BASH:
    1. python3 -m venv linRegression
    2. source linRegression/bin/activate
        - This will create a virtual environment to install all the requirements
    3. pip3 install -r requirements.txt
    4. run the desired python project (listed below)
        - K-Cluster_Data.py
        - Quantizing_Images

# Data Description
## K-CLuster_Data
For the first time of the project I obtained the bitcoin data and calculated the SSE of the data using the sklearn.cluster library from scikit. The results of the experiments are saved on the "K-Cluster_Log" file. The more k-clusters that I created the smaller the error of the program. Which makes sense. The higher the value of k the more clusters you have and the better the data is separated by the program. Which means that the distance between individual points and the centroid of the cluster is smaller. As an added note, the objective of this project is use to reduce the error of the project, which means that the distance between the individual points and their centroids is decreasing.

## Quantizing_Images
Once the project runs, the quantized picture will be opened for the user to see. Once the user closes the picture the project asks - in the console - to describe the picture. Once that has been added, the program will record the results of the program in the following order: Name of the picture used, Original size, K clusters, New Size, Description added by the user on the console.