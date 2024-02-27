# 
# (C) Keisuke Kondo
# Release Date: 2024-02-27
# 
# - global.R
# - ui.R
# - server.R
# 

#==============================================================================
#Global Environment
options(warn = -1)

## SET MAPBOX API
#Mapbox API--------------------------------------------
#Variables are defined on .Renviron
styleUrl <- Sys.getenv("MAPBOX_STYLE")
accessToken <- Sys.getenv("MAPBOX_ACCESS_TOKEN")
#Mapbox API--------------------------------------------

#Packages
if(!require(shiny)) install.packages("shiny")
if(!require(shinydashboard)) install.packages("shinydashboard")
if(!require(shinycssloaders)) install.packages("shinycssloaders")
if(!require(shinyWidgets)) install.packages("shinyWidgets")
if(!require(leaflet)) install.packages("leaflet")
if(!require(leaflet.mapboxgl)) install.packages("leaflet.mapboxgl")
if(!require(sf)) install.packages("sf")
if(!require(tidyverse)) install.packages("tidyverse")

#Shapefiles
listSfPref <- lapply(c(2000, 2005), function(x){st_transform(read_sf(paste0("data/shp_pref/shp_poly_", x, "_pref00.shp"), crs = 4326))})
