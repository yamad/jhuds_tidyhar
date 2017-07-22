# Human Activity Recognition Using Smartphones Dataset

# Version 1.0

## Data description

The dataset contains accelerometer and gyroscope information for 30
human _subjects_ each performing 6 _activities_ while wearing a
smartphone. Short time and frequency domain signals were calculated
for various variables, as described below. The mean and standard
deviation for each variable are provided in this tidy dataset. More
statistics for each signal are available in the original dataset.

### Full dataset data frame - `har_full`

The full dataset for all subjects, activities, and variables is
calculated by the `makeFullDataset` function in `run_analysis.R`. By
default, this dataset is saved as `har_full`, consisting of the
following columns:

  1. **subject** identifier for the human subject who performed the
     activity, by integer id 1-30.

  2. **point** the point in the signal sequence for the given.
     activity, measure/axis, and subject (e.g. 1 is the first point in
     the signal).

  3. **activity** the activity performed: walking,
     walking.upstairs, walking.downstairs, sitting, standing, or laying.

  4. **measure** the measured variable. one of 17,
     see [Measures](#measures) for descriptions.

  5. **axis** the axis of the measured variable, if
     applicable. e.g. body acceleration is measured along X, Y, and Z
     axes.

  6. **domain:magnitude** decomposition of *measure* names into 5
     variables. Together, these render the *measure* column redundant,
     but we retain *measure* because it will be generally easier to
     use, even if more cryptic:

     6. *domain* (freq/time)
     7. *sensor* (accelerometer/gyroscope)
     8. *measuretype* (body/gravity)
     9. *jerk* (boolean)
     10. *magnitude* (boolean)

  11. **mean** the mean value for the *measured* variable in an
     128-sample window, indicated by *point*. Values are normalized
     and bounded within [-1, 1].

  12. **std** the standard deviation of the measured variable in the
     window.

### Averages data frame - `har_averages`

The `har_averages` data frame has the same structure as the `har_full`
data frame, except that values have been averaged across the
signal. That is, the **mean** and **std** columns indicate the mean
and standard deviation of the measured variable across all points in
the signal. That is, we summarize over the **point** column from
`har_full`, taking the average of the given mean value for each point
in the signal, so that only one value for any combination of subject,
activity, measure, and axis is given.

### Original data description

(modified from README.txt from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (walking, walking.upstairs, walking.downstairs, sitting,
standing, laying) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the
data manually. The obtained dataset was randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion
components, was separated using a Butterworth low-pass filter into
body acceleration and gravity. The gravitational force is assumed to
have only low frequency components, therefore a filter with 0.3 Hz
cutoff frequency was used. From each window, a vector of features was
obtained by calculating variables from the time and frequency
domain. See 'features_info.txt' for more details.

## Measures<a name="measures"></a>

(modified from README.txt from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The features selected for this database come from the accelerometer
and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time
domain signals (prefix 't' to denote time) were captured at a constant
rate of 50 Hz. Then they were filtered using a median filter and a 3rd
order low pass Butterworth filter with a corner frequency of 20 Hz to
remove noise. Similarly, the acceleration signal was then separated
into body and gravity acceleration signals (tBodyAcc-XYZ and
tGravityAcc-XYZ) using another low pass Butterworth filter with a
corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to
indicate frequency domain signals).

These signals were used to estimate variables of the feature vector
for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y
and Z directions.

  * tBodyAcc-XYZ
  * tGravityAcc-XYZ
  * tBodyAccJerk-XYZ
  * tBodyGyro-XYZ
  * tBodyGyroJerk-XYZ
  * tBodyAccMag
  * tGravityAccMag
  * tBodyAccJerkMag
  * tBodyGyroMag
  * tBodyGyroJerkMag
  * fBodyAcc-XYZ
  * fBodyAccJerk-XYZ
  * fBodyGyro-XYZ
  * fBodyAccMag
  * fBodyAccJerkMag
  * fBodyGyroMag
  * fBodyGyroJerkMag

## Notes

For more information about this dataset contact:
activityrecognition@smartlab.ws

For more information about the tidy data modification contact:
jyamada1@gmail.com

## Original License

Use of this dataset in publications must be acknowledged by
referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using
a Multiclass Hardware-Friendly Support Vector Machine. International
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or
explicit can be addressed to the authors or their institutions for its
use or misuse. Any commercial use is prohibited.

## Original Copyright

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide
Anguita. November 2012.
