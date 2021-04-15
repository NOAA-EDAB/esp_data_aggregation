
# https://rpubs.com/boyerag/297592

# read in data
nc_data <- ncdf4::nc_open(here::here("data", "ichthyoplankton.netcdf"))

# look at data
nc_data

# extract some data

lon <- ncdf4::ncvar_get(nc_data, "lon")
lat <- ncdf4::ncvar_get(nc_data, "lat", verbose = F)
t <- ncdf4::ncvar_get(nc_data, "taxa")
abun <- ncdf4::ncvar_get(nc_data, "mean_abund")
year <- ncdf4::ncvar_get(nc_data, "year")

# try plotting

world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
latmin <- (min(lat) - 1)
latmax <- (max(lat) + 1)
lonmin <- (min(lon) - 1)
lonmax <- (max(lon) + 1)

data <- data.frame(lat = lat,
                       lon = lon,
                       abun = abun,
                       year = year,
                       decade = stringr::str_trunc(as.character(year), width = 3, ellipsis = "") %>%
                         as.numeric() * 10)
str(data)


ggplot2::ggplot(data = world) +
  ggplot2::geom_sf() +
  ggplot2::stat_density2d(ggplot2::aes(
    x = lon, 
                              y = lat, 
                              fill = ..level.. # not sure what variable this is going off of??
                              ), 
                          alpha = .5, 
                          geom = "polygon", 
                          data = data) +
  #nmfspalette::scale_fill_nmfs(palette = "crustacean", 
  #                             discrete = FALSE, 
  #                             reverse = TRUE) +
  ggplot2::coord_sf(xlim = c(lonmin - 1, lonmax + 1), 
                    ylim = c(latmin - 1, latmax + 1)) +
  #ggplot2::scale_color_gradient(low = "blue", 
  #                     high = "red", 
  #                     name = "Year") +
  ggplot2::xlab("Longitude") +
  ggplot2::ylab("Latitude") +
  ggplot2::facet_wrap(~paste0(decade, "s"), ncol = 2)
# obviously there are problems...                          
