# Course Project
## Getting and Cleaning Data
Author: Stephen Wade
Date: 26/07/2015

This is the repository for the project for *Getting and Cleaning Data*, a
course run by John Hopkins University via [coursera](http://www.coursera.org).

The output is generated by running the script `run_analysis.R` in Rstudio.
This will;

  1. download the UCI HAR data into the `./data/` sub-directory;
  2. extract the contents of the archive;
  3. merge the test and training data into a single tidy dataset, extracting
only the mean and standard deviation components of the feature vector; and
  4. generate a summary (tidy) dataset which contains the average of the mean
and standard deviation variables grouped by subject and activity.

To run, the `dplyr` library (version 0.2 or greater) is required.

The extracted data (without averaging) is stored in `output/UCI_HAR_ms_tidy.txt`
while the summary (averaged) data is found in `output/UCI_HAR_ms_averages.txt`,
both are generated using the `write.table()` function in R.

  * `codebook.md` describes the original data and the tidy dataset produced by this project
  * `run_analysis' is a bash script  which simply runs `run_analysis.R` using Rscript.
  * `download_UCI_data.R` contains a function for downloading the data, and is invoked by
`run_analysis.R`
  * `process_UCI_data.R` contains functions for processing/cleaning the UCI HAR datasets
into a tidy datasets (ready for merging/summary), is invoked by `run_analysis.R`

The MD5 sums of the output files (for verification of procedure) are
  * `UCI_HAR_ms_tidy.txt` 71967342fd58cf33a1362c9b6c495d29
  * `UCI_HAR_ms_summary.txt` 56195ae4e50b6b38638b21786b86ae95
