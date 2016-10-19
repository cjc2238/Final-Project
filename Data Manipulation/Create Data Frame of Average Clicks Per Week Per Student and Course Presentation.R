#############################################
## Reference This Script Before Running #####
#############################################
source('~/GitHub/Final-Project/Data Manipulation/Load Data Frames from CSV Files.R', echo=TRUE)

####################
## Load Libraries ##
####################

library(tidyr)
library(dplyr)

#######################
## Create Data Frame ##
#######################

click_df <- merge(std_vle_df, vle_df, by= c("id_site","code_presentation","code_module"))
