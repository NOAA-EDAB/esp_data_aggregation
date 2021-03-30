`%>%` <- magrittr::`%>%`

temp_anom <- read.csv(here::here("R-scripts/test_models/Regressions/lag1/Black_sea_bass_Mid_MAB/data",
                                 "Black sea bass_Mid_MAB_1_lag_FALSE_remove_recent_sst_anom_.csv"))
temp_anom <- temp_anom %>%
  dplyr::filter(stringr::str_detect(facet, "Recruit"),
                sig == TRUE) %>%
  dplyr::select(Species, Region, Time, Value, Metric, Var, Val)

temp_anom %>% head

tem_anom2 <- temp_anom %>%
  tidyr::pivot_wider(names_from = Var,
                     values_from = Val)
tem_anom2 %>% head

heatwave <- read.csv(here::here("R-scripts/test_models/Regressions/lag1/Black_sea_bass_Mid_MAB/data",
                                 "Black sea bass_Mid_MAB_1_lag_FALSE_remove_recent_heatwave_.csv"))

heatwave <- heatwave %>%
  dplyr::filter(stringr::str_detect(facet, "Recruit"),
                sig == TRUE) %>%
  dplyr::select(Species, Region,  Time, Value, Metric, Var, Val)

heatwave <- heatwave %>%
  tidyr::pivot_wider(names_from = Var,
                     values_from = Val)

data <- dplyr::left_join(tem_anom2,
                  heatwave,
                  by = c("Species", "Region", "Value", "Metric", "Time")) %>%
  dplyr::rename(fall_anom = `fall OI SST Anomaly\ndegreesC`,
                spring_anom = `spring OI SST Anomaly\ndegreesC`,
                summer_anom = `summer OI SST Anomaly\ndegreesC`,
                cumul_heat = `cumulative intensity\ndegrees C`)

mod_data <- data %>% 
  dplyr::filter(Time < 2015) %>%
  tidyr::drop_na() 


model <- glm(Value ~ fall_anom * spring_anom * summer_anom * cumul_heat,
            data = mod_data,
            family = poisson())
new_mod <- MASS::stepAIC(model, 
              k = log(nrow(mod_data))
              )

mod2 <- glm(Value ~ fall_anom + spring_anom + summer_anom + cumul_heat,
           data = mod_data,
           family = poisson())
new_mod2 <- MASS::stepAIC(mod2,
              k = log(nrow(mod_data)),
              scope = list(lower = ~1,
                           upper = ~ fall_anom * spring_anom * summer_anom * cumul_heat))

# preduct data
data$Predicted <- predict(new_mod, newdata = data) %>% exp()
data$Predicted2 <- predict(new_mod2, newdata = data) %>% exp()

extractAIC(new_mod)
extractAIC(new_mod2)

#library(ggplot2)
ggplot(data,
       aes(x = Time,
           y = Value))+
  geom_line()+
  geom_point()+
  geom_line(aes(y = Predicted),
            lty = 2,
            color = "red")+
  geom_point(aes(y = Predicted),
               color = "red")+
  geom_line(aes(y = Predicted2),
            lty = 2,
            color = "blue")+
  geom_point(aes(y = Predicted2),
              color = "blue")+
  geom_vline(xintercept = max(mod_data$Time + 0.5),
             color = "gray20")+
  ylab("Recruitment (thousands of age 1)")+
  xlab("Year")+
  theme_bw()+
  scale_y_continuous(labels = scales::comma,
                     limits = c(0, NA))


text <- "fall_anom * spring_anom * summer_anom * cumul_heat"
parse(eval(text))

model <- glm(Value ~ parse(text = text),
             data = mod_data,
             family = poisson())

mod2 <- glm(Value ~ 1,
            data = mod_data,
            family = poisson())
new_mod2 <- MASS::stepAIC(mod2,
                          k = log(nrow(mod_data)),
                          scope = list(lower = ~1,
                                       upper = "~ fall_anom * spring_anom * summer_anom * cumul_heat")
                          )
new_mod2


# problems with models that are too big

dat <- read.csv(here::here("Regressions/zero_lag/Black_sea_bass_Mid_MAB/data",
                           "abun_reg.csv"))
head(dat)
dat <- dat %>%
  dplyr::select(-X)

dat <- dat %>%
  dplyr::mutate(Var = Var %>%
                  stringr::str_replace_all(" ", "_") %>%
                  stringr::str_replace_all("-", "_") %>%
                  stringr::str_replace_all("/", "_") %>%
                  stringr::str_replace_all("[:^:]", "_") %>%
                  stringr::str_replace("\n", "_") %>%
                  stringr::str_replace("Time", "TimeX")
  )
dat


dat2 <- dat %>%
  tidyr::pivot_wider(names_from = Var,
                     values_from = Val) %>%
  tidyr::drop_na()
#dat2 %>% View

start_model <- glm(Value ~ 1,
                   data = dat2,
                   family = poisson())

ncol(dat2)

full_mod <- paste(colnames(dat2)[6:19],
                  collapse = " * ")
full_mod <- paste("~", full_mod)
full_mod

MASS::stepAIC(start_model,
                k = log(nrow(dat2)),
                scope = list(lower = ~1,
                             upper = full_mod),
              direction = "forward",
              use.start = TRUE,
                trace = 1)


