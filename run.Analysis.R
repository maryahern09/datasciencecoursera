getwd()
setwd("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset")
getwd()

#download all datasets
features <- read.table("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("C:/Users/ahernmm/Documents/datasciencecoursera/UCI HAR Dataset/train/y_train.txt", col.names = "code")

#look at data
names(features)
glimpse(subject_train)

#1. merge training and testing datasets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#look at merged data
names(Merged_Data)
glimpse(Merged_Data)

#2. mean and SD for each measurements
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#view
names(TidyData)
glimpse(TidyData)

#3. bring in activities dataset
TidyData$code <- activities[TidyData$code, 2]

#4. change names
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#look at data
names(TidyData)

#5. subset
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

#look at final
names(FinalData)
glimpse(FinalData)
head(FinalData)
