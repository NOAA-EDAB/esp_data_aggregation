
# all content

files <- list.files()
keep <- which(files == "docs")
remove <- files[-keep]

file.remove(remove)
unlink(remove, recursive = TRUE)

warnings()