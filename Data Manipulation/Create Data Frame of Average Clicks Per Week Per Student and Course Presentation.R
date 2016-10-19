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

#############################
## Create 2013j Data Frame ##
#############################

click_df <- merge(std_vle_df, vle_df, by= c("id_site","code_presentation","code_module"))

click_df_2013j_aaa <- subset(click_df, code_module %in% "AAA" & code_presentation %in% "2013J", select = c(id_student, date, sum_click, activity_type))

click_df_2013j_aaa$bins <- cut(click_df_2013j_aaa$date, breaks = seq(-1, 268, 7))

click_df_2013j_aaa$bins = as.numeric(click_df_2013j_aaa$bins)

click_df_2013j_aaa_df3 <- click_df_2013j_aaa %>% dplyr::group_by(bins, activity_type, id_student) %>% dplyr::summarise(sum(sum_click))

click_df_2013j_aaa_df4 <- tidyr::spread(click_df_2013j_aaa_df3, activity_type, 'sum(sum_click)')

click_df_2013j_aaa_df4$total_weekly_clicks <- rowSums(click_df_2013j_aaa_df4[,c("dataplus","forumng","glossary","homepage","oucollaborate","oucontent","resource","subpage","url")], na.rm=T)

click_df_2013j_aaa_df5 <- data.frame(click_df_2013j_aaa_df4$id_student, click_df_2013j_aaa_df4$bins, click_df_2013j_aaa_df4$total_weekly_clicks)

names(click_df_2013j_aaa_df5) <- c("student_id","week","sum_clicks")


###############################
## Replace N/A Values with 0 ##
###############################

click_df_2013j_aaa_df5$week[is.na(click_df_2013j_aaa_df5$week)] <- 0
click_df_2013j_aaa_df5$sum_clicks[is.na(click_df_2013j_aaa_df5$sum_clicks)] <- 0

click_df_2013j_aaa_df6 <- tidyr::spread(click_df_2013j_aaa_df5, week, 'sum_clicks')

####################################
## Pull Student Final Exam Info ####
####################################

final_result_2013j_aaa <- subset(std_info_df, code_presentation %in% "2013J" & code_module %in% "AAA", select = c(id_student, final_result))

names(final_result_2013j_aaa) <- c("student_id","final_result")

click_df_2013j_aaa_df7 <- merge( click_df_2013j_aaa_df6, final_result_2013j_aaa, by= c("student_id"))

###############################
## Create Data Frame For ML ###
###############################

write.csv(click_df_2013j_aaa_df7, file = "2013_AAA_Click_Data.csv")




