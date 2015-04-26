This file describes how run_analysis.R works.
1.	UnZip the data from the source below
2.	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "data"
3.	Make sure that the run_analysis.R and the data folder are in same working directory
4.	To use run_analysis, use source(“run.analysis.R) command in RStudio
5.	Two files will be generated in result of this tidyData.txt and tidyData.Withmean.txt
6.	To view the average of each variable (with all combination of selected features) for each subject and each activity
	Use data <- read.table(“tidyData.WithMean.txt”)
	View(data)
