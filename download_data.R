## Download data for Human Activity Recognition Using Smartphones dataset
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## script by Jason Yamada-Hanff
## for Coursera Getting and Cleaning Data course

download_data <- function() {
  ## dataset description/variables
  dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  localZip <- "./uci_har_data.zip"
  localDir <- "./UCI HAR Dataset"

  ## get data, if needed
  if (!dir.exists(localDir)) {
    if (!file.exists(localZip)) {
      download.file(dataUrl, destfile=localZip)
    }
    unzip(localZip)
  }
}

download_data()