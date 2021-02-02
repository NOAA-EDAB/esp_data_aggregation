# these packages have to be installed for other packages to get installed
install.packages(c("remotes", "ggplot2", "nlstools"))

# install github packages
remotes::install_github("NOAA-EDAB/assessmentdata")

remotes::install_github("NOAA-EDAB/ecodata")

remotes::install_github("ropensci/rnaturalearthhires")

remotes::install_github("ropensci/rnaturalearth")

remotes::install_github("nmfs-general-modeling-tools/nmfspalette")

# load all packages
renv::restore(lockfile = here::here("bookdown", "renv.lock"))

install.packages("parallel")