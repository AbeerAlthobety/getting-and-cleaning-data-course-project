#Read data
#Read Activity files

ActivityTest<-read.table("y_test.txt",header = FALSE)
ActivityTrain<-read.table("y_train.txt",header = FALSE)

#Read Subject files

SubjectTest<-read.table("subject_test.txt",header = FALSE)
SubjectTrain<-read.table("subject_train.txt",header = FALSE)

#Read feature files

FeaturTest<-read.table("X_test.txt",header = FALSE)
FeaturTrain<-read.table("X_train.txt",header = FALSE)

str(ActivityTest)
str(ActivityTrain)

str(SubjectTest)
str(SubjectTrain)

str(FeaturTest)
str(FeaturTrain)

###1- Merges the training annndd the test sets to create one data set
ActivityData<-rbind(ActivityTest,ActivityTrain)
SubjectData<-rbind(SubjectTest,SubjectTrain)
FeatureData<-rbind(FeaturTest,FeaturTrain)

names(ActivityData)<-c("Activity")
names(SubjectData)<-c("Subject")
FeatureData_names<-read.table("features.txt",header = FALSE)
names(FeatureData)<-FeatureData_names$V2

Data1<-cbind(ActivityData,SubjectData)
Data<-cbind(FeatureData,Data1)

###2-Extracts only the measurements on the mean and standard deviation for each measurement.

MeanStd_Data<-FeatureData_names$V2[grep("mean\\(\\)|std\\(\\)", FeatureData_names$V2)]
Names<-c(as.character(MeanStd_Data), "subject", "activity" )
Data<-subset(Data,select=Names)
str(Data)

##################################################

#3-Uses descriptive activity names to name the activities in the data set

activity_labels<-read.table("activity_labels.txt",header = FALSE)

Data <- merge(activity_labels, Data,by="Activity" )
Data$activityName <- as.character(Data$activityName)

#4-Appropriately labels the data set with descriptive variable names.

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))

#5-From the data set in step 4, creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.

TidyData<-aggregate(. ~Subject +Activity, Data, mean)

write.table(TidyData,"Tidydata.txt",row.name=FALSE)
























