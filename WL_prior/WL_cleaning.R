library(ggplot2)
library(tidyverse)
library(readxl)
library(lubridate)
library(corrplot)
library(naniar)



WL_prior <- read_xlsx("C:/Users/SSabharwal/OneDrive - Watercare Services Limited/Pred_Modelling_Condition/WL_prior/WL_prioritisation_final.xlsx", sheet = "Water_Supply_Local")

# OUr aim is to create two dataframes, one that will help us with the descriptive analysis and one that will help us with the predictive analysis. 
# Below is the cleaning and restructuring process we are going to undertake to produce our descriptive dataframe


WL_prior <- WL_prior %>% select(-GIS_ID)
WL_prior <- WL_prior %>% select(-EQUIP_ID)
WL_prior <- WL_prior %>% select(-COMPKEY)
WL_prior <- WL_prior %>% select(-FAC_CODE)
WL_prior <- WL_prior %>% select(-FAC_DESC)
WL_prior <- WL_prior %>% select(-POSITION)
WL_prior <- WL_prior %>% select(-STATUS)
WL_prior <- WL_prior %>% select(-ACCURACY)
WL_prior <- WL_prior %>% select(-TYPE)
WL_prior <- WL_prior %>% select(-DATASOURCE)
WL_prior <- WL_prior %>% select(-SERVICE)
WL_prior <- WL_prior %>% select(-SUBTYPE)
WL_prior <- WL_prior %>% select(-HACOMPKEY)
WL_prior <- WL_prior %>% select(-OWN)
WL_prior <- WL_prior %>% select(-F_IwiAOI)
WL_prior <- WL_prior %>% select(-constructability_Confidence_Scenario)
WL_prior <- WL_prior %>% select(-constructability_location_scoring)
WL_prior <- WL_prior %>% select(-constructability_location_scoring_dataset_s_)
WL_prior <- WL_prior %>% select(-constructability_environmental_scoring)
WL_prior <- WL_prior %>% select(-constructability_traffic_scoring)
WL_prior <- WL_prior %>% select(-constructability_traffic_scoring_dataset_s_)
WL_prior <- WL_prior %>% select(-constructability_stakeholder_scoring)
WL_prior <- WL_prior %>% select(-constructability_stakeholder_scoring_dataset_s_)
WL_prior <- WL_prior %>% select(-SHAPE_Length)
WL_prior <- WL_prior %>% select(-`cumulative length`)
WL_prior <- WL_prior %>% select(-`Plan for`)
WL_prior <- WL_prior %>% select(-`Cost estimate ($)`)
WL_prior <- WL_prior %>% select(-...56)
WL_prior <- WL_prior %>% select(-`Cost per year`)
WL_prior <- WL_prior %>% select(-...58)
WL_prior <- WL_prior %>% select(-...59)
WL_prior <- WL_prior %>% select(-...60)
WL_prior <- WL_prior %>% select(-PROCESS)
WL_prior <- WL_prior %>% select(-GRP)
WL_prior <- WL_prior %>% select(-LINING)


#We also need to do something about the concatenated break dates
#Instead of splitting the concatenations, I think it makes more sense to count the amount of failures and potentially calculate some sort of failure frequency 
#This makes more sense when our big picture goal here is to predict conditions of the pipe
#In order to do this process we need to split the column of concatenated break dates and then in a seperate data frame count how many instances of the same pipe occurs
#After this we should eliminate the breakdates column and then get rid of all the duplicates in the original data frame
#After getting rid of all the duplicates in the original data frame we can merge the failure counts back to the original data frame

# Also want to create a seperate dataframe which has time to first failure for each pipe with the count of how many pipes for each time to first failure



WL_prior <- WL_prior %>%
  separate_rows(`_concatenated_break_dates`, sep = "\\|")


Failure.count <- WL_prior %>% 
  group_by(OBJECTID) %>% 
  summarise(BreakDateCount = n(), .groups = "drop")


# This is so that we can have a dataframe with breakdate counts in them
WL_prior1 <- WL_prior %>% select(-`_concatenated_break_dates`)

WL_prior1 <- WL_prior1 %>% distinct(OBJECTID, .keep_all = TRUE)

WL_prior1 <- WL_prior1 %>%
  left_join(Failure.count, by = "OBJECTID")


WL_prior1 <- WL_prior1 %>% 
  mutate(BreakDateCount = BreakDateCount - 1)


WL_prior1 <- WL_prior1 %>% select(-OBJECTID)
WL_prior <- WL_prior %>% select(-OBJECTID)



# Now fixing up some other columns



# Turning all character columns into factors

WL_prior <- WL_prior %>% 
  mutate_if(is.character, as.factor)

WL_prior$condition_overall_score_label <- as.numeric(as.character(WL_prior$condition_overall_score_label))
WL_prior$constructability_overall_score_label <- as.numeric(as.character(WL_prior$constructability_overall_score_label))
WL_prior$criticality_overall_score_label <- as.numeric(as.character(WL_prior$criticality_overall_score_label))
WL_prior$criticality_capacity_score <- as.numeric(as.character(WL_prior$criticality_capacity_score))
WL_prior$criticality_pipe_ranking_score <- as.numeric(as.character(WL_prior$criticality_pipe_ranking_score))

# Working on concatenated break dates and turning them into proper dates 

WL_prior$`_concatenated_break_dates` <- as.Date(as.character(WL_prior$`_concatenated_break_dates`), format = "%Y%m%d")

# Format the date as desired
WL_prior$`_concatenated_break_dates` <- format(WL_prior$`_concatenated_break_dates`, "%Y-%m-%d")
WL_prior$`_concatenated_break_dates` <- as.POSIXct(WL_prior$`_concatenated_break_dates`)



# Fix the factor levels 

WL_prior$condition_Confidence_Scenario <- recode_factor(WL_prior$condition_Confidence_Scenario, 
                             "HGL Approximation" = "HGL", 
                             "Te Puna Wai Model Data Available" = "TPWMA")


WL_prior$criticality_key_customer_category <- recode_factor(WL_prior$criticality_key_customer_category, 
                                                        "COMMERCIAL - REAL ESTATE" = "COM_REALESTATE",
                                                        "COMMERCIAL - RETAIL" = "COM_RETAIL",
                                                        "COMMERCIAL LAUNDRY" = "COM_LAUNDRY", 
                                                        "COUNCIL / PARKS & REC" = "COUNCIL_PARKSREC",
                                                        "DEFENCE FORCE" = "DEFENCE_FORCE", 
                                                        "HEALTHCARE / HOSPITAL" = "HEALTHCARE_HOSPITAL",
                                                        "MANUFACTURING - FOOD & BEVERAGE " = "MANUFACTURING_FOOD_BEVERAGE",
                                                        "OFFICE / WAREHOUSE" = "OFFICE_WAREHOUSE", 
                                                        "PETROL STATION" = "PETROL_STATION", 
                                                        "POLICE / FENZ" = "PORT",
                                                        "PRIORITY CUSTOMER" = "PRIORITY_CUSTOMER", 
                                                        "RETIREMENT VILLAGE" = "RETIREMENT_VILLAGE", 
                                                        "SCHOOL / CHILDCARE" = "SCHOOL_CHILDCARE"
                                                        )

#Replacing some NAs
WL_prior <- WL_prior %>% mutate(criticality_key_customer_score = ifelse(is.na(criticality_key_customer_score), 0, criticality_key_customer_score))



#Fixing some more factors

WL_prior$criticality_other_critical_asset_dataset_s_ <- recode_factor(WL_prior$criticality_other_critical_asset_dataset_s_,
                                                                      "KiwiRail or NZTA" = "KiwiRail_NZTA", 
                                                                      "Pipe is <80mm" = "<80mm"
)



WL_prior$condition_Confidence_Scenario <- recode_factor(WL_prior$condition_Confidence_Scenario, 
                                                       "Affects Critical Key Customer" = "Affects_Critical_Key_Customer",
                                                       "Intersects Critical Infrastructure Asset" = "Intersects_Critical_Infrastructure_Asset", 
                                                       "Te Puna Wai Model Data Available" = "Te_Puna_Wai_Model_Data_Available", 
                                                       "Te Puna Wai Model Data NOT Available" = "Te_Puna_Wai_Model_Data_NOT_Available")


# We have now prepared the dataframe for analysis


WL_prior.analysis <- WL_prior

# We now need to prepare the dataframe for modelling

WL_prior.modelling <- WL_prior[, 1:10]

















