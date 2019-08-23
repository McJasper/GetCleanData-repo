# CookBook.md
This is the "CookBook" for the Getting and Cleaning Data course project.

## The Data
### Source
The dataset was obtained from the following url: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

The .zip file was worked with directly.  No transformations of the data were performed prior
to data processing.

For full information on the data set, see the 'README.txt' file extracted by the
run_analysis.R script

### Data Processing
The included script "run_analysis.R" is the main data processing script in this project.
First, it collects the data from the source listed above.  Then, it extracts out several
files which are then filtered, keeping only mean and standard deviation features.  This
data is merged together to give the 'firstTidyDataset' object.  The features of this
table have their names expanded upon, and finally a second data frame 'secondTidyDataset'
is generated containing the mean value of each subject per activity performed of all
the retained features.


### Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeAccelerometer-XYZ and timeGyroscope-XYZ. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAccelerometer-XYZ and timeGravityAccelerometer-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerometerJerk-XYZ and timeBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerometerMagnitude, timeBodyGyroscopeMagnitude, timeBodyAccelerometerJerkMagnitude, timeBodyGyroscopeMagnitude, timeBodyGyroscopeJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fourierBodyAccelerometer-XYZ, fourierBodyAccelerometerJerk-XYZ, fourierBodyGyro-XYZ, fourierBodyAccJerkMag, fourierBodyGyroMag, fourierBodyGyroJerkMag.

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

Only mean and standard deviation of raw measurements were retained by the run_analysis.R script.

The complete list of variables of each feature vector is available in 'features.txt'


