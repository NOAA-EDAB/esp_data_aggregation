test_rmds <- function(species, test_type) {

  `%>%` <- magrittr::`%>%`
  
  dir_name <- "TEST"
  
  this_dir <- here::here(dir_name)
  dir.create(this_dir)
  
  file.copy(from = list.files(here::here("bookdown"), pattern = "index.Rmd", full.names = TRUE),
            to = this_dir, overwrite = TRUE)
  
    params_list <- list(
      species_ID = species,
      path = "figures//",
      ricky_survey_data = NEesp::bio_survey,
      save = FALSE,
      file = "html"
    )
    
    setwd(this_dir)
    files <- list.files(here::here("bookdown"), pattern = ".Rmd", full.names = TRUE) %>%
      stringr::str_subset("index.Rmd", negate = TRUE)  %>%
      stringr::str_subset("/_", negate = TRUE)

    problem_files <- c()
    last_known_chunk <- c()
    error <- c()
    
    for(i in files){
      
      file.copy(from = i, to = this_dir, overwrite = TRUE)
      
      name <- i %>%
        stringr::str_remove(".Rmd") %>%
        stringr::str_replace("bookdown", dir_name) %>%
        paste(".html", sep = "")
      
      test <- try(bookdown::render_book(
    #    preview = TRUE,
        input = c("index.Rmd", i),
        params = params_list,
        output_format = bookdown::html_document2(),
        envir = new.env(),
        output_file = name,
        output_dir = this_dir,
        intermediates_dir = this_dir,
        knit_root_dir = this_dir,
        clean = TRUE,
        quiet = TRUE
      ))
      
      short <- i %>%
        stringr::str_remove("^.{1,}bookdown/")
      
      if(class(test) == "try-error"){
        problem_files <- c(problem_files, short)
        last_known_chunk <- c(last_known_chunk, last_known)

        error <- c(error, test)

        file.remove("_main.Rmd")
      }
      
      file.remove(i %>% stringr::str_replace("bookdown", dir_name))
      
      print(paste("Tested", short))
    }
    
    if(length(problem_files) > 0){

      filename <- paste0("logs/", test_type, Sys.time(), ".csv") %>%
        stringr::str_replace_all(":", ".")
      data <- cbind(problem_files, last_known_chunk, error)
      write.csv(data, file = here::here(filename))
    }
    
    setwd(here::here())
}

test_rmds(species = "NO SPECIES - TEST", test_type = "cant-handle-missing-data-")
test_rmds(species = "Black sea bass", test_type = "cant-run-alone-")
