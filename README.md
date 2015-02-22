# GettingandCleaningData
Repository created for the submission of Getting and Cleaning Data (Coursera) course peer-evaluated project

## Files Contained in the Given Repository
1. README.md (file giving information about what is done in the given project)
2. CodeBook.md (information about variables, summary choices made, experimental design used etc)
3. tidyData.txt (the tidy data obtained from the raw data - Final aim of this project)
4. run_analysis.R (Code programmed in R language to tidy the given raw data)

### Overall Description of the Given Project
The aim of this project is to take in the given untidy/raw data obtained from the UCI University (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and perform some operations on the given data to turn it into a tidy one. 

A full description of the experiment conducted, data used, variables used in the data etc can be found on UCI Machine Learning Repository link - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Summary of the Project
The run_analysis.R script was programmed in R language so as to meet our requirements. As a whole, the given project (run_analysis.R script) work was splitted into five parts-

1. Merging of the training and the test sets ( provided raw data) to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement.
3. Using descriptive activity names to name the activities in the data set.
4. Appropriately labeling the data set with descriptive variable names. 
5. From the data set in step 4, a second tidy dataset was created which would compute the average of each variable for each activity and each subject.

### Additional Information
Additional informational about data (training and test sets), number of variables used, computations performed on the given data can be found in the CodeBook.md file.




