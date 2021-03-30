get_updated_files <- function(date){
  files <- dir() %>%
    file.info()
  
  modified <- files$atime %>%
    stringr::str_detect(date) 
    
  changed_files <- files[modified,] %>% 
    rownames() %>%
    stringr::str_subset(".Rmd") 
  
  changed_files <- changed_files %>%
    subset(stringr::str_detect(changed_files, "_") == FALSE) # no underscores in files to be used!
  
  # put index first and order other files
  index <- which(changed_files == "index.Rmd")
  changed_files <- c("index.Rmd", 
                     stringr::str_sort(changed_files[-index]))
  
  return(changed_files)

}

create_yaml <- function(new_only, date){
  
  files <- get_updated_files(date)
  
  if(new_only == TRUE){
  yml_info <- ymlthis::yml_bookdown_opts(ymlthis::yml_empty(),
                                         book_filename = "bookdown-test",
                                         rmd_files = files,
                                         delete_merged_file = TRUE)
  } else {yml_info <- ymlthis::yml_bookdown_opts(ymlthis::yml_empty(),
                                                 book_filename = "bookdown-test",
                                                 delete_merged_file = TRUE)}
  yaml::write_yaml(yml_info, file = "_bookdown.yml")
}

#get_updated_files("2021-01-27")
#create_yaml(new_only = FALSE, date = "2021-01-27")
