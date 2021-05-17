`%>%` <- magrittr::`%>%`

channel <- dbutils::connect_to_database(
  server = "sole",
  uid = "atyrell"
)

# Pull the length weight coefficients from SVDS.length_weight_coefficients.
#Grab survey length/weight coefficients
lw.qry <- "select svspp, sex, svlwexp, svlwcoeff, svlwexp_spring, svlwcoeff_spring,
               svlwexp_fall, svlwcoeff_fall, svlwexp_winter, svlwcoeff_winter,
               svlwexp_summer, svlwcoeff_summer
               from svdbs.length_weight_coefficients"

lw <- data.table::as.data.table(DBI::dbGetQuery(channel, lw.qry))

# Some of the species have season specific coefficients and others do not.  
# To simplify applying the coefficients later you'll need to fill in the NA values. 

test <- lw %>% 
  dplyr::filter(is.na(SVLWEXP)) %>%
  as.data.frame()
head(test)
names <- colnames(test)

for(i in 3:length(names)){
  print(names[i])
  print(sum(is.na(test[,i])))
}
# all na

#Clean up NAs
lw <- lw[!is.na(SVLWEXP), ]
lw[is.na(SVLWEXP_SPRING), SVLWEXP_SPRING := SVLWEXP]
lw[is.na(SVLWEXP_FALL),   SVLWEXP_FALL   := SVLWEXP]
lw[is.na(SVLWEXP_WINTER), SVLWEXP_WINTER := SVLWEXP]
lw[is.na(SVLWEXP_SUMMER), SVLWEXP_SUMMER := SVLWEXP]
lw[is.na(SVLWCOEFF_SPRING), SVLWCOEFF_SPRING := SVLWCOEFF]
lw[is.na(SVLWCOEFF_FALL),   SVLWCOEFF_FALL   := SVLWCOEFF]
lw[is.na(SVLWCOEFF_WINTER), SVLWCOEFF_WINTER := SVLWCOEFF]
lw[is.na(SVLWCOEFF_SUMMER), SVLWCOEFF_SUMMER := SVLWCOEFF]
    
lw %>% View

#You might want to double check that first line of code.  
# There must be a bunch of species with no values, 
# otherwise I can't remember why I stripped out those rows without the season independent coefficients.

# Merge the right season coefficient/species to the survdat data.
head(NEesp::survey)
new_dat <- dplyr::left_join(NEesp::survey, lw, by = "SVSPP")

# Generate a weight-at-length.  The equation will be W = SVLWCOEFF * L ^ SVLWEXP.
new_dat <- new_dat %>%
  dplyr::mutate(summer_wt_at_len = ifelse(SEASON == "SUMMER", SVLWCOEFF_SUMMER * LENGTH ^ SVLWEXP_SUMMER, NA),
                fall_wt_at_len = ifelse(SEASON == "FALL", SVLWCOEFF_FALL * LENGTH ^ SVLWEXP_FALL, NA),
                winter_wt_at_len = ifelse(SEASON == "WINTER", SVLWCOEFF_WINTER * LENGTH ^ SVLWEXP_WINTER, NA),
                spring_wt_at_len = ifelse(SEASON == "SPRING", SVLWCOEFF_SPRING * LENGTH ^ SVLWEXP_SPRING, NA))

# Multiple the weight-at-length by the number at length (numlen).  
# This will give you the total weight of fish at that length noting the caveats I mentioned in the previous email.
new_dat <- new_dat %>%
  dplyr::mutate(summer_biomass = ifelse(SEASON == "SUMMER", summer_wt_at_len * NUMLEN, NA),
                fall_biomass = ifelse(SEASON == "FALL", fall_wt_at_len * NUMLEN, NA),
                winter_biomass = ifelse(SEASON == "WINTER", winter_wt_at_len * NUMLEN, NA),
                spring_biomass = ifelse(SEASON == "SPRING", spring_wt_at_len * NUMLEN, NA))
saveRDS(new_dat, here::here("black-sea-bass", "survdat_wt_at_len.RDS"))

for(i in 1:ncol(new_dat)){

  dat <- as.data.frame(new_dat)
  if(is.numeric(dat[,1])){
    print(colnames(dat)[i])
    print(min(dat[,i], na.rm = TRUE))
    print(max(dat[,i], na.rm = TRUE))
  }
}
