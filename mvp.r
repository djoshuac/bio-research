library(shiny)
library(leaflet)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
    selectInput("basemap", "Base Map:", providers, "Esri.NatGeoWorldMap")
  )
)

server <- function(input, output, session) {

  points <- reactive({
    p <- input$map_click
    if (length(p) > 0) cbind(p$lng, p$lat) else cbind(-110.0589, 42.3601)
  })

  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(input$basemap) %>%
      setView(lng = -110.0589, lat = 42.3601, zoom = 5)
  })

  observe({
    leafletProxy("map") %>%
      addMarkers(data = points())
  })
}

shinyApp(ui, server)
