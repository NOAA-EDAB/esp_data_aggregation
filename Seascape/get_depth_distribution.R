# unique(survdata.w.codes$common_name) run this from depthdistrbution.rmd to get species contained in the pull of survdat
fishlist<-c(
 "haddock",                 "yellowtail flounder" ,    "Atlantic cod"  ,          "red hake"    ,            "pollock"     ,           
 "scup",                    "alewife"      ,           "silver hake"     ,        "Atlantic mackerel"  ,     "Acadian redfish"    ,    
 "winter flounder",         "summer flounder" ,        "American plaice"   ,      "witch flounder"   ,       "butterfish"        ,     
 "white hake",              "blueback herring"  ,      "black sea bass"   ,       "bluefish"    ,            "Atlantic herring"     ,  
 "ocean pout",              "monkfish"         ,       "little skate"   ,         "winter skate" ,           "windowpane flounder"   , 
 "thorny skate",            "Atlantic wolffish" ,      "cusk"      ,              "Atlantic halibut" ,       "clearnose skate"   ,     
 "smooth skate",            "offshore hake" ,          "rosette skate"  ,         "barndoor skate" ,         "spiny dogfish"  ,        
 "American lobster",       "smooth dogfish",          "Atlantic menhaden" ,      "longfin inshore squid" ,  "Atlantic hagfish"  ,     
 "northern shortfin squid")
library("here")

list_species <- split(fishlist, f = list(fishlist))

purrr::map(list_species, ~rmarkdown::render(here::here("Seascape", "depth_distribution.Rmd"), 
                                            params = list(stock = .x), 
                                            output_dir = here::here("docs","Seascape"),
                                            output_file = paste(.x, "_depth", 
                                                                ".html", sep = "")))
