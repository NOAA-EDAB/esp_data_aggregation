#organizing life history parameters 

devtools::install_github("james-thorson/FishLife")
library( FishLife )
library(tidyverse)

stock_list_all_strata<- readr::read_csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/stock_list.csv")
stock_list<-stock_list_all_strata %>% dplyr::distinct( common_name, .keep_all=TRUE)

# stock_list$sci_name
# 
# 
# Gadus morhua
# Predict<-Plot_taxa( Search_species(Genus="Gadus",Species="morhua")$match_taxonomy, mfrow=c(2,2) )
# 
# 
# # split sci name into parts to use purr::map2
# 
# stock_list %>% str_split_fixed(sci_name,"\\s" , n=2 )
# split_sci<-stock_list %>% separate (col=sci_name,sep ="\\s", into = c("genus" ,"species"))
# 
# select_sci<-split_sci %>% select(genus, species)
# t1<-cbind(select_sci$genus,select_sci$species)
# 
# as.vector(select_sci$genus)
# 
# stock_g<-c(select_sci$genus)
# stock_s<-c(select_sci$species)
# 
# 
# purrr::map2()
# 
# 
# purrr::map2(stock_g,stock_s, plot_taxa(Search_species(Genus=x[1], Species=x[2])$match_taxonomy))
# 
# 
# apply(t1,MARGIN= 1, FUN=get_fish_info)
# 
# 
install.packages("FSA")
library(FSA)




fishlife_predictions_NE<-read_csv(here::here("life history/fishlife","FishLife_extracted_data_11.16.20_northeast.csv"))
predictions_NE_spaced<-fishlife_predictions_NE %>% mutate_all(funs(str_replace(., "\\_", " ")))
predictions_NE_spaced<-predictions_NE_spaced %>% rename(sci_name = Species)
predictions_join <-inner_join(stock_list, predictions_NE_spaced, by="sci_name" )



age<-seq(1:50)

