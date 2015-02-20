#Getting and Cleaning Data
##Course Project Code Book
This code book describes the tidy data set resulting from processing the "Human Activity Recognition Using Smartphones Dataset", by Davide Anguita et al. We first provide a cursory description of the raw data, followed by a description of the cleaning process and the variables in the final data set.
###Raw Data Set
 The raw data consists of a series of measurements of 3-axial linear acceleration and 3-axial angular velocity (as well as some derived quantities) collected with a smartphone on 30 test subjects as they performed different physical activities (i.e. walking, walking upstairs, walking downstairs, sitting, standing, laying). Measured quantities include the following:

  - tBodyAcc-XYZ
  - tGravityAcc-XYZ
  - tBodyAccJerk-XYZ
  - tBodyGyro-XYZ
  - tBodyGyroJerk-XYZ
  - tBodyAccMag
  - tGravityAccMag
  - tBodyAccJerkMag
  - tBodyGyroMag
  - tBodyGyroJerkMag
  - fBodyAcc-XYZ
  - fBodyAccJerk-XYZ
  -fBodyGyro-XYZ
  - fBodyAccMag
  - fBodyAccJerkMag
  - fBodyGyroMag
  - fBodyGyroJerkMag

Additionally, the following quantities were computed for each measurement

  - mean(): Mean value
  - std(): Standard deviation
  - mad(): Median absolute deviation 
  - max(): Largest value in array
  - min(): Smallest value in array
  - sma(): Signal magnitude area
  - energy(): Energy measure. Sum of the squares divided by the number of values. 
  - iqr(): Interquartile range 
  - entropy(): Signal entropy
  - arCoeff(): Autorregresion coefficients with Burg order equal to 4
  - correlation(): correlation coefficient between two signals
  - maxInds(): index of the frequency component with largest magnitude
  - meanFreq(): Weighted average of the frequency components to obtain a mean frequency
  - skewness(): skewness of the frequency domain signal 
  - kurtosis(): kurtosis of the frequency domain signal 
  - bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
  - angle(): Angle between two vectors.

The raw data is divided in two groups, i.e. the training set and the test set. For each set, 2947 observations are encoded in three separate files, with each observation in a different line. The *subject_text.txt* file describes the subject on which the measurement was made; the file *y_test.txt (or y_train.txt)* contains information regarding the activity, and finally, the *X_test.txt (or X_train.txt)* file has a column for each of the 561 measured quantities described above, and explicitly listed in features.txt.

### Transforming the Raw Data

The first processing step is to produce a single data frame for the test and train sets by binding the columns corresponding to experimental subject, activity, and the 561 measured variables. In this manner, we arrive at a data frame whose rows correspond to the measured values of 561 variables for a given subject carrying out a specific activity. The train and test sets can then be merged by row-binding the two data frames. This can be accomplished straightforwardly since the train and test sets have identical structures and do not overlap. 

Then, the information from the *features.txt* file is used to rename the columns of the data frame, such that each is given a descriptive name. Regular expressions are then used on the column names to subset only those corresponding to the calculated mean and standard deviation of measured quantities. Activities are also renamed, replacing the digits by their respective descriptive strings, as outlined in *activity_labels.txt*.

Finally, the data is grouped by subject and activity using the *group_by* functionality of the *dplyr* package, allowing summary statistics to be computed.

### Resulting Tidy Data Set

Following the procedure outlined in the previous section, we arrive at a tidy data set, encoded in a data frame with the following attributes, or columns, as follows. There is one entry for each subject carrying out each activity.

| Column Name   | Description   |
| ------------- | ------------- |
| SUBJECT       | Integer within [1,30] corresponding to the subject being measured  |
| ACTIVITY | String. Takes on values *walking*, *walking_upstairs*, *walking_downstairs*, *sitting*, *standing*, or *laying*  |
|MEAN(quantity)|Corresponds to the mean of the mean or standard deviation of the quantities being measured with the smartphone. Units correspond to those of the base quantity: either *rad/sec* for angular velocities, or *m/s^2* for linear accelerations. The full list of quantities can be found below |

The full list of derived quantities whose mean is found in the tidy data set is as follows:

*tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, tGravityAcc-mean()-X, tGravityAcc-mean()-Y, tGravityAcc-mean()-Z, tBodyAccJerk-mean()-X,
tBodyAccJerk-mean()-Y (dbl), tBodyAccJerk-mean()-Z (dbl), tBodyGyro-mean()-X (dbl), tBodyGyro-mean()-Y (dbl), tBodyGyro-mean()-Z (dbl),
  tBodyGyroJerk-mean()-X (dbl), tBodyGyroJerk-mean()-Y (dbl), tBodyGyroJerk-mean()-Z (dbl), tBodyAccMag-mean() (dbl), tGravityAccMag-mean() (dbl), tBodyAccJerkMag-mean()
  (dbl), tBodyGyroMag-mean() (dbl), tBodyGyroJerkMag-mean() (dbl), fBodyAcc-mean()-X (dbl), fBodyAcc-mean()-Y (dbl), fBodyAcc-mean()-Z (dbl), fBodyAcc-meanFreq()-X (dbl),
  fBodyAcc-meanFreq()-Y (dbl), fBodyAcc-meanFreq()-Z (dbl), fBodyAccJerk-mean()-X (dbl), fBodyAccJerk-mean()-Y (dbl), fBodyAccJerk-mean()-Z (dbl), fBodyAccJerk-meanFreq()-X
  (dbl), fBodyAccJerk-meanFreq()-Y (dbl), fBodyAccJerk-meanFreq()-Z (dbl), fBodyGyro-mean()-X (dbl), fBodyGyro-mean()-Y (dbl), fBodyGyro-mean()-Z (dbl),
  fBodyGyro-meanFreq()-X (dbl), fBodyGyro-meanFreq()-Y (dbl), fBodyGyro-meanFreq()-Z (dbl), fBodyAccMag-mean() (dbl), fBodyAccMag-meanFreq() (dbl), fBodyBodyAccJerkMag-mean()
  (dbl), fBodyBodyAccJerkMag-meanFreq() (dbl), fBodyBodyGyroMag-mean() (dbl), fBodyBodyGyroMag-meanFreq() (dbl), fBodyBodyGyroJerkMag-mean() (dbl),
  fBodyBodyGyroJerkMag-meanFreq() (dbl), tBodyAcc-std()-X (dbl), tBodyAcc-std()-Y (dbl), tBodyAcc-std()-Z (dbl), tGravityAcc-std()-X (dbl), tGravityAcc-std()-Y (dbl),
  tGravityAcc-std()-Z (dbl), tBodyAccJerk-std()-X (dbl), tBodyAccJerk-std()-Y (dbl), tBodyAccJerk-std()-Z (dbl), tBodyGyro-std()-X (dbl), tBodyGyro-std()-Y (dbl),
  tBodyGyro-std()-Z (dbl), tBodyGyroJerk-std()-X (dbl), tBodyGyroJerk-std()-Y (dbl), tBodyGyroJerk-std()-Z (dbl), tBodyAccMag-std() (dbl), tGravityAccMag-std() (dbl),
  tBodyAccJerkMag-std() (dbl), tBodyGyroMag-std() (dbl), tBodyGyroJerkMag-std() (dbl), fBodyAcc-std()-X (dbl), fBodyAcc-std()-Y (dbl), fBodyAcc-std()-Z (dbl),
  fBodyAccJerk-std()-X (dbl), fBodyAccJerk-std()-Y (dbl), fBodyAccJerk-std()-Z (dbl), fBodyGyro-std()-X (dbl), fBodyGyro-std()-Y (dbl), fBodyGyro-std()-Z (dbl),
  fBodyAccMag-std() (dbl), fBodyBodyAccJerkMag-std() (dbl), fBodyBodyGyroMag-std() (dbl), fBodyBodyGyroJerkMag-std() (dbl)*
