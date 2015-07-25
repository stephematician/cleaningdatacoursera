download_UCI_data <- function (overwrite=TRUE) {
    # Downloads and unzips the UCI human activity recognition (HAR) data
    #
    # overwrite: If true, then force download and overwrite, otherwise, if the
    # .zip file is already present, this function merely unzips the file.
    #
    # Author: Stephen Wade
    # Date: 27/07/2015
    
    # Create directory for all the data (raw and processed)
    if (!file.exists('data')) {
        dir.create('data')
    }
    
    # Download the dataset using links supplied by JHU
    data_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    local_archive <- './data/UCI_HAR_Dataset.zip'
    local_data <- './data/UCI_HAR_Dataset.zip'
    
    if (overwrite | !file.exists(local_archive)) {
        download.file(data_url,
                      local_archive,
                      method='curl')
        # Record download date
        sink('data/download_date.txt', append=FALSE, split=FALSE)
        print(date())
        sink()
    }
    
    unzip(local_archive, overwrite = TRUE, junkpaths = FALSE, exdir = "./data/")
    
    return(NULL)
}