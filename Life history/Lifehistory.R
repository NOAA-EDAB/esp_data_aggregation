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



#Pauly 1979) to estimate a default value for t0 as log (-t0) = -0.3922 - 0.2752 log Linf - 1.038 log K

install.packages("FSA")
library(FSA)

library(rfishbase)
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


#common_name, sci_name,
test2<- predictions_join %>% select( Linf,K,t0)

apply(test2, MARGIN = 1, function(x) vonb(1,x[,1],x[,2]),x[,3])

result <- data.frame(n)

map(age, )

for(i in 1:39){
  result<-vonb(i,test2$Linf[i],test2$K[i],test2$t0[i])
  return(result)
}




install.packages("magicfor")
library(magicfor)     
magic_for(print, silent = TRUE) # call magic_for()

test2 %>% map(function(test2) vonb(Linf,K,t0))




for (i in length(predictions_join$sci_name)){
  result<-vonb(i,predictions_join[i,32],predictions_join[i,13],predictions_join[i,33])
  print(result)
}





vonb<-function(t,Linf,K,tzero){Latthisage<-Linf*(1-exp(-K*(t-tzero)))
  return(Latthisage)
}



  
tzero<-function(Linf,K){logtzero<-(-0.3922 - (0.2752*log(Linf) - 1.038*log(K)))
  t0<-exp(logtzero)
  return(t0)  
}  

test_fun<-function(Linf,K,tzero){
  age<-c(1:100)
  
  Latthisage<-Linf*(1-exp(-K*(age-tzero)))
  return(Latthisage)
  
}




exp(c(4.591857129,	-1.980489619))

tzero( 98.6775170,  0.1380017)


age<-seq(1:50)
linf<-rep(98.6775170,50 )
k<-rep(0.1380017, 50)
t0<-rep(tzero( 98.6775170,  0.1380017),50)

t1<-tibble::tibble(age,linf,k,t0)


LatAge<-vonb(t1$age,t1$linf,t1$k,t1$t0)
test1<-data.frame(LatAge,seq(1:50))


ggplot2::ggplot(test1, aes( x=seq.1.50.,y=LatAge ))+
  geom_point()+
  geom_line()



apply(t1, FUN=vonb)

vonb(t1)




