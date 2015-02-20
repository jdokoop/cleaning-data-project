#------------------------------------------
# Coursera Data Science Specialization
# Getting and Cleaning Data - Project
# Feb. 2015
#------------------------------------------
run_analysis <- function(){
  library(dplyr)
  
  # Read data from files
  rawFeatures <- read.table("./UCI\ HAR\ Dataset/features.txt", stringsAsFactors=FALSE)
  rawFeatures <- rawFeatures[,c(2)]
  rawHeader <- c("subject", "activity", rawFeatures)
  
  rawTestMeasurements   <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt")
  rawTestSubjects       <- read.table("./UCI\ HAR\ Dataset/test/subject_test.txt")
  rawTestActivity       <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt")
  
  rawTrainMeasurements  <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt")
  rawTrainSubjects      <- read.table("./UCI\ HAR\ Dataset/train/subject_train.txt")
  rawTrainActivity      <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt")
  
  rawTest  <- cbind(rawTestSubjects, rawTestActivity, rawTestMeasurements)
  rawTrain <- cbind(rawTrainSubjects, rawTrainActivity, rawTrainMeasurements)
  
  # Give columns a descriptive name
  names(rawTest)  <- rawHeader
  names(rawTrain) <- rawHeader
  
  # Merge test and training sets
  rawData <- rbind(rawTest, rawTrain)
  
  # Extract columns with mean and std deviation information for each measurement
  cleanData <- rawData[,c(1, 2, grep("mean", colnames(rawData)), grep("std", colnames(rawData)))]
  
  # Give activities a descriptive name
  cleanData$activity[cleanData$activity == 1] <- "WALKING" 
  cleanData$activity[cleanData$activity == 2] <- "WALKING_UPSTAIRS" 
  cleanData$activity[cleanData$activity == 3] <- "WALKING_DOWNSTAIRS" 
  cleanData$activity[cleanData$activity == 4] <- "SITTING" 
  cleanData$activity[cleanData$activity == 5] <- "STANDING" 
  cleanData$activity[cleanData$activity == 6] <- "LAYING" 
  
  # Create new data set with mean of each observation for each subject
  groupedData <- group_by(cleanData, subject, activity)
  finalTable <- summarise_each(groupedData, funs(mean))

  write.table(finalTable, "tidy_set.txt", sep="\t", row.name=FALSE) 
  
}