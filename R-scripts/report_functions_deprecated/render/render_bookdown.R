# libraries needed
renv::snapshot()

# purrr ----

source(here::here("R", "update_species_names.R"))
source(here::here("R/full_report_functions", "read_data.R"))
# source(here::here("R/full_report_functions", "get_updated_files.R"))

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>%
  unique() %>%
  stringr::str_to_sentence() %>%
  stringr::str_replace("Goosefish", "Monkfish") # change goosefish to monkfish
list_species <- split(all_species, f = list(all_species))

# dir.create(here::here("docs/bookdown"))
# dir.create(here::here("docs/bookdown/Acadian redfish"))
# file.create(here::here("docs/bookdown/Acadian redfish", ".nojekyll"))

setwd(here::here("bookdown/"))

start <- Sys.time()

purrr::map(
  "Monkfish",
  ~ bookdown::render_book(
    input = c("test/index.Rmd"),
    # preview = TRUE,
    preview = FALSE,
    params = list(
      species_ID = .x,

      latlong_data = latlong,
      shape = shape,

      asmt_sum_data = asmt_sum,

      survey_data = survey_big,

      ricky_survey_data = ricky_survey,

      diet_data = allfh,

      rec_data = rec,

      asmt_data = asmt,

      cond_data = cond,

      risk_data = risk,

      risk_year_hist_data = risk_year_hist,

      risk_year_value_data = risk_year_value,

      risk_species_data = risk_species,

      com_data = com,

      swept_data = swept
    ),
    knit_root_dir = here::here(paste("Reports/", .x, sep = "")),
    output_dir = here::here(paste("Reports/", .x, sep = ""))
  )
)
end <- Sys.time()
end - start
# first run - 2.6 minutes
# second run - 2.0 minutes, faster with cached data!

# create .nojekyll file
file.create(here::here("docs/bookdown", ".nojekyll"))

# parallelize all reports ----
# issues with previewing bookdown chapters in parallel
# use parallelization only to generate full reports
#####

# make sure there are no NAs in the species name vector or it will break

start <- Sys.time()

`%>%` <- dplyr::`%>%`

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>%
  unique() %>%
  stringr::str_to_sentence() %>%
  stringr::str_replace("Goosefish", "Monkfish") # change goosefish to monkfish
all_species <- all_species[!is.na(all_species)]

# function to save reports, fix temp file problems
# try copying bookdown .rmd files to new directories
# list.files(here::here("bookdown"), full.names = TRUE)

dir.create(here::here("Reports"))
render_par <- function(x) {
  tf <- tempfile()
  dir.create(tf)

  new_dir <- here::here(paste("Reports/", x, sep = ""))
  dir.create(new_dir)

  file.copy(
    from = list.files(here::here("bookdown"), full.names = TRUE),
    to = new_dir,
    recursive = FALSE,
    overwrite = TRUE
  )

  setwd(new_dir)
  file.create(".nojekyll")

  bookdown::render_book(
    input = ".",
    params = list(
      species_ID = x,

      latlong_data = latlong,
      shape = shape,

      asmt_sum_data = asmt_sum,

      survey_data = survey_big,

      ricky_survey_data = ricky_survey,

      diet_data = allfh,

      rec_data = rec,

      asmt_data = asmt,

      cond_data = cond,

      risk_data = risk,

      risk_year_hist_data = risk_year_hist,

      risk_year_value_data = risk_year_value,

      risk_species_data = risk_species,

      com_data = com,

      swept_data = swept
    ),
    intermediates_dir = tf,
    knit_root_dir = new_dir,
    # clean = TRUE,
    output_dir = new_dir
  )

  # copy images to right folder
  file.copy(
    from = list.files(here::here(new_dir, "/_bookdown_files/"), full.names = TRUE),
    to = new_dir,
    recursive = TRUE,
    overwrite = TRUE
  )

  unlink(tf)
  # return("done")
}

# read in data
source(here::here("R/full_report_functions", "read_data.R"))

# make cluster
cl <- snow::makeCluster(8) # not the same as cores - can have more than 8??

# export data to cluster
snow::clusterExport(cl, list(
  "survey_big", "asmt", "asmt_sum", "risk",
  "latlong", "rec", "allfh", "cond", "com",
  "swept", "risk_species", "risk_year_hist",
  "risk_year_value", "ricky_survey"
))

# set up cluster
snow::clusterEvalQ(cl, {
  # load libraries
  library(ggplot2)
  `%>%` <- dplyr::`%>%`

  # load shapefile
  shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
}) %>% invisible()

# generate reports
snow::clusterApply(
  cl,
  all_species,
  render_par
)

# check what data is on clusters
# parallel::clusterCall(cl, print(ls()))

# stop cluster
Sys.time()
snow::stopCluster(cl)
Sys.time()

end <- Sys.time()
end - start

.restart.R()
Sys.time()

#####

# clean up files (when locally rendered with parallelization)
rmds <- list.files(here::here("Reports"), recursive = TRUE, full.names = TRUE) %>%
  stringr::str_subset(".Rmd")
file.remove(rmds)

folders <- list.dirs(here::here("Reports"), recursive = TRUE, full.names = TRUE) %>%
  stringr::str_subset("_bookdown_files")
unlink(folders, recursive = TRUE)

locks <- list.files(here::here("Reports"), recursive = TRUE, full.names = TRUE) %>%
  stringr::str_subset("renv.lock")
file.remove(locks)
