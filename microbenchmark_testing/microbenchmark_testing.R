dat1 <- risk_year_hist %>%
  dplyr::filter(Species == "Acadian redfish")

dat2 <- risk_species %>%
  dplyr::filter(Species == "Acadian redfish")

# two ways to parse data
microbenchmark::microbenchmark(plot_risk_by_stock(dat2, 
                                                  indicator = "recruitment", 
                                                  include_legend = "no"),
                               plot_risk_by_year(dat1, 
                                                 indicator = "recruitment",
                                                 title = "Change compared to historical",
                                                 include_legend = "no"),
                               times = 10)
# no difference from different data parsing method
# a lot faster than running these functions in a code chunk

# child doc vs not
microbenchmark::microbenchmark(rmarkdown::render(input = here::here("microbenchmark_testing", "child_doc.Rmd")),
                               rmarkdown::render(input = here::here("microbenchmark_testing", "test_child_doc.Rmd")),
                               times = 10)
# slightly faster to not use a child doc (~25%)

# rmd vs r
# WAY faster to do it in R
test_fxn <- function(){
  dat1 <- risk_year_hist %>%
    dplyr::filter(Species == "Acadian redfish")
  
  plot_risk_by_year(dat1, 
                    indicator = "recruitment",
                    title = "Change compared to historical",
                    include_legend = "no")
}

microbenchmark::microbenchmark(rmarkdown::render(input = here::here("microbenchmark_testing", "test_in_rmd.Rmd")),
                               test_fxn(),
                               times = 10)

# render in rmd vs create and read in image file vs read in image file only
# slightly faster to read in fig (~10%)
# slower to create outside of rmd and then read in

ggplot2::ggsave("test.png", path = here::here("microbenchmark_testing"))

test_fxn2 <- function(){
  dat1 <- risk_year_hist %>%
    dplyr::filter(Species == "Acadian redfish")
  
  plot_risk_by_year(dat1, 
                    indicator = "recruitment",
                    title = "Change compared to historical",
                    include_legend = "no")
  
  ggplot2::ggsave("test.png", path = here::here("microbenchmark_testing"))
  
  rmarkdown::render(input = here::here("microbenchmark_testing", "read_fig.Rmd"))
}

microbenchmark::microbenchmark(rmarkdown::render(input = here::here("microbenchmark_testing", "test_in_rmd.Rmd")),
                               rmarkdown::render(input = here::here("microbenchmark_testing", "read_fig.Rmd")),
                               test_fxn2(),
                               times = 10)

# test creating 3 figs vs reading in 3 figs
# reading figs is faster
microbenchmark::microbenchmark(rmarkdown::render(input = here::here("microbenchmark_testing", "test3_in_rmd.Rmd")),
                               rmarkdown::render(input = here::here("microbenchmark_testing", "read_3fig.Rmd")),
                               times = 10)

# checking if an object exists vs just reading it in
# faster to just read it in
fxn1 <- function(x){
  obj_name <- quote(x)
  boo <- exists(as.character(obj_name))
  return(boo)}
fxn2 <- function(x){x <- x
return(x)}
  
microbenchmark::microbenchmark(fxn1(allfh),
                               fxn2(allfh),
                               times = 10)

# reading in data vs exporting to 1 cluster
# reading in data is 4x slower than exporting to cluster
microbenchmark::microbenchmark(source(here::here("R/full_report_functions", "read_data.R")),
                               {# make cluster
                                 cl <- snow::makeCluster(1) # not the same as cores - can have more than 8??
                                 
                                 # export data to cluster
                                 snow::clusterExport(cl, list("survey_big", "asmt", "asmt_sum", "risk",
                                                              "latlong", "rec", "allfh", "cond", "com",
                                                              "swept", "risk_species", "risk_year_hist", 
                                                              "risk_year_value", "ricky_survey", "render_par"))
                                 
                                 # set up cluster
                                 snow::clusterEvalQ(cl, {
                                   # load libraries
                                   library(ggplot2)
                                   `%>%` <- dplyr::`%>%`
                                   
                                   # load shapefile
                                   shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
                                   
                                 }) %>% invisible()
                               },
                               times = 10)

# read in data to 1 cluster vs 7 clusters
# takes slightly less than 7x time to set up 7 clusters - ~5x time
# 26 s vs 133 s
c_fxn <- function(n){
  cl <- snow::makeCluster(n) # not the same as cores - can have more than 8??
  
  # export data to cluster
  snow::clusterExport(cl, list("survey_big", "asmt", "asmt_sum", "risk",
                               "latlong", "rec", "allfh", "cond", "com",
                               "swept", "risk_species", "risk_year_hist", 
                               "risk_year_value", "ricky_survey", "render_par"))
  
  # set up cluster
  snow::clusterEvalQ(cl, {
    # load libraries
    library(ggplot2)
    `%>%` <- dplyr::`%>%`
    
    # load shapefile
    shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
    
  }) %>% invisible()
  
  snow::stopCluster(cl)
}

microbenchmark::microbenchmark(c_fxn(1),
                               c_fxn(7),
                               times = 3)

# read in data to 1 cluster vs read & run (calculate time to run)
# additional ~100 s to run (126s vs 25s)
c_fxn2 <- function(n){
  cl <- snow::makeCluster(n) # not the same as cores - can have more than 8??
  
  # export data to cluster
  snow::clusterExport(cl, list("survey_big", "asmt", "asmt_sum", "risk",
                               "latlong", "rec", "allfh", "cond", "com",
                               "swept", "risk_species", "risk_year_hist", 
                               "risk_year_value", "ricky_survey", "render_par"))
  
  # set up cluster
  snow::clusterEvalQ(cl, {
    # load libraries
    library(ggplot2)
    `%>%` <- dplyr::`%>%`
    
    # load shapefile
    shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
    
  }) %>% invisible()
  
  # generate reports
  snow::clusterApply(cl, 
                     all_species[1],
                     fun = function(all_species) render_par(all_species, files = "index.Rmd", prev = FALSE))
  
  snow::stopCluster(cl)
}

microbenchmark::microbenchmark(c_fxn(1),
                               c_fxn2(1),
                               times = 3)

# time to set up 10 clusters - 213s
microbenchmark::microbenchmark(c_fxn(10),
                               times = 3)
