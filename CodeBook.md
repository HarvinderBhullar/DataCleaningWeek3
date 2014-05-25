This explains the data variable and the transformation requirements for generating the data
========================================================
1. Read the following training data from the train folder  
 * X_train, which contains all the data as described in the assinment
 * Y_train , which describes the each type of activity conducted by each subjects. The activity description is available  in featutes,txt  
 * subjects_train, which contains all the subjects who participated in the data collection exercise 
 * Use features.txt to read the features name and assign the names to the columns
 * Use rbind to combine the test data
2. Repeat the above mentioned steps for test data 
3. Use rbind  to combine the test and train data 
4. First six coulmns in the x_test and x_train contains the mean and standrad deviation across each directions, extract this to get the mean and standard deviation
5. Extract the activity description from the activity_label.txt folder. Use this to add a column to assign description to activity
6. Use aggregate function to find the mean for each features which is grouped by activity and subject 

