# indicator reports ----

# see function information
?NEesp::render_ind_report

# run a report using package data and package template
NEesp::render_ind_report("Black sea bass")

# run a report using package data and local template (from "indicator_bookdown_template-dev" folder)

## source new functions if needed
`%>%` <- magrittr::`%>%`
source(here::here("R-scripts/package-dev", "life_history_functions.R"))
source(here::here("R-scripts/package-dev", "plot_temp_anom.R"))

NEesp::render_ind_report("Black sea bass", 
                         input = here::here("indicator_bookdown_template-dev"),
                         params_to_use = list(
                           species_ID = "Black sea bass",
                           ricky_survey_data = NEesp::bio_survey,
                           path = here::here("action_reports/Black sea bass", "figures//"),
                           save = TRUE
                         ), trouble = TRUE)

# regression reports ----

# see function information
?NEesp::render_reg_report

# run a report using package data and package template
NEesp::render_reg_report(stock_var = "Black sea bass",
                         epus_var = "MAB",
                         region_var = "Mid",
                         remove_var = FALSE,
                         lag_var = 0,
                         parent_folder = "zero_lag")

# run a report using package data and local template (from "correlation_bookdown_template-dev" folder)
NEesp::render_reg_report(stock_var = "Black sea bass",
                         epus_var = "MAB",
                         region_var = "Mid",
                         remove_var = FALSE,
                         lag_var = 0,
                         parent_folder = "zero_lag",
                         input = here::here("correlation_bookdown_template-dev"))