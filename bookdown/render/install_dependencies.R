# these packages have to be installed for other packages to get installed
# install.packages(c("remotes", "ggplot2", "nlstools", "rgeos", "viridis", "ggthemes", "here"))

install.packages("devtools")
devtools::install_deps(dependencies = TRUE)

# install github packages
# packages that have to come from github:
remotes::install_github("NOAA-EDAB/assessmentdata")
remotes::install_github("NOAA-EDAB/ecodata")
remotes::install_github("NOAA-EDAB/survdat")
remotes::install_github("andybeet/dbutils")
remotes::install_github("ropensci/rnaturalearthhires")
remotes::install_github("nmfs-general-modeling-tools/nmfspalette")
remotes::install_github("kaskr/TMB_contrib_R/TMBhelper")
remotes::install_github("James-Thorson/utilities")
remotes::install_github("James-Thorson-NOAA/FishLife")

# remotes::install_github("ropensci/rnaturalearth")

# load all packages
# renv::restore(lockfile = here::here("bookdown", "renv.lock"))

# install.packages("parallel")

# my_packages <- library()$results[,1]

# write.csv(my_packages, here::here("packages_to_install.csv"))
# my_packages <- paste(my_packages, cat = ", ")
# usethis::use_description(fields = list(Suggests = my_packages),
#                         check_name = FALSE)
