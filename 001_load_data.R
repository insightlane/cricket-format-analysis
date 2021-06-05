#***********************************************************************************************
# TITLE:        Analysis of men's international cricket trends by format
#
# DESCRIPTION:  Creation of summarised data and plots of annual metrics (batting averages, batting strike rates and bowling strike rates)
#
# AUTHOR:       InsightLane
#
# CREATED:      June 2021
# MODIFIED:   
#
# INPUTS:       Excel scrapes from Cricinfo (run separately)
#
# OUTPUTS:      ...
#
# STEPS:
#				001. Import cricket innings scores
#				002. Cleanse and combine data sets
#				003. Create summarised data table of metrics per year
#				004. Cleanse plots for export
#
#***********************************************************************************************

library(readxl)
library(dplyr)
##install.packages("ggplot2")
library(ggplot2)
#install.packages("janitor")
library(janitor)
library(tidyr)



test_match_list  <- read_excel("C:/Local Code/insightlane/cricket-format-analysis/input_files/Cricket scrape - Test 2021_03_08.xlsm", sheet = "Master", ) %>%
  clean_names()
odi_match_list  <- read_excel("C:/Local Code/insightlane/cricket-format-analysis/input_files/Cricket scrape - ODI 2021_03_08.xlsm", sheet = "Master") %>%
  select(-23,-24) %>%
  clean_names()
t20_match_list  <- read_excel("C:/Local Code/insightlane/cricket-format-analysis/input_files/Cricket scrape - T20 2021_03_08.xlsm", sheet = "Master") %>%
  select(-23,-24) %>%
  clean_names()
