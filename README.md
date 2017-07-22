# Human Activity Recognition Using Smartphones Dataset (Tidy Version)

A [tidy data](http://vita.had.co.nz/papers/tidy-data.html) version of the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (HAR) dataset, implemented in [R](https://www.r-project.org/).

Created for the Coursera Data Science "Getting and Cleaning Data" course by Jeff Leek and colleagues.

## Usage

Load the `run_analysis.R` script into R:

    source("run_analysis.R")

The script will download the original dataset and create two data frames, `har_full` and `har_averages`, holding tidy data transformations of the data. See `CodeBook.md` and the `run_analysis.R` source for more information.

## Reference

The original dataset is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge
  L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a
  Multiclass Hardware-Friendly Support Vector Machine. International
  Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
  Spain. Dec 2012
