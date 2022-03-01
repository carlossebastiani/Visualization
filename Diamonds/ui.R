#cargamos las librerias necesarioas
library(shiny)
library(ggplot2)
library(dplyr)

## Creamos el ui
shinyUI(
  fluidPage(
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
)




