CodeBook
========================================================

This is a codebook which describes the variales, the data, and any transformation or work that have been performed to clean up the data.

Data source
-----------
* Original data will be downloaded by the included R script `run_analysis.R` from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Detailed description of the original data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original dataset information
-------------
Human Activity Recognition Using Smartphones Dataset
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

 * For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


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

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

data loaded by the 'run_analysis.R' script
-------------------

features: from 'features.txt'   
   
activity_labels: from 'activity_labels.txt'   
   
X_train: from 'X_train.txt'   
y_train: from 'y_train.txt'   
subject_train: from 'subject_train.txt'   
   
X_test: from 'X_test.txt'   
y_test: from 'y_test.txt'   
subject_test: from 'subject_test.txt'   
   
Steps to get tidy data:
----------------------
1. merges the training and test sets to create one data set.
 * subject labels were  added as the first column to the data matrix for both training and testing set.
 * training and testing were rbind into a big complete data called 'all_data' using `rbind` function.
2. extracts only the measurements on the mean and standard deviation for each measurement.
 * column names were added to 'all_data':  
     i). The first column is the subject id, named as 'id';   
     ii). the second column is the numbered activities, named as 'activity';   
     iii). the rest columns are the data from 'X' matrix, the names were derived from 'features'.    
`make.names` function was used to make the names syntactically valid.
 * the first two columns and columns of 'all_data' with a column name containing either "mean" or "std", regardless of cases, were selected.
 * This step generates a extracted data named 'extracted_data'
3. uses descriptive activity names to name the activities in the dataset
 * the numbered activity column in the extracted data was made to be a factor variable labeled with descriptive names from "features" dataset.
4. appropriately labels the data set with descriptive variable names
 * the extracted_data already have descriptive variable names. The rules to understand this name contains in readme.txt. Extra "." was removed from the name to make it even easier to read
5. a independent tidy dataset was created from "extracted_data"
 * extracted_data was first transformed into a data frame tbl object with `tbl_df` function
 * it was then grouped by id and activity with `group_by` function;
 * lastly, the tidy data was generated by summarise each column using `summarise_each` with `mean` function

6. last step, the tidy_data was output as "tidy_data.txt" with `write.table` function, using tabs as seperation.


additional information about variable names
-----------------------
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).    

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).    

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.   
   
tBodyAcc-XYZ   
tGravityAcc-XYZ   
tBodyAccJerk-XYZ   
tBodyGyro-XYZ   
tBodyGyroJerk-XYZ   
tBodyAccMag   
tGravityAccMag   
tBodyAccJerkMag   
tBodyGyroMag   
tBodyGyroJerkMag   
fBodyAcc-XYZ   
fBodyAccJerk-XYZ   
fBodyGyro-XYZ   
fBodyAccMag   
fBodyAccJerkMag   
fBodyGyroMag   
fBodyGyroJerkMag   
   
The set of variables that were estimated from these signals are:    
   
mean: Mean value   
std: Standard deviation   
mad: Median absolute deviation    
max: Largest value in array   
min: Smallest value in array   
sma: Signal magnitude area   
energy: Energy measure. Sum of the squares divided by the number of values.   
iqr: Interquartile range    
entropy: Signal entropy   
arCoeff: Autorregresion coefficients with Burg order equal to 4   
correlation: correlation coefficient between two signals   
maxInds: index of the frequency component with largest magnitude   
meanFreq: Weighted average of the frequency components to obtain a mean frequency   
skewness: skewness of the frequency domain signal    
kurtosis: kurtosis of the frequency domain signal    
bandsEnergy: Energy of a frequency interval within the 64 bins of the FFT of each window.   
angle: Angle between to vectors.   
      
Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle variable:   
         
gravityMean   
tBodyAccMean   
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean   
   
The complete list of variables of each feature vector is available in 'features.txt'
   