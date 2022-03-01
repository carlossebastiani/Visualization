library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel('Ejercicio 3: reactividad avanzada'),
  sidebarLayout(
    sidebarPanel(
      ## creamos un select input para que se escoja la primera variable
      selectInput('variable',label='Elige variable',
                  choices = list('manufacturer'='manufacturer','trans'='trans','class'='class'),
                  selected='manufacturer'),
      uiOutput('values'), #con este uiOutput haremos luego en el server el segundo select input ya que depende del primero
      actionButton('botonborrar',label='Borrar subconjunto') # creación del botón de borrar output
      
    ),
    mainPanel(
      plotOutput('scatter'), #en el mainpanel colocaremos primero el grafico y luego el summary del data frame
      verbatimTextOutput('summary'))
    
  )
  
)

server <- function(input,output) {
  #usamos un reactive para que cuando el usuario cambie en el widget 'variable' podamos guardar el valor que está usando y
  #hagamos el computo de las listas que se pasarán luego al segundo select input
  
  #usamos el switch para que nos guarde la lista que necesitamos cuando se cambie la variable del primer widget
  options <- reactive(switch(input$variable,
                             'manufacturer'=unique(mpg[['manufacturer']]),
                             'trans'=unique(mpg[['trans']]),
                             'class'=unique(mpg[['class']])
  ))
  
  #Utilizamos u renderUI ya uqe el segundo selectOnput depende del primero 
  #metemos en choices las variables que no hemos guardado gracias al reactive. 
  output$values <- renderUI({
    
        selectInput('values', 
                    label ='Elige un valor para eliminar', 
                    choices=options())
        
  })
   #creamos un contenemor de reactive values para poder ir modificando el dataframe original, 
  #en el que se iran quitando las columnas y filas segun el usuario vaya presionando el boton de borrar
  
  miscosicas <- reactiveValues()
  miscosicas$df <- mpg
  observeEvent(input$botonborrar,{
    miscosicas$df <- miscosicas$df[miscosicas$df[,input$variable]!=input$values,]
    
  })
  #creamos el gráfico usando el data frame modificado que nos hemos guardado
  output$scatter <- renderPlot({
    ggplot(miscosicas$df) +
      geom_point(aes(x=displ,y=cty,color=manufacturer))
  })
  #sacamos el summary del data
  output$summary <- renderPrint({
    summary(miscosicas$df)
  })
  
}


shinyApp(ui,server)


miscosicas <- reactiveValues()
miscosicas$df <- flights
observe({ 
  miscosicas$df <- flights %>% 
    filter(air_time < input$Airtime) %>% 
    sample_n(size = input$n)
})