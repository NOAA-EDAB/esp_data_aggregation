#load(here::here("data", "allfh.RData")) #read directly from github
load(url("http://github.com/Laurels1/Condition/raw/master/data/allfh.RData"))
# load(here::here("data", "allfh.RData")) # if the internet is slow
allfh$Species <- stringr::str_to_sentence(allfh$pdcomnam)

key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

for(i in 1:length(key$stock_area)){
  if(key$stock_area[i] == "gbk") {key$stock_area[i] <- "Georges Bank"}
  if(key$stock_area[i] == "gom") {key$stock_area[i] <- "Gulf of Maine"}
  if(key$stock_area[i] == "snemab") {key$stock_area[i] <- "Southern New England / Mid"}
  if(key$stock_area[i] == "gbkgom") {key$stock_area[i] <- "Gulf of Maine / Georges Bank"}
  if(key$stock_area[i] == "ccgom") {key$stock_area[i] <- "Cape Cod / Gulf of Maine"}
  if(key$stock_area[i] == "south") {key$stock_area[i] <- "Southern Georges Bank / Mid"}
  if(key$stock_area[i] == "north") {key$stock_area[i] <- "Gulf of Maine / Northern Georges Bank"}
  if(key$stock_area[i] == "sne") {key$stock_area[i] <- "Georges Bank / Southern New England"}
  if(key$stock_area[i] == "unit") {key$stock_area[i] <- "all"}
}

key$Species <- stringr::str_to_sentence(key$COMNAME)
key$spst <- paste(key$Species, key$strata %>% as.numeric())
key3 <- key %>% dplyr::select(spst, stock_area)

allfh$spst <- paste(allfh$Species, allfh$stratum %>% as.numeric())

allfh$spst %in% key3$spst

allfh <- dplyr::left_join(allfh, key3, by = "spst")
allfh$Region <- tidyr::replace_na(allfh$stock_area, "Outside stock area")

allfh$fish_id <- paste(allfh$cruise6, allfh$stratum, allfh$tow, 
                       allfh$Species, allfh$pdid)

allfh <- allfh %>%
  update_species_names(species_col = "Species")
