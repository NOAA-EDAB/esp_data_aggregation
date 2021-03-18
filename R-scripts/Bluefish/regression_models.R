# test bluefish regression model

# recruitment ----
# factors that are correlated with recruitment with past 10 years of data removed

# calanus cv and adult
test <- ecodata::CalanusStage %>%
  dplyr::rename(Time = Year) %>%
  dplyr::filter(Var == "Adt" | Var == "CV",
                EPU == "MAB",
                Units == "No. per 100m^-3") %>%
  dplyr::group_by(Time) %>%
  dplyr::mutate(Calanus = sum(Value)) %>%
  dplyr::select(Time, Calanus) %>% # numbers are the same for all seasons in a year
  dplyr::distinct()

bluefish <- assessmentdata::stockAssessmentData %>% 
  dplyr::filter(Species == "Bluefish", 
                AssessmentYear == 2019,
                Metric == "Recruitment") %>%
  dplyr::rename(Time = Year)

bluefish2 <- bluefish %>%
  dplyr::mutate(Time = Time - 1) %>%
  dplyr::select(Time, Value) %>%
  dplyr::rename(Recruitment = Value)

data <- dplyr::full_join(bluefish2, test,
                         by = "Time") 

max(data$Time)
model <- lm(Recruitment ~ Calanus, data = data %>%
              dplyr::filter(Time <= 2007))
summary(model)
plot(model)

data2 <- data %>% 
  dplyr::mutate(Predicted = 3.369e+04 + 8.498e-01 * Calanus,
                Residual = Recruitment - Predicted)

fig <- ggplot(data2,
       aes(x = Time + 1,
           y = Recruitment))+
  geom_point(cex = 2)+
  geom_line()+
  geom_point(aes(y = Predicted),
            color = "red")+
  geom_line(aes(y = Predicted),
            color = "red",
            lty = 2)+
#  geom_point(aes(x = Time,
#                 y = Calanus),
#             color = "blue")+
#  geom_line(aes(x = Time,
#                y = Calanus),
#            color = "blue")+
  geom_vline(xintercept = 2008.5,
             color = "gray")+
  scale_y_continuous(labels = scales::comma)+
  xlab("Year")+
  ylab("Recruitment (thousands of age 0 recruits)")+
  theme_bw()

pdf(file = here::here("R/Bluefish", "bluefish_calanus_recruitment.pdf"),
       width = 6,
       height = 4)
fig
dev.off()

plot(data2$Time + 1, data2$Residual)


# spawning stock biomass ----

# total wind speed winter (J/kg) ----
wind <- ecodata::ne_wind %>%
  dplyr::rename(Val = Value) %>%
  dplyr::filter(EPU == "MAB",
                Var == "total wind speed winter") %>%
  dplyr::select(Time, Var, Val)
wind %>% head

# Fall SST anomaly ----
sst <- ecodata::seasonal_oisst_anom %>%
  dplyr::rename(Val = Value) %>%
  dplyr::filter(EPU == "MAB",
                Var == "fall OI SST Anomaly") %>%
  dplyr::select(Time, Var, Val)
sst %>% head

# Spring Temora abundance ----
temora <- ecodata::zoo_oi %>%
  dplyr::rename(Val = Value) %>%
  dplyr::filter(EPU == "MAB",
                Var == "temora zoo spring") %>%
  dplyr::select(Time, Var, Val)
temora %>% head

# Euphausiacea abundance ----
euph <- ecodata::zoo_strat_abun %>%
  dplyr::rename(Val = Value) %>%
  dplyr::filter(EPU == "MAB",
                Var == "Euphausiacea") %>%
  dplyr::select(Time, Var, Val)
euph %>% head

# Small Calanoid abundance ----
sc <- ecodata::zoo_strat_abun %>%
  dplyr::rename(Val = Value) %>%
  dplyr::filter(EPU == "MAB",
                Var == "SmallCalanoida") %>%
  dplyr::select(Time, Var, Val)
sc %>% head

# Cnidaria abundance ----
cnid <- ecodata::zoo_strat_abun %>%
  dplyr::rename(Val = Value) %>%
  dplyr::filter(EPU == "MAB",
                Var == "Cnidaria") %>%
  dplyr::select(Time, Var, Val)
cnid %>% head

# Zooplankton diversity (Shannon-Wiener Index) ----
zdiv <- ecodata::zoo_diversity %>%
  dplyr::rename(Val = Value) %>%
  dplyr::filter(EPU == "MAB") %>%
  dplyr::select(Time, Var, Val)
zdiv %>% head

# Female condition ----
fcond <- read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_MAB.csv") %>%
  dplyr::filter(Species == "Bluefish",
                sex == "F") %>%
  dplyr::rename(Val = MeanCond,
                Time = YEAR) %>%
  dplyr::mutate(Var = paste(sex, "condition")) %>%
  dplyr::select(Time, Var, Val)
fcond %>% head

# Male condition ----
mcond <- read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_MAB.csv") %>%
  dplyr::filter(Species == "Bluefish",
                sex == "M") %>%
  dplyr::rename(Val = MeanCond,
                Time = YEAR) %>%
  dplyr::mutate(Var = paste(sex, "condition")) %>%
  dplyr::select(Time, Var, Val)
mcond %>% head

# recreational CPUE (number of fish caught per day fished) ----
numbers <- ecodata::recdat %>%
  dplyr::filter(Var == "Recreational Seafood",
                EPU == "NE") %>%
  dplyr::rename(Number = Value)

days <- ecodata::recdat %>%
  dplyr::filter(Var == "Recreational Effort",
                EPU == "NE") %>%
  dplyr::rename(Days = Value)

rec <- dplyr::left_join(numbers, days, by = "Time") %>%
  dplyr::mutate(Val = Number/Days,
                Var = "recreational CPUE") %>%
  dplyr::select(Time, Var, Val)
rec %>% head

# Spawning stock biomass
# ignore for now

# bluefish ----
bluefish <- assessmentdata::stockAssessmentData %>% 
  dplyr::filter(Species == "Bluefish", 
                AssessmentYear == 2019,
                Metric == "Abundance") %>%
  dplyr::rename(Time = Year)

bluefish2 <- bluefish %>%
  dplyr::mutate(Time = Time - 1) %>%
  dplyr::select(Time, Value) %>%
  dplyr::rename(Val = Value) %>%
  dplyr::mutate(Var = "SSB") %>%
  dplyr::select(Time, Var, Val)

big_data <- rbind(bluefish2, rec, mcond, fcond, zdiv, cnid, sc, euph, temora, sst, wind) %>%
  tidyr::pivot_wider(id_cols = "Time",
                     names_from = "Var",
                     values_from = "Val")
big_data

colnames(big_data) <- colnames(big_data) %>%
  stringr::str_replace_all(" ", "_") %>%
  stringr::str_replace_all("-", "_")

paste(colnames(big_data[3:12]), collapse = " + ")

big_data_test <- big_data %>% 
  tidyr::drop_na()

model <- lm(SSB ~ recreational_CPUE + M_condition + F_condition + 
              Zoo_Shannon_Wiener_Diversity_index + Cnidaria + SmallCalanoida + 
              Euphausiacea + temora_zoo_spring + fall_OI_SST_Anomaly + 
              total_wind_speed_winter, 
            data = big_data_test %>%
              dplyr::filter(Time <= 2007))
summary(model)
plot(model)

null <- lm(SSB ~ 1, 
            data = big_data_test %>%
              dplyr::filter(Time <= 2007))
AIC(model)
AIC(null)

big_data_test$Predicted <- predict(model, newdata = big_data_test)

# indicators with missing info
# f and m condition
# temora

model2 <- lm(SSB ~ recreational_CPUE +
              Zoo_Shannon_Wiener_Diversity_index + Cnidaria + SmallCalanoida + 
              Euphausiacea + fall_OI_SST_Anomaly + 
              total_wind_speed_winter, 
            data = big_data_test %>%
              dplyr::filter(Time <= 2007))
summary(model2)
plot(model2)

AIC(model2)
AIC(model)
AIC(null)

big_data_test$Predicted2 <- predict(model2, newdata = big_data_test)

MASS::stepAIC(model)
# zoo diversity
# euphausids
# winter wind

model3 <- lm(SSB ~ Zoo_Shannon_Wiener_Diversity_index + 
               Euphausiacea + 
               total_wind_speed_winter, 
             data = big_data_test %>%
               dplyr::filter(Time <= 2007))
summary(model3)
plot(model3)

AIC(model3)
AIC(model2)
AIC(model)
AIC(null)

big_data_test$Predicted3 <- predict(model3, newdata = big_data_test)

# fig
fig <- ggplot(big_data_test,
              aes(x = Time + 1,
                  y = SSB))+
  geom_point(cex = 2)+
  geom_line()+
  geom_point(aes(y = Predicted),
             color = "red")+
  geom_line(aes(y = Predicted),
            color = "red",
            lty = 2)+
  geom_point(aes(y = Predicted2),
             color = "blue")+
  geom_line(aes(y = Predicted2),
            color = "blue",
            lty = 2)+
  geom_point(aes(y = Predicted3),
             color = "purple")+
  geom_line(aes(y = Predicted3),
            color = "purple",
            lty = 2)+
  geom_vline(xintercept = 2008.5,
             color = "gray")+
  scale_y_continuous(labels = scales::comma)+
  xlab("Year")+
  ylab("Spawning stock biomass")+
  theme_bw()
fig

#

model3 <- lm(SSB ~ Zoo_Shannon_Wiener_Diversity_index + 
               #Euphausiacea + 
               total_wind_speed_winter, 
             data = big_data %>%
               dplyr::filter(Time <= 2007))
summary(model3)
plot(model3)
AIC(model3)

big_data$Predicted3 <- predict(model3, newdata = big_data)

# fig
fig <- ggplot(big_data,
              aes(x = Time + 1,
                  y = SSB))+
  geom_point(cex = 2)+
  geom_line()+
  geom_point(aes(y = Predicted3),
             color = "purple")+
  geom_line(aes(y = Predicted3),
            color = "purple",
            lty = 2)+
  geom_vline(xintercept = 2008.5,
             color = "gray")+
  scale_y_continuous(labels = scales::comma)+
  xlab("Year")+
  ylab("Spawning stock biomass")+
  theme_bw()
fig

big_data %>%
  dplyr::select(Time, SSB, Zoo_Shannon_Wiener_Diversity_index, 
                  Euphausiacea,
                  total_wind_speed_winter, Predicted3) %>%
  View
# very high euphausids in 2010 causing dip

