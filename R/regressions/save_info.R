data_prep(stoc_data = stock,
          eco_data = test,
          lag_data = lag) %>%
  write.csv(file = paste(path_to_folder, "//", 
                         folder_name, "//",
                         species, "_", region,
                         "_vs_", EPU, "_", i, sep = ""))