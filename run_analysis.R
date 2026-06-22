library(readr)
library(dplyr)
# _____________Reading Train Dataset________________________

  #Reading Subject Number
    Subject_Number_Train <- read_fwf("train/subject_train.txt")

  #Reading Activity Lable (Y variable)
    Activity_Lable_Train_Y <- read_fwf("train/y_train.txt")

  #Reading features (X variable)
    features_Train_X <- read_fwf("train/X_train.txt", col_positions = fwf_widths(rep(16, 561)))
    
    
    Training_data_set <- cbind(Subject_Number_Train,
                               Activity_Lable_Train_Y,
                               features_Train_X)
    
# _____________Reading Test Dataset________________________
    
    #Reading Subject Number
    Subject_Number_Test <- read_fwf("test/subject_test.txt")
    
    #Reading Activity Lable (Y variable)
    Activity_Lable_Test_Y <- read_fwf("test/y_test.txt")
    
    #Reading features (X variable)
    features_Test_X <- read_fwf("test/X_test.txt", col_positions = fwf_widths(rep(16, 561)))
    
    
    Test_data_set <- cbind(Subject_Number_Test,
                               Activity_Lable_Test_Y,
                               features_Test_X)
    # STEP 1
    Final_data_set <- rbind(Training_data_set,Test_data_set)
    
    # STEP 2
    features <- read.table("features.txt")
    
    feature_names <- features[, 2]
    
    names(Final_data_set) <- c("Subject","Activity Lable",feature_names)
    
    target_columns <- grep("mean\\(\\)|std\\(\\)",names(Final_data_set))
    
    
    TidyDataset <- Final_data_set[, c(1,2,target_columns)]
    
    # STEP 3
    TidyDataset <- TidyDataset %>% 
         mutate(`Activity Lable` = recode(`Activity Lable`,
                                             "1" = "WALKING",
                                             "2" = "WALKING_UPSTAIRS",
                                             "3" = "WALKING_DOWNSTAIRS",
                                             "4" = "SITTING",
                                             "5" = "STANDING",
                                             "6" = "LAYING"))
    
    # STEP 4
    names(TidyDataset) <- gsub("-mean\\(\\)","Mean",names(TidyDataset))
    names(TidyDataset) <- gsub("-std\\(\\)","STD",names(TidyDataset))
    names(TidyDataset) <- gsub("Acc","Acceleration",names(TidyDataset))
    names(TidyDataset) <- gsub("Gyro","Gyroscope",names(TidyDataset))
    names(TidyDataset) <- gsub("BodyBody","Body",names(TidyDataset))
    names(TidyDataset) <- gsub("Mag","Magnitude",names(TidyDataset))
    names(TidyDataset) <- sub("f","Frequency",names(TidyDataset))
    names(TidyDataset)[3:42] <- sub("t","Time",names(TidyDataset)[3:42]) # Because I was facing the problem of changing the first letter "t" to be founded 
    names(TidyDataset) <- gsub("-X","\\(X-Axis\\)",names(TidyDataset))
    names(TidyDataset) <- gsub("-Y","\\(Y-Axis\\)",names(TidyDataset))
    names(TidyDataset) <- gsub("-Z","\\(Z-Axis\\)",names(TidyDataset))
    
    # STEP 5
    SummaryDataset <- TidyDataset %>% group_by(Subject, `Activity Lable`) %>% summarise(across(everything(),mean))
    write.table(SummaryDataset,file="TidyDataest_Jaafar_Reshy.txt",row.names = F)