
# https://rpubs.com/boyerag/297592
`%>%` <- magrittr::`%>%`

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
season <- ncdf4::ncvar_get(nc_data, "season")

# try plotting

world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
latmin <- (min(lat) - 1)
latmax <- (max(lat) + 1)
lonmin <- (min(lon) - 1)
lonmax <- (max(lon) + 1)

data <- data.frame(
  lat = lat,
  lon = lon,
  abun = abun,
  season = season,
  year = year,
  decade = stringr::str_trunc(as.character(year), width = 3, ellipsis = "") %>%
    as.numeric() * 10
) %>%
  dplyr::filter(abun > 10^36) # only high abundance sites
str(data)

# contours/fill
fig <- ggplot2::ggplot(data = world) +
  ggplot2::geom_sf() +
  ggplot2::geom_density_2d_filled(ggplot2::aes(
    x = lon,
    y = lat),
    alpha = 0.5,
    data = data) +
  ggplot2::geom_density_2d(ggplot2::aes(
    x = lon,
    y = lat),
    size = 0.25, 
    colour = "black",
    data = data) +
  ggplot2::geom_point(data = data,
                      ggplot2::aes(x = lon,
                                   y = lat),
                      cex = 0.5) +
  # nmfspalette::scale_fill_nmfs(palette = "crustacean",
  #                             discrete = FALSE,
  #                             reverse = TRUE) +
  ggplot2::geom_sf(data = world) +
  ggplot2::coord_sf(
    xlim = c(lonmin - 1, lonmax + 1),
    ylim = c(latmin - 1, latmax + 1)
  ) +
  # ggplot2::scale_color_gradient(low = "blue",
  #                     high = "red",
  #                     name = "Year") +
  ggplot2::xlab("Longitude") +
  ggplot2::ylab("Latitude") +
  ggplot2::facet_grid(rows = ggplot2::vars(paste0(decade, "s")),
                      cols = ggplot2::vars(season)) +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90)) + 
  ggplot2::labs(title = "Black sea bass larvae observations in MARMAP and ECOMON",
       subtitle = "Only sites with highest larval abundance considered (points); contours and fill.")


# kernel density
# obviously there are problems...
fig2 <- ggplot2::ggplot(data = world) +
  ggplot2::geom_sf() +
  ggplot2::stat_density2d(ggplot2::aes(
    x = lon,
    y = lat,
    fill = ..level.. # not sure what variable this is going off of??
  ),
  alpha = .5,
  geom = "polygon",
  data = data
  ) +
  ggplot2::geom_point(data = data,
                      ggplot2::aes(x = lon,
                                   y = lat),
                      cex = 0.5) +
  ggplot2::geom_sf(data = world) +
  # nmfspalette::scale_fill_nmfs(palette = "crustacean",
  #                             discrete = FALSE,
  #                             reverse = TRUE) +
  ggplot2::coord_sf(
    xlim = c(lonmin - 1, lonmax + 1),
    ylim = c(latmin - 1, latmax + 1)
  ) +
  # ggplot2::scale_color_gradient(low = "blue",
  #                     high = "red",
  #                     name = "Year") +
  ggplot2::xlab("Longitude") +
  ggplot2::ylab("Latitude") +
  ggplot2::facet_grid(rows = ggplot2::vars(paste0(decade, "s")),
                      cols = ggplot2::vars(season)) +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90)) + 
  ggplot2::labs(title = "Black sea bass larvae observations in MARMAP and ECOMON",
       subtitle = "Only sites with highest larval abundance considered (points); kernal density estimates (clearly something is wrong).")

pdf(file = here::here("R-scripts", "black-sea-bass", "geography.pdf"),
    onefile = TRUE,
    width = 11.5,
    height = 8)
fig
fig2
dev.off()