### Class: Getting and Cleaning Data (Coursera)
### Student: Graciano Patino
### Week 4: Course Project


The run_analysis.R script performs all the data preparation and follows the 5 steps requested as part of the project definition.

### Step 0: Loading libraries, downloading datasets to tables and assigning to variables

* 0.1) Assign working directory (where the run_analysis.R script is located). 
* 0.2) Create a directory named "data" if it doesn't exist.
* 0.3) Download the dataset from provided URL in the project definition and unzip to a folder named _UCI HAR Dataset_
* 0.4) Assign common datasets (for the testing and training data) to variables:
* 0.4.1) Loading the features dataset to a variable name "features". It includes 561 observations of 2 variables (feature index, feature name)
  + **features <- read.table("./data/UCI HAR Dataset/features.txt", col.names = c("idx","features"))**
* 0.4.2) Loading the features dataset to a variable name "activity_labels". It includes 6 observations of 2 variables (activity index, activity label)
  + **activitiy_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("actidx", "actlabel"))**
* 0.5) Working on the training sets:
* 0.5.1) Loading subject_train: 7352 observations of 1 variable: subject. 
  + **subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")**
* 0.5.2) Loading x_train data. 7352 observations of 561 variables: each observation corresponds to a vector with 561 features (from the features table)
  + Mapping the 561 columns to the 561 feature names (from the features table)
  + **x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features$features)**
* 0.5.3) Loading y_train data. 7352 observations of 1 variable with range of values from 1 to 6. 
  + These value maps to the index values (actidx) in the activity_labels table.
  + **y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "actidx")**
* 0.6) Working on the test sets:
* 0.6.1) Loading subject_train: 2947 observations of 1 variable: subject
  + **subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")**
* 0.6.2) Loading x_test data. 2947 observations of 561 variables: each observation corresponds to a vector with 561 features (from the features table)
  + Mapping the 561 columns to the 561 feature names (from the features table)
  + **x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features$features)**
* 0.6.3) Loading y_test data. 2947 observations of 1 variable with range of values from 1 to 6. The value maps to the index (actidx) in the activity_labels table.
  + **y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "actidx")**


### Step 1: Merge the training and the test sets to create one data set.

* 1.1) Making a single features set
  + When merging rows following same order: train first (top) and then test (bottom).
  + Merging the x_train and x_test datasets (rows): 10299 observations with 561 columns.
  + **x_merged <- rbind(x_train, x_test)**
* 1.2) Making a Single labels set
  + Merging the y_train and y_test datasets (rows): 10299 observations with 1 columns
  + **y_merged <- rbind(y_train, y_test)**
* 1.3) Making a single subjects set
  + Merging the y_train and y_test datasets (rows): 10299 observations with 1 columns
  + **subject_merged <- rbind(subject_train, subject_test)**
* 1.4) Now merging the 3 sets horizontally (left to right): 10299 observations with 563 columns
  + Merging the subject labels with the data (x_merged) and then merged resulting set with the action labels (y_merged)
  + **merged_one <- cbind(subject_merged, x_merged, y_merged)**

### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

* 2.1) Resulting set has 10299 observations. Each with 88 values
  + **Filtered <- merged_one %>% select(subject, contains("Mean"), contains("mean"), contains("Std"), contains("std"), actidx)**


### 3: Uses descriptive activity names to name the activities in the data set

* 3.1) Replacing the activity index with the name of the activity
* 3.2) Mapping to proper label by using activity indexes from the Filtered table (actidx)
  + **Filtered$actidx <- activitiy_labels[Filtered$actidx, 2]**

### Step 4: Appropriately labels the data set with descriptive variable names

* 4.1) Using function: gsub() replaces all matches of a string
* 4.2) Replacing a selection of strings in the column names such to have (hopefully) more meaningful names. 
* 4.3) Opinion of what names to use and change might vary from person to person depending on level of expertise in the domain.
* 4.4) Using gsub command in R: replaces all the instances of a substring. 
* 4.4) Commands:
  + **names(Filtered) <- gsub("Acc", "Accelerometer", names(Filtered))**
  + **names(Filtered) <- gsub("fBody", "FrequencyBody", names(Filtered))**
  + **names(Filtered) <- gsub("tBody", "TimeBody", names(Filtered))**
  + **names(Filtered) <- gsub("Gyro", "Gyroscope", names(Filtered))**
  + **names(Filtered) <- gsub("tGrav", "TimeGrav", names(Filtered))**
  + **names(Filtered) <- gsub("actidx", "Action", names(Filtered))**
  + **names(Filtered) <- gsub("subject", "Subject", names(Filtered))**


### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* 5.1) "summary functions" apply to columns to create a new table. Summary functions take vectors as input and return single values as output.
* 5.2) summarise_all() apply funs to every column. 
* 5.2) Command:
  + **tidydata2 <- Filtered %>% group_by(Subject, Action) %>% summarise_all(mean)**


### Step 6: Preparing file for submission

* 6.1) Prepare a txt file created with write.table() using row.name=FALSE.
  + **write.table(tidydata2, file = "tidydata2.txt",row.name=FALSE)**


### Some references:

* dplyr part of the tidyverse: <https://dplyr.tidyverse.org/reference/index.html>
* Datascience made simple (list of commands in R and dplyr tutorials): <http://www.datasciencemadesimple.com>
* R-bloggers on how to aggregate in R: <https://www.r-bloggers.com/how-to-aggregate-data-in-r/>
* Great source - Rstudio Cheatsheets for 2019: <https://rstudio.com/wp-content/uploads/2019/01/Cheatsheets_2019.pdf>
* Materials reviewed from the Coursera Getting and Cleaning data class, including swirl lessons.


