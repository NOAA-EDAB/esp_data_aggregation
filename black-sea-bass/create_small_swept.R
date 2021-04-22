`%>%` <- dplyr::`%>%`

## swept area for small bsb ----

og_pull <- readRDS(here::here("data", "survdat_03032021.RDS"))
shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))

area <- survdat::get_area(shape, "STRATA")

og_pull$survdat$STRATUM <- as.numeric(og_pull$survdat$STRATUM)

mod_data <- survdat::strat_prep(
  surveyData = og_pull$survdat %>%
    dplyr::filter(
      SVSPP == 141 # , # bsb only
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

# write.csv(data, here::here("black-sea-bass", "swept_area_info_spring.csv"))
write.csv(data, here::here("black-sea-bass", "swept_area_info_fall.csv"))

spring <- read.csv(here::here("black-sea-bass", "swept_area_info_spring.csv"))
fall <- read.csv(here::here("black-sea-bass", "swept_area_info_fall.csv"))

spring <- spring %>%
  dplyr::mutate(Season = "Spring")
fall <- fall %>%
  dplyr::mutate(Season = "Fall")

all <- rbind(spring, fall)
write.csv(all, here::here("black-sea-bass", "swept_area_info_all_bsb.csv"))

big <- read.csv(here::here("black-sea-bass", "swept_area_info_all_bsb.csv"))

big_abun <- NEesp::plot_swept(big, var = "abundance")
big_bio <- NEesp::plot_swept(big, var = "biomass")

small <- read.csv(here::here("black-sea-bass", "swept_area_info_small_bsb.csv"))

small_abun <- NEesp::plot_swept(small, var = "abundance")
small_bio <- NEesp::plot_swept(small, var = "biomass")

pkg_abun <- NEesp::plot_swept(NEesp::swept %>% dplyr::filter(Species == "Black sea bass"), var = "abundance")
pkg_bio <- NEesp::plot_swept(NEesp::swept %>% dplyr::filter(Species == "Black sea bass"), var = "biomass")

plots <- c(rbind(
  ggpubr::ggpar(list(
    pkg_abun + ggplot2::labs(title = "Abundance - calculated then filtered"),
    big_abun + ggplot2::labs(title = "Abundance - filtered then calculated \n(all BSB)"),
    small_abun + ggplot2::labs(title = "Abundance - filtered then calculated \n(small BSB)")
  ),
  ylim = c(-10^7, 2 * 10^8)
  ),
  ggpubr::ggpar(list(
    pkg_bio + ggplot2::labs(title = "Biomass - calculated then filtered"),
    big_bio + ggplot2::labs(title = "Biomass - filtered then calculated \n(all BSB)"),
    small_bio + ggplot2::labs(title = "Biomass - filtered then calculated \n(small BSB)")
  ),
  ylim = c(-2*10^6, 2 * 10^7)
  )
)
)

tiff(
  file = here::here("black-sea-bass", "swept_comparison.tiff"),
  # onefile = TRUE,
  width = 8,
  height = 8,
  units = "in",
  res = 200,
  compression = "lzw"
)

ggpubr::ggarrange(
  plotlist = plots,
  align = "hv",
  nrow = 3,
  ncol = 2,
  common.legend = TRUE,
  legend = "top"
)

dev.off()
