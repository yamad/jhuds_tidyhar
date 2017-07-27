# Human Activity Recognition Using Smartphones Dataset (Tidy Version)

A [tidy data] version of the
[Human Activity Recognition Using Smartphones](HAR) (HAR) dataset,
implemented in [R].

The enclosed files will download the original dataset and then create
two data frames, `har_full` and `har_averages`. These variables hold
_long_ tidy data formatted versions of the original dataset.

  * `har_full` - mean and std. dev. for every measure (see CodeBook.md) and timepoint by subject and activity
  * `har_averages` - average value of each measure over full time series, by subject and activity

See `CodeBook.md` and the `run_analysis.R` source for more
information.

Created for the Coursera Data
Science ["Getting and Cleaning Data" course][Coursera] by Jeff Leek
and colleagues.

[tidy data]: http://vita.had.co.nz/papers/tidy-data.html
[HAR]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
[R]: https://www.r-project.org
[Coursera]: https://www.coursera.org/learn/data-cleaning

## Usage

Run the following commands in an R session:

    source("download_data.R")    # load data
    setwd("./UCI HAR Dataset")   # change to data directory
    source("../run_analysis.R")  # generate tidy dataset

Note: `run_analysis.R` assumes that the working directory is set to a
folder containing all the data files from the original dataset. This
is behavior is specified by the assignment instructions.

## Exploring the data

In long tidy format, the data is easy to explore using ggplot2
functions. For example, to look at the time signal for all activities
for subject 1,

```{r}
library(ggplot2)

har_full %>%
  filter(subject==1, measure=="tBodyAcc-X") %>%
  ggplot(aes(x=point)) +
  geom_ribbon(aes(ymin=mean-std, ymax=mean+std), fill="gray60") +
  geom_line(aes(y=mean)) +
  facet_grid(~activity)
```

or the walking data for the first 5 subjects,

```{r}
har_full %>%
  filter(subject %in% 1:5, activity=="walking", measure=="tBodyAcc-X") %>%
  ggplot(aes(x=point)) +
  geom_ribbon(aes(ymin=mean-std, ymax=mean+std), fill="gray60") +
  geom_line(aes(y=mean)) +
  facet_wrap(~subject)
```

## Reference

The original dataset is available at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge
  L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a
  Multiclass Hardware-Friendly Support Vector Machine. International
  Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
  Spain. Dec 2012
