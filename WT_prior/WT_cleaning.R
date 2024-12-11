library(ggplot2)
library(tidyverse)
library(readxl)
library(lubridate)
library(corrplot)
library(naniar)



WT_prior <- read_xlsx("C:/Users/SSabharwal/OneDrive - Watercare Services Limited/Pred_Modelling_Condition/WT_prior/WT_prioritisation_final.xlsx")


# Cleaning out columns and variables that are not needed

WT_prior <- WT_prior %>% select(-OBJECTID)
WT_prior <- WT_prior %>% select(-WSL_OBJECTID)
WT_prior <- WT_prior %>% select(-GIS_ID)
WT_prior <- WT_prior %>% select(-EQUIP_ID)
WT_prior <- WT_prior %>% select(-COMPKEY)
WT_prior <- WT_prior %>% select(-FAC_CODE)
WT_prior <- WT_prior %>% select(-FAC_DESC)
WT_prior <- WT_prior %>% select(-FAC_DESC)
WT_prior <- WT_prior %>% select(-PROCESS)
WT_prior <- WT_prior %>% select(-GRP)
WT_prior <- WT_prior %>% select(-POSITION)
WT_prior <- WT_prior %>% select(-STATUS)
WT_prior <- WT_prior %>% select(-LINING)
WT_prior <- WT_prior %>% select(-ACCURACY)
WT_prior <- WT_prior %>% select(-TYPE)
WT_prior <- WT_prior %>% select(-DATASOURCE)
WT_prior <- WT_prior %>% select(-)
# Restructuring some columns



# Fixing datatypes


# Making a modelling dataset and an analysis dataset
