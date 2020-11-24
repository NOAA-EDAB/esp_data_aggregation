names <- read.csv("https://raw.githubusercontent.com/pinskylab/OceanAdapt/master/data_raw/neus_svspp.csv",
                  row.names = NULL)

head(names)
names <- names[,-c(1, 4, 6, 7)]
colnames(names) <- c("Sci_name", "SVSPP", "Com_name")

head(names)

write.csv(names, file = here::here("data", "svspp_key.csv"))
