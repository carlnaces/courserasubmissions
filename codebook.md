

**fileUrl**
- Used as the variable that holds the link for the download of the data.


**zfile**
- holds the downloaded zipfile

**outDir**
- the directory where the zipfile will be unzipped.


**sub_train**
- holds subject_train.txt

**x_train**
- holds X_train.txt

**y_train**
- holds y_train.txt

**sub_test**
- holds subject_test.txt

**x_test**
- X_test.txt

**y_test**
- holds y_test.txt

**features** 
- holds features.txt

**act_labels** 
- activity_labels.txt

**joined**
- combination of x_train and x_test

# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# From the second column of features, we get only what represents mean and std

**mean_std**
- items in features that contains the words "mean" and "std"

**newFeatures**
- cleaned column names


**dataFinal**
- holds final data

**dataFinal2**
- holds new data with the average of each variable for each activity and each subject.
