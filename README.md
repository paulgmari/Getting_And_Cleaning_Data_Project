Getting_And_Cleaning_Data_Project
=================================

Final Project for Coursera "Getting and Cleaning Data" Course

Course Project guidelines:

    You should create one R script called run_analysis.R that does the following. 

    1.  Merges the training and the test sets to create one data set.
    2.  Extracts only the measurements on the mean and standard deviation for 
        each measurement. 
    3.  Uses descriptive activity names to name the activities in the data set
    4.  Appropriately labels the data set with descriptive variable names. 
    5.  Creates a second, independent tidy data set with the average of each variable
        for each activity and each subject. 

Good luck!

Original Data Source:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Note: Requires the following packages in R:

     Plyr, reshape2, data.table

 What the code does:
 
   * Sets the working directory (setwd())
   * Pulls Names of the Data Columns from the table features.txt from the zip folder, using read.table.
   * Looks for the elements in the Features list from features.txt to determine which
       fields have means and standard deviations, using grep1 for pattern matching.
   * Then the Test Data (X_test.txt, y_test.txt, and subject_text.txt) files are loaded using read.table.
   * Next, the X_test data is selected for columns which match the features list columns which have 
       mean and standard deviation.
   *The Activity_Labels are pulled using read.table from activity_labels.txt, and then the y_test table is
      matched to these Activities.
   *Then, the three tables for test are combined using cbind into "test_data".
   *The Training data is pulled next from the X_train.txt, y_train.txt, and subject_train.txt files using
      read.table .  the X_train table is checked against the features list and the list of mean and std dev
      fields.
   *As with the Test data, Activity_Labels are matched to the subject_train table, and y_train is also given
      Column names, as is subject_train using names().
   *Finally, the Test and training data are combined.  The Training data is combined using a cbind(), and the
      test and training data are in turn combined using an rbind().  Labels are created in id_labels, which are
      then used to create data_labels (along with colnames, these are subject to setdiff().
   *Melt is used to reshape the data (and determine which of the data are measures and which are not).
   *Lastly, the data is dcast to create a new table containing the means of the data from the step above, and
      the data is written to a txt file using write.table.
