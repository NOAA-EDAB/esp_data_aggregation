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


