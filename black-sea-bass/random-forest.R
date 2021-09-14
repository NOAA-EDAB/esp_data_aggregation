

data <- read.csv(here::here("black-sea-bass/Black sea bass_regression_report_0lag_Jul13/data/Black_sea_bass_Mid_MAB_0_lag_FALSE_remove_recent_recruit_model_data.csv"))
head(data)

paste(colnames(data), collapse = " + ")

rf_mod <- randomForest::randomForest(Value ~ T_mean + 
                             T_peak + 
                             cumulative_intensity_degrees_C_annual_mean + 
                             cumulative_intensity_Black_sea_bass_spring_degrees_C_annual_mean + 
                             winter_OI_SST_Anomaly_degreesC + 
                             winter_OI_SST_Anomaly_Black_sea_bass_north_spring_degreesC + 
                             winter_OI_SST_Anomaly_Black_sea_bass_spring_degreesC + 
                             MONTHLY_PPD_MEDIAN_month_03_gCarbon_m_2_Day + 
                             WEEKLY_PPD_MEDIAN_week_04_gCarbon_m_2_Day + 
                             WEEKLY_PPD_MEDIAN_week_12_gCarbon_m_2_Day + 
                             WEEKLY_PPD_RATIO_ANOMALY_week_11_ + 
                             WEEKLY_PPD_RATIO_ANOMALY_week_12_ + 
                             thecos_100m3_annual,
                           data = data,
                           subset = 1:15,
                           mrty = 3,
                           ntree = 1000,
                           replace = TRUE,
                           keep.forest = TRUE,
                           importance = TRUE)
summary(rf_mod)
rf_mod

rf_mod$predicted
rf_mod$importance
rf_mod$importanceSD

pred <- predict(rf_mod, newdata=data)
obs <- data$Value

round(cbind(pred, obs, (pred - obs)))
