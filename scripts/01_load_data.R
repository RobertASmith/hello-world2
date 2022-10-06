# Script 1 - Load data
rm(list = ls())

# user specified inputs URLs
regional_hosp_url <- "https://api.coronavirus.data.gov.uk/v2/data?areaType=nhsRegion&metric=covidOccupiedMVBeds&metric=hospitalCases&metric=newAdmissions&format=csv"
england_hosp_url  <- "https://api.coronavirus.data.gov.uk/v2/data?areaType=nation&areaCode=E92000001&metric=covidOccupiedMVBeds&metric=hospitalCases&metric=newAdmissions&format=csv"
case_url          <- "https://api.coronavirus.data.gov.uk/v2/data?areaType=region&metric=newCasesBySpecimenDateRollingSum&format=csv"

# read in the csv files
df_cases          <- read.csv(case_url)
df_regional_hosp  <- read.csv(regional_hosp_url)
df_england_hosp   <- read.csv(england_hosp_url)

# save temporarily
saveRDS(df_cases, file = "data/raw/cases.rds")
saveRDS(df_regional_hosp, file = "data/raw/regional_hosp.rds")
saveRDS(df_england_hosp, file = "data/raw/england_hosp.rds")
