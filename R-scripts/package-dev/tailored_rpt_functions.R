
#' Plot stock-time, indicator-time, and stock-indicator correlations
#'
#' This function plots stock-time, indicator-time, and stock-indicator correlations.
#' 
#' @param data A data frame containing stock and indicator time series. Data from a spreadsheet outputted by a `NEespShiny` or `NEesp` regression report. Must pre-process with `NEesp::prep_data`, or do your own pre-processing.
#' @param title Optional. Title for the suite of plots. Defaults to blank.
#' @param lag The number of years by which the stock-indicator correlation was lagged. Required to correct the stock time series. Defaults to 0.
#' @param species The species name to add to plots. Defaults to "species".
#' @return 3 ggplots arranged with `ggpubr::ggarrange`
#' @importFrom magrittr %>%
#' @export

plot_corr_only <- function(data, title = "", lag = 0, species = "species") {
  if (nrow(data) > 0) {
    dir.create("figures")
    
    my_colors <- c("black", "#B2292E")
    names(my_colors) <- c("FALSE", "TRUE")
    
    data$sig <- factor(data$sig, levels = c("TRUE", "FALSE"))
    
    fig <- ggplot2::ggplot(data, ggplot2::aes(
      x = Val,
      y = Value
    )) +
      ggplot2::geom_path(ggplot2::aes(color = Time)) +
      ggplot2::geom_point(ggplot2::aes(color = Time)) +
      viridis::scale_color_viridis(
        breaks = scales::breaks_extended(n = 4),
        name = "Year",
        guide = ggplot2::guide_colorbar(order = 2)
      ) +
      ggnewscale::new_scale_color() +
      ggplot2::stat_smooth(ggplot2::aes(color = sig),
                           method = "lm"
      ) +
      ggplot2::scale_color_manual(
        values = my_colors,
        name = "Statistically significant\n(p < 0.05)",
        drop = FALSE,
        guide = ggplot2::guide_legend(order = 1)
      ) +
      ggplot2::scale_y_continuous(labels = scales::comma) +
      ggplot2::scale_x_continuous(labels = scales::comma) +
      ggplot2::theme_bw() +
      ggplot2::labs(title = paste("Correlation between", species, "and indicator")) +
      ggplot2::ylab(unique(data$Metric[!is.na(data$Metric)])) +
      ggplot2::xlab(unique(data$Var))
    
    # test if bsb is sig over time - overwrite sig
    dat <- data %>%
      dplyr::select(Value, Time) %>%
      dplyr::distinct() %>%
      dplyr::mutate(Time = Time + lag)
    model <- lm(Value ~ Time, data = dat)
    pval <- summary(model)$coefficients[2, 4]
    data$sig <- (pval < 0.05)
    
    bsb_fig <- ggplot2::ggplot(
      data,
      ggplot2::aes(
        x = Time + lag,
        y = Value
      )
    ) +
      ggplot2::geom_path(ggplot2::aes(color = Time)) +
      ggplot2::geom_point(ggplot2::aes(color = Time)) +
      viridis::scale_color_viridis(
        breaks = scales::breaks_extended(n = 4),
        name = "Year"
      ) +
      ggnewscale::new_scale_color() +
      ggplot2::stat_smooth(ggplot2::aes(color = sig),
                           method = "lm"
      ) +
      ggplot2::scale_color_manual(
        values = my_colors,
        name = "Statistically significant\n(p < 0.05)",
        drop = FALSE
      ) +
      ggplot2::scale_y_continuous(labels = scales::comma) +
      ggplot2::theme_bw() +
      ggplot2::labs(title = stringr::str_to_sentence(species)) +
      ggplot2::xlab("Year") +
      ggplot2::ylab(unique(data$Metric[!is.na(data$Metric)]))
    
    # test if indicator is sig over time - overwrite sig
    dat <- data %>%
      dplyr::select(Val, Time) %>%
      dplyr::distinct()
    model <- lm(Val ~ Time, data = dat)
    pval <- summary(model)$coefficients[2, 4]
    data$sig <- (pval < 0.05)
    
    # reformat Var for y-label
    data$Var <- data$Var %>%
      stringr::str_replace("\n", " ") %>%
      stringr::str_wrap(width = 30)
    
    ind_fig <- ggplot2::ggplot(
      data,
      ggplot2::aes(
        x = Time,
        y = Val
      )
    ) +
      ggplot2::geom_path(ggplot2::aes(color = Time)) +
      ggplot2::geom_point(ggplot2::aes(color = Time)) +
      viridis::scale_color_viridis(
        breaks = scales::breaks_extended(n = 4),
        name = "Year"
      ) +
      ggnewscale::new_scale_color() +
      ggplot2::stat_smooth(ggplot2::aes(color = sig),
                           method = "lm"
      ) +
      ggplot2::scale_color_manual(
        values = my_colors,
        name = "Statistically significant\n(p < 0.05)",
        drop = FALSE
      ) +
      ggplot2::scale_y_continuous(labels = scales::comma) +
      ggplot2::theme_bw() +
      ggplot2::labs(title = "Indicator") +
      ggplot2::xlab("Year") +
      ggplot2::ylab(unique(data$Var))
    
    # version with summary table
    # tbl <- ggpubr::ggtexttable(tab_data, theme = ggpubr::ttheme("blank"), rows = NULL)  %>%
    #  ggpubr::tbody_add_border() %>%
    #  ggpubr::thead_add_border()
    
    # big_fig <- ggpubr::ggarrange(
    #  ggpubr::ggarrange(bsb_fig, ind_fig, tbl,
    #    ncol = 3,
    #    legend = "none",
    #    labels = c("A", "B", "C")
    #  ),
    #  fig,
    #  labels = c(NA, "D"),
    #  common.legend = TRUE,
    #  legend = "top",
    #  nrow = 2
    # )
    
    big_fig <- ggpubr::ggarrange(
      ggpubr::ggarrange(bsb_fig, ind_fig,
                        ncol = 2,
                        legend = "none",
                        labels = c("A", "B")
      ),
      fig,
      labels = c(NA, "C"),
      common.legend = TRUE,
      legend = "top",
      nrow = 2
    )
    
    big_fig <- big_fig +
      ggplot2::theme(
        plot.background = ggplot2::element_rect(color = "black", size = 1),
        plot.margin = ggplot2::unit(c(0.1, 0.1, 0.1, 0.1), "cm")
      )
    
    # save
    file <- paste("figures/",
                  unique(data$Metric)[!is.na(unique(data$Metric))],
                  "_",
                  unique(data$Var),
                  ".png",
                  sep = ""
    ) %>%
      stringr::str_replace_all(" ", "_") %>%
      stringr::str_replace_all("\n", "_")
    
    ggplot2::ggsave(
      filename = file,
      width = 6.5,
      height = 6.5,
      units = "in",
      device = "png"
    )
    
    return(big_fig)
  }
  else {
    print("No data under conditions selected")
  }
}

#' Prepare data for plotting with `plot_corr_only`
#'
#' This function prepares data for plotting with `plot_corr_only`.
#' 
#' @param data A data frame containing stock and indicator time series. Data from a spreadsheet outputted by a `NEespShiny` or `NEesp` regression report. 
#' @param metric The stock assessment metric to assess - c("Recruitmetn", "Abundance", "Catch", "Fmort")
#' @param pattern Optional. A pattern to detect in the `Var` row, for example if you do not want to plot all levels of `Var`. Can be a vector.
#' @param remove Optional. If the pattern should be removed (`TRUE`) or retained (`FALSE`). Can be a vector.
#' @return A tibble
#' @importFrom magrittr %>%
#' @export

prep_data <- function(data, 
                      metric = "Recruitment",
                      pattern = NULL,
                      remove = NULL) {
  data <- data %>%
    read.csv() %>%
    dplyr::filter(
      Metric == metric | is.na(Metric)) %>%
    dplyr::mutate(Var = Var %>% stringr::str_replace_all("\n", " "))
  
  if(length(pattern) > 0){
    for(i in 1:length(pattern)){
      data <- data %>%
        dplyr::filter(stringr::str_detect(Var, pattern[i], negate = remove[i]))
    }
  }

  data <- data %>%
    dplyr::mutate(Var = Var %>% stringr::str_wrap(40)) %>%
    dplyr::arrange(Time)
  
  return(data)
}

#' Create an indicator report card
#'
#' This function creates an indicator report card. The report card assesses ecosystem/socioeconomic favorability for the stock, NOT overall ecosystem/socioeconomic favorability.
#' 
#' @param data A data frame containing stock and indicator time series. Data from a spreadsheet outputted by a `NEespShiny` or `NEesp` regression report. Must pre-process with `NEesp::prep_data`, or do your own pre-processing.
#' @param out_name The name that the indicator column should have in the output.
#' @param min_year The minimum year to consider for the recent time-series average. Defaults to 2016.
#' @return A tibble
#' @importFrom magrittr %>%
#' @export

time_rpt <- function(data, out_name = "unnamed", min_year = 2016) {
  data <- data %>%
    dplyr::select(Time, Val) %>%
    dplyr::distinct()
  
  data <- data %>%
    dplyr::group_by(Time) %>%
    dplyr::mutate(avg_value = mean(Val, na.rm = TRUE)) %>% # average by year
    dplyr::select(-Val) %>%
    dplyr::distinct()
  
  analysis <- data %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      long_avg = mean(avg_value) %>%
        round(digits = 2),
      long_sd = sd(avg_value) %>%
        round(digits = 2)
    ) %>%
    dplyr::filter(Time >= min_year) %>%
    dplyr::mutate(
      short_avg = mean(avg_value) %>%
        round(digits = 2),
      short_sd = sd(avg_value) %>%
        round(digits = 2),
      avg_value = round(avg_value, digits = 2)
    )
  
  status <- c()
  for (i in 1:nrow(analysis)) {
    if (analysis$avg_value[i] > (analysis$long_avg[1] + analysis$long_sd[1])) {
      status[i] <- "high"
    } else if (analysis$avg_value[i] < (analysis$long_avg[1] - analysis$long_sd[1])) {
      status[i] <- "low"
    } else {
      status[i] <- "neutral"
    }
  }
  
  analysis$avg_value <- paste(analysis$avg_value,
                              status,
                              sep = ", "
  )

  output <- rbind(
    cbind(analysis$Time, analysis$avg_value),
    c("recent mean", paste(analysis$short_avg, "±", analysis$short_sd)),
    c("long-term mean", paste(analysis$long_avg, "±", analysis$long_sd))
  ) %>%
    tibble::as_tibble()
  
  colnames(output) <- c("Time", out_name)
  
  return(output)
}

#' Wrapper function to prep data, plot data, and create report card output
#'
#' This is a wrapper function of `prep_data`, `plot_corr_only`, and `time_rpt`
#' 
#' @param file_path The file path to a spreadsheet outputted by a `NEespShiny` or `NEesp` regression report. 
#' @param metric The stock metric to assess. Passed to `prep_data`.
#' @param pattern  Optional. Passed to `prep_data`. A pattern to detect in the `Var` row, for example if you do not want to plot all levels of `Var`. Can be a vector.
#' @param remove Optional. Passed to `prep_data`. If the pattern should be removed (`TRUE`) or retained (`FALSE`). Can be a vector.
#' @param lag Passed to `plot_corr_only`. The number of years by which the stock-indicator correlation was lagged. Required to correct the stock time series. Defaults to 0.
#' @param min_year Passed to `time_rpt`. The minimum year to consider for the recent time-series average. Defaults to 2016.
#' @param species Passed to `plot_corr_only`. The species name to add to plots. Defaults to "species".
#' @return A tibble
#' @importFrom magrittr %>%
#' @export

wrap_analysis <- function(file_path,
                          metric = "Recruitment",
                          pattern = NULL,
                          remove = NULL,
                          lag = 0,
                          min_year = 2016,
                          species = "species"){
  data <- file_path %>%
    prep_data(metric = metric,
              pattern = pattern,
              remove = remove)
  
  for (i in unique(data$Var)) {
    this_data <- data %>%
      dplyr::filter(Var == i)
    
    plt <- plot_corr_only(this_data, lag = lag, species = species)
    print(plt)
    cat("\n\n")
    
    i <- i %>%
      stringr::str_replace_all("\n", " ")
    
    if(exists("rpt_card_time")){
      rpt_card_time <<- dplyr::full_join(rpt_card_time,
                                         time_rpt(data, out_name = i, min_year = min_year),
                                         by = "Time")
    } else {
      rpt_card_time <<- time_rpt(data, out_name = i, min_year = min_year)
    }
  }
}
