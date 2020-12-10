
# species key 
key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                   Species = stringr::str_to_sentence(unique(key$COMNAME)))

# rank f/fmsy by species

bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))
colnames(bf)

bf$Species %in% key2$Species

f_rank <- bf %>% 
  dplyr::select(Species, Region, F.Fmsy, F.Year) %>%
  dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
  dplyr::filter(ne_stock == "TRUE", F.Fmsy > 0) %>%
  
  dplyr::group_by(Species, Region) %>%
  dplyr::mutate(most_recent_year = max(F.Year)) %>%
  dplyr::ungroup() %>%
  
  dplyr::distinct() %>%
  dplyr::filter(F.Year == most_recent_year) %>%

  dplyr::select(Species, Region, F.Fmsy, F.Year) %>%
  dplyr::mutate(Indicator = "ffmsy",
                rank = rank(F.Fmsy), 
                norm_rank = rank/max(rank)) %>%
  dplyr::rename(Value = F.Fmsy, Year_measured = F.Year)
f_rank

# rank b/bmsy by species
bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))

b_rank <- bf %>% 
  dplyr::select(Species, Region, B.Bmsy, B.Year) %>%
  dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
  dplyr::filter(ne_stock == "TRUE", B.Bmsy > 0) %>%
  
  dplyr::group_by(Species, Region) %>%
  dplyr::mutate(most_recent_year = max(B.Year)) %>%
  dplyr::ungroup() %>%
  
  dplyr::distinct() %>%
  dplyr::filter(B.Year == most_recent_year) %>%
  
  dplyr::select(Species, Region, B.Bmsy, B.Year) %>%
  dplyr::mutate(Indicator = "bbmsy",
                rank = abs(rank(B.Bmsy) - max(rank(B.Bmsy) + 1)), 
                norm_rank = rank/max(rank)) %>%
  dplyr::rename(Value = B.Bmsy, Year_measured = B.Year)
b_rank

data <- rbind(f_rank, b_rank)
data$stock <- paste(data$Species, data$Region, sep = "\n")
data <- data %>% 
  group_by(stock) %>%
  mutate(total_risk = sum(norm_rank))

ggplot(data,
       aes(x = reorder(stock, -total_risk),
           y = norm_rank,
           fill = Indicator))+
  geom_bar(stat = "identity")+
  nmfspalette::scale_fill_nmfs(palette = "regional web")+
  ylab("Cumulative normalized risk (max = 2)")+
  geom_text(aes(x = reorder(stock, -total_risk),
                y = 0.05,
                label = reorder(paste(Species, Region), -total_risk)),
            angle = 90,
            hjust = 0,
            color = "gray")+
  theme_bw()+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()
        )

#
write.csv(data, here::here("docs/risk_ranking", "preliminary_risk_ranking.csv"))
