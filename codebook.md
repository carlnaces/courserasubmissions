# CodeBook

## Introduction

This file is the Code Book for the `run_analysis.R` script.

## Variables

| Variable | Description|
|----------|------------|
| fileUrl | holds the url for the zip data  |
| zfile | holds the downloaded zip data |
| outDir | directory for unzipped data |
| sub_train | holds data from subject_train.txt |
| x_train | holds data from X_train.txt |
| y_train | holds data from y_train.txt|
| sub_test | holds data from subject_test.txt |
| x_test | holds data from X_test.txt |
| y_test | holds data from y_test.txt |
| features | holds data from features.txt |
| act_labels | holds data from activity_labels.txt |
| joined | rbind combination of x_train and x_test|
| mean_std | values from the second column of features that has mean and std |
| newFeatures | cleaned feature names |
| sub | rbind combination of sub_train and sub_test|
| act | rbind combination of y_train and y_test|
| dataFinal | cbind combination of sub, act and joined |
| dataFinal2 | data set with the average of each variable for each activity and each subject |
