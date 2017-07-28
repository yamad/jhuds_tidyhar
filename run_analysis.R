## Tidy data for Human Activity Recognition Using Smartphones dataset
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## Creates two data frames containing tidy data from HAR dataset:
##
##   * `har_full` -- mean and std. dev. for every variable (see CodeBook.md) and timepoint by subject and activity
##   * `har_averages` -- average value of each variable over full time series, by subject and activity
##
## script by Jason Yamada-Hanff
## for Coursera Getting and Cleaning Data course

library(dplyr)
library(tidyr)
library(tibble)

## Create combined data frame from training and test data.
## 
## Assumes working directory contains file and folder structure 
## from the dataset zip file, as downloaded by `download_data.R`.
## This is specified behavior from assignment instructions.
##
## note: wrapping function avoids polluting global namespace with temporary variables
##
makeFullDataset <- function() {
    
    ## Combine train and test datasets
    ## -----------------------------
    train.data <- read.table(file.path("train", "X_train.txt"))
    train.subj <- read.table(file.path("train", "subject_train.txt"))
    train.activity <- read.table(file.path("train", "y_train.txt"))
    train <- cbind(train.subj, train.activity, train.data)
    
    test.data <- read.table(file.path("test", "X_test.txt"))
    test.subj <- read.table(file.path("test", "subject_test.txt"))
    test.activity <- read.table(file.path("test", "y_test.txt"))
    test <- cbind(test.subj, test.activity, test.data)
    
    full <- rbind(train, test)
    
    ## Make variable names, preserve just mean and std statistics
    ## --------------------------------------
    features <- read.table("features.txt", stringsAsFactors=FALSE)
    # make.unique handles repeated column names
    names(full) <- c("subject", "activity", make.unique(features[,2]))
    # trailing parens excludes `meanFreq` features
    full <- select(full, subject, activity, contains("mean("), contains("std"))  
    
    # mark series of points as signals (implicit from repeated rows by
    # subject and activity)
    full <- full %>% 
        group_by(subject, activity) %>%
        mutate(point=row_number()) %>%
        ungroup
    

    ## Tidy data into long tidy format
    ## --------------------------------------
    
    # convert to long tidy format by collecting all measurement columns
    full <- full %>%
        gather(measure, value, -subject, -activity, -point) %>%
        arrange(subject, activity, measure) %>%
        select(subject, activity, measure, point, value)
    
    # extract mean and std columns
    full <- full %>%
        mutate(stat=ifelse(grepl("mean", measure), "mean", "std")) %>%
        mutate(measure=gsub("-(mean|std)\\(\\)", "", measure)) %>%
        spread(stat, value)
    
    
    ## Use activity names, normalized to lowercase
    ## --------------------------------------
    activity.labels <- read.table("activity_labels.txt")
    full$activity <- factor(full$activity, 
                            levels=activity.labels[,1], 
                            labels=tolower(activity.labels[,2]))
    
    full
}

## combined and tidied dataset
har_full <- makeFullDataset()

## average over points by subject, activity, and measurement variable
har_averages <- har_full %>% 
    group_by(subject, activity, measure) %>% 
    summarize(avg=mean(mean), std=sd(mean)) %>%
    rename(mean=avg)

write.table(har_averages, file="tidy_avgs.txt", row.names=FALSE)
