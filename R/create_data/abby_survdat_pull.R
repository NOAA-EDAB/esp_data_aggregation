
channel <- dbutils::connect_to_database(server = "sole",
                                        uid = "atyrell")

odbc::odbcListDrivers()

pull <- survdat::get_survdat_data(channel,
                          all.season = TRUE,
                          bio = TRUE)

saveRDS(pull, here::here("data", "survdat_122920.RDS"))

pull <- readRDS(here::here("data", "survdat_122920.RDS"))

pull$survdat %>% head
pull$survdat %>% nrow
pull$survdat %>% tail

survey <- readRDS(here::here("data", "survey_data.RDS"))
survey <- survey[-which(survey$Species == "Jonah crab" & survey$LENGTH >= 99.9), ] # remove error jonah crab

survey %>% head
survey %>% tail

pull$survdat$INDID %>% unique %>% length
pull$survdat$INDID %>% length

survey$fish_id %>% unique %>% length
survey$fish_id %>% length

test <- survey_big %>%
  dplyr::filter(Species == "Haddock")

test %>% 
  get_len_data() %>%
  plot_len()
