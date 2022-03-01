#cargamos las librerias necesarioas
library(shiny)
library(ggplot2)
library(dplyr)

## Creamos el ui
ui <- fluidPage(
  titlePanel('Explorador de Diamantes'), #titulo de la hoja
  sidebarLayout(
    sidebarPanel(
      numericInput("num", label = "Tamaño de la muestra", value = 20), #se incluye in cuadro en el ui para que se intruzca elinput
      selectInput("cut", label = "Filtro de cut", 
                  choices = list("Fair" = 'Fair', "Good" = 'Good', "Very Good" = 'Very Good',
                                 'Premium' = 'Premium', 'Ideal'= 'Ideal'), 
                  selected = 'Premium') ## se crea un dropdows con las disintas variables a seleccionar
    ),
    mainPanel(plotOutput('point')) #metemos dentro del main panel lo que nos dará el server
  )
)

#creamos el server
server <- function(input,output){
  output$point <- renderPlot({
    #hacemos un subse de diamonds solo con las columnas que nos interesan
    #al mismo tiempo haciendo los filtros que nos pasa el usuario en el input
    #se utiliza en sample_n para deteerminar la catidad de filas randoms que tomará
    new_diamonds <- diamonds %>% 
      select(price,carat, cut,color) %>% 
      filter(cut==input$cut) %>% 
      sample_n(input$num)
    #se grafica y se incluye dentro de aes la variable color para que pinte según el color
    ggplot(new_diamonds) +
      geom_point(aes(x=price, y=carat, colour=color))
    
  })
}

##creación de shinyApp con ui y server
shinyApp(ui, server)


