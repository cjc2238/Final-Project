#############################################
## Reference This Script Before Running #####
#############################################
source('~/GitHub/Final-Project/Data Manipulation/Load Data Frames from CSV Files.R', echo=TRUE)

####################
## Load Libraries ##
####################

library(tidyr)
library(dplyr)
library(ggplot2)

##################################
## Load Binary Click Data Frame ##
##################################

df1 <- read.csv("AAA_Data_Binary_Label.csv")

#####################################################
## Merge Binary Click Data Frame with Student Info ##
#####################################################

df2 <- merge(df1, std_info_df, by= c("id_student","code_presentation"))

##############################
## Remove Unwanted Features ##
##############################

df3 <- subset(df2, code_module %in% "AAA", select = -c(X, final_result.x, final_result.y))

#####################
## Save Data Frame ##
#####################

write.csv(df3, file = "AAA_Data_Binary_Label_Additional_Features.csv")
