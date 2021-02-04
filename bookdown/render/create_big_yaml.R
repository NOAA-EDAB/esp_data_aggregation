`%>%` <- dplyr::`%>%`

yaml <- readLines(here::here(".github/workflows", "test_report.yaml"))

all_yamls <- c()
for(i in 1:length(all_species)){
  new_yaml <- yaml[-c(1:7)] %>%
    stringr::str_replace("build1", paste("build", i, sep = "")) %>%
    stringr::str_replace("species: '1'", paste("species: ", i, sep = ""))
  all_yamls <- c(all_yamls, new_yaml)
}
all_yamls <- c(yaml[1:7], all_yamls)

all_yamls %>%
 ymlthis::use_yml_file(path = here::here(".github/workflows/big_yaml.yaml"))

