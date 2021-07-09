
filename <- paste0("logs/lint-output-", 
                   Sys.time() %>% 
                     stringr::str_replace_all(":", "."), 
                   ".csv")
file.create(filename)

test <- lintr::with_defaults(line_length_linter = NULL,
                             object_name_linter = NULL)
results <- lintr::lint_dir("bookdown", 
                           pattern = ".Rmd", 
                           linters = test)

write.csv(results, file = filename, row.names = FALSE)

