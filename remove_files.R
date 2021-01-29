
# all content

files <- list.files()
keep <- which(files == "docs")
remove <- files[-keep]

# do NOT run this code locally!!! for github actions only!
#file.remove(remove)
#unlink(remove, recursive = TRUE)

usethis::use_build_ignore(remove, escape = TRUE)
