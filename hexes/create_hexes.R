
hexSticker::sticker(imgurl, 
        package = "NEesp", 
        p_size=20, 
        s_x=1, 
        s_y=1, 
        s_width=.6,
        filename = here::here("hexes", "NEesp_hex.png"))

sysfonts::font_add_google("Gochi Hand", "gochi")
## Automatically use showtext to render text for future devices
showtext::showtext_auto()

imgurl <- here::here("hexes", "noaa-bird.png")
hexSticker::sticker(imgurl, 
                    package = "NEesp", 
                    p_size=36, 
                    s_x=1, 
                    s_y=0.8, 
                    s_width=.8,
                    p_family = "gochi",
                    h_fill = "#007078",
                    h_color = "#4C9C2E",
                    url = "noaa-edab.github.io/NEesp",
                    u_size = 6,
                    filename = here::here("hexes", "NEesp_hex.png"))

hexSticker::sticker(imgurl, 
                    package = "NEespShiny", 
                    p_size=28, 
                    s_x=1, 
                    s_y=1, 
                    s_width=.8,
                    p_family = "gochi",
                    p_y = 1,
                    h_fill = "#007078",
                    h_color = "#4C9C2E",
                    angle = 30,
                    url = "noaa-edab.github.io/NEespShiny",
                    u_size = 5,
                    filename = here::here("hexes", "NEespShiny_hex.png"))
