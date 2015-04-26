#setwd("setwd("C:\\Bilal\\Coursera\\Data Scientist\\Getting and Cleaning Data\\Course Project")")

# Step1. Collecting datasets X, Y and Label.
Xtrain.Data <- read.table("./Data/train/X_train.txt")
ytrain.Data <- read.table("./Data/train/y_train.txt")
subtrain.Data <- read.table("./Data/train/subject_train.txt")
Xtest.Data <- read.table("./Data/test/X_test.txt")
ytest.Data <- read.table("./Data/test/y_test.txt") 
subtest.Data <- read.table("./Data/test/subject_test.txt")

# Joining Datasets X, Y and Label
join.XData <- rbind(Xtrain.Data, Xtest.Data)
join.yData <- rbind(ytrain.Data, ytest.Data)
join.SubData <- rbind(subtrain.Data, subtest.Data)
names(join.SubData) <- "subject"

# Step2. Extracts only the mean and standard deviation. 
features <- read.table("./data/features.txt", col.names=c("featureId", "featureLabel"))
includedFeatures <- grep("[Mm]ean\\(\\)|[Ss]td\\(\\)", features[, "featureLabel"])
join.XData <- join.XData[, includedFeatures]
names(join.XData) <- gsub("-", "", features[includedFeatures, "featureLabel"]) # remove "-" in column names
names(join.XData) <- gsub("mean", "Mean", names(join.XData))
names(join.XData) <- gsub("std", "Std", names(join.XData))

# Step3. Uses descriptive activity names for the activities
activity <- read.table("./data/activity_labels.txt", col.names=c("activityId", "activityLabel"))
activity[, "activityLabel"] <- gsub("_", "", activity[, "activityLabel"])
activityLabel <- activity[join.yData[, 1], "activityLabel"]
join.yData[, 1] <- activityLabel
names(join.yData) <- "activity"

# Step4. Combine data set with subjects and activities. 
tidyData <- cbind(join.SubData, join.yData, join.XData)
write.table(tidyData, "tidyData.txt") # write out the 1st dataset

# Step5. Create tidy data set with the average of 
# each variable for each activity and each subject. 
groupingElements <- list(activity = tidyData$activity,
                         subject = tidyData$subject)
tidyData.WithMean = aggregate(tidyData[3:dim(tidyData)[2]], by = groupingElements, mean)

write.table(tidyData.WithMean, "tidyData.WithMean.txt", row.name=FALSE) 