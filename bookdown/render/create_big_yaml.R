`%>%` <- dplyr::`%>%`

yaml <- readLines(here::here(".github/workflows", "building_block.yaml"))

all_yamls <- c()
for (i in 1:37) {
  new_yaml <- yaml %>%
    stringr::str_replace("build1", paste("build", i, sep = "")) %>%
    stringr::str_replace("REPLACE", i %>% as.character())
  all_yamls <- c(all_yamls, new_yaml)
}

write.table(all_yamls,
  file = here::here(".github/workflows/test.txt"),
  quote = FALSE,
  row.names = FALSE
)
# add header, copy file text and add on github web
# personal access token issue with pushing from local
