#'
#'Note: survdat is still in dev so you'll probably need to install again at a later date
#'


library(magrittr)
# connect to the database (use VPN)
channel <- dbutils::connect_to_database("sole","atyrell")
#query
qry <- c(
  "select b.cruise6,b.stratum,b.tow,b.station, s.svvessel,
  s.est_year year,season, est_month month,est_day day,
  substr(est_time,1,2)||substr(est_time,4,2) time,
  round(substr(beglat,1,2) + (substr(beglat,3,7)/60),6) beglat,
  round(((substr(beglon,1,2) + (substr(beglon,3,7)/60)) * -1), 6) beglon,
  setdepth,surftemp, bottemp,
  b.svspp,logged_species_name, sex,length,age,maturity,indid,indwt,stom_volume,stom_wgt, expcatchwt, expcatchnum
  from union_fscs_svbio b, union_fscs_svcat p, union_fscs_svsta s, svdbs_cruises c
  where
  (b.cruise6=s.cruise6) and
  (c.cruise6=b.cruise6) and
  (p.cruise6=c.cruise6) and
  (p.stratum=b.stratum) and
  (b.stratum=s.stratum) and
  (p.station=b.station) and
  (b.station=s.station) and
  (p.svspp=b.svspp) and
  (p.tow=b.tow) and
  (b.tow=s.tow) ;"
)
# this will take some time
laurel <- DBI::dbGetQuery(channel, qry)

# change names of columns
dataSet <- laurel %>% 
  dplyr::rename(ABUNDANCE = EXPCATCHNUM,
                BIOMASS = EXPCATCHWT)
#apply conversion factors
newdata <- channel %>% 
  survdat:::apply_conversion_factors(data.table::as.data.table(dataSet))

# filter dogfish for early years. They should be there now
newdata$survdat %>% 
  dplyr::filter(YEAR < 2001, SVSPP =="015") %>% 
  dplyr::distinct(YEAR)

