#####################
## Load Data Files ##
#####################

# Set working directory to data folder
setwd("~/GitHub/Project Data Files")

# Load .CSV files and convert to dataframes
assessments_df <- read.csv("assessments.csv")
courses_df <- read.csv("courses.csv")
std_assessments_df <- read.csv("studentAssessment.csv")
std_info_df <- read.csv("studentinfo.csv")
std_registration_df <- read.csv("studentRegistration.csv")
std_vle_df <- read.csv("studentVle.csv")
vle_df <- read.csv("vle.csv")


