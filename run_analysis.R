# This is an R script to read and merge two datasets, perform stats and create tidy dataset.
# For assignment 4 of 'Getting and Cleaning Data'   JW - Dec 14, 2017

# Set the working data, download the zip file and unzip 
setwd("/Users/j.wagg/DataScience/Course3/FinalProject/")
zipfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipfile,destfile="./getdata_projectfiles_UCIHARDataset.zip")
unzip(zipfile="getdata_projectfiles_UCIHARDataset.zip",exdir="./")

# Read the vector which lists the features
feat <- read.table('./UCI HAR Dataset/features.txt')
#str(feat)

# Read in the test data and file with subject IDs and give names to the columns  
xtestdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytestdata <- read.table("./UCI HAR Dataset/test/y_test.txt")
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(xtestdata) <- feat[,2] 
colnames(ytestdata) <-"activityNum"
colnames(testsubject) <- "subject"

# Read in the training data and file with subject IDs and give names to the columns 
xtraindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytraindata <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(xtraindata) <- feat[,2] 
colnames(ytraindata) <-"activityNum"
colnames(trainsubject) <- "subject"

# Read in the file which assigns numbers to type of activity and give names to columns
Numactivity = read.table('./UCI HAR Dataset/activity_labels.txt')
colnames(Numactivity) <- c('activityNum','activity')

# Merge the training and test datasets into one dataset
testmerge <- cbind(ytestdata, testsubject, xtestdata)
trainmerge <- cbind(ytraindata, trainsubject, xtraindata)
finalmerge <- rbind(testmerge, trainmerge)
# names(finalmerge) - looks OK!

# Now find all of the columns that include the mean and standard deviation measurements
tomatch <- (grepl("activityNum",colnames(finalmerge)) | 
              grepl("subject",colnames(finalmerge)) | 
              grepl("std*",colnames(finalmerge)) | 
              grepl("mean*",colnames(finalmerge)))
subfinalmerge <- finalmerge[,tomatch]
# names(subfinalmerge) - looks good!

# Change the activity number to the corresponding name 
subfinalmergeNames <- merge(subfinalmerge, Numactivity,by='activityNum',all.x=T)
# subfinalmergeNames['activity'] - looks good!

# calculate the average of each variable for each activity (aggregate) and then reorder
avgfinal <- aggregate(. ~subject + activity, subfinalmergeNames, mean)
avgfinal <- avgfinal[order(avgfinal$subject,avgfinal$activity),]

# Finally, write the new dataset out to a text file
write.table(avgfinal,"newdatatidy.txt",sep="\t",row.names=FALSE)



