# First, download file into "data" folder
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip the file 
unzip(zipfile="./data/Dataset.zip",exdir="./data")


# 1. Merge the training and the test sets to create one data set:

# Read the data from files into variables

# Read training files:
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Read testing files:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Read feature file:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Read activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Assign column names:
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merge all data in one set:
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
train_and_test <- rbind(merge_train, merge_test)


# 2. Extract only the measurements on the mean and standard deviation for each measurement

# Read column names:
colNames <- colnames(train_and_test)

# Create vector for defining ID, mean and standard deviation:
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

# Subset train_and_test:
subset_MeanAndStd <- train_and_test[ , mean_and_std == TRUE]


# 3. Use descriptive activity names to name the activities in the data set:
ActivityNames <- merge(subset_MeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)


# 4. Appropriately label the data set with descriptive variable names.
# The subject and activity variables have been given descriptive names, 
# the features variables will be given descriptive names here:
        # prefix t >> time
        # prefix f >> frequency
        # Gyro >> Gyroscope
        # Acc >> Accelerometer 
        # Mag >> Magnitude
        # BodyBody >> Body
names(ActivityNames)<-gsub("^t", "time", names(ActivityNames))
names(ActivityNames)<-gsub("^f", "frequency", names(ActivityNames))
names(ActivityNames)<-gsub("Acc", "Accelerometer", names(ActivityNames))
names(ActivityNames)<-gsub("Gyro", "Gyroscope", names(ActivityNames))
names(ActivityNames)<-gsub("Mag", "Magnitude", names(ActivityNames))
names(ActivityNames)<-gsub("BodyBody", "Body", names(ActivityNames))



# 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:

# Making second tidy data set 
TidySet <- aggregate(. ~subjectId + activityId, ActivityNames, mean)
TidySet <- TidySet[order(TidySet$subjectId, TidySet$activityId),]
write.table(TidySet, "TidySet.txt", row.name=FALSE)
