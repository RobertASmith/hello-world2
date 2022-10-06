plotOverallLake <- function( plot_startdate,
                             df_hosp,
                             df_cases,
                             custom_theme){
  
  df_hosp <- df_hosp %>% 
    filter(date > as.Date(plot_startdate) & areaName == "England" & measure != "newAdmissions")
  
  
  ggplot( )+
    
    custom_theme + 
    
    geom_col(data= df_cases %>% filter(date > as.Date(plot_startdate)) %>% 
               group_by(date) %>% 
               summarise(cases = sum(cases)) %>% 
               ungroup(), 
             aes(x=date, y=cases), 
             fill="#47d4ae") +
    
    geom_col(data = df_hosp,
             aes(x = date, y = -value, fill = measure), 
             position="stack", 
             show.legend=FALSE) +
    
    geom_hline(yintercept=0, colour="Black")+
    
    scale_x_date(name="", date_labels = "%b-%y", date_breaks = "month")+
    
    scale_y_continuous(name="", labels=abs, position = "right", breaks = seq(-4e+4, +5e+4, 1e+4))+
    
    scale_fill_manual(values=c("covidOccupiedMVBeds" = "#ff1437", "covidOccupied_nonMVBeds" = "#ff9f55"))+
    
    annotate(geom="text", x=as.Date("2020-09-01"), y=25000, 
             label="New cases in the population", hjust=0, family="Lato")+
    
    annotate(geom="text", x=as.Date("2020-09-01"), y=-20000, 
             label="Total patients in hospital", hjust=0, family="Lato")+
    
    labs(title="National plot showing hospital occupancy lags cases by around a fortnight",
         subtitle="Daily confirmed new COVID-19 cases and patients in hospital with COVID-19 in Mechanically Ventilated & all other beds in England",
         caption="Data from coronavirus.data.gov.uk")
  
  
}


plotRegionalLake <- function(plot_startdate = "2020-08-01",
                             df_cases = df_cases,
                             df_hosp = df_hosp,
                             custom_theme = custom_theme) {
  df_cases <-
    df_cases %>% filter(date > as.Date(plot_startdate) &
                          Region != "England")
  df_hosp  <-
    df_hosp  %>% filter(date > as.Date(plot_startdate) &
                          areaName != "England" & measure != "newAdmissions")
  
  ggplot() +
    
    geom_col(data = df_cases,
             aes(x = date, y = cases),
             fill = "#47d4ae") +
    
    geom_col(
      data = df_hosp,
      aes(x = date, y = -value, fill = measure),
      position = "stack",
      show.legend = FALSE
    ) +
    
    geom_hline(yintercept = 0, colour = "Black") +
    
    scale_x_date(name = "", date_labels = "%b-%y") +
    
    scale_y_continuous(name = "",
                       labels = abs,
                       position = "right") +
    
    scale_fill_manual(values = c(
      "covidOccupiedMVBeds" = "#ff1437",
      "covidOccupied_nonMVBeds" = "#ff9f55"
    )) +
    
    facet_wrap(~ Region) +
    
    custom_theme +
    
    labs(title = "Regional plots showing hospital occupancy lags cases by around a fortnight",
         subtitle = "Daily confirmed <span style='color:#47d4ae;'>new COVID-19 cases</span> and patients in hospital with COVID-19 in <span style='color:#ff1437;'>Mechanically Ventilated</span> and<span style='color:#ff9f55;'> all other</span> beds",
         caption = "Data from coronavirus.data.gov.uk")
  
}