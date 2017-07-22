# Human Activity Recognition Using Smartphones Dataset (Tidy Version)

A [tidy data] version of the
[Human Activity Recognition Using Smartphones](HAR) (HAR) dataset,
implemented in [R].

Created for the Coursera Data Science ["Getting and Cleaning Data" course][Coursera]
by Jeff Leek and colleagues.

[tidy data]: http://vita.had.co.nz/papers/tidy-data.html
[HAR]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
[R]: https://www.r-project.org
[Coursera]: https://www.coursera.org/learn/data-cleaning

## Usage

Load the `download_data.R` script, change the working directory to
downloaded and unzipped data directory, and then load the
`run_analysis.R` script into an R session:

    source("download_data.R")
    setwd("./UCI HAR Dataset")
    source("../run_analysis.R")

This sequence will download the original dataset and create two data
frames, `har_full` and `har_averages`, which hold tidy data
transformations of the original dataset. See `CodeBook.md` and the
`run_analysis.R` source for more information.

Note: `run_analysis.R` assumes that the working directory is set to a
folder containing all the data files from the original dataset. This
is behavior is specified by the assignment instructions.

## Reference

The original dataset is available at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge
  L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a
  Multiclass Hardware-Friendly Support Vector Machine. International
  Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
  Spain. Dec 2012
