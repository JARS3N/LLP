dryqc_server <- function() {
  require(shiny)
  require(ggplot2)
  require(ggthemes)
  shinyServer(function(input, output, session) {
    updateSelectInput(session, 'Lot', choices = LLP::get_dqc_lots())
    observeEvent(input$Lot, {
      DATA <- LLP::pull_dqc_data(input$Lot, input$analyte)
      output$plot1 <- renderPlot({
        ggplot(DATA, aes(sn, var)) +
          geom_tufteboxplot(outlier.colour = "transparent") +
          theme_minimal() +
          theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
          ylab("%Transmission")+
          ggtitle(input$Lot)
      })
      #end
    })
    
  })
}
