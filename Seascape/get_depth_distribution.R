library(here)
library(survdat)
library(dbutils)
library(tidyverse)

channel <- connect_to_database(server="sole",uid="RTABANDERA")

survdata<-readRDS("survdat_pull_bio.rds")


# abundance is adjusted but not length for bigalo data
groupdiscription =svspp
# filter by group giv list of svspp codes
get_fish_info()
surv.species<-survdat::get_species(channel)

surv.species.1<-surv.species$data
surv.code<-surv.species.1 %>% dplyr::distinct(SVSPP,.keep_all =T)
# black sea bass is svspp= 	141 bluefish =135

test.sp.code<-c(141,135)


black_and_blue<-