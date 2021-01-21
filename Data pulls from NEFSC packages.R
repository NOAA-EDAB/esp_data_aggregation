remotes::install_github("andybeet/dbutils",build_vignettes=TRUE)
library(dbutils)
con <- dbConnect(RPostgreSQL::PostgreSQL(), "username", "passsword")

con <- connect_to_database(server="sole",uid="RTABANDERA")
install.packages("odbc")
t1<-dbutils::create_species_lookup(con,species ="73",speciesType = "SVSPP")
remotes::install_github("NOAA-EDAB/survdat",build_vignettes = FALSE)
library(survdat)
library(dbutils)
survdat::get_area()


svdbs<-survdat::get_survdat_data(con, bio = TRUE)

survdata<-svdbs$survdat
saveRDS(survdata, file="survdat_pull_bio.rds")

conversion_factors<-survdat::get_conversion_factors(con)

getwd()




apply_conversion_factors(con, survdat.raw, use.SAD = F)

remotes::install_github("NOAA-EDAB/comlandr",build_vignettes = TRUE)
library("comlandr")

comlandr::get_comland_data(con,endyear= 2020)
