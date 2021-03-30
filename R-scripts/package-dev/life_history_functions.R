#' Plot `survdat` depth data
#'
#' This function plots `survdat` depth data
#'
#' @param data A `survdat` data frame or tibble, containing data on one species.
#' @return A ggplot
#' @importFrom magrittr %>%
#' @export

plot_depth <- function(data, species){
  
  selected.spp.sum <- data %>%
    dplyr::group_by(YEAR, SEASON) %>%
    dplyr::summarise(
      ave.d = mean(DEPTH),
      sd.d = sd(DEPTH, na.rm = TRUE),
      ave.t = mean(BOTTEMP),
      sd.t = sd(BOTTEMP, na.rm = TRUE)
    )
  
  if(nrow(selected.spp.sum) > 0){
    fig <- selected.spp.sum %>%
      ggplot2::ggplot(ggplot2::aes(
        x = YEAR %>% as.numeric(),
        y = -ave.d,
        color = SEASON,
        group = SEASON
      )) +
      ggplot2::geom_line() +
      ggplot2::geom_point() +
      ggplot2::geom_pointrange(ggplot2::aes(
        ymin = -ave.d - sd.d,
        ymax = -ave.d + sd.d
      )) +
      ggplot2::xlab("Year") +
      ggplot2::ylab("depth of trawl (ft)") +
      ggplot2::ggtitle("Seasonal depth profile of",
              subtitle = species
      ) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90))
    
    return(fig)
  } else print("NO DATA")
   
}

#' Plot `survdat` temperature-at-depth data
#'
#' This function plots `survdat` temperature-at-depth data
#'
#' @param data A `survdat` data frame or tibble, containing data on one species.
#' @return A ggplot
#' @importFrom magrittr %>%
#' @export

plot_temp_depth <- function(data, species){
  
  selected.spp.sum <- data %>%
    dplyr::group_by(YEAR, SEASON) %>%
    dplyr::summarise(
      ave.d = mean(DEPTH),
      sd.d = sd(DEPTH, na.rm = TRUE),
      ave.t = mean(BOTTEMP),
      sd.t = sd(BOTTEMP, na.rm = TRUE)
    ) 
  
  if(nrow(selected.spp.sum) > 0){
    fig <- selected.spp.sum %>%
      ggplot2::ggplot(ggplot2::aes(
        x = YEAR %>% as.numeric(),
        y = ave.t,
        color = SEASON,
        group = SEASON
      )) +
      ggplot2::geom_line() +
      ggplot2::geom_point() +
      ggplot2::geom_pointrange(ggplot2::aes(
        ymin = ave.t - sd.t,
        ymax = ave.t + sd.t
      )) +
      ggplot2::xlab("Year") +
      ggplot2::ylab("Bottom temperature (°C)") +
      ggplot2::ggtitle("Seasonal bottom temperature of tows that contain",
              subtitle = species
      ) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90))
    
    return(fig)
  } else print("NO DATA")
}

#' Fit a von Bertalanffy curve to data
#'
#' This function fits a von Bertalanffy curve to`survdat` data
#'
#' @param data A `survdat` data frame or tibble, containing data on one species.
#' @return A data frame of von Bertalanffy predicted age/length data
#' @export

vonb_model <- function(data){
  if (data$AGE %>% unique() %>% length() >= 3) {
    # define the type of von b model
    vb <- FSA::vbFuns(param = "Typical")
    # define starting parameters based on the avalible data
    f.starts <- FSA::vbStarts(LENGTH ~ AGE, data = data, methLinf = "Walford")
    
    # fit a non-linear least squares model based on the data and starting values
    f.fit <- nls(LENGTH ~ vb(AGE, Linf, K, t0), data = data, start = f.starts)
    # store the fit parameters for later investigation
    f.fit.summary <- summary(f.fit, correlation = TRUE)
    
    # define the range of age values that will be used to generate points from the fitted model
    # roughly by 0.2 year steps
    newages <- data.frame(AGE = seq(0, 50, length = 250))
    # predict(f.fit,newdata=newages) this funtion uses the model from f.fit to generate new lengths
    # make a dataset with the values from the model
    vonb_model_data <- data.frame(AGE = seq(1, 50, length = 250), 
                                  LENGTH = predict(f.fit, newdata = newages))
    
    return(vonb_model_data)
    
  } else {
    print("NOT ENOUGH DATA TO FIT A CURVE")
  }
}

#' Plot length-age `survdat` data
#'
#' This function plots length-age `survdat` data
#'
#' @param data A `survdat` data frame or tibble, containing data on one species.
#' @param vonb A data frame of von Bertalanffy predicted age/length data
#' @return A ggplot
#' @importFrom magrittr %>%
#' @export

plot_la <- function(data, vonb, species){
  if (nrow(data) > 0) {
    fig <- ggplot2::ggplot(
      data = data,
      ggplot2::aes(
        x = AGE,
        y = LENGTH,
        color = YEAR %>% as.numeric()
      )
    ) +
      ggplot2::geom_jitter(alpha = 0.5) +
      ggplot2::scale_color_gradientn(
        colors = nmfspalette::nmfs_palette("regional web")(4),
        name = "Year"
      ) +
      ggplot2::xlim(0, (1.5 * max(data$AGE))) +
      ggplot2::ylim(0, (1.5 * max(data$LENGTH, na.rm = TRUE))) +
      ggplot2::xlab("Age (jittered)") +
      ggplot2::ylab(" Total length (cm) (jittered)") +
      ggplot2::ggtitle(species, subtitle = "Length at age") +
      ggplot2::theme_minimal()
    
    if (nrow(vonb) > 0) {
      fig <- fig +
        ggplot2::geom_line(
          data = vonb,
          inherit.aes = FALSE,
          mapping = ggplot2::aes(
            x = AGE,
            y = LENGTH
          ),
          color = "blue",
          size = 1.4
        )
    }
    
    return(fig)
  } else {
    print("NO DATA")
  }
}

#' Plot `survdat` age diversity data
#'
#' This function plots `survdat` age diversity data
#'
#' @param data A `survdat` data frame or tibble, containing data on one species.
#' @return A ggplot
#' @importFrom magrittr %>%
#' @export

plot_age_diversity <- function(data, species){
  if (data$AGE %>% unique() %>% length() >= 3) {
    
    selected.age <- data %>% 
      dplyr::filter(!is.na(AGE))
    
    age.freq <- selected.age %>%
      dplyr::group_by(YEAR, AGE) %>%
      dplyr::summarise(age.n = length(AGE))
    age.freq <- age.freq %>%
      dplyr::group_by(YEAR) %>%
      dplyr::mutate(prop = (age.n / sum(age.n))) %>%
      dplyr::mutate(prop.ln = (prop * log(prop)))
    
    
    age.freq <- age.freq %>%
      dplyr::group_by(YEAR) %>%
      dplyr::summarise(shanon.h = (-1 * (sum(prop.ln))))
  } else {
    print("NOT ENOUGH DATA TO GENERATE METRIC")
    age.freq <- tibble::tibble() # make empty tibble for next logical test
  }
  
  if (nrow(age.freq) > 0) {
    fig <- age.freq %>%
      ggplot2::ggplot(ggplot2::aes(x = YEAR, 
                                   y = shanon.h)) +
      ggplot2::geom_path(group = 1, 
                         size = 1.2, 
                         color = "blue") +
      ggplot2::geom_point(size = 3, 
                          shape = 23, 
                          fill = "Black") +
      ggplot2::xlab("Year") +
      ggplot2::ylab("Shannon diversity index (H)") +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90)) +
      ggplot2::ggtitle("Age diversity of", subtitle = species)
    
    return(fig)
    
  } else {
    print("NO DATA")
  }
}

#' Plot `survdat` age density data
#'
#' This function plots `survdat` age density data
#'
#' @param data A `survdat` data frame or tibble, containing data on one species.
#' @return A ggplot
#' @importFrom magrittr %>%
#' @export

plot_age_density <- function(data){
  if (data$AGE %>% unique() %>% length() >= 3) {
    fig <- data %>%
      tidyr::drop_na(AGE) %>%
      dplyr::group_by(YEAR) %>%
      ggplot2::ggplot(ggplot2::aes(x = AGE, 
                                   y = YEAR, 
                                   fill = YEAR %>% as.numeric())) +
      ggplot2::scale_fill_gradientn(
        colors = nmfspalette::nmfs_palette("regional web")(4),
        name = "Year"
      ) +
      ggridges::geom_density_ridges2() +
      ggplot2::scale_x_continuous(
        limits = c(0, (max(data$AGE, na.rm = TRUE))),
        breaks = seq(0, max(data$AGE, na.rm = TRUE), by = 5)
      )
    
    return(fig)
  } else {
    print("NO DATA")
  }
}
