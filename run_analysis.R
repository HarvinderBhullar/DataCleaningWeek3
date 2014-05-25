
#
# This function first compute the mean and std across each dircetion and then
# generate the new tidy data set which is grouped by each activity and each subject
#
#
run_analysis <- function()
{
        train <-  read.csv("data/train/X_train.txt", header=FALSE, sep="", colClasses=c( rep("numeric",561)))
        # read all the features from the feature text
        features <-  read.csv("data/features.txt", sep="" , header=FALSE)
        #assign column names from the feature data
        names(train) <- features[,2]
        test <- read.csv("data/test/X_test.txt", header=FALSE, sep="", colClasses=c(rep("numeric",561)))
        names(test) <- features[,2]
        #merge two data sets using row bind
        testTrain <- rbind(train, test)
        
        #
        #2. extract only the mean and std from the merge data set
        #
        #first three cols and mean across x,y, direction and next 3 cols are std across each dircetion
        meanNStd <- testTrain[,1:6]
       
        #read test activity
        testAct <- read.csv("data/test/y_test.txt", header=FALSE, colClasses=c("numeric"))
        names(testAct) <- "Activity.Name"
        trainAct <- read.csv("data/train/y_train.txt", header=FALSE, colClasses=c("numeric"))
        names(testAct) <- "Activity"
        names(trainAct) <- "Activity"
        #merge activity the way data set is merged, keep the order of merging same
        mergedAct <- rbind(trainAct,testAct)
        #merge this data set with meanNStd set
        meanNStd <- cbind(mergedAct,meanNStd )
       
        noOfRows <- nrow(meanNStd)
        #
        #Add descriptive activity labels to the data set
        #This is not optimized but wrote it for the lack of time
        #
        for(i in 1:noOfRows )
        {
              
            if(meanNStd$Activity[i] == 1)
                    meanNStd$Activity.Description[i] <- "WALKING"
            else if(meanNStd$Activity[i] == 2)
                    meanNStd$Activity.Description[i] <- "WALKING_UPSTAIRS"
            else if(meanNStd$Activity[i] == 3)
                    meanNStd$Activity.Description[i] <- "WALKING_DOWNSTAIRS"
            else if(meanNStd$Activity[i] == 4)
                    meanNStd$Activity.Description[i] <- "SITTING"
            else if(meanNStd$Activity[i] == 5)
                    meanNStd$Activity.Description[i] <- "STANDING"
            else if(meanNStd$Activity[i] == 6)
                    meanNStd$Activity.Description[i] <- "LAYING"
            else
                    meanNStd$Activity.Description[i] <- "NA"
            
         }
        meanNStd
        
        #
        #This is the last part which is generating a separate tidy data set, which is group by each activity
        # and subject, store this into a file
        #
        tidyData  <-  tidyDataSet()
        write.csv(tidyData, "tidyDataSet.txt")
        
}

#
# This function returns the tidy data set which is grouped by each activity and each subject
#

tidyDataSet <- function()
{
        train <-  read.csv("data/train/X_train.txt", header=FALSE, sep="", colClasses=c( rep("numeric",561)))
        # read all the features from the feature text
        features <-  read.csv("data/features.txt", sep="" , header=FALSE)
        #assign column names from the feature data
        names(train) <- features[,2]
        test <- read.csv("data/test/X_test.txt", header=FALSE, sep="", colClasses=c(rep("numeric",561)))
        names(test) <- features[,2]
        #merge two data sets using row bind
        testTrain <- rbind(train, test)
        
        #read test activity
        testAct <- read.csv("data/test/y_test.txt", header=FALSE, colClasses=c("numeric"))
        names(testAct) <- "Activity.Name"
        trainAct <- read.csv("data/train/y_train.txt", header=FALSE, colClasses=c("numeric"))
        names(testAct) <- "Activity"
        names(trainAct) <- "Activity"
        #merge activity the way data set is merged, keep the order of merging same
        mergedAct <- rbind(trainAct,testAct)
        #merge this data set with testTrain set
        testTrain <- cbind(mergedAct,testTrain )
        
        #read subjects for test and train        
        testSub <- read.csv("data/test/subject_test.txt", header=FALSE, colClasses=c("numeric"))
        names(testAct) <- "Activity.Name"
        trainSub <- read.csv("data/train/subject_train.txt", header=FALSE, colClasses=c("numeric"))
        names(testSub) <- "Subject"
        names(trainSub) <- "Subject"
        #merge activity the way data set is merged, keep the order of merging same
        mergedSub <- rbind(trainSub,testSub)
        #merge this data set with testTrain set
        testTrain <- cbind(mergedSub,testTrain )
        
        #Group by Subject and Activity
        testTrain <- aggregate(testTrain, by=list(testTrain$Subject, testTrain$Activity), function(x) mean(x))
        
        #two extra column named Group.1 and Group.2 are added which needs to be removed
        testTrain$Group.1 <- NULL
        testTrain$Group.2 <- NULL
        
        
        testTrain
        
}