
`%>%` <- dplyr::`%>%`

names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence()

write.csv(all_species, 
          file = here::here("data", "species_guilds.csv"))

guilds <- read.csv(here::here("data", "species_guilds.csv"))
head(guilds)

risk <- read.csv(here::here("data/risk_ranking", "overall_rank.csv"))
head(risk)

guild_risk <- dplyr::left_join(guilds, risk, by = "Species")
head(guild_risk)

guild_risk2 <- guild_risk %>%
  dplyr::select(Species, Guild, Region, total_risk) %>%
  dplyr::group_by(Species) %>%
  dplyr::mutate(avg_species_risk = mean(total_risk)) %>%
  dplyr::select(-total_risk, -Region) %>%
  dplyr::ungroup() %>%
  dplyr::distinct() %>%
  dplyr::group_by(Guild) %>%
  dplyr::summarise(guild_risk = sum(avg_species_risk),
                   n_guild_species = length(avg_species_risk),
                   avg_guild_risk = guild_risk/n_guild_species) %>%
  dplyr::filter(Guild != "") %>%
  dplyr::ungroup() %>% 
  dplyr::mutate(rank = rank(avg_guild_risk),
                norm_rank = rank/max(rank))
guild_risk2
