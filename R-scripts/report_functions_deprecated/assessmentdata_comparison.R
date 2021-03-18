
`%>%` <- dplyr::`%>%`


dat <- read.csv(here::here("data", "Export_All_Assessment_Records.csv"))
dat %>% head()
### does not have enough additional info to justify changing data source

asmt_sum <- read.csv(here::here("data", "assessmentdata_ratings.csv"))
asmt_sum %>% head()

#
dat2 <- dat %>% 
  dplyr::filter(Jurisdiction == "NEFMC" | 
                  Jurisdiction == "NEFMC / MAFMC" | 
                  Jurisdiction == "MAFMC")
split_info <- stringr::str_split_fixed(dat2$`Stock`, " - ", n = 2)
dat2$Species <- split_info[,1]

unique(split_info[, 2])

split_info2 <- stringr::str_split_fixed(split_info[,2], " \\|", n = 2)
split_info2

dat2$Region <- split_info2[,1]

head(dat2)
unique(dat2$Region)

unique(dat2$Species) %>% stringr::str_sort()
unique(asmt_sum$Species) %>% stringr::str_sort()

unique(asmt_sum$Species) %in% unique(dat2$Species)

names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence()

unique(asmt_sum$Species) %in% all_species

unique(asmt_sum$Species)[(unique(asmt_sum$Species) %in% all_species) == FALSE]

colnames(asmt_sum)
colnames(dat2)



for(i in all_species){
  asmt_sum_b <- asmt_sum %>%
    dplyr::filter(Species == i,
                  is.na(B.Year) == FALSE,
                  is.na(B.Bmsy) == FALSE) %>%
    dplyr::select(B.Year, B.Bmsy)
  
  dat2_b <- dat2 %>%
    dplyr::filter(Species == i,
                  is.na(B.Year) == FALSE,
                  is.na(B.Bmsy) == FALSE) %>%
    dplyr::select(B.Year, B.Bmsy)
  
  if(length(asmt_sum_b[,1]) < length(dat2_b[,1])){
    print(paste(i, "assessmentdata is missing B info"))
  }
  
  asmt_sum_b <- asmt_sum %>%
    dplyr::filter(Species == i,
                  is.na(F.Year) == FALSE,
                  is.na(F.Fmsy) == FALSE) %>%
    dplyr::select(F.Year, F.Fmsy)
  
  dat2_b <- dat2 %>%
    dplyr::filter(Species == i,
                  is.na(F.Year) == FALSE,
                  is.na(F.Fmsy) == FALSE) %>%
    dplyr::select(F.Year, F.Fmsy)
  
  if(length(asmt_sum_b[,1]) < length(dat2_b[,1])){
    print(paste(i, "assessmentdata is missing F info"))
  }
}

for(i in c("Atlantic cod")){
  asmt_sum_b <- asmt_sum %>%
    dplyr::filter(Species == i,
                  is.na(B.Year) == FALSE,
                  is.na(B.Bmsy) == FALSE) %>%
    dplyr::select(B.Year, B.Bmsy) %>%
    dplyr::arrange(B.Year)
  
  dat2_b <- dat2 %>%
    dplyr::filter(Species == i,
                  is.na(B.Year) == FALSE,
                  is.na(B.Bmsy) == FALSE) %>%
    dplyr::select(B.Year, B.Bmsy) %>%
    dplyr::arrange(B.Year)

    print(asmt_sum_b)
    
    print(dat2_b)

  asmt_sum_b <- asmt_sum %>%
    dplyr::filter(Species == i,
                  is.na(F.Year) == FALSE,
                  is.na(F.Fmsy) == FALSE) %>%
    dplyr::select(F.Year, F.Fmsy) %>%
    dplyr::arrange(F.Year)
  
  dat2_b <- dat2 %>%
    dplyr::filter(Species == i,
                  is.na(F.Year) == FALSE,
                  is.na(F.Fmsy) == FALSE) %>%
    dplyr::select(F.Year, F.Fmsy) %>%
    dplyr::arrange(F.Year)
  
     print(asmt_sum_b)
    
    print(dat2_b)
}












