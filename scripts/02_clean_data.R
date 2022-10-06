# Script 2 - Clean data
rm(list = ls())

# we need the following packages.
library(dplyr)
library(reshape2)

# read in data
df_cases         <- readRDS(file = "data/raw/cases.rds")
df_regional_hosp <- readRDS(file = "data/raw/regional_hosp.rds")
df_england_hosp  <- readRDS(file = "data/raw/england_hosp.rds")

# read in cases from dashboard by region, combine midlands into a single region.
df_cases <- df_cases %>%
  mutate(
    Region = case_when(
      areaName %in% c("East Midlands", "West Midlands") ~ "Midlands",
      areaName %in% c("Yorkshire and The Humber", "North East") ~
        "North East and Yorkshire",
      TRUE ~ areaName
    ),
    date = as.Date(date)
  ) %>%
  group_by(Region, date) %>%
  summarise(cases = sum(newCasesBySpecimenDateRollingSum) / 7) %>%
  ungroup()


# Read in hospital Data, rowbind the data to combine datasets, then melt to long format by measure...
df_hosp <- 
  rbind(df_regional_hosp, df_england_hosp) %>% 
  mutate(date = as.Date(x = date),
         covidOccupied_nonMVBeds = hospitalCases - covidOccupiedMVBeds)  %>% 
  melt(id.vars = c("areaCode", "areaName", "areaType", "date"), 
       variable.name = "measure" ) %>%
  mutate(measure = factor(x = measure, 
                          levels = c("covidOccupied_nonMVBeds", "covidOccupiedMVBeds"))) %>%
  filter(date < max(df_cases$date))

# check which values are different...
setdiff(unique(df_hosp$areaName), unique(df_cases$Region))
intersect(unique(df_hosp$areaName), unique(df_cases$Region))

# save interim data
saveRDS(object = df_hosp,
        file = "data/processed/hospital_admission_data.rds")

saveRDS(object = df_cases,
        file = "data/processed/cases_data.rds")
