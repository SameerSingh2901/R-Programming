
#################################---P A R T -- 1 --- ######################################################


install.packages(c("cowplot", "googleway","ggplot2","ggrepel","ggspatial","libwgeom","sf","rnaturalearth","rnaturalearthdata"))
library("ggplot2")
library("sf")


theme_set(theme_bw())

library("rnaturalearth")
library("rnaturalearthdata")

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)



#Basic plotting
ggplot(data = world) +
  geom_sf()



#title, subtitle
ggplot(data = world) +
  geom_sf() +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("World Map", subtitle = paste0("(",length(unique(world$name)),"countries"))



#Map color - geom_sf
ggplot(data = world) +
  geom_sf(color = "black", fill = "lightblue")



#Map better color
ggplot(data = world) +
  geom_sf(aes(filled.contour = pop_est)) +
  scale_fill_viridis_c(option = "plasma", trans = "sqrt")



#or
ggplot(data = world)+
  geom_sf()+
  coord_sf(xlim=c(-4.87,41.31),ylim=c(9.63,51.14),expand = FALSE)



#scale bar and north arrow 
library("ggspatial") 

ggplot(data = world)+
  geom_sf()+
  annotation_scale(location = "bl", width_hint = 0.5)+
  annotation_north_arrow(location = "bl",which_north ="true",
                         pad_x = unit(0.75,"in"), pad_y = unit(0.5,"in"),
                         style = north_arrow_fancy_orienteering)+
  coord_sf(xlim=c(-4.87,41.31),ylim=c(9.63,51.14))


#plot --- map with names
world_points <- cbind(spData::world, st_coordinates(st_centroid(spData::world$geom)))
names(world_points) [names(world_points)=="name_long"] <- "name"

ggplot(data = world)+
  geom_sf()+
  geom_text(data = world_points, aes(x=X,y=Y, label=name),
            color = "black", fontface="bold",check_overlap = FALSE)+
  annotate(geom="text",x=-90,y=26, label ="Lambert Nord France",
           fontface="italic", color="blue", size =6)+
  coord_sf(xlim=c(-4.87,41.31),ylim=c(9.63,51.14))





#plot --- map with names with arrow and scale (combination)
ggplot(data = world)+
  geom_sf()+
  geom_text(data = world_points, aes(x=X,y=Y, label=name),
            color = "black", fontface="bold",check_overlap = FALSE)+
  annotate(geom="text",x=-90,y=26, label ="Lambert Nord France",
           fontface="italic", color="blue", size =6)+
  annotation_scale(location = "bl", width_hint = 0.5)+
  annotation_north_arrow(location = "bl",which_north ="true",
                         pad_x = unit(0.1,"in"), pad_y = unit(0.1,"in"),
                         style = north_arrow_nautical)+
  coord_sf(xlim=c(-4.87,41.31),ylim=c(9.63,51.14),expand=FALSE)+
  xlab("Longitude")+
  ylab("Latitude")+
  ggtitle("Map of Lambert Nord France")+
  theme(panel.grid.major = element_line(color = grey(0.5),
                                        linetype = "dashed",size = 0.5),
        panel.background = element_rect(fill="aliceblue"))



#----
(gworld <- ggplot(data = world)+
    geom_sf(aes(fill = region_wb))+
    
    geom_rect(xmin = -4.87, xmax = 41.31, ymin = 9.63, ymax = 51.14,
              fill = NA, color = " Black", size = 1.5)+
    scale_fill_viridis_d(option = "plasma")+
    
    theme(panel.background = element_rect(fill = "azure"),
          panel.border = element_rect(fill = NA)))

(ggulf <- ggplot(data = world)+
    geom_sf(aes(fill = region_wb))+
    
    geom_text(data = world_points, aes(x=X,y=Y, label=name),
              color = "black", fontface="bold",check_overlap = FALSE)+
    annotate(geom="text",x=-90,y=26, label ="Lambert Nord France",
             fontface="italic", color="blue", size =6)+
    coord_sf(xlim = c(-4.87,41.31),ylim = c(9.63,51.14),expand = FALSE) +
    
    scale_fill_viridis_d(option="plasma"))





