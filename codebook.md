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
The below text is from the description of the original data:
```
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING", WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 
```
data loaded by the R script
-------------------
```
features: from 'features.txt', contains the name of the features collected (i.e. the names for the columns
contained in the matrix.

activity_labels: from 'activity_labels.txt', which links the descriptive activity to the numbered values

X_train: from 'X_train.txt', a matrix of data collected as traning set.
y_train: from 'y_train.txt',a vector of numbered activity labels for the traning set.
subject_train: from 'subject_train.txt',a vector of the subject id labels for training set.

X_test: from 'X_test.txt',a matrix of data collected as testing set.
y_test: from 'y_test.txt',a vector of numbered activity labels for the testing set.
subject_test: from 'subject_test.txt',a vector of the subject id labels for testing set.
```
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