library(sf)
library(tidyverse)
library(rath)

# 1:250 000
#lkr250 <- st_read("data/spatial/nuts250_0101.utm32s.shape/nuts250/250_NUTS3.shp")


# Bahnstrecken
bahn <- st_read("data/geo-strecke_2019/Strecken/Shapefiles/strecken_polyline.shp")

ggplot() +
  geom_sf(data = lkr2500,mapping = aes()) + 
  geom_sf(data = bahn,mapping = aes(),col = "red")+ 
  ggsave(file = "bahn.pdf",width = 10,height = 10,dpi = 500)


# 1: 2 500 000
lkr2500 <- st_read("data/spatial/nuts2500_0101.utm32s.shape/nuts2500/2500_NUTS3.shp")

ggplot(lkr2500) +
  geom_sf(aes())+ 
  geom_sf(data = centroids,aes(),size = 0.2,col = "red")+ 
  ggsave(file = "centroids.pdf",width = 10,height = 10,dpi = 500)


centroids <- 
  lkr2500 %>% 
  st_geometry() %>% 
  st_centroid()

centroids %>% as.data.frame %>% .["geometry"] %>% as.data.frame

# B
# source: https://www.statistik-bw.de/Presse/Pressemitteilungen/2016042

bw <- st_read("data/spatial/baden-wuerttemberg/LTWahlkreise2016/LTWahlkreise2016.shp")

ggplot(data = bw) + 
  geom_sf(col = "red") #+ 
  ggpreview(device = "pdf", cairo = TRUE,
            width = 10, height = 10, dpi = 300)

# compare both
ggplot() +
  geom_sf(data = lkr2500,
          aes(),
          col = "red") + 
  geom_sf(data = bw,col = "blue",alpha = 0.3) + 
  coord_sf() #+
  ggpreview(device = "pdf", cairo = TRUE,
            width = 10, height = 10, dpi = 300) 

# Bayern:
# source: https://fragdenstaat.de/anfrage/geometrien-der-stimmkreiseinteilung-zur-landtagswahl-2018-in-bayern-als-maschinenlesbare-daten/

bayern <- st_read("data/spatial/bayern/Stimmkreis.shp")

# Brandenburg
# source: https://www.europeandataportal.eu/data/de/dataset/dc98b5c3-4c29-44ee-9872-34adc4aab5f1    KEIN LINK
# Anfrage ist raus

# Berlin

# Hessen
# S: https://statistik.hessen.de/zahlen-fakten/landtagswahl

hessen <- st_read("data/spatial/hessen/HSL_Landtagswahlkreise_2018/HSL_Landtagswahlkreise_2018.shp")


# Rheinland-Pfalz 



# Sachsen: 
# https://www.europeandataportal.eu/data/de/dataset/https-ckan-govdata-de-dataset-f2900eaf-c8d6-5c55-8a46-1777d6f24570/resource/d34f142a-5c7f-4b4e-8185-1a1afae65df6?inner_span=True
library(xml2)

sachsen_xml <- xml2::read_xml()

sachsen <- st_read("https://geodienste.sachsen.de/wms_smi_wahlkreise/guest?REQUEST=GetCapabilities&SERVICE=WMS")


# Compare all

ggplot() +
  geom_sf(data = lkr2500,
          aes(),
          col = "red") + 
  geom_sf(data = bw,col = "green",alpha = 0.1,size = 0.1) + 
  geom_sf(data = bayern,col = "green",alpha = 0.1,size = 0.1) + 
  geom_sf(data = hessen,col = "green",alpha = 0.1,size = 0.1) + 
  geom_sf(data = sachsen,col = "green",alpha = 0.1,size = 0.1) + 
  coord_sf()+
  ggsave(file = "flo.pdf",width = 10,height = 10,dpi = 500)
  #ggpreview(device = "pdf", cairo = TRUE,width = 10, height = 10, dpi = 300) 



  
  