library(ggplot2)
library(tidyverse)
library(readxl)
library(lubridate)
library(corrplot)
library(naniar)



WWT_prior <- read_xlsx("C:/Users/SSabharwal/OneDrive - Watercare Services Limited/Pred_Modelling_Condition/WWT_prior/WWT_prioritisation_final.xlsx")



# Getting rid of useless columns

WWT_prior <- WWT_prior %>% select(-GIS_ID)
WWT_prior <- WWT_prior %>% select(-OBJECTID)
WWT_prior <- WWT_prior %>% select(-WSL_OBJECTID)
WWT_prior <- WWT_prior %>% select(-EQUIP_ID)
WWT_prior <- WWT_prior %>% select(-COMPKEY)
WWT_prior <- WWT_prior %>% select(-FAC_CODE)
WWT_prior <- WWT_prior %>% select(-FAC_DESC)
WWT_prior <- WWT_prior %>% select(-PROCESS)
WWT_prior <- WWT_prior %>% select(-GRP)
WWT_prior <- WWT_prior %>% select(-POSITION)
WWT_prior <- WWT_prior %>% select(-STATUS)
WWT_prior <- WWT_prior %>% select(-LINING)
WWT_prior <- WWT_prior %>% select(-US_INV)
WWT_prior <- WWT_prior %>% select(-DS_INV)
WWT_prior <- WWT_prior %>% select(-ACCURACY)
WWT_prior <- WWT_prior %>% select(-TYPE)
WWT_prior <- WWT_prior %>% select(-SERVICE)
WWT_prior <- WWT_prior %>% select(-DATASOURCE)
WWT_prior <- WWT_prior %>% select(-SUBTYPE)
WWT_prior <- WWT_prior %>% select(-FLOWDIR)
WWT_prior <- WWT_prior %>% select(-FLOWDIRACC)
WWT_prior <- WWT_prior %>% select(-HACOMPKEY)
WWT_prior <- WWT_prior %>% select(-R_STAT)
WWT_prior <- WWT_prior %>% select(-R_MAT)
WWT_prior <- WWT_prior %>% select(-R_DIA)
WWT_prior <- WWT_prior %>% select(-R_INST)
WWT_prior <- WWT_prior %>% select(-AQ_TYPE)
WWT_prior <- WWT_prior %>% select(-USE_AREA)
WWT_prior <- WWT_prior %>% select(-HAUNITTYPE)
WWT_prior <- WWT_prior %>% select(-USE_AREAID)
WWT_prior <- WWT_prior %>% select(-R_OWN)
WWT_prior <- WWT_prior %>% select(-OWN)
WWT_prior <- WWT_prior %>% select(-PARLINENO)
WWT_prior <- WWT_prior %>% select(-F_IwiAOI)
WWT_prior <- WWT_prior %>% select(-`New action`)



# Need to fix data types for certain columns/Need to fix and normalise some entries



WWT_prior <- WWT_prior %>% 
  mutate(across(where(is.character), as.factor))

WWT_prior$condition_CCTV_score <- as.numeric(WWT_prior$condition_CCTV_score)

WWT_prior$condition_overall_score_label <- as.factor(WWT_prior$condition_overall_score_label)

levels(WWT_prior$condition_CCTV_source) <- c(levels(WWT_prior$condition_CCTV_source), "None")

WWT_prior$condition_CCTV_source[is.na(WWT_prior$condition_CCTV_source)] <- "None"

WWT_prior$condition_CCTV_date <- as.factor(WWT_prior$condition_CCTV_date)

levels(WWT_prior$condition_CCTV_date) <- c(levels(WWT_prior$condition_CCTV_date), "None")

WWT_prior$condition_CCTV_date[is.na(WWT_prior$condition_CCTV_date)] <- "None"


WWT_prior$condition_CCTV_score <- as.factor(WWT_prior$condition_CCTV_score)

levels(WWT_prior$condition_CCTV_score) <- c(levels(WWT_prior$condition_CCTV_score), "None")

WWT_prior$condition_CCTV_score[is.na(WWT_prior$condition_CCTV_score)] <- "None"


WWT_prior$INSTALLED <- format(WWT_prior$INSTALLED, "%Y")

WWT_prior$INSTALLED <- as.numeric(WWT_prior$INSTALLED)



# Creating modelling data set and analysis data set

WWT.analysis <- WWT_prior 
WWT.analysis <- WWT.analysis %>% select(-SHAPE_Length)

WWT.modelling <- WWT_prior 

WWT.modelling <- WWT.modelling %>% select(-condition_overall_score)
  WWT.modelling <- WWT.modelling %>% select(-criticality_overall_score)
  WWT.modelling <- WWT.modelling %>% select(-criticality_overall_score_label)
  WWT.modelling <- WWT.modelling %>% select(-criticality_operational_score)
  WWT.modelling <- WWT.modelling %>% select(-criticality_pipe_type_score)
  WWT.modelling <- WWT.modelling %>% select(-criticality_people_impacts_score)
  WWT.modelling <- WWT.modelling %>% select(-criticality_people_impacts_dataset_s_)
  WWT.modelling <- WWT.modelling %>% select(-criticality_environmental_impacts_score)
  WWT.modelling <- WWT.modelling %>% select(-criticality_environmental_impacts_dataset_s_)
    WWT.modelling <- WWT.modelling %>% select(-criticality_infiltration_score)
    WWT.modelling <- WWT.modelling %>% select(-criticality_impact_of_failure_score)
    WWT.modelling <- WWT.modelling %>% select(-criticality_flow_ratio)
    WWT.modelling <- WWT.modelling %>% select(-criticality_confidence_scenario)
    WWT.modelling <- WWT.modelling %>% select(-condition_confidence_scenario)
    WWT.modelling <- WWT.modelling %>% select(-`Risk-score`)


    

write.csv(WWT.modelling, "WWT.modelling.csv", row.names = FALSE)
write.csv(WWT.analysis,"WWT.analysis.csv", row.names = FALSE)