NEesp::render_ind_report("Black sea bass", trouble = TRUE)

NEesp::render_reg_report(stock_var = "Black sea bass", 
                         epus_var = "MAB",
                         region_var = "Mid",
                         trouble = TRUE,
                         parent_folder = "lag0")

NEesp::render_reg_report(stock_var = "Black sea bass", 
                         epus_var = "MAB",
                         region_var = "Mid",
                         trouble = TRUE,
                         lag_var = 1,
                         parent_folder = "lag1")

#
NEesp::render_ind_report("Black sea bass", trouble = TRUE, input = "bookdown",
                         params_to_use = list(
                           species_ID = "Black sea bass",
                           
                           path = here::here("action_reports/Black sea bass", "figures//"),
                           
                           latlong_data = NEesp::latlong,
                           shape = NEesp::shape,
                           
                           asmt_sum_data = NEesp::asmt_sum,
                           
                           survey_data = NEesp::survey,
                           
                           ricky_survey_data = NEesp::bio_survey,
                           
                           diet_data = NEesp::allfh,
                           
                           rec_data = NEesp::rec_catch,
                           
                           asmt_data = NEesp::asmt,
                           
                           cond_data = NEesp::cond,
                           
                           risk_data = NEesp::risk,
                           
                           risk_year_hist_data = NEesp::risk_year_hist,
                           
                           risk_year_value_data = NEesp::risk_year_value,
                           
                           risk_species_data = NEesp::risk_species,
                           
                           com_data = NEesp::com_catch,
                           
                           swept_data = NEesp::swept
                         ))
