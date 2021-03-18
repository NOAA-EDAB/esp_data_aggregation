## palette for diet ----

# get prey categories
load(here::here("data", "allfh.RData"))
all_diet <- allfh %>% dplyr::filter(pyamtw > 0)
prey <- all_diet$gensci %>%
  unique() %>%
  stringr::str_sort()

# create colors
mycolors2 <-  grDevices::colorRampPalette(
  nmfspalette::nmfs_palette("regional web")(6))(length(prey))
scales::show_col(mycolors2)

# make palette
prey_palette <- data.frame(prey_id = prey,
                           color = mycolors2)

# view palette (with category names)
barplot(names.arg = prey_palette$prey_id,
        height = rep(1, length(prey_palette$prey_id)), 
        col = prey_palette$color,
        las = 2,
        cex.names = 0.5)

# save palette
write.csv(prey_palette, here::here("data", "prey_color_palette.csv"))


## palette for rec catch ----

# get catch modes
rec <- read.csv(here::here("data/MRIP", "all_MRIP_catch_year.csv")) %>%
  dplyr::filter(sub_reg_f == "NORTH ATLANTIC")
rec_mode <- unique(rec$mode_fx_f)

# create colors
mycolors2 <-  nmfspalette::nmfs_palette("regional web")(4)
scales::show_col(mycolors2)

# make palette
rec_palette <- data.frame(rec_mode = rec_mode,
                           color = nmfspalette::nmfs_palette("regional web")(5))

# save palette
write.csv(rec_palette, here::here("data", "rec_color_palette.csv"))

## palette for com catch ----

# get catch modes
com <- read.csv(here::here("data", "com_landings_clean_20201222.csv"))
states <- unique(com$State)

# create colors
mycolors2 <-  grDevices::colorRampPalette(
  nmfspalette::nmfs_palette("regional web")(6))(length(states))
scales::show_col(mycolors2)

# make palette
com_palette <- data.frame(state_id = states,
                           color = sample(mycolors2))

# save palette
write.csv(com_palette, here::here("data", "com_color_palette.csv"))

