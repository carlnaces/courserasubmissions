<!--
*** Thanks for checking out this README Template. If you have a suggestion that would
*** make this better, please fork the repo and create a pull request or simply open
*** an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, repo_name, twitter_handle, email
-->





<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
First thank you [othneildrew](https://github.com/othneildrew/Best-README-Template/blob/master/BLANK_README.md) for this great template. 


<!-- ABOUT THE PROJECT -->
## About The Project

This project was created as a submission to the Getting and Cleaning Data Course Project for coursera.

### Built With

* [Rstudio]()



<!-- GETTING STARTED -->
## Getting Started

Open run_analysis.R.

The explanation written here is somehow better explained within the code.
Please run the codes below one at a time to be able to follow.


We first start by loading the needed packages.
```sh
library(dplyr)
library(reshape2)
```
Then creating a directory to work with.
```sh
if(!file.exists("./data")){
  dir.create("/.data")}
```

Setting the provided download link from the course project to a variable *fileUrl*
```sh
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```
We then download the zip file, and unzip it.
```sh
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/data.zip")
zfile <- "./data/data.zip"
outDir <- "./data/"
unzip(zfile, exdir = outDir)
```
The resulting folder will be found on the specified directory with name UCI HAR Dataset.

We now start with reading the training sets data.
```sh
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
```

Then read the test data.
```sh
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
```

We also read the features and activity labels file.
```sh
features <- read.table("./data/UCI HAR Dataset/features.txt")
act_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
```

Merging the training and test sets thru rbind.
```sh
joined <- rbind(x_train,x_test)
```
Extracts only the measurements on the mean and standard deviation for each measurement. 
From the second column of features, we get only what represents mean and std.
Use this to index the joined data set to get what we only want.
```sh
mean_std <- grep("mean|std", features[,2])
joined <- joined[,mean_std]
```

Now we are left with 79 variables with mean and std.

Use descriptive activity names to name the activities in the data set.
Clean the names on the features list.
Let's start by removing () and - in each.
```sh
newFeatures <- sapply(features[, 2],
                      function(x) {
                        gsub("([()]|[-])", "",x)
  })
```
  
Use newFeatures as the names of the joined data set.
```sh
names(joined) <- newFeatures[mean_std]
  })
```
Appropriately lable the data set with descriptive variable names.
We start by combining subject train and test data.
```sh
sub <- rbind(sub_train, sub_test)
act <- rbind(y_train, y_test)
names(sub) <- 'subject'
names(act) <- 'activity'
```

Combine subject, activity and the joined x train and x test with only mean and std values.

```sh
dataFinal <- cbind(sub, act, joined)
```

Transform the data in the activity column to descriptive names - WALKIN, LAYING etc..
```sh
actGrouping <- factor(dataFinal$activity)
#act_labels[,2]
levels(actGrouping) <- act_labels[,2]
dataFinal$activity <- actGrouping
```

From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.

Melt everything except the first two columns subject and activity.
Transforming this data set into a tall version. Maybe can be done with 
pivot_taller from dplyr.

```sh
baseData <- melt(dataFinal,(id.vars=c("subject","activity")))

dataFinal2 <- dcast(baseData, subject + activity ~ variable, mean)

names(dataFinal2)[-c(1:2)] <- paste("[mean of]" , names(dataFinal2)[-c(1:2)] )

```

Write the table.
```sh
write.table(dataFinal2, file = "tidydata.txt", sep = ",")
```


<!-- CONTACT -->
## Contact

Carl Naces - [@coralnaces](https://twitter.com/coralnaces)
Email: carljessenaces@gmail.com

Project Link: [https://github.com/github_username/repo_name](https://github.com/github_username/repo_name)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
This wouldn't have been possible without the help of the codes of other people from the internet.
* [kosamari](https://github.com/kosamari/data-exercise/blob/master/run_analysis.R)
* [ravindranathgnanaiah](http://rstudio-pubs-static.s3.amazonaws.com/181260_5a1f23da7bb148188c3a540e3a3c4ec5.html)






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo.svg?style=flat-square
[contributors-url]: https://github.com/github_username/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo.svg?style=flat-square
[forks-url]: https://github.com/github_username/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo.svg?style=flat-square
[stars-url]: https://github.com/github_username/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo.svg?style=flat-square
[issues-url]: https://github.com/github_username/repo/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo.svg?style=flat-square
[license-url]: https://github.com/github_username/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/github_username
[product-screenshot]: images/screenshot.png
