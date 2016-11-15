library(tidyr)
library(dplyr)

source('~/GitHub/Final-Project/Data Manipulation/Load Data Frames from CSV Files.R', echo=TRUE)

click_df <- merge(std_vle_df, vle_df, by= c("id_site","code_presentation","code_module"))

df <- split(click_df, list(click_df$code_presentation,click_df$code_module), drop = TRUE) 

lapply(names(df), function(x){write.table(df[[x]], file = paste("output", x, sep = ""))})


