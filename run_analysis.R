# Course project for Coursera Getting and Cleaning Data class
#
# This code is designed with the assumption that you have downloaded and unzipped the dataset
# and related files into your working directory
#
# File Download 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# Original data set description
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# changed to http to dodge download difficulty.
# http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Create folder for project
# dir.create("getAndClean_Project")

# Download dataset
# download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
# destfile = "getAndCleanData_Project/dataset.zip")

# Unzipped manually. file locations:
# test set: "getAndClean_Project/UCI HAR Dataset/test"
# train set: "getAndClean_Project/UCI HAR Dataset/train"

# Read in and bind all X and Y axis data.  Inertial signals data is not used. Function designed to have data in working directory.
# Step 1: Merges all of the data including the parts that are intended to be pruned.

# Aggragate function for all operations on data
data_beast <- function() {
    activity_labels <- read.table("getAndClean_Project/UCI HAR Dataset/activity_labels.txt") # Read in metadata
    activity_features <- read.table("getAndClean_Project/UCI HAR Dataset/features.txt")
    
    x_set_bind <- function() { # subfunction to assemble sensor data
        test_set_xtest <- read.table("getAndClean_Project/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
        train_set_xtest <- read.table("getAndClean_Project/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
        
        rbind(test_set_xtest, train_set_xtest)
    }
# Step 2: Assembles sensor data, applies given feature names and filters mean and standard deviation columns.
    full_set_xtest <- x_set_bind()
    names(full_set_xtest) <- activity_features[,2]
    measures_needed <- c(grep("mean", names(full_set_xtest)), grep("std", names(full_set_xtest)))
    full_set_xtest <- full_set_xtest[,c(measures_needed)]
    
    
# Step 4: Crudely makes a series of changes to label sensor data meaningfully (steps 3:4 out of order, oh my)
    name_modified_scripted <- names(full_set_xtest)
    name_modified_scripted <- tolower(name_modified_scripted)
    
    name_modified_scripted <- gsub("-x"," on x axis",name_modified_scripted)
    name_modified_scripted <- gsub("-y"," on y axis",name_modified_scripted)
    name_modified_scripted <- gsub("-z"," on z axis",name_modified_scripted)
    
    name_modified_scripted <- sub("t","time ",name_modified_scripted)
    name_modified_scripted <- sub("f","frequency ",name_modified_scripted)
    
    name_modified_scripted <- sub("acc"," linear acceleration",name_modified_scripted)
    name_modified_scripted <- sub("gyro"," gyroscope angular velocity ",name_modified_scripted)
    name_modified_scripted <- sub("mag"," magnitude",name_modified_scripted)
    name_modified_scripted <- sub("jerk"," jerk",name_modified_scripted)
    
    name_modified_scripted <- gsub("\\()","",name_modified_scripted)
    name_modified_scripted <- gsub("\\-"," ",name_modified_scripted)
    
    name_modified_scripted <- gsub("bodybody","body", name_modified_scripted)
    
    name_modified_scripted <- gsub("std","standard deviation", name_modified_scripted)
    name_modified_scripted <- gsub("stime d","standard deviation", name_modified_scripted)
    
    
    names(full_set_xtest) <- name_modified_scripted 
    
    # subfunction to assemble activity data
    y_set_bind <- function() {
        test_set_ytest <- read.table("getAndClean_Project/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
        train_set_ytest <- read.table("getAndClean_Project/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
        
        rbind(test_set_ytest, train_set_ytest)
    }
# Step 3: Combines test/train y test (activity names), converts them to factor values, and labels the factor levels as activities.
    full_set_ytest <- y_set_bind()
    full_set_ytest[,1] <- as.factor(full_set_ytest[,1])
    levels(full_set_ytest[,1]) <- activity_labels[,2]
    names(full_set_ytest) <- "activity"
    
# Reads in and attaches subjects to movement and activity data.    
    subject_test_test <- read.table(file = "getAndClean_Project/UCI HAR Dataset/test/subject_test.txt")
    subject_train_test <- read.table(file = "getAndClean_Project/UCI HAR Dataset/train/subject_train.txt")
        subject_all <- rbind(subject_test_test, subject_train_test)
        names(subject_all) <- "testsubject"
    
    # assembles activity,mean and standard deviation sensor, and subject data. Final section of function
    full_set_alltests <- cbind(full_set_xtest, full_set_ytest, subject_all)
}
# output of modified original dataset
movement_data_trimmed <- data_beast()

# Step 5: creates table of means for each variable sorted by test subject and activity
means_bysubject_byactivity <- ddply(movement_data_trimmed,.(testsubject,activity),numcolwise(mean,na.rm = TRUE))

# Writes dataset of means by subject and activity to text file
write.table(means_bysubject_byactivity, row.names = FALSE, file = "getAndClean_Project/movement_data.txt")
