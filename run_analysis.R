#########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Nimish Awalgaonkar
## 2015-02-21

# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

#Working Directory Information

# Folder in which the data is unzipped -- c:/Users/XYZ/Desktop/Project/Data_for_Project
# Current default working directory --  C:/Users/XYZ/Desktop/Project/Data_for_Project

###############################################################################################################################################################################

# I AM GRATEFUL TO hglenrock FOR SHARING HIS REPOSITORY (https://github.com/hglennrock/getting-cleaning-data-project/blob/master/run_analysis.R) ON THE GIVEN CLEANING AND GETTING DATA PROJECT.
# THE MAIN INSPIRATION AND APPROACH IN WRITING THIS run_analysis.R COMES FROM HIS WORK AND I HAVE TAKEN AN APPROACH SIMILIAR TO HIS APPROACH IN DEALING WITH THE GIVEN PROBLEM.

################################################################################################################################################################################

#loading the required libraries

library(plyr)



#Reading the required text data into R

test <- read.table("./test/X_test.txt")  #### testing set activity data (without the descriptive activity column)
train <- read.table("./train/X_train.txt") #### training set activity data (without the descriptive activity column)
test_activity <- read.table("./test/y_test.txt") #### descriptive activity data for testing set
train_activity <- read.table("./train/y_train.txt") #### descriptive activity data for training set


# Combining/Merging the training and test data - using the rbind function

combine_test <- cbind (test_activity, test)
combine_train <- cbind(train_activity,train)

combine <- rbind(combine_test,combine_train)

# Reading the given feature set
raw_features <- read.table("features.txt")
features <- as.character(raw_features[,2])


# Giving the names to the columns of the combined data (test and training data) columns

names(combine) <- c("activity",as.character(features))
colNames <- names(combine)

## Extracting only the measurements on the mean and standard deviation for each measurement

# Creating a logical vector which is true for mean and standard deviation columns
logicalVector <-  (grepl("activity",colNames)| grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

combine_meanstdv <- combine[logicalVector==TRUE]

### Reading the activity description given in the file activity_labels.txt
activity <- read.table("activity_labels.txt")
names(activity) <- c("activity","activity_description")

## Merging combined data with that of the activity description data
finalData <- merge(activity,combine_meanstdv,by='activity');

## Assigning appropriate names to the columns

colNames <- colnames(finalData)

for (i in 1: length(colNames)) {
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(finalData) <- colNames

## Preparing a tidy data set

## Getting rid of the activity description column as its the character column.
finalDataNoActivityDescription  <- finalData[,names(finalData) != 'activity_description']

## Adding the subject column into the final data set
subject_test <- read.table("./test/subject_test.txt")
subject_train <- read.table("./train/subject_train.txt")
final_subject <- rbind(subject_test,subject_train)
finalDataNoActivityDescription <- cbind(final_subject,finalDataNoActivityDescription)

## Finding the average of variables for each activity and subject

final1Data <- finalDataNoActivityDescription[names(finalDataNoActivityDescription) != c("subject","activity")]
tidyData <- aggregate(finalDataNoActivityDescription[,names(finalDataNoActivityDescription) != c('activity','subject')],by=list(activity=finalDataNoActivityDescription$activity,subject = finalDataNoActivityDescription$subject),mean);

## writing the final tidyData into a text names "tidyData.txt"

write.table(tidyData, "tidyData.txt")

