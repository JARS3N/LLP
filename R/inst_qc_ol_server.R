inst_qc_ol_server <- function() {
  require(shiny)
  require(ggplot2)
  
  shinyServer(function(input, output, session) {
    observeEvent(input$plat, {
      db<-adminKraken::con_mysql()
      q_str <-
        gsub("%PLAT%",
             input$plat,
             'SELECT * FROM inst_qc_ol where platform= "%PLAT%";')
      send_query <- RMySQL::dbSendQuery(db, q)
      data <- RMySQL::dbFetch(send_query,n=Inf)
      RMySQL::dbClearResult(send_query)
      RMySQL::dbDisconnect(db)
      
      
      output$plot1 <- renderPlot({
        ggplot(data, aes(Instrument, O2)) +
          geom_hline(yintercept = c(142, 162), col = "blue") +
          geom_hline(yintercept = 152,
                     lty = 2,
                     col = 'blue') +
          geom_jitter(
            alpha = .5,
            height = 0,
            width = .1,
            shape = 21
          ) +
          theme_light() +
          theme(text = element_text(size = 12),
                axis.text.x = element_text(angle = 90, hjust = 1)) +
          ggthemes::scale_color_gdocs() +
          ggtitle(paste0(input$platform, "Instrument QC Outliers"))
      })
    })
  })
}
