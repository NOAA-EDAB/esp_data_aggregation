character_to_factor <- function(x){
  if(is.null(x) == FALSE){
    if(nrow(x) > 0){
      for(i in 1:ncol(x)){
        x <- as.data.frame(x)
        if(class(x[ , i]) == "character"){
          x[ , i] <- as.factor(x[ , i])
        }
      }
      return(x)
    }
  }
}
