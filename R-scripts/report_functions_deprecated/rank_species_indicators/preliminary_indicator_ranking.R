# set up ----

`%>%` <- dplyr::`%>%`

# species key 
key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                   Species = stringr::str_to_sentence(unique(key$COMNAME)))

# read in data
source(here::here("R/full_report_functions", "read_data.R"))

# high normalized rank = more risk

# f/fmsy ----

# rank f/fmsy by species
# high f/fmsy = high risk

f_rank <- asmt_sum %>% 
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

# b/bmsy ----

# rank b/bmsy by species
# low b/bmsy = high risk

b_rank <- asmt_sum %>% 
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

# recreational catch ----

# rank recreational catch by species
# species not separated into stock areas
# high catch = more risk (the fish is more important)

max_year <- max(rec$year)
rec_rank <- rec %>% 
  dplyr::select(Species, year, tot_cat) %>%
  dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
  dplyr::filter(ne_stock == "TRUE", 
                tot_cat > 0, 
                year > max_year - 5) %>%
  dplyr::ungroup() %>%
  dplyr::group_by(Species) %>%
  dplyr::summarise(avg_catch_5yr = mean(tot_cat)) %>%
  dplyr::mutate(Year_measured = paste("average of", 
                                      max_year - 5, "-", max_year, 
                                      "data"),
                Indicator = "rec_catch",
                rank = rank(avg_catch_5yr), 
                norm_rank = rank/max(rank)) %>%
  dplyr::rename(Value = avg_catch_5yr)
rec_rank

# total catch ----

# lots of catch descriptions in new assessmentdata package
# which to use so analysis is consistent - highest overall?
# rank by max of all time
catch_rank  <- asmt %>% dplyr::filter(Metric == "Catch") %>%
  dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
  dplyr::filter(ne_stock == "TRUE") %>%
  dplyr::group_by(Species, Region, Units) %>%
  dplyr::mutate(max_catch = max(Value)) %>%
  dplyr::filter(Value == max_catch) %>%
  dplyr::mutate(Indicator = "total_catch") %>%
  dplyr::rename("Year_measured" = "Year")
catch_rank

catch_rank <- catch_rank %>%
  dplyr::ungroup() %>%
  dplyr::mutate(rank = rank(Value), 
                norm_rank = rank/max(rank)) %>%
  dplyr::select(Species, Region, Value, Year_measured, Indicator, rank, norm_rank)

# abundance ----
# avg abundance of past 10 years as % of avg abundance of all times up to 10 years ago
abun_rank  <- asmt %>% dplyr::filter(Metric == "Abundance", Units == "Number") %>%
  dplyr::mutate(ne_stock = (Species %in% key2$Species),
                recent = Year > max(Year) - 10) %>%
  dplyr::filter(ne_stock == "TRUE") %>%
  dplyr::group_by(Species, Region, Description, recent) %>%
  dplyr::mutate(mean_abun = mean(Value)) %>%
  dplyr::mutate(Indicator = "abundance") %>%
  dplyr::select(Species, Region, recent, mean_abun) %>%
  dplyr::distinct() %>%
  tidyr::pivot_wider(names_from = recent,
                     values_from = mean_abun,
                     names_prefix = "recent_") %>%
  dplyr::mutate(abun_score = recent_TRUE/recent_FALSE) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(rank =  abs(rank(abun_score) - max(rank(abun_score) + 1)), 
                norm_rank = rank/max(rank)) %>%
  dplyr::select(Species, Region, abun_score, rank, norm_rank) %>%
  dplyr::rename("Value" = "abun_score") %>%
  dplyr::mutate(Year_measured = "mean of last 10 years vs historic mean",
                Indicator = "abundance") %>%
  dplyr::select(Species, Region, Value, Year_measured, Indicator, rank, norm_rank)
abun_rank



# additional indicators to rank ----

# abs value of temperature change (surface-bottom x spring-fall)
# range of temperatures found at
# abs value of salinity change (surface-bottom x spring-fall)
# range of salinities found at

# avg biomass of past 10 years as % of avg biomass of all times up to 10 years ago
# avg recruitment of past 10 years as % of avg recruitment of all times up to 10 years ago
# avg length of past 10 years as % of avg length of all times up to 10 years ago
# max length of past 10 years as % of max length of all times up to 10 years ago
# number of prey categories in diet
# % of years that stock assessment was rejected

# plot ----

# plot total risk
data <- rbind(f_rank, b_rank, catch_rank, abun_rank)

head(data)

# add dummy regions to rec rank
rec_new <- dplyr::left_join( 
          data %>% 
            dplyr::select(Species, Region) %>% 
            dplyr::distinct(), 
          rec_rank,
          by = "Species")

data2 <- rbind(data, rec_new)

data2$stock <- paste(data2$Species, data2$Region, sep = "\n")
data2 <- data2 %>% 
  dplyr::group_by(stock) %>%
  dplyr::mutate(total_risk = sum(norm_rank, na.rm = TRUE))

# first plot
ggplot(data2,
       aes(x = reorder(stock, -total_risk),
           y = norm_rank,
           fill = Indicator))+
  geom_bar(stat = "identity")+
  nmfspalette::scale_fill_nmfs(palette = "regional web")+
  ylab("Cumulative normalized risk (max = 3)")+
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

data2 <- data2 %>% dplyr::filter(is.na(Value) == FALSE)
head(data2)

# missing data = risk of 0.5
data3 <- data2 %>%
  tidyr::pivot_wider(names_from = "Indicator",
                     values_from = "norm_rank") %>%
  dplyr::group_by(Species, Region, stock) %>%
  dplyr::summarise(ffmsy_new = sum(ffmsy, na.rm = TRUE),
                   bbmsy_new = sum(bbmsy, na.rm = TRUE),
                   total_catch_new = sum(total_catch, na.rm = TRUE),
                   rec_catch_new = sum(rec_catch, na.rm = TRUE),
                   abun_new = sum(abundance, na.rm = TRUE)) %>%
  dplyr::mutate(ffmsy_new = ifelse(ffmsy_new == 0, 0.5, ffmsy_new),
                bbmsy_new = ifelse(bbmsy_new == 0, 0.5, bbmsy_new),
                total_catch_new = 
                  ifelse(total_catch_new == 0, 0.5, total_catch_new),
                total_catch_new = 
                  ifelse(total_catch_new == 0, 0.5, total_catch_new),
                abun_new = ifelse(abun_new == 0, 0.5, abun_new)) %>%
  dplyr::mutate(total_risk = 
                  ffmsy_new + bbmsy_new + total_catch_new + rec_catch_new + abun_new) %>%
  tidyr::pivot_longer(cols = c(ffmsy_new, bbmsy_new, total_catch_new, rec_catch_new, abun_new))
data3

data3$label <- paste(data3$Species, 
                     data3$total_risk %>% round(digits = 2), 
                     sep = ", ")

fig <- ggplot(data3,
       aes(x = reorder(stock, -total_risk),
           y = name,
           fill = value))+
  geom_raster(stat = "identity")+
  geom_text(aes(x = reorder(stock, -total_risk),
                y = 0.5,
                label = label),
            angle = 90,
            hjust = 0,
            cex = 3,
            color = "black")+
  theme_bw()+
  scale_fill_gradient2(high = "darkred", mid = "beige", low = "forestgreen", midpoint = 0.5)+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        legend.position = "bottom"
  )+
  facet_wrap(facets = vars(Region),
             scales = "free_x")
fig

pdf(here::here("docs/risk_ranking", "preliminary_risk_ranking.pdf"),
    height = 6.5, width = 9)
fig
dev.off()

#
write.csv(data3, here::here("docs/risk_ranking", "preliminary_risk_ranking.csv"))

read.csv(here::here("docs/risk_ranking", "preliminary_risk_ranking.csv")) %>% head





