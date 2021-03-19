remotes::install_github("NOAA-EDAB/esp_data_aggregation@package", dependencies = FALSE)
NEesp::render_ind_report("Black sea bass", input = "bookdown")
setwd("~/EDAB/esp_data_aggregation")
