
`%>%` <- magrittr::`%>%`
output <- c()

suppressWarnings({
  for (i in species) {
    
    sink("hide.txt")
    test <- try(NEesp::render_ind_report(i,
      input = here::here("bookdown"),
      params_to_use = list(
        species_ID = i,
        ricky_survey_data = NEesp::bio_survey,
        path = here::here("action_reports", i, "figures//"),
        save = TRUE
      ), trouble = FALSE
    ))

    if (class(test) == "try-error") {
      problem_file <- NEesp::find_files(
        paste0("\\{r", "(.{1,5})", chunk_name),
        here::here("bookdown")
      ) %>% invisible()

      problem_file <- problem_file %>%
        tibble::as_tibble() %>%
        dplyr::filter(stringr::str_detect(file, "not-used", negate = TRUE))

      if (problem_file == "Not found") {
        problem_file2 <- NEesp::find_files(
          paste0("\\{r", "(.{1,5})", last_known),
          here::here("bookdown")
        ) %>% invisible()

        problem_file2 <- problem_file2 %>%
          tibble::as_tibble() %>%
          dplyr::filter(stringr::str_detect(file, "not-used", negate = TRUE))

        file_name <- problem_file2[, 1] %>%
          stringr::str_split("bookdown/", n = 2)
        file_name <- file_name[[1]][2]

        this_output <- c(
          i, test[1],
          paste("unknown - last known file:", file_name),
          chunk_name,
          paste("unknown - last known line:", problem_file2[2])
        )
      } else {
        
        file_name <- problem_file[, 1] %>%
          stringr::str_split("bookdown/", n = 2)
        file_name <- file_name[[1]][2]

        this_output <- c(i, toString(test[1]), file_name, chunk_name, problem_file[, 2],
                         recursive = TRUE)
      }
      output <- rbind(output, this_output)
    }
    sink()
    print(paste("Done with", i))
  }

  if (class(output) == "NULL") {

    dir.create(here::here("logs"))
  
  } else {
    
    colnames(output) <- c("Species", "Error", "File throwing error", "Chunk name", "Line throwing error")

    file <- paste0("logs/", Sys.time(), ".csv") %>%
      stringr::str_replace_all(":", ".")
    dir.create(here::here("logs"))
    
    write.csv(output, here::here(file), row.names = FALSE)
    
    # clean up .Rmd and .yml files that didn't render
    files_to_remove <- c(list.files(here::here("action_reports"), 
                                    pattern = "\\.Rmd$",
                                    recursive = TRUE,
                                    full.names = TRUE),
                         list.files(here::here("action_reports"), 
                                    pattern = "\\.yml$",
                                    recursive = TRUE,
                                    full.names = TRUE))
    file.remove(files_to_remove)
  }
})
