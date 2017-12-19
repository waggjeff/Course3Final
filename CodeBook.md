This is the code book describing the data columns contained in the 'newdatatidy.txt' file and the transformations
that were made to the original data. The raw data are available for download as desrcibed in the 'README.md' file. These
consist of records of accelerometer and gyroscope measurements for two groups of people (test and training samples) in 
various states of motion:

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

The 'run_analysis.R' script, the raw data are downloaded and unzipped. I merge the test and training samples into 
 single data frame after adding column names to the data:
 
 'activityNum' - is the reference number for the activity (1 to 5).
 
 'activity' - is the full English name of the activity undertaken (Walking, etc.). 
 
 'subject' - is a reference number for the subject of the study, whether they are in the test or training set. 
 
 After merging the two datasets I create a new data frame which contains only the data columns which include average
 or standard deviation meansurement values. 
 
 A new data frame is created which contains the mean value of each activity for each measurement variable for each subject.
 This data frame is then re-ordered according to subject and activity.
 
 Finally, the tidy dataset is written to the 'newdatatidy.txt' file.  
