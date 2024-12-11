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
WT_prior <- WT_prior %>% select(-PROCESS)
WT_prior <- WT_prior %>% select(-GRP)
WT_prior <- WT_prior %>% select(-POSITION)
WT_prior <- WT_prior %>% select(-STATUS)
WT_prior <- WT_prior %>% select(-LINING)
WT_prior <- WT_prior %>% select(-ACCURACY)
WT_prior <- WT_prior %>% select(-TYPE)
WT_prior <- WT_prior %>% select(-DATASOURCE)
WT_prior <- WT_prior %>% select(-SERVICE)
WT_prior <- WT_prior %>% select(-SUBTYPE)
WT_prior <- WT_prior %>% select(-HACOMPKEY)
WT_prior <- WT_prior %>% select(-R_STAT)
WT_prior <- WT_prior %>% select(-R_MAT)
WT_prior <- WT_prior %>% select(-R_DIA)
WT_prior <- WT_prior %>% select(-R_INST)
WT_prior <- WT_prior %>% select(-AQ_TYPE)
WT_prior <- WT_prior %>% select(-USE_AREA)
WT_prior <- WT_prior %>% select(-USE_AREAID)
WT_prior <- WT_prior %>% select(-HAUNITTYPE)
WT_prior <- WT_prior %>% select(-OWN)
WT_prior <- WT_prior %>% select(-R_OWN)
WT_prior <- WT_prior %>% select(-PARLINENO)
WT_prior <- WT_prior %>% select(-LIN_DATE)
WT_prior <- WT_prior %>% select(-PROJ_REF)
WT_prior <- WT_prior %>% select(-F_IwiAOI)
WT_prior <- WT_prior %>% select(-SHAPE_Length)
WT_prior <- WT_prior %>% select(-`New action`)



# Restructuring some columns and adjusting datatypes 


WT_prior <- WT_prior %>% mutate_if(is.character, as.factor)


WT_prior$INSTALLED <- format(WT_prior$INSTALLED, "%Y")

WT_prior$INSTALLED <- as.numeric(WT_prior$INSTALLED)

WT_prior$condition_overall_score_label <- as.factor(WT_prior$condition_overall_score_label)



# Making a modelling dataset and an analysis dataset

WT.analysis <- WT_prior 


WT.modelling <- WT_prior[,1:12]


write_csv(WT.analysis, "WT.analysis.csv")
write_csv(WT.modelling, "WT.modelling.csv")
