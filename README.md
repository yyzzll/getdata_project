Getting and Cleaning Data Project
===============
Project requirement
--------------
You should create one R script called run_analysis.R that does the following.    

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Materials contained
--------------
1. README.md: overall description of the project and explaination of what the analysis files did
2. Codebook.md: all the variables and summaries that have been calculated, along with units, and any other relevant information
3. run_analysis.R: the R script accomplishs the reauired five steps described in the "preject requirement" section

How R script works
--------------
1. put `run_analysis.R` in a local folder
2. using `setwd()` function in R or RStudio to make the above folder your working directory
3. Run `source("run_analysis.R")`, and it will generate a new file `tiny_data.txt` in the working directory.

Other information
---------------
* The code to read the `tiny_data.txt` from coursera course project submission into R is:
`tidy<-read.table("tidy_data.txt", header=TRUE, sep = "\t")`

Packages needed for the R script
--------------
* `utils` to unzip the downloaded zip file
* `dplyr` 
