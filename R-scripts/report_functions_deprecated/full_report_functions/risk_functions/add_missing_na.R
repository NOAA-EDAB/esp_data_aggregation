# distinguish between 0.5 due to missing data and true 0.5 ranking

missing_na <- function(data){
  for(i in 1:nrow(data)){
    if(data$Value[i] %>% is.na()){
      data$norm_rank[i] <- NA
    }
  }
  
  return(data)
  
}
