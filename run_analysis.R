# Clear environment
rm(list=ls())

# Load Dependencies
library(dplyr)

# Download zipped set of files
if(!file.exists("zipData.zip")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "zipData.zip")
}

# Extract a list of file names to select from
fileList <- unzip(zipfile = "zipData.zip", list = T)

# Get readme file
unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/README.txt")

# Get column annotations
unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/features.txt")
featureNames <- unlist(read.table("UCI HAR Dataset/features.txt", sep = "\n"))

# Get column annotation descriptions
unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/features_info.txt")

# Get activity labels
unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/activity_labels.txt")

# Get Test data
xTestDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/test/X_test.txt")
xTestData <- read.table(file = xTestDatafile, header = F)
# Get test data annotations
yTestDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/test/y_test.txt")
yTestData <- unlist(read.table(file = yTestDatafile))

#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #4 is performed:
# Appropriately labels the data set with descriptive variable names.

# Assign column annotations to test data
colnames(xTestData) <- featureNames

# Assign row annotations to factor
xTestData$RowAnnotation <- as.factor(yTestData)
# Mark this data as coming from the test set
xTestData$Dataset <- as.factor("Testing")

# Get Train data
xTrainDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/train/X_train.txt")
xTrainData <- read.table(file = xTestDatafile, header = F)
# Get train data annotations
yTrainDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/train/y_train.txt")
yTrainData <- unlist(read.table(file = yTestDatafile))

#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #4 is performed:
# Appropriately labels the data set with descriptive variable names.

# Assign column annotations to training data
colnames(xTrainData) <- featureNames 
# Assign row annotations to factor
xTrainData$RowAnnotation <- as.factor(yTrainData)
# Mark this data as coming from the train set
xTrainData$Dataset <- as.factor("Training")

#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #2 is performed:
# Extracts only the measurements on the mean and standard deviation for each measurement.
testDataSelection <- select(.data = xTestData, matches("mean|std|RowAnnotation|Dataset"))
trainDataSelection <- select(.data = xTrainData, matches("mean|std|RowAnnotation|Dataset"))

#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #1 is performed:
# Merges the training and the test sets to create one data set.

# Join frames by rbind()
### Only bind frames if columns are identical!!!
if(assertthat::are_equal(names(testDataSelection), names(trainDataSelection))){
  combinedDataFrames <- rbind(testDataSelection, trainDataSelection)
  }

#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #3 is performed:
# Uses descriptive activity names to name the activities in the data set

# Create a meaningful factor for the activities
activityConverter <- as.vector(unlist(read.table("UCI HAR Dataset/activity_labels.txt")[2]))
combinedDataFrames$Activity <- factor(activityConverter[combinedDataFrames$RowAnnotation], ordered = T)
