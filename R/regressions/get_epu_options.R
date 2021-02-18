return_epu <- function(x){
  
  data <- eval(parse(text = x))
  
  if("sf" %in% class(data)){
    
  } else {
    if("EPU" %in% colnames(data)){
      y <- data %>%
        dplyr::ungroup() %>%
        dplyr::select(EPU) %>%
        dplyr::distinct()
      
      return(y)
    }
  }
}

return_epu(ecodata::cold_pool)

d <- data(package = "ecodata")
## names of data sets in the package
d$results[, "Item"]
d


library(ecodata)
parse((d$results[1, "Item"]))
eval(parse(text=d$results[1, "Item"]))

return_epu(d$results[1, "Item"])

data_names <- d$results[, "Item"]
data_names <- data_names[-which(data_names == "seabird_mab (seabird_MAB)")]

epus <- c()
for(i in 1:length(data_names)){
  
  these_epus <- return_epu(data_names[i])
  
  epus <- dplyr::bind_rows(epus, these_epus) %>% 
    dplyr::distinct()
  
  if(i == length(data_names)) {print(epus)}
}
