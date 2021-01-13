#organizing life history parameters 
install.packages("FSA")
install.packages("ggrepel")

devtools::install_github("james-thorson/FishLife")
library( FishLife )
library(tidyverse)
library(ggrepel)
library(FSA)
library(rfishbase)

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






t2<-fecundity("Gadus morhua")
t3<-maturity("Gadus morhua")
t4<-fooditems("Gadus morhua")

fishlife_predictions_NE<-read_csv(here::here("life history/fishlife","FishLife_extracted_data_11.16.20_northeast.csv"))
predictions_NE_spaced<-fishlife_predictions_NE %>% mutate_all(funs(str_replace(., "\\_", " ")))
predictions_NE_spaced<-predictions_NE_spaced %>% rename(sci_name = Species)
predictions_join <-inner_join(stock_list, predictions_NE_spaced, by="sci_name" )

predictions_join<-predictions_join %>% filter(WORKED==TRUE)
predictions_join<-predictions_join %>% mutate(Loo=as.numeric(Loo), K=as.numeric(K))


predictions_join$Linf<-exp(predictions_join$Loo)
predictions_join$K<-exp(predictions_join$K)
predictions_join<-predictions_join %>% mutate(t0=tzero(Linf, K))
write.csv(predictions_join, file = "predictions_join.csv")









#function to calculate the fitted growth curve for von bertalanffy growth curve
vonb<-function(t,Linf,K,tzero){Latthisage<-Linf*(1-exp(-K*(t-tzero)))
  return(Latthisage)
}


#Pauly 1979 based method to estimate a default value for t0 as log (-t0) = -0.3922 - 0.2752 log Linf - 1.038 log K
#consistant way of generating t0  
tzero<-function(Linf,K){logtzero<-(-0.3922 - (0.2752*log(Linf) - 1.038*log(K)))
  t0<-exp(logtzero)
  return(t0)  
}  



#select out needed cols
prediction.select<-predictions_join %>% select(common_name, Linf,K,t0)
#split into a set of lists for map use
flist<-split(t1, f=t1$common_name)

# vonb wants arguments in the order t,Linf,K,tzero)

spec.age.growth.list<-map(flist, ~vonb(seq(1:50),.x[[2]],.x[[3]],.x[[4]]))


spec.age.growth<-do.call(cbind,spec.age.growth.list)

spec.age.growth.df<-data.frame(spec.age.growth)
fish.names<-colnames(spec.age.growth.df)



spec.age.growth.df$year<-seq(1:50)

age.growth.curves<-spec.age.growth.df %>% pivot_longer(cols = fish.names,names_to = "species", values_to = "length" )



age.growth.curves %>% ggplot(aes(x=year, y=length,label = species))+geom_line(aes(color=species))+geom_label_repel(box.padding = 0.5, max.overlaps = Inf)




