# Getting_and_cleaning_data_with_R

This is a repository from Graciano Patino for Coursera course project on Getting and Cleaning Data (using R)

## Peer-graded Assignment: Getting and Cleaning Data Course Project

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

Below are the instructions on how to run analysis on Human Activity recognition dataset.

## Dataset:

Name of dataset: Human Activity Recognition Using Smartphones
Link for getting dataset: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

## Files included for this project

* _CodeBook.md:_ The codebook that describes the variables, the data, and any transformations or work that I performed to clean up the data
* _run_analysis.R:_ The included script performs all the data preparation before executing the required 5 steps per the project instructions:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* _tinydata2.txt:_ This is output data set after passing the data through all the data conversions and exporting it into a file.
