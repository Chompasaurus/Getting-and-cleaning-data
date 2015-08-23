

This code is designed with the assumption that you have downloaded and unzipped the dataset
and related files into your working directory.  The original README.txt for the dataset has been pasted below the notes about the 
new code written for the assignment.  

The R script run_analysis.R is designed to:
    1.  read in and bind movement, activity, and subject data from the test and training sets together with appropriate label
    files
    2.  extend the variable names to be more descriptive         
    3.  isolate the mean and standard deviation measurements 
    4.  create a new dataset of mean movement measurements according to which subject was testing and which action they performed
    5.  write a text file containing the dataset of means

The script's major sections are:

1. the function data_beast() reads in metadata and creates two subfunctions, each of which reads the test and train sections
of the x and y tests, respectively, then returns the merged sets to the upper function.  The variable name data goes through
series of character replacements to extend abbreviations to full word descriptions.  The factor levels for activity are assigned 
activity names to replace the numbers 1:6.  Movement data is reduced to the subset of columns holding mean and standard
deviation data.  Finally the subset of movement data is column-bound with the test subject and activity descriptions, and the 
upper function returns the data required.

    2.  the ddply function of the plyr package is used to create a seperate dataset of the means for each variable grouped by     
    which subject was testing and what action they performed.

    3.  A .txt file containing the table of means is written into the working directory.

File Download:
    Original data set description
        http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    changed to http to dodge download difficulty.
        http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Create folder for project
    dir.create("getAndClean_Project")

Download dataset
    download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "getAndCleanData_Project/dataset.zip")

Unzipped manually. file locations:
    test set: "getAndClean_Project/UCI HAR Dataset/test"
    train set: "getAndClean_Project/UCI HAR Dataset/train"
    
    
Original readme:    
    
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
    
    