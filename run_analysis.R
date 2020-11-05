library(dplyr)
library(reshape2)
# Let' start by creating a data directory

if(!file.exists("./data")){
  dir.create("/.data")
}

# First we set the download link.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# We proceed to download the file using the download function.
download.file(fileUrl, destfile = "./data/data.zip")

# We assign the file and the directory where we want to unzip the zipfile.
zfile <- "./data/data.zip"
outDir <- "./data/"

# We then unzip the file to the directory we specfied.
unzip(zfile, exdir = outDir)



#We start with reading the training sets data.
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

# We then read the test data.
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

# We read the features file. 
features <- read.table("./data/UCI HAR Dataset/features.txt")
                      # col.names = c("rownumber", "variablename"))

act_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
# Combine the training and test data sets into one.

# joined_train_test <- rbind(sub_train,sub_test)
# joined_trainx_testx <- rbind(x_train,x_test)
# joined_trainy_testy <- rbind(y_train,y_test)
# joined_temp <- cbind(joined_trainx_testx, joined_trainy_testy)
# joined <- cbind(joined_temp, joined_train_test)

# 1 Merge training and test sets.

joined <- rbind(x_train,x_test)

# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# From the second column of features, we get only what represents mean and std

mean_std <- grep("mean|std", features[,2])
# Use this to index the joined data set to get what we only want.
joined <- joined[,mean_std]

#Now we are left with 79 variables with mean and std.

# 3 Uses descriptive activity names to name the activities in the data set.
# Clean the names on the features list.
# Let's start by removing () and - in each.
newFeatures <- sapply(features[, 2],
                      function(x) {
                        gsub("([()]|[-])", "",x)
  })
# Use newFeatures as the names of the joined data set.
names(joined) <- newFeatures[mean_std]

# 4 Appropriately labels the data set with descriptive variable names.

# We start by combining subject train and test data.

sub <- rbind(sub_train, sub_test)
act <- rbind(y_train, y_test)
names(sub) <- 'subject'
names(act) <- 'activity'


# Combine subject, activity and the joined x train and x test with only 
# mean and std values.

dataFinal <- cbind(sub, act, joined)

# Transform the data in the activity column to descriptive names - WALKIN, LAYING etc..

actGrouping <- factor(dataFinal$activity)
#act_labels[,2]
levels(actGrouping) <- act_labels[,2]
dataFinal$activity <- actGrouping


# 5 From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# Melt everything except the first two columns subject and activity.
# Transforming this data set into a tall version. Maybe can be done with 
# pivot_taller from dplyr

baseData <- melt(dataFinal,(id.vars=c("subject","activity")))

dataFinal2 <- dcast(baseData, subject + activity ~ variable, mean)

names(dataFinal2)[-c(1:2)] <- paste("[mean of]" , names(dataFinal2)[-c(1:2)] )

#Write the table.
write.table(dataFinal2, file = "tidydata.txt", sep = ",")










