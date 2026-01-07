mvdata_server<-function(){
require(shiny)
require(ggplot2)
require(ggthemes)
shinyServer(function(input, output, session) {
  updateSelectInput(session, 'Lot', choices = LLP::list_mvlots())
  
  observeEvent(c(input$Lot, input$Variable), {
    output$plot1 <- renderPlot({
      Data <- LLP::query_mvdata(input$Lot, input$Variable)
      Data$sn <- as.numeric(Data$sn)
      Data <- setNames(Data[order(Data$sn), ], c("var", "sn"))
      
      
      ggplot(Data, aes(x = sn, y = var)) +
        geom_point(alpha = .3,
                   shape = 21,
                   fill = 'darkgreen') +
        theme_bw() +
        theme(text = element_text(size = 14),
              axis.text.x = element_text(angle = 90, vjust = 1)) +
        ylab(input$Variable) +
        ggtitle(paste0("Machine Vision:", input$Variable, "\n Lot:", input$Lot))
    })
    
  })
  
})
}
