
common_names_survdat<-function(survdat_pull_type="all"){
  #returns all survdata by defult, if survdat_pull_type= bio returns bio pulls
  if(survdat_pull_type=="bio"){
    
    '%>%' <- magrittr::'%>%'
    survdata<-NEesp::bio_survey
    sp_key<-NEesp::species_key

    survdata.bio.w.codes<-dplyr::inner_join(survdata, sp_key, by= "SVSPP" )%>%
      dplyr::rename("common_name"="Species")

    #print("bio survdata")
    return(survdata.bio.w.codes)
    
    
  }else{
    
    '%>%' <- magrittr::'%>%'
    survdata<-NEesp::survey %>%
      dplyr::rename("common_name"="Species")
    #print("all survdata")
    return(survdata)
    
  }

}


