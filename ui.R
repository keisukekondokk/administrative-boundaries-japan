# 
# (C) Keisuke Kondo
# Release Date: 2024-02-27
# 
# - global.R
# - ui.R
# - server.R
# 

dashboardPage(
  skin = "blue",
  #++++++++++++++++++++++++++++++++++++++
  #Header
  dashboardHeader(
    title = "Administrative Boundaries in Japan",
    titleWidth = 350,
    tags$li(
      actionLink(
        "github",
        label = "",
        icon = icon("github"),
        href = "https://github.com/keisukekondokk/administrative-boundaries-japan",
        onclick = "window.open('https://github.com/keisukekondokk/administrative-boundaries-japan', '_blank')"
      ),
      class = "dropdown"
    )
  ),
  #++++++++++++++++++++++++++++++++++++++
  #SideBar
  dashboardSidebar(width = 150,
                   sidebarMenu(
                     menuItem(
                       "MAP",
                       tabName = "tab_map1",
                       icon = icon("map")),
                     menuItem("README",
                              tabName = "info",
                              icon = icon("info-circle"))
                   )
  ),
  #++++++++++++++++++++++++++++++++++++++
  #Body
  dashboardBody(
    tags$style(type = "text/css", "html, body {margin: 0; width: 100%; height: 100%;}"),
    tags$style(type = "text/css", "h2 {font-weight: bold; margin-top: 20px;}"),
    tags$style(type = "text/css", "h3 {font-weight: bold; margin-top: 15px;}"),
    tags$style(type = "text/css", "h4, h5 {font-weight: bold; text-decoration: underline; margin-top: 10px;}"),
    tags$style(
      type = "text/css",
      "#map1 {margin: 0; height: calc(100vh - 50px) !important;}"
    ),
    tags$style(
      type = "text/css",
      ".panel {padding: 7px; background-color: #FFFFFF; opacity: 1;} .panel:hover {opacity: 1;}"
    ),
    tags$style(
      type = "text/css",
      "#buttonMapUpdate {color: #FFFFFF;}"
    ),
    #++++++++++++++++++++++++++++++++++++++
    #Tab
    tabItems(
      #++++++++++++++++++++++++++++++++++++++
      tabItem(
        tabName = "tab_map1",
        fluidRow(
          style = "margin-top: -20px; margin-bottom: -20px;",
          absolutePanel(
            id = "panel_map1",
            class = "panel panel-default",
            top = "15vh",
            bottom = "auto",
            left = "auto",
            right = "auto",
            width = 120,
            height = "auto",
            draggable = TRUE,
            style = "z-index: 100;",
            radioButtons(
              "map1_button",
              label = p(span(icon("calendar"), "Select Period:")),
              choices = list(
                "1980-10-01" = 1980,
                "1985-10-01" = 1985,
                "1990-10-01" = 1990,
                "1995-10-01" = 1995,
                "2000-10-01" = 2000,
                "2005-10-01" = 2005,
                "2010-10-01" = 2010,
                "2015-10-01" = 2015,
                "2020-10-01" = 2020
              ),
              selected = 1980,
              width = "100%"
            ),
            actionButton(
              "buttonMapUpdate", 
              span(icon("play-circle"), "Load Map"), 
              class = "btn btn-primary",
              width = "100%"
            ),
            HTML("<b>NOTE: Please wait while the page loads.</b>"),
          ),
          leafletOutput("map1") %>%
            withSpinner(color = getOption("spinner.color", default = "#3C8EBC"))
        )
      ),
      #++++++++++++++++++++++++++++++++++++++
      tabItem(
        tabName = "info",
        fluidRow(
          style = "margin-bottom: -20px; margin-left: -30px; margin-right: -30px;",
          column(
            width = 12,
            div(
              class = "mx-0 px-0 col-sm-12 col-md-12 col-lg-10 col-xl-10",
              box(
                width = NULL,
                title = h2(span(icon("info-circle"), "README")),
                solidHeader = TRUE,
                p("This web app visualizes historical administrative boundaries in Japan, which is the supplementary material of Kondo (2019, 2023). Please read the Terms of Use before you use this web app."),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("fas fa-file-alt"), "Terms of Use")),
                p(
                  "Users (hereinafter referred to as the User or Users depending on context) of the content on this web site (hereinafter referred to as the Content) are required to conform to the terms of use described herein (hereinafter referred to as the Terms of Use). Furthermore, use of the Content constitutes agreement by the User with the Terms of Use. The content of the Terms of Use is subject to change without prior notice."
                ),
                #--------------------
                h4("Copyright"),
                p("The copyright of the developed code belongs to Keisuke Kondo."),
                #--------------------
                h4("Copyright of Third Parties"),
                p(
                  "Keisuke Kondo developed the Content based on the National Land Numerical Information, which is provided from the Ministry of Land, Infrastructure, Transport and Tourism. Users must confirm the terms of use for the National Land Numerical Information, prior to using the Content."
                ),
                #--------------------
                h4("Disclaimer"),
                p("(a) Keisuke Kondo makes the utmost effort to maintain, but nevertheless does not guarantee, the accuracy, completeness, integrity, usability, and recency of the Content."),
                p("(b) Keisuke Kondo and any organization to which Keisuke Kondo belongs hereby disclaim responsibility and liability for any loss or damage that may be incurred by Users as a result of using the Content. Keisuke Kondo and any organization to which Keisuke Kondo belongs are neither responsible nor liable for any loss or damage that a User of the Content may cause to any third party as a result of using the Content"),
                p("(c) The Content may be modified, moved or deleted without prior notice."),
                #--------------------
                h4("Contact"),
                p("URL: ",
                  a(
                    href = "https://keisukekondokk.github.io/contact/",
                    "https://keisukekondokk.github.io/contact/",
                    .noWS = "outside"
                  ),
                  .noWS = c("after-begin", "before-end")
                ),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("user-circle"), "Author")),
                p(
                  "Keisuke Kondo", br(),
                  "Senior Fellow, Research Institute of Economy, Trade and Industry (RIETI)", br(),
                  "Associate Professor, Research Institute for Economics and Business Administration (RIEB), Kobe University"
                ),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("database"), "Data Sources")),
                h4("National Land Numerical Information: National Land Information Division, National Spatial Planning and Regional Policy Bureau, MLIT of Japan"),
                p(
                  "URL: ",
                  a(
                    href = "https://nlftp.mlit.go.jp/ksj/index.html",
                    "https://nlftp.mlit.go.jp/ksj/index.html",
                    .noWS = "outside"
                  ),
                  .noWS = c("after-begin", "before-end")
                ), 
                h4("Municipal Name and Code：Portal Site of Official Statistics of Japan （e-Stat）"),
                p(
                  "URL: ",
                  a(
                    href = "https://www.e-stat.go.jp/",
                    "https://www.e-stat.go.jp/",
                    .noWS = "outside"
                  ),
                  .noWS = c("after-begin", "before-end")
                ),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("book"), "References")),
                HTML(
                  "<ul>
                    <li>Kondo, Keisuke (2019) Municipality-level panel data and municipal mergers in Japan, RIETI Technical Paper No.19-T-001 (in Japanese).<br>
                    URL: <a href='https://www.rieti.go.jp/en/publications/summary/23020001.html' target='_blank'>https://www.rieti.go.jp/en/publications/summary/23020001.html</a></li>
                    <li>Kondo, Keisuke (2023) Municipality-level panel data and municipal mergers in Japan, RIETI Technical Paper No.23-T-001.<br>
                    URL: <a href='https://www.rieti.go.jp/en/publications/summary/23020001.html' target='_blank'>https://www.rieti.go.jp/en/publications/summary/23020001.html</a></li>
                    <li>GitHub: municipality-converter.<br>
                    URL: <a href='https://keisukekondokk.github.io/data/' target='_blank'>https://keisukekondokk.github.io/data/</a><br>
                    URL: <a href='https://github.com/keisukekondokk/municipality-converter' target='_blank'>https://github.com/keisukekondokk/municipality-converter</a></li>
                  </ul>"
                ),              
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("calendar"), "Update History")),
              　p(
                  "Release Date: February 27, 2024", br(),
              　)
              )
            )
          )
        )
      )
    )
  )
)
