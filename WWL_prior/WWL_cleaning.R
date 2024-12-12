library(ggplot2)
library(tidyverse)
library(readxl)
library(lubridate)
library(corrplot)
library(naniar)



WWL_prior <- read_xlsx("C:/Users/SSabharwal/OneDrive - Watercare Services Limited/Pred_Modelling_Condition/WWL_prior/WW_local_prioritisation_final.xlsx")




# Getting rid of useless columns
WWL_prior <- WWL_prior %>% select(-OBJECTID)
WWL_prior <- WWL_prior %>% select(-GIS_ID)
WWL_prior <- WWL_prior %>% select(-COMPKEY)
WWL_prior <- WWL_prior %>% select(-PROCESS)
WWL_prior <- WWL_prior %>% select(-TYPE)
WWL_prior <- WWL_prior %>% select(-SERVICE)
WWL_prior <- WWL_prior %>% select(-HACOMPKEY)
WWL_prior <- WWL_prior %>% select(-constructability_overall_score_label)
WWL_prior <- WWL_prior %>% select(-constructability_location_scoring)
WWL_prior <- WWL_prior %>% select(-constructability_location_scoring_dataset_s_)
WWL_prior <- WWL_prior %>% select(-constructability_traffic_scoring)
WWL_prior <- WWL_prior %>% select(-constructability_traffic_scoring_dataset_s_)
WWL_prior <- WWL_prior %>% select(-constructability_stakeholder_scoring)
WWL_prior <- WWL_prior %>% select(-constructability_depth_score)
WWL_prior <- WWL_prior %>% select(-constructability_depth__m_)
WWL_prior <- WWL_prior %>% select(-constructability_environmental_scoring)
WWL_prior <- WWL_prior %>% select(-constructability_environmental_scoring_dataset_s_)
WWL_prior <- WWL_prior %>% select(-constructability_Confidence_Scenario)
WWL_prior <- WWL_prior %>% select(-constructability_stakeholder_scoring_dataset_s_)
WWL_prior <- WWL_prior %>% select(-`Plan for`)
WWL_prior <- WWL_prior %>% select(-`Age...63`)
WWL_prior <- WWL_prior %>% select(-`RUL(remaining useful life)`)
WWL_prior <- WWL_prior %>% select(-`Age...65`)
WWL_prior <- WWL_prior %>% select(-`...66`)
WWL_prior <- WWL_prior %>% select(-`Adjusted estimated life`)
WWL_prior <- WWL_prior %>% select(-`Cost estimate ($)`)
WWL_prior <- WWL_prior %>% select(-`MATERIAL...67`)
WWL_prior <- WWL_prior %>% select(-`...69`)
WWL_prior <- WWL_prior %>% select(-`Cost per year`)
WWL_prior <- WWL_prior %>% select(-`...71`)
WWL_prior <- WWL_prior %>% select(-`...72`)
WWL_prior <- WWL_prior %>% select(-criticality_overall_score_label)
WWL_prior <- WWL_prior %>% select(-`cumulative length`)


#Fixing datatypes and restructuring columns/also dealing

WWL_prior$INSTALLED <- format(WWL_prior$INSTALLED, "%Y")
WWL_prior$INSTALLED <- as.numeric(WWL_prior$INSTALLED)

WWL_prior <- WWL_prior %>% rename("MATERIAL" = `MATERIAL...5`)
WWL_prior$Depth <- as.numeric(WWL_prior$Depth)
WWL_prior$criticality_groundlevel <- as.numeric(WWL_prior$criticality_groundlevel)
WWL_prior$condition_overall_score_label <- as.factor(WWL_prior$condition_overall_score_label)

WWL_prior$condition_CCTV_INSP_Date <- format(WWL_prior$condition_CCTV_INSP_Date, "%Y")
WWL_prior$condition_CCTV_INSP_Date <- as.numeric(WWL_prior$condition_CCTV_INSP_Date)

WWL_prior$condition_last_recorded_overflow <- as.numeric(substr(WWL_prior$condition_last_recorded_overflow, 1, 4))


WWL_prior <- WWL_prior %>% mutate_if(is.character, as.factor)



# Making modelling and analysis datasets

WWL.analysis <- WWL_prior


WWL_prior <- WWL_prior %>% select(-criticality_overall_score)
WWL_prior <- WWL_prior %>% select(-criticality_hydro_basement_score)
WWL_prior <- WWL_prior %>% select(-criticality_groundlevel)
WWL_prior <- WWL_prior %>% select(-criticality_impact_on_people_score)
WWL_prior <- WWL_prior %>% select(-criticality_people_impacts_dataset_s_)
WWL_prior <- WWL_prior %>% select(-criticality_upstream_connections_score)
WWL_prior <- WWL_prior %>% select(-criticality_impact_on_environment_score)
WWL_prior <- WWL_prior %>% select(-criticality_environmental_impacts_dataset_s_)
WWL_prior <- WWL_prior %>% select(-criticality_engineered_overflow_health_enviro)
WWL_prior <- WWL_prior %>% select(-criticality_engineered_overflow_manholes)
WWL_prior <- WWL_prior %>% select(-criticality_pipe_importance_level)
WWL_prior <- WWL_prior %>% select(-criticality_Confidence_Scenario)
WWL_prior <- WWL_prior %>% select(-condition_CCTV_provider)
WWL_prior <- WWL_prior %>% select(-condition_flushing_dataset)


WWL.modelling <- WWL_prior


write.csv(WWL.modelling, "WWL.modelling.csv", row.names = FALSE)
write.csv(WWL.analysis,"WWL.analysis.csv", row.names = FALSE)