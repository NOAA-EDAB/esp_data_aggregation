all_risk <- read.csv(here::here("data/risk_ranking", "full_risk_data_over_time.csv"))

all_risk %>% head

test <- all_risk %>%
  dplyr::filter(Species == "Acadian redfish")

year <- test$Year %>%
  stringr::str_trunc(9, "right", ellipsis = "") %>%
  stringr::str_split_fixed("-", n = 2)
test$new_year <- year[ , 2]

fig <- ggplot(test,
              aes(x = new_year %>% as.numeric,
                  y = Indicator %>% 
                    stringr::str_replace_all("_", " "),
                  fill = norm_rank ))+
  geom_raster(stat = "identity")+
  facet_grid(rows = vars(category),
             scales = "free_y")+
  theme_bw()+
  scale_fill_gradient2(high = "darkred", 
                       mid = "beige", 
                       low = "forestgreen", 
                       midpoint = 0.5,
                       name = "Normalized rank")+
  theme(legend.position = "top")+
  ylab("Indicator")+
  xlab("Year")
fig
