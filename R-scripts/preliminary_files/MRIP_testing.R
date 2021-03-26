library(ggplot2)
`%>%` <- dplyr::`%>%`


names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence()
list_species <- split(all_species, f = list(all_species))


data <- read.csv(here::here("data", "mrip_catch_year_2019.csv"))
head(data)

data$Species <- stringr::str_to_sentence(data$common)
        
rows <- match(data$Species, all_species) %>% is.na() %>% which()

known_data <- data[-rows, ]
head(known_data)

summary <- known_data %>%
  dplyr::filter(sub_reg_f == "NORTH ATLANTIC") %>%
  dplyr::group_by(Species, mode_fx_f) %>%
  dplyr::summarise(total_catch = sum(tot_cat))
summary


files <- dir(here::here("data/MRIP"))
read_files <- files[stringr::str_detect(files, "catch_year") %>% which()]

big_data <- c()
for(i in 1:length(read_files)){
  this_data <- read.csv(here::here("data/MRIP", read_files[i]))
  big_data <- rbind(big_data, this_data)
}
head(big_data)

big_data$tot_cat <- stringr::str_replace(big_data$tot_cat, ",", "") %>%
  as.numeric()
big_data$Species <- stringr::str_to_sentence(big_data$common)

write.csv(big_data, file = here::here("data/MRIP", "all_MRIP_catch_year.csv"))

get_rec_catch <- function(data, species){
  
  data <- dplyr::filter(data, Species == species)
  
  summary <- data %>%
    dplyr::filter(sub_reg_f == "NORTH ATLANTIC") %>%
    dplyr::group_by(mode_fx_f, year) %>%
    dplyr::summarise(total_catch = sum(tot_cat))
  
  fig <- ggplot(summary,
                aes(x = year,
                    y = total_catch,
                    fill = mode_fx_f))+
    geom_area()+
    theme_bw()+
    scale_y_continuous(name = "Total catch (lb)",
                       labels = scales::comma)+
    xlab("Year")+
    labs(fill = "Category")
  
  return(fig)
  
}

get_rec_catch(data = big_data, species = "Acadian redfish")



