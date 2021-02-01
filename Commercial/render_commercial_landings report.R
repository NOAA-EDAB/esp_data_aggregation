

all_species<-c(        "smooth dogfish",          "spiny dogfish",           "barndoor skate",          "winter skate",           
"clearnose skate",           "little skate",            "smooth skate",            "thorny skate",           
"atlantic herring",       "alewife",                 "blueback herring",        "offshore hake" ,          "silver hake",            
"atlantic cod",            "haddock",                 "pollock",                 "white hake",              "red hake",               
"cusk",                    "atlantic halibut",        "american plaice",         "summer flounder",         "yellowtail flounder",    
"winter flounder",         "witch flounder",          "atlantic mackerel",       "butterfish",              "bluefish",               
"black sea bass",          "scup",                   "acadian redfish",        "atlantic wolffish",       "ocean pout",             
 "monkfish",                "american lobster" ,       "northern shrimp",         "northern shortfin squid", "longfin inshore squid",  
 "atlantic menhaden",       "windowpane flounder"  )

#"rosette skate" is removed as it does not contain any records 

library("here")

all_species<-stringr::str_sort(all_species)


list_species <- split(all_species, f = list(all_species))

purrr::map(list_species, ~rmarkdown::render(here::here("Commercial", "Commercial_landings_1950_2019.Rmd"), 
                                            params = list(stock = .x), 
                                            output_dir = here::here("docs","Commercial landings"),
                                            output_file = paste(.x, "_landings", 
                                                                ".html", sep = "")))

