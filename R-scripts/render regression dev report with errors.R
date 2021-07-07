
`%>%` <- magrittr::`%>%`
output <- c()

suppressWarnings({
  for (i in 1:nrow(species)) {
    
#    sink("hide.txt")
    
    location <- system.file("correlation_bookdown_template", package = "NEesp")
    x <- "package"
    
    # make 0 lag reports
    test <- try(NEesp::render_reg_report(
      stock_var = species[i, 1],
      epus_var = species[i, 3],
      region_var = species[i, 2],
      lag_var = 0,
      remove_var = FALSE,
      save_var = TRUE,
      input = x,
      parent_folder = "zero_lag",
      trouble = FALSE
    ))

   if (class(test) == "try-error") {
    print("ERROR ANALYSIS")
    print(test)
    print(chunk_name)
    print(last_known)
    }
    
    # make 1 lag reports
    test <- try(NEesp::render_reg_report(
      stock_var = species[i, 1],
      epus_var = species[i, 3],
      region_var = species[i, 2],
      lag_var = 1,
      remove_var = FALSE,
      save_var = TRUE,
      input = x,
      parent_folder = "one_year_lag",
      trouble = FALSE
    ))
    
    if (class(test) == "try-error") {
      print("ERROR ANALYSIS")
      print(test)
      print(chunk_name)
      print(last_known)
    }
    
    # make 1 lag remove reports
    test <- try(NEesp::render_reg_report(
      stock_var = species[i, 1],
      epus_var = species[i, 3],
      region_var = species[i, 2],
      lag_var = 1,
      remove_var = TRUE,
      save_var = TRUE,
      input = x,
      parent_folder = "one_year_lag_remove_recent",
      trouble = FALSE
    ))
    
    if (class(test) == "try-error") {
      print("ERROR ANALYSIS")
      print(test)
      print(chunk_name)
      print(last_known)
    }
    
#    sink()

    print(paste("Done with", 
                paste(NEesp::regression_species_regions[i,], collapse = " ")
                ))
  }

    # clean up .Rmd and .yml files that didn't render
    files_to_remove <- c(list.files(here::here("Regressions"), 
                                    pattern = "\\.Rmd$",
                                    recursive = TRUE,
                                    full.names = TRUE),
                         list.files(here::here("Regressions"), 
                                    pattern = "\\.yml$",
                                    recursive = TRUE,
                                    full.names = TRUE))
    file.remove(files_to_remove)
  })
