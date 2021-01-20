#organizing life history parameters 

#install.packages("ggrepel")
#install.packages("ggpubr")
#devtools::install_github("james-thorson/FishLife")

library( FishLife )
library(tidyverse)
library(rfishbase)
library(ggpubr)

stock_list_all_strata<- readr::read_csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/stock_list.csv")
stock_list<-stock_list_all_strata %>% dplyr::distinct( common_name, .keep_all=TRUE)


fishlife_predictions_NE<-read_csv(here::here("life history/fishlife","FishLife_extracted_data_11.16.20_northeast.csv"))
predictions_NE_spaced<-fishlife_predictions_NE %>% mutate_all(funs(str_replace(., "\\_", " ")))
predictions_NE_spaced<-predictions_NE_spaced %>% rename(sci_name = Species)
predictions_join <-inner_join(stock_list, predictions_NE_spaced, by="sci_name" )

predictions_join<-predictions_join %>% filter(WORKED==TRUE)
predictions_join<-predictions_join %>% mutate(Loo=as.numeric(Loo), K=as.numeric(K))


predictions_join$Linf<-exp(predictions_join$Loo)
predictions_join$K<-exp(predictions_join$K)
predictions_join<-predictions_join %>% mutate(t0=tzero(Linf, K))
#write.csv(predictions_join, file = "predictions_join.csv")


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

#catagorize the Linf into rough bins
prediction.select$body_cat<-cut(prediction.select$Linf, breaks=c(-Inf,50, 100, Inf), 
                                labels=c("small","med","large"))


#split into a set of lists for map use
flist<-split(prediction.select, f=prediction.select$common_name)

# vonb wants arguments in the order t,Linf,K,tzero)

spec.age.growth.list<-map(flist, ~vonb(seq(1:75),.x[[2]],.x[[3]],.x[[4]]))

# turn the list of lists into a single object
spec.age.growth<-do.call(cbind,spec.age.growth.list)
#turn this object into a df for manipulation
spec.age.growth.df<-data.frame(spec.age.growth)
# make an index of years int he dataset 

spec.age.growth.df$year<-seq(1:75)
#Pivot from wide format to long to make graphing easy

age.growth.curves<-spec.age.growth.df %>% pivot_longer(cols = fish.names,names_to = "common_name", values_to = "length" )
#remove the period in common name to enable the matching fuction in dplyr join
age.growth.curves$common_name<-str_replace(age.growth.curves$common_name,"\\."," " )

age.growth.join<-right_join(prediction.select,age.growth.curves, by= "common_name")

#plots can be seperated or arranged into one plot below 

small<-age.growth.join %>%
  filter(body_cat=="small")%>%
  ggplot(aes(x=year, y=length))+
  geom_line(aes(color=common_name),size=1.4)+
  xlab("Year")+
  ylab(" Total length (cm)")+
  labs(color="Common name of stock")+
  ggtitle("Small bodied fish growth")+
  theme_minimal()

med<-age.growth.join %>%
  filter(body_cat=="med")%>%
  ggplot(aes(x=year, y=length))+
  geom_line(aes(color=common_name),size=1.4)+
  xlab("Year")+
  ylab(" Total length (cm)")+
  labs(color="Common name of stock")+
  ggtitle("Medium bodied fish growth")+
  theme_minimal()


large<-age.growth.join %>%
  filter(body_cat=="large")%>%
  ggplot(aes(x=year, y=length))+
  geom_line(aes(color=common_name),size=1.4)+
  xlab("Year")+
  ylab(" Total length (cm)")+
  labs(color="Common name of stock")+
  ggtitle("large bodied fish growth")+
  theme_minimal()

ggarrange(small,med,large)

#annotation for bookdown

# The predicted von Bertalanffy growth curve for NMFS managed fish species. Growth parameters of Linf (Length infinty), K (growth coefficient) 
# were estimated using [James Thorson FishLife R package](https://github.com/James-Thorson-NOAA/FishLife). This package uses a mix of previously published
# life history parameters extracted from fishbase and correlated higher taxon parameters to generate estimates for growth and population parameters. t0 (size at age 0) was
# estimated using the method described by Pauly 1979 for generating a consistent value for t0 from Linf and K. Fish were categorized into three groups with 
# small bodied species reaching max size < 50 cm,   medium 50-100 cm, and large >100 cm as rough divisions for comparisons of growth among similar body sizes.
