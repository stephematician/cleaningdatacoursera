# This script creates a clean data set as per the requirements of the Coursera
# 'Getting and Cleaning Data' course run by John Hopkins University
#
# Author: Stephen Wade
# Date: 27/07/2015

library('dplyr')

source('download_UCI_data.R')
source('process_UCI_data.R')

tidy_file <- './output/UCI_HAR_ms_tidy.txt'
summary_file <- './output/USI_HAR_ms_summary.txt'

if (!file.exists('output')) {
    dir.create('output')
}

download_UCI_data(overwrite=FALSE)

# Read in the two individual datasets
UCI_training <- UCI_as_one('train')
UCI_test <- UCI_as_one('test')

# Merge and sort
merged_UCI_data <- rbind(UCI_training, UCI_test)
UCI_HAR_ms_tidy <- arrange(merged_UCI_data, id, activity)
UCI_HAR_ms_tidy <- group_by(UCI_HAR_ms_tidy, id, activity)

write.table(UCI_HAR_ms_tidy, tidy_file, row.names=FALSE)

# requires dplyr 0.2
UCI_HAR_ms_summary <- summarise_each(UCI_HAR_ms_tidy, funs(mean))
write.table(UCI_HAR_ms_summary, summary_file, row.names=FALSE)

