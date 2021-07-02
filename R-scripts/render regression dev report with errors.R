
`%>%` <- magrittr::`%>%`
output <- c()

species <- NEesp::regression_species_regions[1,]

# the dumb way to try to force through errors
error_analysis <- function(fchunk_name = chunk_name,
                           flast_known = last_known,
                           ftest = test){
  problem_file <- NEesp::find_files(
    paste0("\\{r", "(.{1,5})", fchunk_name),
    location
  ) %>% invisible()

  if (problem_file == "Not found") {
    problem_file2 <- NEesp::find_files(
      paste0("\\{r", "(.{1,5})", flast_known),
      location
    ) %>% invisible()

  } else {
    problem_file2 <- ""
  }
  
  this_output <- cat(
    toString(species[i,]), 
    "0lag", 
    ftest[1],
    fchunk_name,
    problem_file,
    problem_file2,
    sep = "\n"
  )
  
  return(this_output)
}

# the original way
error_analysis2 <- function(fchunk_name = chunk_name,
                           flast_known = last_known,
                           ftest = test){
  problem_file <- NEesp::find_files(
    paste0("\\{r", "(.{1,5})", fchunk_name),
    location
  ) %>% invisible()
  
  problem_file <- problem_file %>%
    tibble::as_tibble() 
  
  if (problem_file == "Not found") {
    problem_file2 <- NEesp::find_files(
      paste0("\\{r", "(.{1,5})", flast_known),
      location
    ) %>% invisible()
    
    problem_file2 <- problem_file2 %>%
      tibble::as_tibble()
    
    file_name <- problem_file2[, 1] %>%
      stringr::str_split("correlation_bookdown_template/", n = 2)
    file_name <- file_name[[1]][2]
    
    this_output <- c(
      i, "0lag", ftest[1],
      paste("unknown - last known file:", file_name),
      fchunk_name,
      paste("unknown - last known line:", problem_file2[,2])
    )
  } else {
    
    file_name <- problem_file[, 1] %>%
      stringr::str_split("correlation_bookdown_template/", n = 2)
    file_name <- file_name[[1]][2]
    
    this_output <- c(i, toString(ftest[1]), file_name, fchunk_name, problem_file[, 2],
                     recursive = TRUE)
  }
  return(this_output)
}

suppressWarnings({
  for (i in 1:nrow(species)) {
    
    sink("hide.txt")
    
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
      this_output <- error_analysis()
      #output <- rbind(output, this_output)
      output <- cat(output, this_output)
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
      this_output <- error_analysis()
      #output <- rbind(output, this_output)
      output <- cat(output, this_output)
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
      this_output <- error_analysis()
      #output <- rbind(output, this_output)
      output <- cat(output, this_output)
    }
    
    sink()
    print(this_output)
    print(output)
    print(paste("Done with", i))
  }

  if (class(output) == "NULL") {

    dir.create(here::here("logs"))
  
  } else {
    
    colnames(output) <- c("Species", "Report type", "Error", "File throwing error", "Chunk name", "Line throwing error")

    file <- paste0("logs/", Sys.time(), ".csv") %>%
      stringr::str_replace_all(":", ".")
    dir.create(here::here("logs"))
    
    write.csv(output, here::here(file), row.names = FALSE)
    
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
  }
})
