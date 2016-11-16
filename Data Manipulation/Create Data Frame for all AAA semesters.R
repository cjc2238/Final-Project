source('~/GitHub/Final-Project/Data Manipulation/Load Data Frames from CSV Files.R', echo=TRUE)

click_df <- merge(std_vle_df,
                  vle_df,
                  by= c("id_site","code_presentation","code_module"))

click_df_aaa <- subset(click_df,
                             code_module %in% "AAA",
                             select = c(id_student, date, sum_click, activity_type, code_presentation))

activity_type_sum_click_aaa <- click_df_aaa %>% dplyr::group_by(id_student, activity_type, code_presentation) %>% dplyr::summarise(sum(sum_click))

spread_activity_type_avg_click_aaa <- tidyr::spread(activity_type_sum_click_aaa,
                                                          activity_type,
                                                          'mean(sum_click)')

std_info_df_aaa <- subset(std_info_df, code_module %in% "AAA", select= c(id_student, code_presentation, final_result))

df <- merge(spread_activity_type_avg_click_aaa, std_info_df_aaa, by = c("id_student","code_presentation"))

df <- na.replace(df, 0)

apply(df,2,function(x) sum(is.na(x)))

write.csv(df, file = "AAA_SUM_Data_for_Tree.csv")
