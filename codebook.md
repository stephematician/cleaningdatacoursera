# Course Project Code Book
## Getting and Cleaning Data
Author: Stephen Wade
Date: 26/07/2015

This is the codebook for the dataset and analysis for the course project of the
Getting and Cleaning Data course run by John Hopkins University via [coursera](http://www.coursera.org)

### Study Design

The data used in this study is the Human Activity Recognition Using Smartphones
Dataset.

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

A group of 30 volunteers were sampled performing the following activities;
walking, walking upstairs, walking downstairs, sitting, standing and laying.
Measurements using the acclerometer and gyroscope of a Samsung Galaxy S II worn
by the volunteer were taken. The raw measurements were taken at a frequency of
50Hz over 6 variables, 3 axial (liner) accelerations and 3 axial angular
velocity variables.

The recorded signals (or time-series) were then pre-processed by applying noise
filters, and then sampled in fixed-width sliding windows of 128 readings (i.e. a
window of 2.56 seconds of the activity being performed by the subject) with 50%
overlap.

The accleration signal is assumed to have two components, body and
gravitational. These are separated into two further time-series using a low-pass 
'Butterworth' filter, where The gravitational force is assumed to have only
low-frequency components, and thus a 0.3Hz cut-off is used.

A record (row) in the original data thus corresponds to one 2.56sec window (as
specified) of a particular activity by a volunteer. The attributes (columns) for
each record are described in 'features_info.txt' and 'features.txt' of the
original dataset. In summary, the attributes are; aggregates and transforms of
the processed time-series for body and graviational acceleration, and the
gyroscopic time-series. These attributes include the mean, standard deviation,
median, energy measure, correlation between signals, skewness of the Fourier
domain view of the signal, and others.

Here we are only interested in mean and standard deviation (and we ignore the
weighted mean as described in features_info.txt for computing a meanFreq).

The original data was also split into two separate datasets, a test and a
training set. These are stored in separate folders 'test' and 'train' in the
original dataset, and will be merged in this exercise.

The pre-processed time-series data is also available (before being turned into
the feature vector). This is ignored in this exercise, too, and it is assumed
that the feature vectors have been correctly calculated from the time-series.

General notes; all the data is stored as .txt files with spaces separating
entries. Features are normalized and bounded within [-1,1], presumably this
means they all have Euclidean norm equal to one.

### Code Book

run_analysis.R generates a set of summary data for the experiment. It performs
these steps;

1. downloads the UCI HAR data;
2. extracts the contents of the archive;
3. merges the test and training data into a single tidy dataset, extracting
only the mean and standard deviation components of the feature vector; and
4. generates a summary (tidy) dataset which contains the average of the mean
and standard deviation variables grouped by subject and activity.

#### The tidy datasets
Two datasets are generated (in step 3 and step 4). The larger set, from step 3,
is output as `output/UCI_HAR_ms_tidy.txt` (UCI HAR mean and standard
deviation extract), the summary is output as `output/UCI_HAR_ms_averages.txt`.

The following attributes (columns) in the both datasets are:

  * `id` - the volunteer id (1-30)
  * `activity` - the activity, in quotes, can be one of `"walking"`,
  `"walking upstairs"`, `"walking downstairs"`, `"sitting"`, `"standing"` and
    `"laying"`
  * `tBodyAcc` `-mean()` and `-std()`, with `-X`, `-Y` and `-Z` components
  * `tGravityAcc` `-mean()` and `-std()`, with `-X`, `-Y` and `-Z` components
  * `tBodyAccJerk` `-mean()` and `-std()`, with `-X`, `-Y` and `-Z` components
  * `tBodyGyro` `-mean()` and `-std()`, with `-X`, `-Y` and `-Z` components
  * `tBodyGyroJerk` `-mean()` and `-std()`, with `-X`, `-Y` and `-Z` components
  * `tBodyAccMag` `-mean()` and `-std()`
  * `tGravityAccMag` `-mean()` and `-std()`
  * `tBodyAccJerkMag` `-mean()` and `-std()`
  * `tBodyGyroMag` `-mean()` and `-std()`
  * `tBodyGyroJerkMag` `-mean()` and `-std()`
  * `fBodyAcc` `-mean()` and `-std()`, with `-X`, `-Y` and `-Z` components
  * `fBodyAccJerk` `-mean()` and `-std()`, with `-X`, `-Y` and `-Z` components
  * `fBodyGyro` `-mean()` and `-std()`, with `-X`, `-Y` and `-Z` components
  * `fBodyAccMag` `-mean()` and `-std()`
  * `fGravityAccMag` `-mean()` and `-std()`
  * `fBodyAccJerkMag` `-mean()` and `-std()`
  * `fBodyGyroMag` `-mean()` and `-std()`
  * `fBodyGyroJerkMag` `-mean()` and `-std()`

The general naming schema is that `t` stands for time domain, and `f` stands for
Fourier/frequency domain. The `-mean()` and `-std()` indicate mean and standard
devations of the signal and `-X`, `-Y` and `-Z` represent the axis of the
measurement. So `fBodyAcc-mean()-Y` would be the mean of the body acceleration
along the y axis in the frequency domain.

The dimensions (i.e. units) of the variables is not clear, as each is an
aggregate of different physical measurements, and the feature vectors themselves
are normalized. They are assumed to be dimensionless (unitless) here.

The last three items were identified as`fBodyBodyAccJerkMag`, `fBodyBodyGyroMag`
and `fBodyBodyGyroJerkMag` in the original dataset, probably in error, so the
repeated `Body` was removed.

The final tidy dataset is also sorted by `id` (in increasing order) and the
activity (in the increasing order specified by `activity_labels.txt`).

#### The summary dataset

The difference with the summary dataset is that each record is no longer of a
single 2.56sec window, but the average over all the 2.56sec windows of a given
volunteer's recorded activity.

