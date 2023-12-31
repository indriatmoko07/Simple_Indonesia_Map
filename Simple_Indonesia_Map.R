##############Making Indonesia Map and Location######################


#####################Install packages###################
list.of.packages <- c("rnaturalearth", "rnaturalearthdata", "ggplot2","ggspatial","ggrepel")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

if (!require("rnaturalearthhires", quietly = TRUE)) {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    install.packages("devtools")
  }
  remotes::install_github("ropensci/rnaturalearthhires",
                          dependencies = TRUE, upgrade = TRUE, quiet = TRUE)
  library("rnaturalearthhires")
}

#################Load the packages##########################
library("rnaturalearth")
library("rnaturalearthdata")
library("ggplot2")
library("rnaturalearthhires")
library("ggplot2")
library("devtools")
library("ggspatial")
library("ggrepel")


#################Call the map and location (YOU CAN CHANGE THE COORDINATE AND LOCATION LABELS)##################
world <- ne_countries(scale = "large", returnclass = "sf")
class(world)

(sites <- data.frame(
  longitude = c( 95.327345,98.617991,  105.195757,  107.622231, 114.574473), 
  latitude = c(5.518278,3.592350,  -5.393023, -6.942481,-3.327241 ), 
  loc =c("Banda Aceh","Medan","Bandar Lampung","Bandung","Banjarmasin")))


#######################Plot It!!!##########################
ggplot(data = world) +
  geom_sf(fill = "darkgray") +
  geom_point(data = sites, aes(x = longitude, y = latitude), size = 3, 
             shape = 21, fill = "red") +
  coord_sf(xlim = c(94, 141), ylim = c(-13, 8), expand = FALSE) +
  annotation_scale(location = "bl", width_hint = 0.1) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.37, "in"), pad_y = unit(0.25, "in"),
                         style = north_arrow_fancy_orienteering)+
  xlab("Longitude") + ylab("Latitude") +
  geom_text_repel(data = sites, aes(x = longitude, y = latitude, label = loc), 
                  fontface = "bold", nudge_x = c(1, -1.5, 1, 1, 1), nudge_y = c(0.25, 
                                                                                 -0.25, -0.5, -0.5, -0.5))
#############################END#########################################