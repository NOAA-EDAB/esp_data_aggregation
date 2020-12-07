`%>%` <- dplyr::`%>%`
library(ggplot2)

get_diet <- function(data){
  
  normalized <- data %>%
    dplyr::filter(pyamtw > 0) %>%
    
    # only look at season/year combinations with >20 predator samples
    dplyr::group_by(year, season) %>%
    dplyr::mutate(n_predators = length(unique(pdid))) 
  
    if(max(normalized$n_predators) > 20){
      normalized <- normalized %>%
        dplyr::filter(n_predators > 20) %>%
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
      combo <- expand.grid(year = min(normalized$year):max(normalized$year),
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
      
      # assign colors based on nmfs color palette
      
      colors <- read.csv(here::here("data", "prey_color_palette.csv"))
      
      plot_colors <- colors$color
      names(plot_colors) <- colors$prey_id

      # plot
      fig <- ggplot(new_normalized,
                    aes(x = year,
                        y = prop2,
                        fill = gensci))+
        geom_bar(color = "black", stat = "identity")+
        scale_fill_manual(name = "Prey \ncategory",
                          values = plot_colors)+
        theme_classic()+
        ylab("Proportion of gut content")
      
      if(length(unique(new_normalized$season)) > 1){
        fig <- fig + facet_grid(rows = vars(season))
      }
      
      # summary table
      table <- new_normalized %>% dplyr::group_by(gensci, season, year) %>%
        dplyr::filter(sum(prop2) > 0) %>%
        dplyr::group_by(gensci, season) %>%
        dplyr::summarise(mean_proportion = paste(mean(prop2) %>% round(digits = 3), 
                                                 " +- ",
                                                 sd(prop2) %>% round(digits = 3),
                                                 " (", length(prop2), ") ", 
                                                 sep = ""),
                         
                         range_proportion = paste(min(prop2) %>% round(digits = 3),
                                                  max(prop2) %>% round(digits = 3),
                                                  sep = " - "))
      
      print(fig)
      return(knitr::kable(table, 
                          col.names = c("Prey category", "Season", 
                                        "Mean proportion +- SD (n years)", 
                                        "Range")))

  } else print("NOT ENOUGH DATA")
}