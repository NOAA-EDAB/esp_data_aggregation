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
NEesp::render_ind_report("Black sea bass", trouble = TRUE, input = "bookdown")
