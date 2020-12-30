library(rfishbase)
library(stringr)
library(tibble)
library(dplyr)

data <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
head(data)

species <- unique(data$COMNAME)
sci_species <- rfishbase::common_to_sci(species, Language = "English")
head(sci_species)


# fecundity - lots of missing data...

fec <- rfishbase::fecundity(species_list = sci_species$Species)
unique(fec$Locality)
colnames(fec)
fec

length(unique(fec$SpecCode))
length(unique(fec$Species))
length(unique(fec$autoctr))

atlantic_data <- as_tibble(fec[str_which(fec$Locality, "lantic"),])
head(atlantic_data)

unique(atlantic_data$Locality)

# remove non-NW Atlantic data
atlantic_data <- as_tibble(atlantic_data[-c(str_which(
  atlantic_data$Locality, "North Atlantic, eastern South Pacific, 
  eastern South Atlantic coast of South America, Cape coast of South Africa, , 
  temperate south coast of Australia, temperate southern New Zealand, North Pacific"),
  str_which(atlantic_data$Locality, "NE Atlantic, 1976"),
  str_which(atlantic_data$Locality, "Northeast Atlantic")),])

gom_data <- as_tibble(fec[str_which(fec$Locality, "aine"),])
head(gom_data)
unique(gom_data$Locality)

# remove repetitive maine/atlantic entry
gom_data <- as_tibble(gom_data[-str_which(
  gom_data$Locality, "Gulf of Maine and Middle Atlantic Bight (southern contingent)"),])

georges_data <- as_tibble(fec[str_which(fec$Locality, "eorges"),])

northeast_data <- bind_rows(atlantic_data, gom_data, georges_data)
head(northeast_data)
str(northeast_data)

# stocks

stock <- rfishbase::stocks(sci_species$Species)
colnames(stock)
unique(stock$StockDefs)
unique(stock$LocalUnique)

northeast_stock <- as_tibble(stock[str_which(stock$LocalUnique, "Northwest Atlantic"), ])
northeast_stock
View(northeast_stock)

# maturity
mat <- rfishbase::maturity(sci_species$Species)
mat
colnames(mat)
unique(mat$Locality)
