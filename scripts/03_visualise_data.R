# Script 3 - Visualise Data
rm(list = ls())

# we need the following packages.
library(ggplot2)
library(ggtext)

# we also need to source some custom functions
source("R/plot_functions.R")

# we can read in data from the last stage if we needed
df_hosp <- readRDS(file = "data/processed/hospital_admission_data.rds")

df_cases <- readRDS(file = "data/processed/cases_data.rds")

# define variables here.
plot_startdate <- "2020-08-01"

# create custom theme for consistency
custom_theme <- theme_classic() +
  theme(plot.title.position = "plot", 
        plot.caption.position = "plot",
        strip.background = element_blank(), strip.text=element_text(face="bold", size=rel(1)),
        plot.title = element_text(face="bold", size=rel(1.5), hjust=0, margin=margin(0,0,5.5,0)),
        text = element_text(family="Lato"),
        plot.subtitle = element_markdown())

# create the plot for England...
engPlot <- plotOverallLake(plot_startdate = "2020-08-01",
                           df_cases = df_cases,
                           df_hosp = df_hosp,
                           custom_theme = custom_theme)


# create the plot for each region in a facet...
regionPlot <- plotRegionalLake(plot_startdate = "2020-08-01",
                              df_cases = df_cases,
                              df_hosp = df_hosp,
                              custom_theme = custom_theme)


# save plots
ggsave(plot = engPlot, 
       filename = "outputs/plots/lakePlotOverall.png",
       width = 12, 
       height = 9)

ggsave(plot = regionPlot, 
       filename = "outputs/plots/lakePlotRegional.png",
       width = 12, 
       height = 9)

