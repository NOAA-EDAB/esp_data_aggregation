dat <- data.frame(x = rpois(10, 5),
                  y = rpois(10, 5) * 10 + rpois(1, 1))

mod <- glm(y ~ x, data = dat, family = poisson())
mod <- lm(y ~x, data = dat)
results <- summary(mod)

results$coefficients[2, 1] # slope
results$coefficients[2, 4] # pval
results$adj.r.squared 

pseudoR2 <- function(model, data, respv_colname){
  
  data <- data %>%
    dplyr::rename(Measured = respv_colname)
  
  data$Predicted <- predict(model, newdata = data) %>% exp()

 pseudoR2 <- 1 - 
   sum((data$Measured - data$Predicted)^2) / 
   sum((data$Measured - mean(data$Measured))^2)  
 
 return(pseudoR2)
}

`%>%` <- magrittr::`%>%`
pseudoR2(model = mod, data = dat, resp_colname = "y")

plot(dat$x, dat$y)
