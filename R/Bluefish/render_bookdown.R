setwd(here::here("R/Bluefish/bookdown"))
bookdown::render_book(input = ".",
                      clean = FALSE,
                      quiet = FALSE) 

bookdown::render_book(input = ".",
                      params = list(lag = 1)
                      output_dir = "lag1_book",
                      clean = FALSE,
                      quiet = FALSE) 