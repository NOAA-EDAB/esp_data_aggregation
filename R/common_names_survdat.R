
Common_names_survdat<-function(survdatpull){

  '%>%' <- magrittr::'%>%'
  survdata<-readRDS(survdatpull)
  survdata<-survdata$survdat
  survdata<-survdata %>% mutate(SVSPP=as.numeric(SVSPP))
  stock_list_all_strata <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/stock_list.csv")
  stock_list_all_strata<-stock_list_all_strata %>%
                            rename(SVSPP=svspp)
  stock_list<-stock_list_all_strata %>%
                    dplyr::distinct(SVSPP,.keep_all =T) %>%
                      mutate(common_name=stringr::str_to_sentence(common_name))
  
  survdata.w.codes<-inner_join(survdata, stock_list, by= "SVSPP" )
  
  return(survdata.w.codes)
}


