# Human Activity Recognition Using Smartphones Dataset

# Version 1.0

## Data description

The dataset contains accelerometer and gyroscope information for 30
human _subjects_ each performing 6 _activities_ while wearing a
smartphone. Short time and frequency domain signals were calculated
for various variables, as described below. See
the [original data description](#orig-data) for more information.

### Full dataset data frame - `har_full`

The full dataset for all subjects, activities, and variables is
calculated by the `makeFullDataset` function in `run_analysis.R`. By
default, this dataset is saved as `har_full`, consisting of the
following columns:

  1. **subject** identifier for the human subject who performed the
     activity, by integer id 1-30.

  2. **activity** the activity performed by the subject: walking,
     walking\_upstairs, walking\_downstairs, sitting, standing, or
     laying.

  3. **measure** the measured variable (e.g. "fBodyAcc-X"). one of 33
     possibilites, see [measures](#measures) for further description.

  4. **point** the point in the signal sequence for the given
     activity, measure, and subject (e.g. 1 is the first point in the
     signal).

  5. **mean** the mean value for the *measured* variable in an
     128-sample window, indicated by *point*. Values are normalized
     and bounded within [-1, 1].

  6. **std** the standard deviation of the measured variable in the
     window.

### Averages data frame - `har_averages`

`har_averages` gives the **mean** and standard deviation **std** of
the signal for each combination of subject, activity, and measure.

## Transformations of the original dataset

The original dataset was transformed into a _long_ tidy format,
meaning that an observation (row) consists of a measurement and its
statistics for each subject and activity.

 * Data are combined from the training and test datasets (Users may
   want to make their own subsets).
 * Only mean and standard deviation statistics are preserved.
 * Statistics are placed in their own columns, so the names "-mean()"
   and "-std()" are removed from the variable names

### _long_ tidy format

The tidy data concept leaves the notion of _observation_ and
_variable_ up for interpretation.

In this case, the _long_ tidy format was chosen in preference to the
_wide_ format. In the wide format, each column has to represent both a
measurement _and_ a statistic (e.g. "fBodyAcc-mean()-X",
"fBodyAcc-std()-X"). If a new statistic is calculated, a new column
has to be added for every combination of measurement and statistic.

The long format does not have this fault. It separates the idea of a
particular type of measurement (`fBodyAcc-X`) and any statistics on
that measurement (mean, std, etc.). In the tidy data terminology, the
measurement type is therefore a variable. Note that this format
provides a very natural extension for adding new statistics. A new
statistic is just one new column in a long tidy format.

### Measure naming

The measure names have several abbreviations and are therefore
somewhat cryptic. We have chosen not to change the names of the
measurements from the original dataset for the following reasons:

  * provenance of each point in the original data is much clearer,
  * names become unwieldy when the abbreviations are not used,
  * decomposing the names into components helps clarity some but is
    cumbersome for data transformations

The same measurements made along different axes are considered to be
separate measures. For example, `fBodyAcc-X` is a different
measurement from `fBodyAcc-Y`. This simplifies the data structure
because not all measures have axes.

#### Measure abbreviation key

 | abbrev. | description |
 | ------- | ----------- |
 | f*      | frequency domain signal |
 | t*      | time domain signal |
 | Acc     | accelerometer data |
 | Gyro    | gyroscope data |
 | Jerk    | jerk, calculated from linear acceleration and angular velocity |
 | Mag     | magnitude, Euclidean norm of 3D signals |
 | -X, -Y, -Z | axis of measurement |

## Original data description<a href="#orig-data"></a>

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
