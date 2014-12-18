
##############################
#STEP 0 Preparation
############################

##set working directory
setwd("E:/temporary/coursera_videos/John Hopkins Data Science specialization/003 getting and cleaning data-v-ongoing/course project")
##verify working directory
getwd()

###download and extract zip files from the course website
library(utils)
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
locFile<-"./dataset.zip"
download.file(fileUrl,locFile,method="curl")
unzip(locFile)

###load data into R
#library(dplyr)
#library(data.table)
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)
features<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)

X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

###############################################################
#Step 1. Merges the training and the test sets to create one data set.
##############################################################
train<-cbind(subject_train,y_train, X_train)
test<-cbind(subject_test,y_test, X_test)
all_data<-rbind(train,test)

###########################################################
#Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
###########################################################
colnames(all_data)<-c("id","activity",make.names(features[,2])) #add column names to the dataset
extracted_data<-all_data[,c(1,2, grep("mean|std", colnames(all_data),ignore.case=TRUE))] #select columns whose names contains "mean" or "std" ignoring case, and the y column

############################################################
#Step 3. Uses descriptive activity names to name the activities in the data set
############################################################

extracted_data$activity <- factor(extracted_data$activity,
                    levels = activity_labels[,1],
                    labels = activity_labels[,2])

###########################################################
#Step 4. Appropriately labels the data set with descriptive variable names. 
##########################################################
#The variable names were generated from "features", which is already descriptive
#e.g., in "tBodyAcc.mean...X", "t" refers to "time", "Body" refers to "Body movement"
# "ACC" refers to the equipment for measurement, which is accelorater
# "X" means the measurement is in X-axis
# the extra "." in the variable names will be removed next to make it easier to read
colnames(extracted_data)<-gsub("\\.\\.", "", colnames(extracted_data))

##########################################################
#Step 5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
##########################################################


library(dplyr)

tidy_data<-
      extracted_data %>%
      tbl_df %>% 
      group_by(id,activity) %>% 
      summarise_each(funs(mean))

#output tidy data to tidy_data.txt with row.name=FALSE
write.table(tidy_data, file = "tidy_data.txt", row.name=FALSE, append = FALSE, sep = "\t")

