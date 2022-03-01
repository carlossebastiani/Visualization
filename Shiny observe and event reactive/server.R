library(shiny)

shinyServer(function(input,output){
  
  observe({
    input$calc
    print('HOLA')
  })
  
  x <- eventReactive(input$calc,{
    rnorm(input$n, mean=input$mean,sd=input$standarddev)}
                     )
  
  output$hist <- renderPlot({

    
    hist(x())
    
    
  })
  
  output$summary <- renderPrint({
    
    summary(x())
    
  })
})