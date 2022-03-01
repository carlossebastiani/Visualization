library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input,output){
    output$point <- renderPlot({
      #hacemos un subse de damonds solo con las columnas que nos interesan
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
)