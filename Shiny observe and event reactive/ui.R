library(shiny)


shinyUI(
  fluidPage(
    titlePanel('Histograma de distrbución'), 
    sidebarLayout(
      sidebarPanel(
        sliderInput(inputId='n',label = 'Tamaño muestral',min=2,max=500,value=30),
        numericInput(inputId='mean',label = 'Media de la Muestra', value = 0),
        numericInput(inputId='standarddev',label = 'Desv. típica', value = 1),
        actionButton(inputId='calc', label='Calcular')
        
      ),
      mainPanel(
        plotOutput('hist'),
        verbatimTextOutput('summary')
      )
    )
  )
)
