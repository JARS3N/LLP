mv_platformview_server<-function(){
library(ggplot2)
library(shiny)
library(ggthemes)
shinyServer(function(input, output, session) {
  observeEvent(c(input$platform, input$vars), {
    DF <- LLP::pull_mvdata(platform = input$platform, var = input$vars)
    
    output$plot <- renderPlot({
      ggplot(DF, aes(Lot, var)) +
        geom_boxplot(outlier.shape = NA,
                     aes(fill = use),
                     alpha = .25) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 90, hjust = 1),
              legend.position = "bottom") +
        ggthemes::scale_fill_colorblind() +
        ylab(input$vars)
    })
  })
  
})
}
