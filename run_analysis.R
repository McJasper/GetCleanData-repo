# Clear environment
rm(list=ls())

setwd("D:/Programming Exercises/Coursera/Getting and Cleaning Data/Programming Exercise")

# Load Dependencies
library(dplyr)
library(assertthat)

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

# Get Test Subject list
testSubjectsVector <- read.table(unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/test/subject_test.txt"),
                                 col.names = "SubjectId")

# Get Test data
xTestDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/test/X_test.txt")
xTestData <- read.table(file = xTestDatafile, header = F)
# Get test data annotations
yTestDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/test/y_test.txt")
yTestData <- unlist(read.table(file = yTestDatafile))

# Assign column annotations to test data
colnames(xTestData) <- featureNames

# Assign row annotations to factor
xTestData$RowAnnotation <- yTestData

# Indicate test SubjectId
xTestData$SubjectId <- testSubjectsVector$SubjectId

# Get Train subject list
trainSubjectVector <- read.table(unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/train/subject_train.txt"), 
                            col.names = "SubjectId")

# Get Train data
xTrainDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/train/X_train.txt")
xTrainData <- read.table(file = xTrainDatafile, header = F)
# Get train data annotations
yTrainDatafile <- unzip(zipfile = "zipData.zip", files = "UCI HAR Dataset/train/y_train.txt")
yTrainData <- unlist(read.table(file = yTrainDatafile))

# Assign column annotations to training data
colnames(xTrainData) <- featureNames 
# Assign row annotations to factor
xTrainData$RowAnnotation <- yTrainData

# Indicate Subject
xTrainData$SubjectId <- trainSubjectVector$SubjectId

rm(trainSubjectVector, testSubjectsVector)

#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #2 is performed:
# Extracts only the measurements on the mean and standard deviation for each measurement.
testDataSelection <- select(.data = xTestData, matches("mean|std|RowAnnotation|SubjectId"))
trainDataSelection <- select(.data = xTrainData, matches("mean|std|RowAnnotation|SubjectId"))

rm(xTestData, xTrainData, yTestData, yTrainData)
#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #1 is performed:
# Merges the training and the test sets to create one data set.

# Join frames by rbind()
### Only bind frames if columns are identical!!!
if(assertthat::are_equal(names(testDataSelection), names(trainDataSelection))){
  firstTidyDataset <- rbind(testDataSelection, trainDataSelection)
  }else{stop("Datasets failed to rbind.  Stopping execution.")}

rm(testDataSelection, trainDataSelection)
#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #3 is performed:
# Uses descriptive activity names to name the activities in the data set
# Create a meaningful factor for the activities
activityConverter <- as.vector(unlist(read.table("UCI HAR Dataset/activity_labels.txt")[2]))
firstTidyDataset$Activity <- factor(activityConverter[firstTidyDataset$RowAnnotation], ordered = T)
firstTidyDataset<- firstTidyDataset[,-which(colnames(firstTidyDataset) == "RowAnnotation")]

#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #4 is performed:
# Appropriately labels the data set with descriptive variable names.
# Remove original variable numbering
names(firstTidyDataset) <- gsub(pattern = "[0-9]{1,3} ", replacement = "", x = names(firstTidyDataset)) 
# Substitute 't' for time measurements
names(firstTidyDataset) <- gsub(pattern = "^t", replacement = "time", x = names(firstTidyDataset)) 
  # Substitute 'Acc' for Accelerometer measurements
names(firstTidyDataset) <- gsub(pattern = "Acc", replacement = "Accelerometer", x = names(firstTidyDataset))
  # Substitute 'Gyro' for Gyroscope measurements 
names(firstTidyDataset) <- gsub(pattern = "Gyro", replacement = "Gyroscope", x = names(firstTidyDataset))
  # Substitute 'Mag' for Magnitude
names(firstTidyDataset) <- gsub(pattern = "Mag", replacement = "Magnitude", x = names(firstTidyDataset))
  # Lastly, substitute 'f' for Fourier Transformed values
names(firstTidyDataset) <- gsub(pattern = "^f", replacement = "Fourier", x = names(firstTidyDataset))

# Make more meaningful Subject Ids as a factor
firstTidyDataset$SubjectId <- factor(paste0("Subject", unlist(firstTidyDataset$SubjectId)))

#~~~~~~~~~~~~~~~~~
# **FOR GRADERS** Here is where point #5 is performed:
# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
secondTidyDataset <- group_by(.data = firstTidyDataset, SubjectId, Activity)
secondTidyDataset <- summarise_all(secondTidyDataset, mean)






