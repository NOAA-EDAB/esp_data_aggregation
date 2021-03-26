dat <- data.frame(x = rpois(10, 5),
                  y = rpois(10, 5) * 2 + rpois(1, 1))

model <- glm(y ~ x, data = dat, family = gaussian())
results <- summary(model)

results$coefficients[2, 1] # slope
results$coefficients[2, 4] # pval
results$adj.r.squared 

pseudoR2 <- function(model, data, ind_colname){
  new_data <- data %>%
    dplyr::select(ind_colname)
}