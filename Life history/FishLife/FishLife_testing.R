library(purrr)
library(devtools)
library(stringr)

devtools::install_github("james-thorson/FishLife")
library( FishLife )

# check vignette
vignette("tutorial","FishLife")
head(FishLife::FishBase_and_RAM$beta_gv) # what are all these variables :(

( Predictions = Plot_taxa(Search_species(Family="Scombridae")$match_taxonomy) )
# not sure what the order of output is... assuming species-level is first list

# get species names from EDAB github

# take scientific names from EDAB github
#####
data <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/stock_list.csv")
head(data)
sci_species <- unique(data$sci_name)
sci_separate <- cbind(stringr::word(sci_species, 1),
                      stringr::word(sci_species, 2))
colnames(sci_separate) <- c("Genus", "Species")
head(sci_separate)
#####

# take common names from different EDAB github file and convert to scientific names
# (problem because common names are matched to scientific names from all geographic regions)
#####
data <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
head(data)

species <- unique(data$COMNAME)
sci_species <- rfishbase::common_to_sci(species, Language = "English") 
unique_sci <- unique(sci_species[,1]) # cut out repeats
head(sci_species)

# split scientific name into two columns
sci_separate <- cbind(stringr::word(unique_sci$Species, 1),
                      stringr::word(unique_sci$Species, 2))
colnames(sci_separate) <- c("Genus", "Species")
head(sci_separate)
#####

# run FishBase code over all species of interest and produce .csv of results
#####

# write function to use with apply
get_fish_info <- function(x){
  predict_this <- Plot_taxa(Search_species(Genus=x[1],
                                           Species=x[2])$match_taxonomy)
  predictions <- c(paste(x[1], x[2], sep = "_"), predict_this[[1]]$Mean_pred)
  return(predictions)
}

# write wrapper function to try() and bypass errors
apply_fun <- function(x){
  try(get_fish_info(x), TRUE)
}

# apply function to scientific name data
test <- apply(sci_separate, MARGIN = 1, FUN = apply_fun)
head(test)

# take just the entries that worked
worked <- test[sapply(test, function(x) !inherits(x, "try-error"))]
head(worked)

# put into a dataframe to save
worked_df <- data.frame(matrix(unlist(worked),  nrow = length(worked), byrow = TRUE))
names(worked_df) <- c("Species", names(worked[[1]])[-1])
head(worked_df)

# save extracted data
setwd("~/ESP data")
write.csv(worked_df, file = "FishLife_extracted_data_11.16.20_short.csv")

# see what failed
failed <- test[sapply(test, function(x) inherits(x, "try-error"))]
failed
# only 4 failed (one is a repeat)

# with purrr ...??? not happy (did not work with sapply or lapply either)
test2 <- map(sci_separate, apply_fun)
head(test2) # fail
#####

# get info on which species were used in calculations
#####

# write function to get fish info
get_calc_fish <- function(x){
  fish <- Search_species(Genus=x[1], Species=x[2])$match_taxonomy
  return(fish[1]) # first element is the most specific taxonomy
}

# write wrapper function to try() and bypass errors
apply_fish <- function(x){
  try(get_calc_fish(x), TRUE)
}

fish_names <- apply(sci_separate, MARGIN = 1, FUN = apply_fish)
head(fish_names)

fish_names_worked <- data.frame(matrix(unlist(fish_names),  nrow = length(fish_names), byrow = TRUE))

write.csv(fish_names_worked, file = "fishbase_names.csv")
#####
