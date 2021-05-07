`%>%` <- dplyr::`%>%`

# data
source(here::here("R/full_report_functions", "read_data.R"))

# render
dir.create(here::here("test"))
setwd(here::here("test"))

file.copy(
  from = c(
    here::here("bookdown", "index.Rmd"),
    #         here::here("bookdown", "16-bbmsy.Rmd"),
    here::here("bookdown", "18-age-diversity.Rmd")
  ),

  # recursive = TRUE,
  # from = here::here("bookdown"),

  to = here::here("test"),
  overwrite = TRUE
)

# setwd(here::here("test/bookdown"))

bookdown::render_book(
  input = ".",
  params = list(
    species_ID = "Acadian redfish",

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
  intermediates_dir = here::here("test"),
  clean = FALSE,
  quiet = FALSE
)
