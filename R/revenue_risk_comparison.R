risk <- read.csv(here::here("data/risk_ranking", "full_risk_data.csv"))
risk_year <- read.csv(here::here("data/risk_ranking", "full_risk_data_over_time.csv"))
risk_species <- read.csv(here::here("data/risk_ranking", "full_risk_data_by_species.csv"))


# what is going on with revenue

year_test <- risk_year %>% dplyr::filter(Species == "Acadian redfish", Indicator == "revenue")
year_test[45:49,]


risk_test <- risk %>% dplyr::filter(Species == "Acadian redfish", Indicator == "revenue_5yr")
risk_test
