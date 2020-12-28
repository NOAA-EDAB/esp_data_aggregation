character_to_factor <- function(x){
  for(i in 1:ncol(x)){
    if(class(x[ , i]) == "character"){
      x[ , i] <- as.factor(x[ , i])
    }
  }
  return(x)
}