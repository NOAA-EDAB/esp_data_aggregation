update_species_names <- function(data, species_col){

  col_num <- which(colnames(data) == species_col)
  
  data <- data %>%
    dplyr::rename(Species = species_col) %>%
    dplyr::mutate(Species = Species %>%
                    stringr::str_replace("Goosefish", "Monkfish"))
  # add any other names that have to be changed in mutate() above
  
  colnames(data)[col_num] <- species_col
                    
  return(data)
}