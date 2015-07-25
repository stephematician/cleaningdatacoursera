
UCI_as_one <- function(uci_prefix) {
    vector_file <- paste('./data/UCI HAR Dataset/', uci_prefix,
                      '/X_', uci_prefix, '.txt', sep='')
    subject_file <- paste('./data/UCI HAR Dataset/', uci_prefix,
                       '/subject_', uci_prefix, '.txt', sep='')
    activity_file <-paste('./data/UCI HAR Dataset/', uci_prefix,
                          '/y_', uci_prefix, '.txt', sep='')
    
    vector_data <- read.table(vector_file)
    subject_data <- read.table(subject_file, colClasses='numeric')
    activity_data <- read.table(activity_file)
    
    # rename the subject data
    subject_data <- select(subject_data, id = V1)

    # need to process the activity data
    activity_data <- UCI_activity_as_factor(activity_data)
    
    # need to process vector data
    features <- UCI_get_features()
    vector_data <- vector_data[,features$V1]
    names(vector_data) <- features$V2
    
    uci_dataset <- cbind(subject_data, activity_data, vector_data)
    
    return(uci_dataset)
}

UCI_get_features <- function() {
    # returns the id's of the columns we are interested in for analysis.
    feature_file <- './data/UCI HAR Dataset/features.txt'
    feature_table <- read.table(feature_file, stringsAsFactors=FALSE)
    
    feature_table <- subset(feature_table,
                            (grepl("mean()", V2) |
                             grepl("std()", V2)) &
                            !grepl("meanFreq", V2))
    # clean up a few names
    err_names <- which(grepl("BodyBody", feature_table$V2))
    for (i in err_names) {
        feature_table$V2[i] <- gsub("BodyBody", "Body", feature_table$V2[i])
    }
    return(feature_table)
}

UCI_activity_as_factor <- function(uci_table) {
    # takes in a data.table with V1 as a numeric indicator of activity
    #
    # returns the activity translated into a factor as specified by
    # activity labels.txt
    activity_file <- './data/UCI HAR Dataset/activity_labels.txt'
    activity_table <- read.table(activity_file)
    
    activity_table$V2 <- sapply(activity_table$V2, tolower)
    activity_table$V2 <- sapply(activity_table$V2,
                                function(x){gsub(pattern = '_', replacement = ' ', x)})
    
    with_acts <- merge(uci_table,
                       activity_table,
                       by.x = 'V1',
                       by.y = 'V1')
    # remove the old columns
    with_acts_tidy <- select(with_acts,-V1, activity=V2)
    with_acts_tidy$activity <- as.factor(with_acts_tidy$activity)
    
    return(with_acts_tidy)
    
}