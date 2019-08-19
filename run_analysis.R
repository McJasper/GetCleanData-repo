download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              destfile = "zipData.zip")

fileList <- unzip(zipfile = "zipData.zip", list = T)

# Get Test data
xTestDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/test/X_test.txt")
xTestData <- read.table(file = xTestDatafile, header = F)

yTestDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/test/y_test.txt")
yTestData <- read.table(file = yTestDatafile)

# Gest Train data

# Merge the datasets and label test/train with a factor


# Open feature file and extract feature names to column headers

# open activity_labels and assign the yTestData to the correct movement type

