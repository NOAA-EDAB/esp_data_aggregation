setwd(here::here("R/Bluefish/bookdown"))
bookdown::render_book(input = ".",
                      params = list(lag = 0,
                                    cache = FALSE),
                      output_dir = "Bluefish_lag0_book",
                      clean = TRUE,
                      quiet = FALSE) 

bookdown::render_book(input = ".",
                      params = list(lag = 1),
                      output_dir = "Bluefish_lag1_book",
                      clean = TRUE,
                      quiet = FALSE) 

bookdown::render_book(input = ".",
                      params = list(lag = 1,
                                    remove_recent = TRUE),
                      output_dir = "Bluefish_lag1_remove_recent_book",
                      clean = TRUE,
                      quiet = FALSE) 
