##setting working directory
setwd("~/R/UCI HAR Dataset")

## Names of Data Columns
features_list <-read.table("~/R/UCI HAR Dataset/features.txt")[,2]

## Measurements of the Means and Std Deviations in Data
mean_stddev_list <-grepl("mean|std", features_list)

## Load and Process Test Data, and find Means and Std Deviations
X_test<-read.table("~/R/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("~/R/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("~/R/UCI HAR Dataset/test/subject_test.txt")
names(X_test)=features_list
X_test=X_test[,mean_stddev_list]

## Pull Activity Level Labels and Apply them to Y Test Data
activity_labels<-read.table("~/R/UCI HAR Dataset/activity_labels.txt")[,2]
y_test[,2]=activity_labels[y_test[,1]]
names(y_test)=c("Activity_ID", "Activity_Label")
names(subject_test)="subject"

## Combine Test Data Tables
test_data<-cbind(as.data.table(subject_test), y_test, X_test)

## Load and Process Training Data, and find Means and Std Deviations
X_train<-read.table("~/R/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("~/R/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("~/R/UCI HAR Dataset/train/subject_train.txt")
names(X_train)=features_list
X_train=X_train[,mean_stddev_list]

## Pull Activity Level Labels and Apply them to Y Training Data
y_train[,2]=activity_labels[y_train[,1]]
names(y_train)=c("Activity_ID", "Activity_Label")
names(subject_train)="subject"

## Combine Test and Training Data
training_data<-cbind(as.data.table(subject_train), y_train, X_train)
data_comb=rbind(test_data, training_data)
id_labels =c("subject", "Activity_ID", "Activity_Label")
data_labels=setdiff(colnames(data_comb), id_labels)
melted_data=melt(data_comb, id = id_labels, measure.vars = data_labels)

## Creating Second Table with Means of Values for Data Submission
tidy_data=dcast(melted_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file="~/R/UCI HAR Dataset/tidy_data.txt")