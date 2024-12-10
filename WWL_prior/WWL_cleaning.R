library(ggplot2)
library(tidyverse)
library(readxl)
library(lubridate)
library(corrplot)
library(naniar)



WWL_prior <- read_xlsx("C:/Users/SSabharwal/OneDrive - Watercare Services Limited/Pred_Modelling_Condition/WWL_prior/WW_local_prioritisation_final.xlsx")




# Getting rid of useless columns

WWL_prior <- WWL_prior %>% select(-OBJECTID)
WWL_prior <- WWL_prior %>% select(-GISID)
WWL_prior <- WWL_prior %>% select(-COMPKEY)
WWL_prior <- WWL_prior %>% select(-PROCESS)
WWL_prior <- WWL_prior %>% select(-TYPE)
WWL_prior <- WWL_prior %>% select(-SERVICE)
WWL_prior <- WWL_prior %>% select(-HACOMPKEY)
WWL_prior <- WWL_prior %>% select(-)



# Fixing Datatypes



# Restructuring columns



# Making modelling and analysis datasets



