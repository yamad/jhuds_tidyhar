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
makeFullDataset <- function() {
    
    features <- read.table("features.txt", col.names=c("col.id", "name"))
    features$col.id <- features$col.id + 2  # first two cols aren't listed in features table
    features <- features %>%                # get only mean and stddev stats
        filter(grepl("(mean|std)\\(", name))  #   trailing parens excludes `meanFreq` features
    
    ## prepare dataset of type "train" or "test"
    ##
    ## these processing steps are identical in training and test sets
    prepDataset <- function(dataset.type) {
        # names
        dir <- file.path(getwd(), dataset.type)
        df.fname <- paste("X_", dataset.type, ".txt", sep="")          # e.g. train/X_train.txt
        activity.fname <- paste("y_", dataset.type, ".txt", sep="")    # e.g. train/y_train.txt
        subj.fname <- paste("subject_", dataset.type, ".txt", sep="")  # e.g. train/subject_train.txt
        
        df <- as_tibble(read.table(file.path(dir, df.fname)))
        # subset desired features to reduce data ASAP
        df <- df[,features$col.id]
        names(df) <- features$name
        
        # load subject and activity ids for each row in dataset
        subj <- read.table(file.path(dir, subj.fname), col.names=c("subject"))
        act <- read.table(file.path(dir, activity.fname), col.names=c("activity"))
        df <- cbind(df, subj, act)
        
        # mark series of points as signals (implicit from repeated rows by
        # subject and activity)
        df <- df %>% group_by(subject, activity) %>%
            mutate(point=row_number()) %>%
            ungroup
        
        df # return prepped data.frame
    }
    
    ## Combine datasets
    ## -----------------------------
    # train.data <- read.table(file.path("train", "X_train.txt"))
    # train.subj <- read.table(file.path("train", "subject_train.txt"))
    # train.activity <- read.table(file.path("train", "y_train.txt"))

    train <- prepDataset("train")
    test <- prepDataset("test")
    full <- bind_rows(train, test)
    
    ## use activity names
    ## normalize activity labels to lowercase
    activity.labels <- read.table("activity_labels.txt")
    activity.labels[,2] <- tolower(activity.labels[,2])
    full$activity <- factor(full$activity, levels=activity.labels[,1], labels=activity.labels[,2])
    
    # convert to long tidy format by collecting all measurement columns
    full <- full %>%
        gather(measure, value, -subject, -activity, -point) %>%
        arrange(subject, activity, measure) %>%
        select(subject, activity, measure, point, value)
    
    # create mean and std columns
    full <- full %>%
        mutate(stat=ifelse(grepl("mean", measure), "mean", "std")) %>%
        mutate(measure=gsub("-(mean|std)\\(\\)", "", measure)) %>%
        spread(stat, value)
}

## combined and tidied dataset
har_full <- makeFullDataset()

## average over points by subject, activity, and measurement variable
har_averages <- har_full %>% 
    group_by(subject, activity, measure) %>%
    summarize(avg=mean(mean), std=sd(mean)) %>%
    rename(mean=avg)