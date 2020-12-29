



all_species<-c("smooth dogfish","spiny dogfish", "barndoor skate", "winter skate",  "clearnose skate","rosette skate",      "little skate",        "smooth skate",        "thorny skate",        "atlantic herring",   
"alewife", "blueback herring",    "silver hake",  "atlantic cod",       "haddock", "pollock",   "white hake",  "red hake", "cusk",  "atlantic halibut", "american plaice", "summer flounder", "yellowtail flounder", "winter flounder",     "atlantic mackerel",  
"butterfish", "bluefish", "black sea bass", "scup",  "acadian redfish", "atlantic wolffish", "ocean pout",   "atlantic menhaden",  "windowpane flounder")

list_species <- split(all_species, f = list(all_species))

purrr::map(list_species, ~rmarkdown::render(here::here("Recreational", "recreational_landings_1950_2019.Rmd"), 
                                               params = list(stock = .x), 
                                               output_dir = here::here("docs","Recreational landings"),
                                               output_file = paste(.x, "_landings", 
                                                                   ".html", sep = "")))

