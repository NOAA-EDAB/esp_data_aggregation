`%>%` <- dplyr::`%>%`
library(ggplot2)

load(here::here("data", "allfh.RData"))

class(allfh)
head(allfh)

colnames(allfh)

data <- allfh %>% dplyr::select(pdcomnam, svspp, gensci, pyamtw, year, season)
head(data)
 
test <- data %>% dplyr::filter(svspp == 72 & pyamtw > 0)

normalized <- test %>%
  dplyr::group_by(year, season, gensci) %>%
  dplyr::summarise(total_weight = sum(pyamtw)) %>%
  dplyr::mutate(proportion = total_weight/sum(total_weight)) 
normalized

normalized$gensci <- stringr::str_replace(normalized$gensci, " ", "_")

# group low abundance prey as "other"
groups <- normalized %>% dplyr::group_by(year, season, gensci) %>%
  dplyr::summarise(max_prop = max(proportion)) %>%
  dplyr::filter(max_prop > 0.05)

groups <- groups$gensci %>% unique()

rows <- match(normalized$gensci, groups) %>%
  is.na() %>% which()

normalized[rows,"gensci"] <- "OTHER"

# re-group proportions with new "other" category
normalized <- normalized %>% dplyr::group_by(year, season, gensci) %>%
  dplyr::summarise(prop2 = sum(proportion))

# add in zeros
combo <- expand.grid(year = unique(normalized$year),
                     season = unique(normalized$season),
                     gensci = unique(normalized$gensci))

new_normalized <- dplyr::full_join(normalized, combo, 
                            by = c("year" = "year",
                                   "season" = "season",
                                   "gensci" = "gensci")) %>%
  dplyr::mutate(prop2 = ifelse(is.na(prop2), 0, prop2))

# get order of most important - least important prey
prey <- new_normalized %>% dplyr::group_by(gensci) %>%
  dplyr::summarise(imp = max(prop2)) %>%
  dplyr::arrange(dplyr::desc(imp))

new_normalized$gensci <- factor(new_normalized$gensci, 
                            prey$gensci)

# plot
ggplot(new_normalized,
       aes(x = year,
           y = prop2,
           fill = gensci))+
  geom_area()+
  facet_grid(rows = vars(season))+
  scale_fill_brewer(type = "qual", palette = 7)+
  theme_classic()

# summary table
table <- new_normalized %>% dplyr::group_by(gensci, season, year) %>%
  dplyr::filter(sum(prop2) > 0) %>%
  dplyr::group_by(gensci, season) %>%
  dplyr::summarise(mean_proportion = paste(mean(prop2) %>% round(digits = 3), 
                                           " ± ",
                                           sd(prop2) %>% round(digits = 3),
                                           " (", length(prop2), ") ", 
                                           sep = ""),
                   
                   range_proportion = paste(min(prop2) %>% round(digits = 3),
                                            max(prop2) %>% round(digits = 3),
                                            sep = " - "))
knitr::kable(table, 
             col.names = c("Prey category", "Season", 
                           "Mean proportion ± SD (n years)", 
                           "Range"))




get_diet <- function(species, data){
  
  data <- data %>% dplyr::filter(pdcomnam == stringr::str_to_upper(species) & pyamtw >= 0)
  
  normalized <- data %>%
    dplyr::group_by(year, season, gensci) %>%
    dplyr::summarise(total_weight = sum(pyamtw)) %>%
    dplyr::mutate(proportion = total_weight/sum(total_weight)) 

  normalized$gensci <- stringr::str_replace(normalized$gensci, " ", "_")
  
  # group low abundance prey as "other"
  groups <- normalized %>% dplyr::group_by(year, season, gensci) %>%
    dplyr::summarise(max_prop = max(proportion)) %>%
    dplyr::filter(max_prop > 0.05)
  
  groups <- groups$gensci %>% unique()
  
  rows <- match(normalized$gensci, groups) %>%
    is.na() %>% which()
  
  normalized[rows,"gensci"] <- "OTHER"
  
  # re-group proportions with new "other" category
  normalized <- normalized %>% dplyr::group_by(year, season, gensci) %>%
    dplyr::summarise(prop2 = sum(proportion))
  
  # add in zeros
  combo <- expand.grid(year = unique(normalized$year),
                       season = unique(normalized$season),
                       gensci = unique(normalized$gensci))
  
  new_normalized <- dplyr::full_join(normalized, combo, 
                                     by = c("year" = "year",
                                            "season" = "season",
                                            "gensci" = "gensci")) %>%
    dplyr::mutate(prop2 = ifelse(is.na(prop2), 0, prop2))
  
  # get order of most important - least important prey
  prey <- new_normalized %>% dplyr::group_by(gensci) %>%
    dplyr::summarise(imp = max(prop2)) %>%
    dplyr::arrange(dplyr::desc(imp))
  
  new_normalized$gensci <- factor(new_normalized$gensci, 
                                  prey$gensci)
  
  # plot
  fig <- ggplot(new_normalized,
         aes(x = year,
             y = prop2,
             fill = gensci))+
    geom_area()+
    facet_grid(rows = vars(season))+
    scale_fill_brewer(type = "qual", palette = 7)+
    theme_classic()
  
  # summary table
  table <- new_normalized %>% dplyr::group_by(gensci, season, year) %>%
    dplyr::filter(sum(prop2) > 0) %>%
    dplyr::group_by(gensci, season) %>%
    dplyr::summarise(mean_proportion = paste(mean(prop2) %>% round(digits = 3), 
                                             " ± ",
                                             sd(prop2) %>% round(digits = 3),
                                             " (", length(prop2), ") ", 
                                             sep = ""),
                     
                     range_proportion = paste(min(prop2) %>% round(digits = 3),
                                              max(prop2) %>% round(digits = 3),
                                              sep = " - "))
  table_out <- knitr::kable(table, 
               col.names = c("Prey category", "Season", 
                             "Mean proportion ± SD (n years)", 
                             "Range"))
  
  # outputs
  return(fig)
  return(table_out)
}
get_diet(species = "Silver hake", data = allfh)

