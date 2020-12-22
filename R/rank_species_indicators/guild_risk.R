
`%>%` <- dplyr::`%>%`

names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence()

#write.csv(all_species, 
#          file = here::here("data", "species_guilds.csv"))

guilds <- read.csv(here::here("data", "species_guilds.csv"))
head(guilds)

risk <- read.csv(here::here("data/risk_ranking", "full_risk_data.csv"))
head(risk)

guild_risk <- dplyr::left_join(guilds, risk, by = "Species")
head(guild_risk)

# add length classes
survey <- readRDS(here::here("data", "survey_data.RDS"))
head(survey)

survey2 <- survey %>%
  dplyr::filter(LENGTH > 0, ABUNDANCE > 0) %>%
  dplyr::group_by(Species, YEAR, SEASON, Region) %>%
  dplyr::mutate(n_fish = sum(NUMLEN)) %>%
  dplyr::filter(n_fish > 10) %>% # only year-season-region with >10 fish
  dplyr::summarise(mean_len = sum(LENGTH*NUMLEN)/sum(NUMLEN)) %>%
  dplyr::group_by(Species, SEASON, Region) %>%
  dplyr::summarise(annual_mean_len = mean(mean_len)) %>%
  dplyr::group_by(Species, Region) %>% 
  dplyr::summarise(region_mean_len = mean(annual_mean_len)) %>%
  dplyr::filter(Region != "Outside stock area") %>%
  dplyr::group_by(Species) %>%
  dplyr::summarise(overall_mean_len = mean(region_mean_len)) %>%
  dplyr::mutate(len_class = round(overall_mean_len, digits = -1))
survey2

guild_risk2 <- dplyr::left_join(survey2, guild_risk, by = "Species") %>%
  dplyr::group_by(Species, Scientific_name, Indicator, Guild, overall_mean_len) %>%
  dplyr::summarise(mean_norm_risk = mean(norm_rank)) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(size = ifelse(overall_mean_len < 40, "small", "large")) 

guild_info <- guild_risk2 %>%
  dplyr::select(Species, Scientific_name, Guild, size) %>%
  dplyr::distinct()
write.csv(guild_info, file = here::here("data/risk_ranking", "guild_info.csv"))

guild_risk3 <- guild_risk2 %>%
  dplyr::group_by(Guild, size, Indicator) %>%
  dplyr::summarise(guild_risk = sum(mean_norm_risk),
                   n_guild_species = length(mean_norm_risk),
                   avg_guild_risk = guild_risk/n_guild_species) %>%
  dplyr::filter(Guild != "") %>%
  dplyr::ungroup() %>% 
  dplyr::group_by(Indicator) %>%
  dplyr::mutate(rank = rank(avg_guild_risk),
                norm_rank = rank/max(rank)) %>%
  dplyr::group_by(Guild, size) %>%
  dplyr::mutate(total_guild_risk = sum(avg_guild_risk),
                label_y = total_guild_risk - cumsum(avg_guild_risk),
                sum_ranks = sum(rank))
head(guild_risk3)

library(ggplot2)

mycolors <-  grDevices::colorRampPalette(
  nmfspalette::nmfs_palette("regional web")(6))(guild_risk3$Indicator %>% 
                                                  unique() %>% length())
scales::show_col(mycolors)

ggplot(guild_risk3,
       aes(x = reorder(paste(Guild, "\n", size) %>%
                         stringr::str_replace("_", "\n"), 
                       total_guild_risk),
           y = avg_guild_risk, 
           fill = Indicator)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_manual(values = sample(mycolors))+
  geom_text(aes(y = label_y,
                label = paste(rank, "out of 8")),
            stat = "identity",
            vjust = -0.6) +
  geom_text(aes(y = total_guild_risk,
                label = paste("sum of ranks:\n", sum_ranks)),
            stat = "identity",
            vjust = -0.6)+
  theme_bw()+
  #theme(axis.text.x = element_text(angle = 90))+
  xlab("Guild")+
  ylab("Average risk within guild")+
  ylim(c(0,8))

write.csv(guild_risk3, file = here::here("data/risk_ranking", "guild_data.csv"))
