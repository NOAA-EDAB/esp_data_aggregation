# set up ----

`%>%` <- dplyr::`%>%`

# species key 
key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                   Species = stringr::str_to_sentence(unique(key$COMNAME)))

# high normalized rank = more risk

# f/fmsy ----

# rank f/fmsy by species
# high f/fmsy = high risk

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

# b/bmsy ----

# rank b/bmsy by species
# low b/bmsy = high risk

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

# recreational catch ----

# rank recreational catch by species
# species not separated into stock areas
# high catch = more risk (the fish is more important)

rec <- read.csv(here::here("data/MRIP", "all_MRIP_catch_year.csv")) %>%
  dplyr::filter(sub_reg_f == "NORTH ATLANTIC")
head(rec)

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

# rank by max of all time
asmt <- assessmentdata::stockAssessmentData %>%
  dplyr::filter(Region == "Gulf of Maine / Georges Bank" |
                  Region == "Eastern Georges Bank" |
                  Region == "Georges Bank" |
                  Region == "Gulf of Maine" |
                  Region == "Gulf of Maine / Cape Hatteras" |
                  Region == "Georges Bank / Southern New England" |
                  Region == "Southern New England / Mid" |
                  Region == "Gulf of Maine / Northern Georges Bank" |
                  Region == "Southern Georges Bank / Mid" |
                  Region == "Cape Cod / Gulf of Maine")
asmt$Region <- asmt$Region %>% 
  stringr::str_replace("Mid", "Mid-Atlantic")
asmt$Species <- asmt$Species %>% 
  stringr::str_to_sentence()
asmt$Units <- asmt$Units %>%
  stringr::str_replace("Thousand Recruits", "Number x 1,000")

catch_rank  <- dplyr::filter(Metric == "Catch") %>%
  dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
  dplyr::filter(ne_stock == "TRUE") %>%
  
  dplyr::group_by(Species) %>%
  dplyr::mutate(max_catch = mean(tot_cat)) 
dplyr::mutate(Year_measured = paste("average of", 
                                    max_year - 5, "-", max_year, 
                                    "data"),
              Indicator = "rec_catch",
              rank = abs(rank(avg_catch_5yr) - max(rank(avg_catch_5yr) + 1)), 
              norm_rank = rank/max(rank)) %>%
  dplyr::rename(Value = avg_catch_5yr)
catch_rank

# additional indicators to rank ----

# abs value of temperature change (surface-bottom x spring-fall)
# range of temperatures found at
# abs value of salinity change (surface-bottom x spring-fall)
# range of salinities found at
# avg abundance of past 10 years as % of avg abundance of all times up to 10 years ago
# avg biomass of past 10 years as % of avg biomass of all times up to 10 years ago
# avg recruitment of past 10 years as % of avg recruitment of all times up to 10 years ago
# avg length of past 10 years as % of avg length of all times up to 10 years ago
# max length of past 10 years as % of max length of all times up to 10 years ago
# number of prey categories in diet
# % of years that stock assessment was rejected

# plot ----

# plot total risk
data <- rbind(f_rank, b_rank)

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

#
write.csv(data2, here::here("docs/risk_ranking", "preliminary_risk_ranking.csv"))





