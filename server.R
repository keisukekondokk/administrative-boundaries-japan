# 
# (C) Keisuke Kondo
# Release Date: 2024-02-27
# 
# - global.R
# - ui.R
# - server.R
# 

server <- function(input, output, session) {
  ####################################
  ## VISUALIZATION
  ## - leaflet: Maps
  ####################################

  #++++++++++++++++++++++++++++++++++++++
  #Maps: map1
  #++++++++++++++++++++++++++++++++++++++
  
  #Leaflet Object
  output$map1 <- renderLeaflet({
    #Leaflet    
    leaflet() %>%
      #Tile Layer from Mapbox
      addMapboxGL(
        accessToken = accessToken,
        style = styleUrl,
        setView = FALSE
      ) %>%
      setView(137.50061532587793, 35.48748008188884, zoom = 8)
  })

  #LeafletProxy
  map1_proxy <- leafletProxy("map1", session)

  #Switch Leaflet
  observeEvent(input$buttonMapUpdate, {
    
    #withProgress
    withProgress(message = "Loading the map...", value = 0, {
      
      #Load Shapefiles
      if(input$map1_button >= 2005) {
        #withProgress
        incProgress(0.1, detail = "Please wait until the map is drawn. It may take a few minutes.")
      }
      else {
        #withProgress
        incProgress(0.1, detail = "Please wait until the map is drawn.")
      }

      #Load Shapefiles
      if(input$map1_button == 1980) {
        year <- 1980
        sfPref <- listSfPref[[1]]
      }
      else if(input$map1_button == 1985) {
        year <- 1985
        sfPref <- listSfPref[[1]]
      }
      else if(input$map1_button == 1990) {
        year <- 1990
        sfPref <- listSfPref[[1]]
      }
      else if(input$map1_button == 1995) {
        year <- 1995
        sfPref <- listSfPref[[1]]
      }
      else if(input$map1_button == 2000) {
        year <- 2000
        sfPref <- listSfPref[[1]]
      }
      else if(input$map1_button == 2005) {
        year <- 2005
        sfPref <- listSfPref[[2]]
      }
      else if(input$map1_button == 2010) {
        year <- 2010
        sfPref <- listSfPref[[2]]
      }
      else if(input$map1_button == 2015) {
        year <- 2015
        sfPref <- listSfPref[[2]]
      }
      else if(input$map1_button == 2020) {
        year <- 2020
        sfPref <- listSfPref[[2]]
      }
      
      #Load Shapefiles
      if(input$map1_button >= 2005) {
        #withProgress
        incProgress(0.2, detail = "Please wait until the map is drawn. It may take a few minutes.")
      }
      else {
        #withProgress
        incProgress(0.2, detail = "Please wait until the map is drawn.")
      }

      #Load Shapefiles
      sfMuni <- st_transform(read_sf(paste0("data/shp_city/shp_poly_", year, "_pref00_city_seirei.shp"), crs = 4326)) %>%
        dplyr::mutate(cityNm1 = if_else(is.na(cityNm1), "", cityNm1))
      
      #Load Shapefiles
      if(input$map1_button >= 2005) {
        #withProgress
        incProgress(0.5, detail = "Please wait until the map is drawn. It may take a few minutes.")
      }
      else {
        #withProgress
        incProgress(0.5, detail = "Please wait until the map is drawn.")
      }
      
      #Leaflet
      map1_proxy %>%
        clearShapes() %>%
        clearControls() %>%
        #Polygon
        addPolygons(
          data = sfMuni,
          fillColor = "#FFFFFF", 
          fillOpacity = 0.0,
          stroke = TRUE,
          color = "#000000", 
          weight = 1.5, 
          dashArray = "5, 2",
          popup = paste0(
            "<b>Year-Month-Day: </b>　", year, "-", "10-01", "<br>",
            "<b>Municipality code: </b>　", sfMuni$cityCod, "<br>",
            "<b>Municipality name (JP): </b>　", sfMuni$prefNam," ", sfMuni$cityNm1, " ", sfMuni$cityNm2, "<br>"
          ),
          popupOptions = list(maxWidth = 300, closeOnClick = TRUE),
          label = paste0(sfMuni$prefNam," ", sfMuni$cityNm1, " ", sfMuni$cityNm2, " (", sfMuni$cityCod, ")"),
          group = "Municipal Boundaries"
        ) %>%
        addPolygons(
          data = sfPref,
          fill = FALSE, 
          color = "#303030", 
          weight = 4.5, 
          group = "Prefecture Boundaries"
        ) %>%
        addLayersControl(
          overlayGroups = c("Municipal Boundaries", "Prefecture Boundaries"),
          position = "topright",
          options = layersControlOptions(collapsed = TRUE)
        )
      
      #Load Shapefiles
      if(input$map1_button >= 2005) {
        #withProgress
        incProgress(0.2, detail = "Please wait until the map is drawn. It may take a few minutes.")
      }
      else {
        #withProgress
        incProgress(0.2, detail = "Please wait until the map is drawn.")
      }
    })

  }, ignoreInit = FALSE, ignoreNULL = FALSE)
  
}
