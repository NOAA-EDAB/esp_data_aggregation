# these packages have to be installed for other packages to get installed
#install.packages(c("remotes", "ggplot2", "nlstools", "rgeos", "viridis", "ggthemes", "here"))

install.packages("devtools",
                 dependencies = TRUE)
devtools::install_deps()

# install github packages
remotes::install_github("NOAA-EDAB/assessmentdata")

remotes::install_github("NOAA-EDAB/ecodata")

remotes::install_github("ropensci/rnaturalearthhires")

remotes::install_github("ropensci/rnaturalearth")

remotes::install_github("nmfs-general-modeling-tools/nmfspalette")

# load all packages
#renv::restore(lockfile = here::here("bookdown", "renv.lock"))

#install.packages("parallel")

#my_packages <- library()$results[,1]
#my_packages <- paste(my_packages, cat = ", ")
#usethis::use_description(fields = list(Suggests = my_packages),
#                         check_name = FALSE)
