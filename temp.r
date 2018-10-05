library(magrittr)
library(shiny)
library(leaflet)


ui <- fluidPage(
  leafletOutput("mymap")
)

server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap)
  })

  observeEvent(input$map_click, {
    p <- input$map_click
    print(p)
  })
}

shinyApp(ui, server)
