spot_height_plot_server<-function(){
require(shiny)
require(ggplot2)
require(ggthemes)
require(dplyr)

shinyServer(function(input, output, session) {
  label <- c("pHeight" = 'pH', "oHeight" = "O2")
  db <- adminKraken::con_dplyr()
  X <- db %>%  tbl("xf24spotheight") %>% collect() %>%
    mutate(., year = sapply(Date, function(u) {
      as.numeric(strsplit(u, split = "-")[[1]][1])
    }))
  shiny::updateSelectInput(
    session = session,
    inputId = "year",
    choices = rev(as.numeric(unique(X$year)))
  )
  
  observeEvent(list(input$analyte, input$year), {
    output$spot_plot <- renderPlot({
      filter(X, year == input$year) %>%
        select(., Lot, var = input$analyte) %>%
        ggplot(., aes(Lot, var)) +
        geom_hline(yintercept = 0.003, col = 'red') +
        ggthemes::geom_tufteboxplot() +
        ylab(label[input$analyte]) +
        ggtitle(paste0("XF24 Spot Height for ",input$year))+
        theme_bw()+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
       
    })
  })
})
}
