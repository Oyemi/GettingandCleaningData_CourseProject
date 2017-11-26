# Getting and Cleaning Data Course Project

## The Data Set
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
Link to the data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Getting and Cleaning
Following the project instructions, the work done on the data was:
1. Merging the training and the test sets to create one data set
   * Reading the data into R environment
   * Reading the data from files into variables
   * Assigning column names
   * Merging all data in one set 
2. Extracting only the measurements on the mean and standard deviation for each measurement
   * Reading column names
   * Creating vector for defining ID, mean and standard deviation:
   * Subsetting ‘train_and_test’ 
3. Using descriptive activity names to name the activities in the data set 
4. Appropriately labelling the data set with descriptive variable names.
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject 
   * Making second tidy data set 
   * Writing second tidy data set in txt file
 
The file, ‘run_analysis.R’, contains all the code used.

## The Result
The tidy data set is a dataframe with 180 observations and 82 variables. The first row is the header, which contains the names of each column. The first 2 variables, subjectId and activityId, are integer variables, the remaining 80 are numeric.
