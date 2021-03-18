# paralellization test
# speed up report generation??
# <2 minutes to shut down with small data

`%>%` <- dplyr::`%>%`

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

# make names mini
names2 <- c("Haddock", "Bluefish", "Little skate", "Black sea bass",
            "Butterfish", "Scup", "Spiny dogfish")

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence() 
all_species <- all_species[!is.na(all_species)]

# function to save reports, fix temp file problems
render_par <- function(x){
  
  tf <- tempfile()
  dir.create(tf)
  
  rmarkdown::render(here::here("R", "full_report_template.Rmd"), 
                    params = list(species_ID = x,
                                  
                                  latlong_data = latlong,
                                  shape = shape,
                                  
                                  asmt_sum_data = asmt_sum,
                                  
                                  survey_data = survey_big2,
                                  
                                  diet_data = allfh2,
                                  
                                  rec_data = rec,
                                  
                                  asmt_data = asmt,
                                  
                                  cond_data = cond,
                                  
                                  risk_data = risk,
                                  
                                  com_data = com,
                                  
                                  swept_data = swept
                    ), 
                    intermediates_dir = tf,
                    output_dir = here::here("docs/parallel_test"),
                    output_file = paste(x, "_parallel_test", 
                                        ".html", sep = ""))
  
  unlink(tf)
  
  print(Sys.time())
}

# read in data
source(here::here("R/full_report_functions", "read_data.R"))
# make data mini
survey_big2 <- survey[1:1000, ]
allfh2 <- allfh[1:1000, ]

# make cluster
# dependency - snow package
start <- Sys.time()
cl <- snow::makeCluster(4,
                        type = "SOCK", 
                        methods = FALSE)

# export data to cluster
snow::clusterExport(cl, list("survey_big2", "asmt", "asmt_sum", "risk",
                                 "latlong", "rec", "allfh2", "cond", "com",
                                 "swept"))

# set up cluster
snow::clusterEvalQ(cl, {
  #RevoUtilsMath::setMKLthreads(1)
  
  # load libraries
  library(ggplot2)
  `%>%` <- dplyr::`%>%`
  
  # load shapefile
  shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
  
}) %>% invisible()
end <- Sys.time()
end - start

# generate reports
snow::clusterApply(cl, names2, render_par)
Sys.time()
end <- Sys.time()
end - start

# stop cluster
snow::stopCluster(cl)
end <- Sys.time()
end - start

## parallel package
# 3 clusters - 1.7 min
# 4 clusters - 1.6 min
# 7 clusters - 1.6 min

## snow package
# 3 clusters - 1.1 min
# 4 clusters - 59 seconds
# 7 clusters - 59 seconds
#####

## test writing in data as function variables rather than exporting to cluster
# no speed improvement
#####
# read in data
#source(here::here("R/full_report_functions", "read_data.R"))
# make data mini
survey_big2 <- survey[1:1000, ]
allfh2 <- allfh[1:1000, ]

# make cluster
# dependency - snow package
start <- Sys.time()
cl <- snow::makeCluster(4,
                        type = "SOCK", 
                        methods = FALSE)

# set up cluster
snow::clusterEvalQ(cl, {
  #RevoUtilsMath::setMKLthreads(1)
  
  # load libraries
  library(ggplot2)
  `%>%` <- dplyr::`%>%`
  
  # load shapefile
  shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
  
}) %>% invisible()

# generate reports
snow::parLapply(cl, names2, function(x, latlong, asmt_sum, survey_big2, allfh2,
                                     rec, asmt, cond, risk, com, swept){
  
  tf <- tempfile()
  dir.create(tf)
  
  rmarkdown::render(here::here("R", "full_report_template.Rmd"), 
                    params = list(species_ID = x,
                                  
                                  latlong_data = latlong,
                                  shape = shape,
                                  
                                  asmt_sum_data = asmt_sum,
                                  
                                  survey_data = survey_big2,
                                  
                                  diet_data = allfh2,
                                  
                                  rec_data = rec,
                                  
                                  asmt_data = asmt,
                                  
                                  cond_data = cond,
                                  
                                  risk_data = risk,
                                  
                                  com_data = com,
                                  
                                  swept_data = swept
                    ), 
                    intermediates_dir = tf,
                    output_dir = here::here("docs/parallel_test"),
                    output_file = paste(x, "_parallel_test", 
                                        ".html", sep = ""))
  
  unlink(tf)
}, latlong, asmt_sum, survey_big2, allfh2, rec, asmt, cond, risk, com, swept)

# check what data is on clusters
# parallel::clusterCall(cl, print(ls()))

# stop cluster
snow::stopCluster(cl)
end <- Sys.time()
end - start

