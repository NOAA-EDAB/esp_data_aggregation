render_reg_report_word <- function(stock_var, epus_var, region_var, remove_var = FALSE,
                              lag_var = 0, parent_folder, input = "package",
                              trouble = FALSE, save_var = TRUE, out = "html") {
  starting_dir <- getwd()
  
  new_dir <- here::here(
    "Regressions", parent_folder,
    paste(
      stock_var, region_var
      %>% stringr::str_replace_all("/", "-"),
      epus_var
    )
  ) %>%
    stringr::str_replace_all(" ", "_")
  
  dir.create(new_dir,
             recursive = TRUE
  )

  if(input == "package"){
    file.copy(
      from = list.files(system.file("correlation_bookdown_template", package = "NEesp"),
                        full.names = TRUE
      ),
      to = here::here(new_dir),
      overwrite = TRUE
    ) %>%
      invisible()
  } else {
    file.copy(
      from = list.files(input,
                        full.names = TRUE
      ),
      to = here::here(new_dir),
      overwrite = TRUE
    ) %>%
      invisible()
  }
  
  
  setwd(here::here(new_dir))

  if(save_var){
    dir.create("data",
               recursive = TRUE
    )
  }
  
  
  # render bookdown
  if (trouble == FALSE) {
    bookdown::render_book(
      input = ".",
      params = list(
        lag = lag_var,
        stock = stock_var,
        region = region_var,
        epu = c(epus_var, c("All", "all", "NE")),
        path = here::here(new_dir, "figures//"),
        save = save_var,
        remove_recent = remove_var,
        out = out
      ),
      output_dir = new_dir,
      intermediates_dir = new_dir,
      knit_root_dir = new_dir,
      output_format = bookdown::word_document2(),
      clean = TRUE,
      quiet = TRUE
    ) %>%
      suppressMessages() %>%
      suppressWarnings()
  }
  
  if (trouble == TRUE) {
    bookdown::render_book(
      input = ".",
      params = list(
        lag = lag_var,
        stock = stock_var,
        region = region_var,
        epu = c(epus_var, c("All", "all", "NE")),
        path = here::here(new_dir, "figures//"),
        save = save_var,
        remove_recent = remove_var,
        out = out
      ),
      output_dir = new_dir,
      intermediates_dir = new_dir,
      knit_root_dir = new_dir,
      output_format = bookdown::word_document2(),
      clean = TRUE,
      quiet = FALSE
    )
  }
  
  # clean up files
  list.files(here::here(new_dir),
             full.names = TRUE
  ) %>%
    stringr::str_subset(".Rmd") %>%
    file.remove()
  
  list.files(here::here(new_dir),
             full.names = TRUE
  ) %>%
    stringr::str_subset(".yml") %>%
    file.remove()
  
  setwd(starting_dir)
  
  print(paste("Done with", parent_folder, region_var, epus_var, stock_var, "!",
              sep = ": "
  ))
}

render_reg_report_word("Black sea bass", "MAB", "Mid", lag_var = 1, parent_folder = "lag1", input = "correlation_bookdown_template-dev")
