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
## Assumes working directorycontains file and folder structure 
## from the dataset zip file, as downloaded by `download_data.R`.
## This is specified behavior from assignment instructions.
##
## note: using a function to avoid polluting global namespace with temporary variables
makeFullDataset <- function() {
  ## load auxillary tables
  activity.labels <- read.table("activity_labels.txt",
                                col.names=c("activity.id", "activity"))
  # normalize names to use "." dots and lowercase
  activity.labels$activity <- tolower(gsub("_", ".", activity.labels$activity))

  features <- read.table("features.txt",
                         col.names=c("col.id", "name"))
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
    subj <- read.table(file.path(dir, subj.fname), col.names=c("subject.id"))
    act <- read.table(file.path(dir, activity.fname), col.names=c("activity.id"))

    # add/join identifying variables for each row
    df$subject <- subj$subject.id
    df$activity.id <- act$activity.id

    # mark series of points as signals (implicit from repeated rows by
    # subject and activity)
    df <- df %>% group_by(subject, activity.id) %>%
      mutate(point=row_number()) %>%
      ungroup

    df # return prepped data.frame
  }

  ## Combine datasets
  ## -----------------------------
  train <- prepDataset("train")
  test <- prepDataset("test")
  full <- bind_rows(train, test)

  ## use activity names
  full <- full %>%
    left_join(activity.labels, by="activity.id") %>%
    select(-(activity.id))

  ## return tidy data
  full %>%
    gather(measure, value, -subject, -activity, -point) %>%
    separate(measure, into=c("measure", "statistic", "axis")) %>%
    spread(statistic, value) %>%
    arrange(subject, activity, measure, axis)
}

## combined and tidied dataset
har_full <- makeFullDataset()
# average over points by subject, activity, and measurement variable
har_averages <- har_full %>% 
  group_by(subject, activity, measure, axis) %>% 
  summarize(avg=mean(mean), std=sd(mean)) %>%
  rename(mean=avg)
