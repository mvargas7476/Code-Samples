import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
from skimage import io
import os.path

# Method to Print to the text file with the results and the formatting of such file
def writeResult (fileName, imgName, fileSize, kVal, newSize):
    imgQual = input("Quality Description: ")
    if (os.path.exists(fileName) == False):
        f = open(fileName, "w")
        f.write("{:^20}".format("Image Used") + "   :   "
            + "{:^15}".format("Original size") + "   :   "
            + "{:^15}".format("K Value") + "   :   "
            + "{:^15}".format("New Size") + "   :   "
            + "{:^15}".format("Image Quality") + "\n")

        f.write("{:^20}".format(imgName) + "   :   "
            + "{:^15}".format(str(fileSize)) + "   :   "
            + "{:^15}".format(str(kVal)) + "   :   "
            + "{:^15}".format(str(newSize)) + "   :   "
            + "{:^15}".format(str(imgQual)) + "\n")
        f.close()
    else:
        f = open(fileName, "a")
        f.write("{:^20}".format(imgName) + "   :   "
            + "{:^15}".format(str(fileSize)) + "   :   "
            + "{:^15}".format(str(kVal)) + "   :   "
            + "{:^15}".format(str(newSize)) + "   :   "
            + "{:^15}".format(str(imgQual)) + "\n")
        f.close()

# Gets the img size for use
def getImgSize(fileName):
    picSize = str(os.path.getsize('quantizedImages/' + fileName + '.png'))
    picSize = picSize[0:2]
    picSize = picSize + "Kb"
    return picSize

# Creates the quantized image
# Stores image in quantizedImage folder, and creates output
def picResize(arrPos, kCluster):
    imgIndex = arrPos - 1

    # Array containing the picture names, for easy access
    picArr = ['Project_Picture1.jpg', 'Project_Picture2.jpg','Project_Picture3.jpg', 'Profile Picture.jpg']
    picSize = {picArr[0]: "364Kb", picArr[1]: "613Kb", picArr[2]: "549Kb", picArr[3]: "22Kb"}
    imgLen = len(picArr[imgIndex]) - 4

    # Obtaining the original picture, and setting the number of clusters
    print("Reading image " + picArr[imgIndex])
    original = io.imread(picArr[imgIndex])
    n_colors = kCluster
    fileName = "Quantizing_Images_Log.txt"

    # Begin reshaping the original image based on the number of clusters
    print("Reshaping the image")
    arr = original.reshape((-1, 3))
    kmeans = KMeans(n_clusters = n_colors, random_state = 42).fit(arr)
    labels = kmeans.labels_
    centers = kmeans.cluster_centers_
    lessColors = centers[labels].reshape(original.shape).astype('uint8')

    # Displays the newly quantized image for the user to see
    print("Displaying the Image")
    io.imshow(lessColors)
    plt.axis('off')
    plt.title('Resized ' + picArr[imgIndex][0:imgLen])
    plt.savefig('quantizedImages/' + picArr[imgIndex][0:imgLen] + '.png')
    plt.show()

    # Asks the user to insert a description of the quantized picture, then adds the results to the table
    print("Writing resuls")
    writeResult(fileName, picArr[imgIndex][imgLen - 1], picSize[picArr[imgIndex]], n_colors, getImgSize(picArr[imgIndex][0:imgLen]))

# Creates the folder quantizedImage to save the images inside of it
dirName = "quantizedImages"
if not os.path.exists(dirName):
    os.mkdir(dirName)
    print("Directory " , dirName ,  " Created ")

# Runs the algorithm for the picture chosen, values can be 1, 2, 3
picResize(4, 4)