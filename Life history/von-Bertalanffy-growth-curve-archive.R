
#function to calculate the fitted growth function for von bertalanffy growth curve
vonb<-function(t,Linf,K,tzero){Latthisage<-Linf*(1-exp(-K*(t-tzero)))
return(Latthisage)
}


#Pauly 1979 based method to estimate a default value for t0 as log (-t0) = -0.3922 - 0.2752 log Linf - 1.038 log K
#consistant way of generating t0  
tzero<-function(Linf,K){logtzero<-(-0.3922 - (0.2752*log(Linf) - 1.038*log(K)))
t0<-exp(logtzero)
return(t0)  
}  


stock_list_all_strata<- readr::read_csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/stock_list.csv")
stock_list<-stock_list_all_strata %>% dplyr::distinct( common_name, .keep_all=TRUE)


fishlife_predictions_NE<-readr::read_csv(here::here("life history/fishlife","FishLife_extracted_data_11.16.20_northeast.csv"))
predictions_NE_spaced<-fishlife_predictions_NE %>% dplyr::mutate_all(funs(str_replace(., "\\_", " ")))
predictions_NE_spaced<-predictions_NE_spaced %>% dplyr::rename(sci_name = Species)
predictions_join <-dplyr::inner_join(stock_list, predictions_NE_spaced, by="sci_name" )

predictions_join<-predictions_join %>% 
  dplyr::filter(WORKED==TRUE)
#reformat these into numeric cols
predictions_join<-predictions_join %>% 
  dplyr::mutate(Loo=as.numeric(Loo), K=as.numeric(K))

#return the model output into original scale
predictions_join$Linf<-exp(predictions_join$Loo)
predictions_join$K<-exp(predictions_join$K)

predictions_join<-predictions_join %>% mutate(t0=tzero(Linf, K))
#write.csv(predictions_join, file = "predictions_join.csv")


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
#extract col names for pivoting 
fish.names<-colnames(spec.age.growth.df)
fish.names<-fish.names[fish.names != "year"]


#Pivot from wide format to long to make graphing easy


age.growth.curves<-spec.age.growth.df %>% pivot_longer(cols = fish.names,names_to = "common_name", values_to = "length" )
#remove the period in common name to enable the matching fuction in dplyr join
age.growth.curves$common_name<-str_replace(age.growth.curves$common_name,"\\."," " )

age.growth.join<-right_join(prediction.select,age.growth.curves, by= "common_name")

age.growth.join$common_name<-  str_to_lower(age.growth.join$common_name)
#recode black sea.bass to black sea bass inorder to be consistant with other datasets 

age.growth.join$common_name<- recode(age.growth.join$common_name, "black sea.bass" = "black sea bass")

################################
survdata<-readRDS(here::here("survdat_pull_bio.rds"))

survdata<-survdata %>% mutate(SVSPP=as.numeric(SVSPP))
stock_list_all_strata <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/stock_list.csv")
stock_list_all_strata<-stock_list_all_strata %>% rename(SVSPP=svspp)
stock_list<-stock_list_all_strata %>% dplyr::distinct(SVSPP,.keep_all =T)

survdata.w.codes<-inner_join(survdata, stock_list, by= "SVSPP" )

selected.surv<-survdata.w.codes %>% filter(common_name ==params$stock)

selected.surv %>%  ggplot(aes(x=AGE, y=LENGTH))+ geom_point()



#########################################################
#logical filtering of params for plotting

is_small<-FALSE
is_med<-FALSE
is_large<-FALSE




sizeclass<-age.growth.join %>% filter(common_name==params$stock)

if(sizeclass$body_cat=="small"){
  is_small<-TRUE}

if(sizeclass$body_cat=="med"){
  is_med<-TRUE}

if(sizeclass$body_cat=="large"){
  is_large<-TRUE}



