# Code Book: Human Activity Recognition Tidy Summary

This Code Book describes the data, variables, and transformations performed to clean and summarize the **UCI Human Activity Recognition (HAR) Dataset**.

## Project Overview
The objective of this project was to take raw accelerometer and gyroscope data from Samsung Galaxy S II smartphones and transform it into a tidy, summarized dataset. The final output provides the average of selected movement features for 30 subjects across six different activities.

## The Raw Data
The original data was obtained from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

The raw dataset included:
*   **Triaxial acceleration** from the accelerometer (Total acceleration) and the estimated body acceleration.
*   **Triaxial Angular velocity** from the gyroscope. 
*   A **561-feature vector** with time and frequency domain variables.
*   **Activity Labels** (Walking, Sitting, etc.).
*   **An identifier of the subject** who carried out the experiment.

---

## Data Transformation Steps
The following steps were implemented in `run_analysis.R` to clean the data:

1.  **Merging:** The training and test datasets were merged to create one consolidated data frame.
2.  **Extraction:** Out of 561 features, only the measurements on the **mean** (`mean()`) and **standard deviation** (`std()`) for each signal were extracted. This resulted in 66 movement variables.
3.  **Naming Activities:** Activity identifiers (integers 1–6) were replaced with descriptive strings provided in `activity_labels.txt` (e.g., `WALKING`, `LAYING`).
4.  **Labeling Variables:** Column headers were renamed to be human-readable by expanding abbreviations:
    *   `Acc` $\rightarrow$ `Acceleration`
    *   `Gyro` $\rightarrow$ `Gyroscope`
    *   `Mag` $\rightarrow$ `Magnitude`
    *   Prefix `t` $\rightarrow$ `Time`
    *   Prefix `f` $\rightarrow$ `Frequency`
    *   Corrected `BodyBody` typos to `Body`.
5.  **Summarizing:** A final independent tidy dataset was created by calculating the **average (mean)** of each variable for every unique combination of Subject and Activity.

---

## Variable Dictionary

### Identifiers
*   **`Subject`**: (Integer) The ID of the participant, ranging from 1 to 30.
*   **`Activity Lable`**: (Factor) The specific activity performed:
    *   `WALKING`
    *   `WALKING_UPSTAIRS`
    *   `WALKING_DOWNSTAIRS`
    *   `SITTING`
    *   `STANDING`
    *   `LAYING`

### Measurements (66 Variables)
All measurement variables are **numeric** and represent the **mean of the normalized values** for that specific feature per subject/activity. 

**Key to Variable Names:**
*   **Time**: Captured at a constant rate of 50 Hz.
*   **Frequency**: Indicates the application of a Fast Fourier Transform (FFT).
*   **Body**: Relates to the body acceleration signal.
*   **Gravity**: Relates to the gravity acceleration signal.
*   **Mean**: The average value of the signal.
*   **STD**: The standard deviation of the signal.
*   **X/Y/Z-Axis**: The specific direction of the 3-axial signal.

**Example Variables:**
*   `TimeBodyAccelerationMean(X-Axis)`
*   `TimeBodyAccelerationSTD(Z-Axis)`
*   `FrequencyBodyGyroscopeMagnitudeMean`
*   `FrequencyBodyAccelerationJerkMean(Y-Axis)`

---

## Units and Data Format
*   **Units:** All sensor signals were **normalized and bounded within [-1,1]** in the original dataset. Therefore, the resulting means in this summary are unitless and remain within the same range.
*   **Dimensions:** The final tidy dataset (`SummaryDataset`) contains **180 observations** (30 subjects × 6 activities) and **68 variables** (2 identifiers + 66 measurements).