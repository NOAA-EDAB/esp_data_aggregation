`%>%` <- dplyr::`%>%`

## swept area for small bsb ----

og_pull <- readRDS(here::here("data", "survdat_03032021.RDS"))
shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))

area <- survdat::get_area(shape, "STRATA")

og_pull$survdat$STRATUM <- as.numeric(og_pull$survdat$STRATUM)

mod_data <- survdat::strat_prep(
  surveyData = og_pull$survdat %>%
    dplyr::filter(SVSPP == 141#, # bsb only
                 # LENGTH < 19 # small fish only
                  ) %>% 
    dplyr::filter(SEASON == "FALL"),
 #  dplyr::filter(SEASON == "SPRING"),
  areaPolygon = shape,
  areaDescription = "STRATA"
)

mean_info <- survdat::strat_mean(mod_data,
                                 areaDescription = "STRATA",
                                 seasonFlag = TRUE,
                                 poststratFlag = FALSE
)

test <- survdat::swept_area(mod_data,
                            stratmeanData = mean_info,
                            areaDescription = "STRATA"
)
# test

# add common name
data <- test %>%
  dplyr::mutate(Species = "Black sea bass")
# data

#write.csv(data, here::here("black-sea-bass", "swept_area_info_spring.csv"))
write.csv(data, here::here("black-sea-bass", "swept_area_info_fall.csv"))

spring <- read.csv(here::here("black-sea-bass", "swept_area_info_spring.csv"))
fall <- read.csv(here::here("black-sea-bass", "swept_area_info_fall.csv"))

spring <- spring %>%
  dplyr::mutate(Season = "Spring")
fall <- fall %>%
  dplyr::mutate(Season = "Fall")

all <- rbind(spring, fall)
write.csv(all, here::here("black-sea-bass", "swept_area_info_all_bsb.csv"))

NEesp::plot_swept(all, var = "abundance")
NEesp::plot_swept(all, var = "biomass")
