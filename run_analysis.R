# Class: Getting and Cleaning Data (Coursera)
# Student: Graciano Patino
# Week 4: Course Project

# One of the most exciting areas in all of data science right now is wearable 
# computing - see for example this article . Companies like Fitbit, Nike, and 
# Jawbone Up are racing to develop the most advanced algorithms to attract new 
# users. The data linked to from the course website represent data collected 
# from the accelerometers from the Samsung Galaxy S smartphone. A full description 
# is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

############################################################################
#
# 0: Loading libraries, downloading datasets and assigning to tables

library(dplyr)

setwd("~/0-Rfiles/W4/Project")

if (!file.exists("data")) {
  dir.create("data")
}

# Loading files to a directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip", method = "curl")
# Unzip dataset into "data" directory
unzip(zipfile="./data/Dataset.zip", exdir="./data")
# Unzipped directory is "UCI HAR Dataset" (and check that files were created)
#list.files("./data/UCI HAR Dataset")

# Common datasets for the training and the test datasets
#
# "features" include 561 observations of 2 variables (feature index, feature name)
features <- read.table("./data/UCI HAR Dataset/features.txt", col.names = c("idx","features"))
#
# "activity_labels" include 6 observations of 2 variables (activity index, activity label)
activitiy_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("actidx", "actlabel"))


# Working on the training sets
#
# 7352 observations of 1 variable: subject
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
# range(subject_train): 1 (lowest), 30 (highest)

# 7352 observations of 561 variables: each observation corresponds to a vector with 561 features (from the features table)
# Mapping the 561 columns to the 561 feature names (from the features table)
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features$features)
# range(x_train): -1 to 1

# 7352 observations of 1 variable with range of values from 1 to 6. These value maps to the index values (actidx) in the activity_labels table.
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "actidx")
# range(y_train): Values go from 1 to 6. 


# Working on the test sets
#
# 2947 observations of 1 variable: subject
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
# range(subject_test): 2 (lowest), 24 (highest)

# 2947 observations of 561 variables: each observation corresponds to a vector with 561 features (from the features table)
# Mapping the 561 columns to the 561 feature names (from the features table)
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features$features)
# range(x_test): -1 to 1

# 2947 observations of 1 variable with range of values from 1 to 6. The value maps to the index (actidx) in the activity_labels table.
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "actidx")
# range(y_test): Values go from 1 to 6. 


##################################################################################
#
# 1: Merge the training and the test sets to create one data set.

# Making a single features set
#
# When merging rows following same order: train first (top) and then test (bottom)
# Merging the x_train and x_test datasets (rows): 10299 observations with 561 columns
x_merged <- rbind(x_train, x_test)
range(x_merged)
# range(x_merged): -1 (low), 1 (high)

# Making a Single labels set
#
# Merging the y_train and y_test datasets (rows): 10299 observations with 1 columns
y_merged <- rbind(y_train, y_test)
range(y_merged)
# range(y_merged): 1 (low), 6 (high)

# Making a single subjects set
#
# Merging the y_train and y_test datasets (rows): 10299 observations with 1 columns
subject_merged <- rbind(subject_train, subject_test)
range(subject_merged)
# range(y_merged): 1 (low), 30 (high)

# Now merging the 3 horizontally (left to right): 10299 observations with 563 columns
# Merging the subject labels with the data (x_merged) and then merged resulting set
# with the action labels (y_merged)
merged_one <- cbind(subject_merged, x_merged, y_merged)


##################################################################################
#
# 2: Extracts only the measurements on the mean and standard deviation for each 
# measurement.

Filtered <- merged_one %>% select(subject, contains("Mean"), contains("mean"), contains("Std"), contains("std"), actidx)
# Resulting set has 10299 observations. Each with 88 values


##################################################################################
#
# 3: Uses descriptive activity names to name the activities in the data set

# Replacing the activity index with the name of the activity
# Mapping to proper label by using activity indexes from the Filtered table (actidx)
Filtered$actidx <- activitiy_labels[Filtered$actidx, 2]


##################################################################################
#
# 4: Appropriately labels the data set with descriptive variable names.
#
# Using function: gsub() replaces all matches of a string

# Replacing a selection of strings in the column names such to have (hopefully) more meaningful
# names. Opinion of what names to use might vary depending on level of expertise in the domain.

names(Filtered) <- gsub("Acc", "Accelerometer", names(Filtered))
names(Filtered) <- gsub("fBody", "FrequencyBody", names(Filtered))
names(Filtered) <- gsub("tBody", "TimeBody", names(Filtered))
names(Filtered) <- gsub("Gyro", "Gyroscope", names(Filtered))
names(Filtered) <- gsub("tGrav", "TimeGrav", names(Filtered))
names(Filtered) <- gsub("actidx", "Action", names(Filtered))
names(Filtered) <- gsub("subject", "Subject", names(Filtered))


##################################################################################
#
# 5: From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

tidydata2 <- Filtered %>% group_by(Subject, Action) %>% summarise_all(mean)


##################################################################################
#
# Preparing file for submission

# Prepare a txt file created with write.table() using row.name=FALSE.
write.table(tidydata2, file = "tidydata2.txt",row.name=FALSE)


